Return-Path: <linux-pci+bounces-32212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06539B06CD5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 06:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB42172FCF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9DB27877F;
	Wed, 16 Jul 2025 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU+KW7t9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD42701DC;
	Wed, 16 Jul 2025 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641608; cv=none; b=Bl/vo8rMktGn5EPQb0r/bSzx9FFK5npp0l+G2bJ435AQLgzbpxIlhdTLFJYMC3KYJzQDC7eKNcGuWrgVNNlW5DCysIqgwj6NvkuDWz0ReACYD30imaBrHEBYf1e9xFM3H7MaTa3oOsMuXlNbZqGrvGxumGZTvh1z0TQUBypBWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641608; c=relaxed/simple;
	bh=VQdKlwiYXht4bWkhJfcb8jwnNBfdeiL5+qX+sWbgybY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRFWncc2I6QUDfpKdGrgcCYjwGorngnvCWLvqbJPPhLxmVBOstfSPrRBXoObH4/zUIQegJ9QbkD/XLkPQ7QDHugSOOELmVh4ocSbURl70zQPI9ViMreZDG9zTF2nTeXt/+6xUvurnNcHzGVxRSb7X67qYkiVdKccLGDimHHzKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU+KW7t9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-75001b1bd76so2529375b3a.2;
        Tue, 15 Jul 2025 21:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752641606; x=1753246406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg7vtDw6PJWRrMAivmMSbqCib0l30VjCAuTpnZ+kki8=;
        b=IU+KW7t9HKf0o3ol+gTY71kMqcp3LQcsdeSZQuhout0YYZ0Z+EKHKfkp5sxFm+QfjU
         uQJadD/9XH74/fQqfshvg1tGrkSq6fTKIa9TZI5JswMAb4en45d7gRU2oop/pSioD2pu
         FfNVVjiTZu0keD5OmswbVX/kHG+iL9GYyZGtpEgJ02U7ASCgyqBR1dSjEDSSgGz02Hd6
         CAO1tPez2ysKmfU3fMlnI7zUBtfOtLZ9RXTa0N0UBXyoHtlkpcdpxbRsuCUDaR/EBYJO
         G+aZ15wYGqUIi2lgeCTDF8wq3qKNuWSFXkguC0QgUOejtVwmRBz+6wd6phg2gtFCFAYF
         UyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752641606; x=1753246406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xg7vtDw6PJWRrMAivmMSbqCib0l30VjCAuTpnZ+kki8=;
        b=bLZZNrzlpLLAHzxGW5SomQSiGGTh4t9ruSt2fOPppRTQR016AAF6hI9C6HJLKZpi0I
         7AY16qfAJPGUVLTIxIMjXCIdZQyUfQ+62VqxPdO1wl0sIE60mear13dQ4eryeiu9axbH
         7PtG0HL85L/PLz0tJvh33SYoDuARQse5Te3ix9re5dggm7vg6pA5T/i/B+V/2HSLbrhZ
         w69EYgOdwtGW7JFr/sJp9fEQjiKNUb1qF464hzCB/fkwpPcekE7KWpr66Qt+EaYDZFZN
         kLvpi/aom22rB/zzFYGTli0hwSZ9FpyNNAhpG2nUFkRDBeHT2BnD6nP6FJLeoO2VJSxz
         wSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnaCEPbrOWL+7eCO+ZbApUwfjsKCrvSFKos2CNizHVeylrKRGOOGtWmV53Y8uuGJ30la8gO81Dl+TCjuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7x1WUk41I/YfDktJ7pBiLhXCyimEFFrR6f6Aud5MoFq3sWOUV
	Gb8VwO29VL0Xvy9O3xQ7XdQoQZPq8LFDIzwXa4xIGp570Sa1MNM5Y8lzSQQKZQ==
X-Gm-Gg: ASbGncs0std3yDT3CnejDbXlqTBnYZaWGKGPkeegfB1P0bbza+apbgICqhb+YzsfCYv
	WtcWV3bKJsrlYi7kmyx+zKYzEmX/ImH5CQfcPYhaPbiw4onvAx5wqZDXYpl+YdA89iN8QmAgD1j
	Ngso211R89pHcv89vRzxaam1+Tee51XX07GtmtinZqKo2Am94xNDf+rk1DD/nRdwi2c4itgMguH
	/dzUvIgwGEaH8JspJEtgeE4xloJ8M4O4ltTI5Moy0AkONs244YMIpRGMZAgUAquTEegqnf9++Nh
	3L+gRMzU0b496m9nI412YyH8Me2V6M5iywXtMnhL2WsRlcX4tbZacGzI1GH5aE3hRLX5OY2n2hX
	OLrWylLSKmn5sERaElp7Nvrk7dAZB
X-Google-Smtp-Source: AGHT+IEg1AtMU9Bi41BePY6cGMS3w3F9XLtxUtiUfIk1jVTy3ZW4PChmtRXetyB0Z1LI95kFBEQydg==
X-Received: by 2002:a05:6a00:2306:b0:74b:4dcc:a150 with SMTP id d2e1a72fcca58-75722b73091mr1799974b3a.6.1752641605713;
        Tue, 15 Jul 2025 21:53:25 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06b19sm13822043b3a.64.2025.07.15.21.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 21:53:25 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH pci-next v2 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Tue, 15 Jul 2025 21:53:22 -0700
Message-ID: <20250716045323.456863-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716045323.456863-1-thepacketgeek@gmail.com>
References: <20250716045323.456863-1-thepacketgeek@gmail.com>
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
 drivers/pci/pci-sysfs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..d59756bc91c9 100644
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
+		return -EINVAL;
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
 
@@ -1749,8 +1766,12 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (pci_is_pcie(pdev))
+	if (pci_is_pcie(pdev)) {
+		if (strncmp(a->name, "device_serial_number", 20) == 0 &&
+			!pci_get_dsn(pdev))
+			return 0;
 		return a->mode;
+	}
 
 	return 0;
 }
-- 
2.50.0


