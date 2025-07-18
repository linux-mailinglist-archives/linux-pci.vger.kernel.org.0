Return-Path: <linux-pci+bounces-32564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82AEB0AAB9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 21:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805F83BF755
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF202E7F15;
	Fri, 18 Jul 2025 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAfl7s5n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F52E7F0A;
	Fri, 18 Jul 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867158; cv=none; b=iJXuAZzLkIIV8c2Tnk/6KWPa0JTA5DyHZdIhfKLENSORIV74TvKl4TIll+JTBfqTliX3RmJu6fbkMqOSf0Up6DmgJcSdg7UvFueJ5uTKZgX1WO3PAkAbPTWsepLE9Ew3t/iV0VM4KoOz+n6o6lOexc+6ZJYg34glkaUlhGbGL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867158; c=relaxed/simple;
	bh=v4bq9msCeAyzUOwtfpJP8OcMtMYiFNdDoxtAurvl5jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMNPl/Da5e86tDoGpZmdfaEgl8RRC+MF9+lpX+MYkmztMEZWxQYrjp/Gv1GnoZSYH3JIhayqW+u+ZeUB5DDxxFO/38FBIPwI535u+FifeQxRuS6si48zTWjizHW1OPDh0GL6Bs6bYDdSP9D1WgiTtQAVuLA83rIOG/V+j42Mil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAfl7s5n; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-75001b1bd76so1664807b3a.2;
        Fri, 18 Jul 2025 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752867154; x=1753471954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAMvxunzG7PmniHyPNqnUq0JbSXInMFyemo0IZM5GFQ=;
        b=EAfl7s5njtYjjCrKSNzJrPccDXH5WysJRbOjEmPcgtLinfhptXx4Y9Ggbwwvca9RU8
         lRATIdmxW/IFmlBAp5w5Xji/t82NxS/VTW4MB+KvYpwCjIIkDrHPC3wZcDMFJxxDP9kR
         NQihIAjOzvmAKQfZTxGBi63oM9JBJiUdzzRxfvJagBLDoSQ2cRV7X4YGs6Le4XJGA/sD
         yeghYYKtiDdpra3firCXfuSuvbP/rmFmMo0JF9mrpeVpAc9cVGKqP5KZNhg6S2INaNje
         tiKfA/I9a9e1mWygoiC7t0VleK0wd8DMwQIdkas1As1XbUQFulkIJeSfLaPeu2odhADF
         oFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752867154; x=1753471954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAMvxunzG7PmniHyPNqnUq0JbSXInMFyemo0IZM5GFQ=;
        b=U0nSIVGcgPewrwcatHfsXzLS0Vpjs1OWzWB32W/RGKsnCa0VtY9XAwAspibXe5AF3D
         N9Wu6wicm/k8TjIXNUlZcTodR5no4HlRvxLE6WrIQMHEiKhMYF02FbwGqsfZC60lAwyS
         7JRZyZznMz13esemDjzEJ39+HlGYMbrjbOYFNOJ8G0aMk+8E+9aJqm5IOTbOUoAuUStd
         n8tm5ujEW0e3cysz9/pNdzRnYZkQr79dqlgJdIsNjAbTlS6RQ4KyvJxqMc4ihFle2lxf
         hdkWooiUm394bDL0U/sdzdU4BPwnURX4Z5nSfeh15wMD2ZfCEgBmVhofOiKrdizepL9g
         4X8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnU+0of1y4YfdI+uWnYhmHFgTrmH/b/tE/xR5XuseBXzQQBQHu8jcvps8im2MtQKDUgWwXs3JgAMWB@vger.kernel.org, AJvYcCXJYM5V4CmbPHVdBqX2tRPbyksPyQuGkw/hA9nHgSQ25yIlDPqD6Dc9pWnOQDXbCHubnzNo3I1CFmGi4rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7sIqInSEAprE1r7UF2jdLr48cCZgt/2h3h5x3xH7TQvRFgsg
	fqBbnLj1yeopT+40cwmmzzLOoJQxTp5eCwS75KwXxdv0Aj21jQ8+PsA6
X-Gm-Gg: ASbGncuNwoB7hRT1JWZolJ4Nti1wv8A2a8XYJL0e6sQMrgAo65u5KIVlBOApuMz8qQQ
	J1lxZqFCnLKVAZT9p8w0GxhGYaQ/vXjSjVY252VIytwVYoxgZzhkftuPKqV0s7PqO0dGOwXaCZt
	1xe3Ykab9J1P6OYNjVa+2/ZQFG4NwJLCRV1tPHGR3fY0agVnSJ8t5OX+9h4AF/NtvYo68zv+fSl
	IHvSatJIBxLjuUT23CXEGsCKlR5Ga3Kdf4cYAX3b0ikZagJLs5TmTIHxv9f5DeC4OiBpGYSFfnR
	kzt5pm1UTWadNOFNinNr2L47xsg+IQs2DiveJYNIvNjLbJra48tMvdtzPFMVPVL/l9gnQXQgkJV
	HAM5Wka0S6/5d9kQSH+2KUi0xtZuO
X-Google-Smtp-Source: AGHT+IGmx750BsaTgyHD0afUmAIntfxcXM9uALuUkdT2gA1qII3B7V+5R9N5KNvKjbZNC40Ln+gscA==
X-Received: by 2002:a05:6a20:12cb:b0:220:78b9:f849 with SMTP id adf61e73a8af0-23812c45ea0mr20198113637.24.1752867153739;
        Fri, 18 Jul 2025 12:32:33 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb974ca5sm1625672b3a.131.2025.07.18.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 12:32:33 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Fri, 18 Jul 2025 12:32:29 -0700
Message-ID: <20250718193230.300055-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250718193230.300055-1-thepacketgeek@gmail.com>
References: <20250718193230.300055-1-thepacketgeek@gmail.com>
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
capability, the serial_number sysfs attribute will not be visible.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Reviewed-by: Mario Limonciello <superm1@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..0a2580cdd58c 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,3 +612,12 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
+
+What:		/sys/bus/pci/devices/.../serial_number
+Date:		October 2025
+Contact:	Matthew Wood <thepacketgeek@gmail.com>
+Description:
+		This is visible only for PCIe devices that support the serial
+		number extended capability. The file is read only and due to
+		the possible sensitivity of accessible serial numbers, admin
+		only.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..1d26e4336f1b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -30,6 +30,7 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/aperture.h>
+#include <linux/unaligned.h>
 #include "pci.h"
 
 #ifndef ARCH_PCI_DEV_GROUPS
@@ -239,6 +240,22 @@ static ssize_t current_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(current_link_width);
 
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u64 dsn;
+	u8 bytes[8];
+
+	dsn = pci_get_dsn(pci_dev);
+	if (!dsn)
+		return -EIO;
+	put_unaligned_be64(dsn, bytes);
+
+	return sysfs_emit(buf, "%8phD\n", bytes);
+}
+static DEVICE_ATTR_ADMIN_RO(serial_number);
+
 static ssize_t secondary_bus_number_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -660,6 +677,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_serial_number.attr,
 	NULL,
 };
 
@@ -1749,10 +1767,13 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (pci_is_pcie(pdev))
-		return a->mode;
+	if (!pci_is_pcie(pdev))
+		return 0;
 
-	return 0;
+	if (a == &dev_attr_serial_number.attr && !pci_get_dsn(pdev))
+		return 0;
+
+	return a->mode;
 }
 
 static const struct attribute_group pci_dev_group = {
-- 
2.50.1


