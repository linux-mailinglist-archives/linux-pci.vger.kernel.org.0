Return-Path: <linux-pci+bounces-32412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BE2B091A2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE35174DD1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B82FCE1A;
	Thu, 17 Jul 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db5RM1qV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027C2FCE00;
	Thu, 17 Jul 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769366; cv=none; b=d7yzBz1uJTgBMKLLDjYACFAnPIhXfPn1oDZjy1tYZakMP1WBibCAUnrL3aKAOg+YXI9wCfjvLC4trCpBCYRW2/fwo7qI5V0DBbYlOS5TstCvytaA+PAlqfyO5jkerc66w73xRrOCm0hpUyZanTJhBs85QDxXX9sa0yWONeyWnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769366; c=relaxed/simple;
	bh=bsbpxmx0DzSr432AsZe9dnFFqERqxfaHV0RcMK7/bpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iqzcn9zq2t+15zoSjyu8zs9TaOu+Kdxnj41+mhDNBgWAejV34NoOXMPMnNOFL2qSHiFc4Iq3KqrKF2aK4fMr4hP9CYJAN2zkPrcS1PvR8n99zFU1I5rouLvrMVsCt8kIUwHs+HNAZF50NX1HNMgQzBdK3UePj7R/TMy0+98JRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db5RM1qV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747e41d5469so1454870b3a.3;
        Thu, 17 Jul 2025 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752769364; x=1753374164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz6lyUcLod/QPGb/nk8D6vag9l6UYfcL528xL4xpp4E=;
        b=Db5RM1qVE3UfedXaJqcoZVOVPVLG0FdWtDJLPBO3yCvXgI40lNJETr3v9rJyYx/cnW
         x7GVdVQotiyn0XTOJNp0DDJV+tmA8iI5iugsOs28uA9acqrjS+zuH9dkVPQHG58t3/Ro
         dCpy0SrK8hb9TGSGgY+1yCNx6OgqcQ8yJnB5meDC3u+fCwkd1czwmTeLtUMG5bDStitd
         BCjPmsC6xKddFUR6quLMPAF3zSu1EWn69e6GfSCTiuO1/ShhNEefT0Xi7zlaM8qJYWFs
         p135++Q5WN7V7YhYFYp0UqN5HZII/AVX/vbt2IDYjQFQc4uLBklmi2g81lzOJkbCLxOy
         NopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769364; x=1753374164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz6lyUcLod/QPGb/nk8D6vag9l6UYfcL528xL4xpp4E=;
        b=ayC3///lo0xAU5yMEjqj1sBUqqdpGxkXcdrMDD0Rx0ml2OMe6ibQDVUJdvBTWBGhpt
         kV1q6Am1bBHAh7Goahqvn1E0aUfaEqeeBf4xt4mIRxpwUqQT1wr90x5el2OkAMRggh4u
         AKuyxpruBjec9hClchvAjbyM0RwJ4J5C4hP6G80wPBefhS0HNcgVbEcSycSWrIh9/3Lj
         OQ7M6y9ME03tVx+pVmDLdXp/zK5f2RuEd5ebCv8671QPBqP+bzH53NzNr3PBGSTL2qBJ
         juP1+WiJl4jNp1VEfH/kjdUbprOKy2UJWRPixyX+2XYIkRaV+YB0QHHy75dfrwhXUVkm
         z3mw==
X-Forwarded-Encrypted: i=1; AJvYcCUi7eHDVXz4QgxvfgKhYBYzVmjxKCgET/QvlqN0opYKj2QuQzquqlFr/2zclzcxwmzQoNjRHW6wOemBeK0=@vger.kernel.org, AJvYcCWDNZq5KVvVbw1BdOT8u2KfLG4EuSbAfRdlBxvWmAAFGDa16qYK/UYIjIwYG3M/fSa+TWcHBxJAxPFs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbkry3aJBoy1JOsuai8whajadC55iG7oFTeEewkr0Bk9nqXsQj
	TlYXfkNO66H5kao6J5E/OZJYsxybvkM7C1U83HpcqkLFkhTtesUCCgEZ79T7LA==
X-Gm-Gg: ASbGncvejRCFfYxz8TdoEPm5HIqSZ13fl7tvmEUuM3L5SRB//CO9AtZHmiA8qhtPc2o
	j11FXvKpBMY//RkF9R8J0lAiT+RjiOTzP11LiVXseF3NFyqZv7sMRhZs//XRPJRW2He9/n5iK4J
	CR4MNOkZNDasFHNz7VOu2bUi51/hOiTd+hi3phVehGRL2+unIiPJWY60IuuirjsjU6PiuBhlJsg
	+0WrGG+WoUAtVgTapy94/dujIxmx6RGcCHeczwBJIKqNtuxR4/of2szHOuiDB3GQC+Z7/zT+GQu
	pnw+iull9P04akxVhsMbNo5Xn0aNPLxdg/KPgG05HEAYTj/wWfL23SjwssS5ZBftEPLXa7fwlHr
	Q0RT6scnrA86NA7Ol40/wxBrMSNd4
X-Google-Smtp-Source: AGHT+IEbj7VPi2QWqnq+ZR5J91run5w/LTdun/3oxaSqyc1Rbir1uolTTdq1UTm1ZdWyhe14ZjvRdw==
X-Received: by 2002:a05:6a20:3c8d:b0:234:b1d:70d3 with SMTP id adf61e73a8af0-2381143e790mr10185014637.17.1752769363592;
        Thu, 17 Jul 2025 09:22:43 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f5296csm16438047b3a.135.2025.07.17.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:22:43 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Thu, 17 Jul 2025 09:22:39 -0700
Message-ID: <20250717162240.512045-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717162240.512045-1-thepacketgeek@gmail.com>
References: <20250717162240.512045-1-thepacketgeek@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 26 ++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..4da41471cc6b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,3 +612,12 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
+
+What:		/sys/bus/pci/devices/.../serial_number
+Date:		July 2025
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


