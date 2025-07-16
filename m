Return-Path: <linux-pci+bounces-32301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C75B07B3B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CE75056CF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE52F5492;
	Wed, 16 Jul 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8vVh+4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D82F5485;
	Wed, 16 Jul 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683542; cv=none; b=TvuMOt1tJQbomDu5ahUqp8k9mypPQ6mq1MzOpXezVL5u91Qi/0ON40IR9ugJmF+vzTLs7fA+a85t8UevotML29C2KRks7VNIjvGN6+20myAcr6WbHd9BMi0FYQZ2UQgk2INLfReO1JYZ8zGqtsPUz24KuBEGtbVu/Sdjiv3hfbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683542; c=relaxed/simple;
	bh=+GQWe2rh+1vBCxFyMeHyCqAzT7LOikCJ+r2yzy5xFRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig2BUMMsb4qhSipZ18CiLmX+5ny4HtOpGIC606cdyRBB0zLWoXRSx3HdJjbB8RWWVjea6Tm+aIY1kSma6+9xLSCxDGo/+zEHw7ieLDtnGFnAIOc9iOCJKAKOy2vib6lsx52bdo3sPfnkcxHl0/+kjbLAj34qeOFqVyaAWrmqNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8vVh+4R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234f17910d8so67360345ad.3;
        Wed, 16 Jul 2025 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752683540; x=1753288340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8cgcYwxxKYhRO+b70u/IqCQdpzOxqZFlIVZxh4STFM=;
        b=P8vVh+4RJhcFdxRPsjx4m0I7DsJg0XaqPBlXmgzlvmvTvFONg5ZwAN6RKyq2rNz8Uc
         pB0l77m5fI46ss88mEDpIY9SsoiZ/Dk3yferbz5KOeICd3bTBPwvIIsWOg2dYOBGX79n
         uONolGi81oewLNM7Jtyp0dH5fQOGNosMfqePBjoV5IvTrg9xrqP5nh7GssGeLN8nceig
         UbtNdsh65JwWuJoYMTsjD9OJHnIKh9xPc6Zhi0HNmMefMYCC1kWwyW5+PkM1oUM94fKj
         tDR6nr0Kk51s3qCPCTs5WtP/4M5P1PknoB61QR/WwIbMgOwgIvcSlNynN/mcDc7InlVW
         SUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752683540; x=1753288340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8cgcYwxxKYhRO+b70u/IqCQdpzOxqZFlIVZxh4STFM=;
        b=HNKM3P/WGE42e7KLmv1kYMOUBRclqa+ebgn16Yc+aSbH0u1BWf8j7JHG3u8VziKRnk
         CWt2wmNINRHYtslYEktZHXHVq48if1HVhuFvW3M/DiD6EkRWDFSG5pD8YXJilIUTIyKo
         jcDyMDbaZ4IKVJBFGIWLmQnJAreB7z9/hcjyWgba4/Kezd2ziSmLM0DBRMoTRZ9GqHuT
         +Yy9/u0Mfqw09g2LAMpHesc73HlnPq525q5h/Y88hoFNV17izVkbcxfIHmBFr8iLxPt4
         QIcHqWOtcLU3Wy3SM86Dv6b8whmy8cT6VqNRTfWBJgL35lc4YzuDdSTSvprCPaTl4C+w
         NSQg==
X-Forwarded-Encrypted: i=1; AJvYcCVgnxXT4mHF7QPtcgG7aD2UPSJ3JPXfB1VGLw/q6JuRtIcxvPu7v8aF+UIGYBmY+SavsOQaceClXgMO+94=@vger.kernel.org, AJvYcCWkyNYPmnC6UOpMATBpt17W07bKlPLuvqcGBCX+fq3uXRROGPM7iNf/qIuQxEjWVSlMUoC83SMAG3RE@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyMinEjRWTP/YwfmrQl8s5kIvYFBJPxEXxzuJQyW1ytaCT4m+
	6nFlcFBHc7Dlfcv7GyCeo7A/W5HAv9NsLz2ZUmnudvLJpS6nS75noa+bmzE7EA==
X-Gm-Gg: ASbGnct4n56tzaHpGC0LkG2aJYmJ2gHXs/8pFtskZrYsFNefUHfTF4HMGMgoyHDsQ62
	O4l3Q450mErmhVcPep31+Y6n+n3HEQFHcwgz1iUAV3Zu37TxERVBjPHmMdPshpRvxh8PVlk+/gA
	xcwtvXDoLaaW23A5Phadks6z3RhKxzhwJ5ti/GAMVVFWZTZIJSBUAMpLU+tc8+oehncpA5d72R8
	yE8xDq5moNaR53LXHGTZhMy2PAkm0JwF5kOdSnfeYDQxDb1Uj+IuCatb0FdnXAWc3XAwZEE5J6P
	QPtnQKnTDm9TjUOIwgq4l60okj+zOxYz8R/UADvBDxliyP9zqprkFOKGDz4xKKoSa/q/3tD55+d
	DiVIek8f4e5gDtDxzZpgxg0hG4U9V
X-Google-Smtp-Source: AGHT+IHThwpCuAhY7wpw+0NnMNDHMgf7L34B4jdpjSe6OTXayh68FaDzRObR7Wa7WWplS5RCMmDsIg==
X-Received: by 2002:a17:903:1b0f:b0:23d:eb0f:f44 with SMTP id d9443c01a7336-23e24ebe611mr51524455ad.8.1752683539701;
        Wed, 16 Jul 2025 09:32:19 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435f371sm126471385ad.237.2025.07.16.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:32:17 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Wed, 16 Jul 2025 09:32:11 -0700
Message-ID: <20250716163213.469226-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716163213.469226-1-thepacketgeek@gmail.com>
References: <20250716163213.469226-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only interface for reading PCIe device serial
numbers from userspace in a programmatic way. This device attribute
uses the same hexadecimal 1-byte dashed formatting as lspci serial number
capability output. If a device doesn't support the serial number
capability, the device_serial_number sysfs attribute will not be visible.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  7 +++++++
 drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..f7e84b3a4204 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,3 +612,10 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
+
+What:		/sys/bus/pci/devices/.../device_serial_number
+Date:		July 2025
+Contact:	Matthew Wood <thepacketgeek@gmail.com>
+Description:
+		This is visible only for PCIe devices that support the serial
+		number extended capability. The file is read only.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..b7b52dea6e31 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(current_link_width);
 
+static ssize_t device_serial_number_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u64 dsn;
+
+	dsn = pci_get_dsn(pci_dev);
+	if (!dsn)
+		return -EIO;
+
+	return sysfs_emit(buf, "%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx\n",
+		dsn >> 56, (dsn >> 48) & 0xff, (dsn >> 40) & 0xff, (dsn >> 32) & 0xff,
+		(dsn >> 24) & 0xff, (dsn >> 16) & 0xff, (dsn >> 8) & 0xff, dsn & 0xff);
+}
+static DEVICE_ATTR_RO(device_serial_number);
+
 static ssize_t secondary_bus_number_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -660,6 +676,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_device_serial_number.attr,
 	NULL,
 };
 
@@ -1749,10 +1766,14 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (pci_is_pcie(pdev))
-		return a->mode;
+	if (!pci_is_pcie(pdev))
+		return 0;
+
+	if (a == &dev_attr_device_serial_number.attr && !pci_get_dsn(pdev))
+		return 0;
+
+	return a->mode;
 
-	return 0;
 }
 
 static const struct attribute_group pci_dev_group = {
-- 
2.50.0


