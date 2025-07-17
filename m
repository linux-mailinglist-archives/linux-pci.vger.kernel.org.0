Return-Path: <linux-pci+bounces-32416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3100FB0923A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F80B4E1422
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860012FD584;
	Thu, 17 Jul 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmtmpbTm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760A2FCFE1;
	Thu, 17 Jul 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771061; cv=none; b=CvHBXE1hdKvFKT2LToF5GH3OQ1lYf5I42FdxZ64AGfEjZ5I1Od46I4ZI7TSVdxOKEggSeL3I8kJz+J6M43VxOXBJLcE3QUWPeArr6terj82hRGfmU+9sdsYpjs9fQiITTPMiZdB5tKWXZV/TXn0O8D6y9xP9x03/pIlS+quC3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771061; c=relaxed/simple;
	bh=xk4DrsDp/eUeLybXPITp8Mxc0dMWd3PknhSI3ZlzuBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDasjMq08JMctFUlojMNgHksVteX87Fk1pufsLKy3vXpdheFnTTHi/aEZ5o83dkdKjFab+4lpyB/qqaSiFKFZvOZnxDw6nh0gItxuCgBfrtWKglz1nFjMsMBwDCde/1NBD3dcFjaGqB0/SpL6WuDZS3XwwZRu6Mqtj/67OfeUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmtmpbTm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1003787b3a.2;
        Thu, 17 Jul 2025 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752771059; x=1753375859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMMow8FBXmjh5Pcof1+suRVgnnaIz1gnJYKSCYhj5ao=;
        b=ZmtmpbTm0NHCKWQV0P4njzXBkKIzAMTM+SuuwSHeWoCySn56G4fHdYlVUkj69EnJ7z
         /Fu1yikUhp5skCiiyUUIfwe+9k9YVsf6ymespQA256pZBezr8EGN3GlI1PtsOySs7X9l
         b9XDgfl+YSL1EFw4b2owME5s86dUHZDirSV3xFMC1rPWC3v6q2NfvxA7w4lhiB1BtQ7v
         Ym1siVkYC+7SOt2ukPoa98kum1KoiPgwqeOX0nikmW6a0g6ggAbqG8HFTAX+v+WRHg1V
         sQUpeQmdbp0JNr2v/1MsM7Pg9wB96ZfH+Lrn/dkxsgVmTp/g2SbULwJ6BfmjIRrIt4ub
         AOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771059; x=1753375859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMMow8FBXmjh5Pcof1+suRVgnnaIz1gnJYKSCYhj5ao=;
        b=Y8LffjR4LZmdLUuhmGfIDK1G8x/JY9L/gDWIgtk3kqQRXJ37aSl/0o01vS0PuSq3gR
         x7nFvaA3nc8PORzlUgUiHP3KzApzb2g3DCv77EADH6WfyGmsSx742qUdbF1GBUQZegT7
         Xw5YAznXdDp6jCC4zZ7ka1SHK+A/VLx2oSB8Zei6JP0H9YmIYUZ3BG3i3hGBdWkhKmqj
         ZQHJAKj7oCzDPL7hfo6RnsnR/ANNkeoxPL+9wNGmgt94lpYGrAKrmh1xHpE6dGRI37hR
         EfpobnOaw/FqIYXM+0YYIy8EcRaWoD/UAsTO4IdsGvDy9o7kBRUY7+j7B03MQgRo0qy9
         zPaA==
X-Forwarded-Encrypted: i=1; AJvYcCU1eeAk2XK5pf/qaXuxCI3CltCq67GONP/QPb6qzPQtmLe8B7GUnDsenHzQST5cQp3pR3pHOpfB2Qtg@vger.kernel.org, AJvYcCV9EaafZOaUolM4KqQjObM4rVX8b/ri15VqOC7A5gVTyD/o0cTEo/MNJplEEltqWFbpFQGlC3plBNosFxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Pp4YQRl0AttWFGcFO/fAESB/UmG2wUutPH0He0hATCMEA5Vy
	BqDh16gRwJTEEzc/zN/hjplF57/SEGnd/YqLly74Z4rX7ieD161fgjcc
X-Gm-Gg: ASbGncv7bjgVjvqiXngOXGvIc+YSn5M7G+fqtgOZx6qMRdG42zDybRSjGOh7fh37V/6
	AICmbBTZbFdzNjODRVujHdST04oPDtFZnM5UJc3am7PDXihd3RlX/j1wiuQZUK/HZORw91t4vkx
	GjndiMuMLIwM8RxEFI9m/WJ8gvy6Lid/J016uLIt4sqhE2vlkqYGcaVSC0RAaMmy89bqTlvTPk0
	ea3jUpKggYo8hlXAmB26BxvbYl7Q1u2/IB3CxgQuHqpJmlIV0cT9z/eA7mkjLSJ+qKrz/VeTafH
	nKUWaDohEnnNAphNv6fkDEXHCfEbYn38b7n7jJ1CILb2fdctZGWl1XnEkjtM6I2EFh3wUSNAgLK
	SAvaB7N0yIPXQOQZ64B6+79bm9bJwOM1d7T24c4A=
X-Google-Smtp-Source: AGHT+IEn2h+CwLZgkmLx81hd6dGC5XxGZ0boJiKdmHRhtElOB8xs/urREIPrKCC5Ad0b+RadRB/qfg==
X-Received: by 2002:a05:6a21:2010:b0:238:351a:643b with SMTP id adf61e73a8af0-238351aa128mr7175630637.43.1752771059232;
        Thu, 17 Jul 2025 09:50:59 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d337sm15801046b3a.73.2025.07.17.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:50:58 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Thu, 17 Jul 2025 09:50:54 -0700
Message-ID: <20250717165056.562728-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717165056.562728-1-thepacketgeek@gmail.com>
References: <20250717165056.562728-1-thepacketgeek@gmail.com>
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
 drivers/pci/pci-sysfs.c                 | 26 ++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

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
index 268c69daa4d5..bc0e0add15d1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(current_link_width);
 
+static ssize_t serial_number_show(struct device *dev,
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
+static DEVICE_ATTR_ADMIN_RO(serial_number);
+
 static ssize_t secondary_bus_number_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -660,6 +676,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_serial_number.attr,
 	NULL,
 };
 
@@ -1749,10 +1766,13 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
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
2.50.0


