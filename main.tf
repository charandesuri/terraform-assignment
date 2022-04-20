
resource "aws_s3_bucket" "assignment_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_bucket_object" "bucket1" {
   bucket = aws_s3_bucket.assignment_bucket.bucket
   key = "assignment"
   acl = "public-read"
   source="./web.jpeg"
   etag = filemd5("./web.jpeg")

}

resource "aws_cloudfront_distribution" "s3_distribution" {

origin {
    domain_name = "${aws_s3_bucket.assignment_bucket.bucket_regional_domain_name}"
    origin_id   = "my_first_origin"
}
enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "assignment"
default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "my_first_origin"
forwarded_values {
      query_string = false
cookies {
        forward = "none"
      }
    }
viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
# Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "my_first_origin"
forwarded_values {
      query_string = false
      headers      = ["Origin"]
cookies {
        forward = "none"
      }
    }
min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "allow-all"
  }
# Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id  = "my_first_origin"
forwarded_values {
      query_string = false
cookies {
        forward = "none"
      }
    }
min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress             = true
    viewer_protocol_policy = "redirect-to-https"
  }
price_class = "PriceClass_200"
restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "IN"]
    }
  }
tags = {
    Environment = "production"
  }
viewer_certificate {
    cloudfront_default_certificate = true
  }
}