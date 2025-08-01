Return-Path: <linux-pci+bounces-33314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A6B18737
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 20:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AE81C271F1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3865B28D82F;
	Fri,  1 Aug 2025 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNfOWXoO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03F28C87D;
	Fri,  1 Aug 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072012; cv=none; b=IuFAiTaYwhD86+nAMTDaKyWPg1OOH8aK03Z9fs0EYxrnUPe9OCvTj1c9qz9xJ1g6EVu+89E9J5iL6nbFrGlv9rvw9YezjTS/VoVuFAD7T5BD/nvZJzdlF5WkZ2j82mS9qSaEAJTXpY1hRTwp+VBvJk+GglvImWk3dogOFeXu+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072012; c=relaxed/simple;
	bh=7TtroRd5pPcTYhSknBDgOtBvlln/rtrSpohsr4YwUvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEcxfVjc6i45AoovGqu3MN53cXXs9g2gRK0W4D1OrijRnhYaubh4X1QOZnvm56IjnEBBg6R9/HB3hdSS9J0uYoQUEKHBVWnoSEBp4BUE8k2DmTCYybqS9blQ84ZfdqLdVz760AAxESRpJikdLn53tAA5jct41TV49A0rVjbhH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNfOWXoO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23fd3fe0d81so19759735ad.3;
        Fri, 01 Aug 2025 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754072010; x=1754676810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzDnONcSpsqvdV7IwgZ4K8ZQ0Lot64n1ajgnKT5KByM=;
        b=eNfOWXoOWXsXV3SDr2Rb8NGn6SdnwD0K7kqYu5zbcHATct79agqJqYd2JaVp2IsGM8
         kHyumE6Q2Wh64zWB4wziDnYzqbNWbpZdOebQUVXV7tqffi9ETrhykr66Y8rVmrXfAglu
         5pPNl+aStGb29o3mA4NPJ4oGxKWmeWP+yEALaNHE5bpZhSoDZC4K765D6Jk4Ik2scZwT
         e/nLboMNjnDywrxJtufwpz+pLRnPRoFMoIFF/rAZOS7+opUcnYq0dh7ZIhaGXDma5Tz/
         d6+dUUgykoDeuYw5Ibqkufu7QmdTWGtAp4brIuasUa+9CWQbymKzCtrWRFK7hITIZcXr
         KRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754072010; x=1754676810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzDnONcSpsqvdV7IwgZ4K8ZQ0Lot64n1ajgnKT5KByM=;
        b=lnLtzz+2cxihRhuvIucgU7TIWdwQAeS6f99xkQ+c4CPntNcc5t0c4QgcMAdfwFy7Rk
         H6iyh74z6Gc1Xivtsj2WelWmrVdFvcOPzdBqsTo1KiUNt2F7PWox08KzpmGiV9JQJZOm
         QvBeVPXfLZxSz86kqbTUh8+Rom5OnT4x3ACbZ74XFtweQl9FjjRl1S8ydEQkpr+JUSkP
         bGmd15TITjrAIj09zYrPpFyq0mkf/dLeJNC4Nj/rURz1BE9UZY9mvpKYSRyb8qm9vzC2
         eRPeEB5epCL6MeJYrTLPnkEnRbujpqVpWR0qpwMIcMiJ4B5W5iodt5J90sVnpulY35wf
         Ex/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlhJwfQY6Cp+Ubv0HxCoLYuE/vuKfDLn/cZaysaDL6x27ze9M/CAtT+c8bcI01V60Y5tGhV7JZHZwzSpk=@vger.kernel.org, AJvYcCXh+CYnCoq5BmMQOAZRuzwGYC5uQn7arB9gm77H7YfcKgVLBblPw2YGayldTxv7MS0cH/0nWFDunJMY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8THXplC2LzpAXlZwoS4pT2j5olyHkQMJLTLSNIPJKaUJQh10
	vID74IoS6pOB51sRlh88urkhyuKMte6zIvxkyYV/ASKZfyhvBf/zWy0Q
X-Gm-Gg: ASbGncvFMHNmSOkiOF5m4m/Y5qfM78xLFr84NqmYaQ1Lffa+I1UqHYdrs9kW6eg2b3o
	5+Z2zY67LDJ6MLPNW/fT/yb/yA/UwyoQs7GDtP7qXysAS6mbBo/S1EqkYaOUlh8wuIfGc+pAOF4
	03INsZ2zdTnM1HG3vSgeDf+yWIFYePNT7ZzLpG3wMVhzPwstBHmgq0bLothfJKl0aNpiEXtQAJU
	Si5FmjaAQiwYqt4m5OiIFqXLepG3JTyw5hrWcSUCnBrnK04DZTXmPEeGzHOnqsCJJ4vxPprw9DW
	Z4mi+BXbWyd5/1e6gUbTrDpiLukwbhTJ6miMbpZe+R+KW67ifq/4JTOS3f2z5KHogu9Zhuknnqw
	3ieFBNhbeU9GVNE85DgdCeuxXnZOi
X-Google-Smtp-Source: AGHT+IERUNJQRv/peiOQbcz9BwWTs/B9jJiQ3TVpxwzfFVpe4VLvxrNjns/E+YW/X2F6Dt9B+n7zXA==
X-Received: by 2002:a17:903:24f:b0:240:6fda:582a with SMTP id d9443c01a7336-24246f82e11mr7150555ad.23.1754072009754;
        Fri, 01 Aug 2025 11:13:29 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bacbb74sm4233582a12.42.2025.08.01.11.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:13:29 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Fri,  1 Aug 2025 11:13:24 -0700
Message-ID: <20250801181326.1782789-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801181326.1782789-1-thepacketgeek@gmail.com>
References: <20250801181326.1782789-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only interface for reading PCIe device serial
numbers from userspace in a programmatic way. This device attribute
uses the same hexadecimal 1-byte dashed formatting as lspci serial number
capability output. If a device doesn't support the serial number
capability, the serial_number sysfs attribute will not be visible.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Reviewed-by: Mario Limonciello <superm1@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..d5251f4f3659 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,3 +612,12 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
+
+What:		/sys/bus/pci/devices/.../serial_number
+Date:		December 2025
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


