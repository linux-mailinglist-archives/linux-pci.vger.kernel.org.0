Return-Path: <linux-pci+bounces-34497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ADFB309EF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 01:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433791C81F44
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 23:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49DA2E7F14;
	Thu, 21 Aug 2025 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdc89cNw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435AB2DC323;
	Thu, 21 Aug 2025 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818565; cv=none; b=n11AgM7o46E3lX7IbYmV7REYqI4H3r8ebETebMdbUrLKlxZONLMmdrrkQCPIW67nv3yE73+z1Tj6dxreQFgXFqrwpyF3WRsgNi/VoWQlp7AVpMLX4VUcHsEPanb9CfhxDaa4gPLW1lOttAxTl83euA5Hb9iUEoMqjR1STlNMAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818565; c=relaxed/simple;
	bh=7TtroRd5pPcTYhSknBDgOtBvlln/rtrSpohsr4YwUvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2juSo50Ng7wxCYFOpnmSwhEFmNTQpNWlUT7a2lezpYSo+vSgR4yqWcAB6d29Zcc1x4Xqz7HRaaLD5SkLsMQUDagM8Wsv91Ol8euLYxw07MSiEmCoiZKF+p8A0ASazeAb1149Qc7rp+Ln5LmHPfFJSG+FwCO3RqgrlgnzcVgLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdc89cNw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b474a38b25cso1281371a12.0;
        Thu, 21 Aug 2025 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818562; x=1756423362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzDnONcSpsqvdV7IwgZ4K8ZQ0Lot64n1ajgnKT5KByM=;
        b=Bdc89cNwcONKkWb5kRTMqvFVGWzHRLxzs6xTTR44Y2cEyBs56WIDBUXXlW7CeTpMlw
         hCc30XdVO6v5XEx1t+GhKsxNQTAGpx3HapWCM8dxaVMoit8qFdymz9JZcrAqCXbZmH2s
         DG4oYnVPazK4cisqRBOG9lwjDIGyUNVpsgC914wg50/tX8BmDvRaYc1ZuPaf4n3VfPBP
         uoeG2+FOHJES6ol0mq37X31v9NzN0eW3uPubU1SpKGmDOzuMDa/DbnuKbxKFwbXk9Chs
         +Ox6gBqhPzJaAhYqsFzUWh78axlnFByZn041HkEHNAl1REUIR+Mn08RnA0CgRuxamxhb
         w0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818562; x=1756423362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzDnONcSpsqvdV7IwgZ4K8ZQ0Lot64n1ajgnKT5KByM=;
        b=CqZrVClx2F0es5PLqCPlUcaXukPOyZXQWrpECiV3W7tjQknRMAxBcEOcoKW8rBVAZv
         LFkx6divnHTulyB25c8N9eueiYjLBna47hQMjV8bwQdLTb+Fpk6FWAbHUI2m6uDf1x/g
         OiaPQhPfYFrZdDz4/2CANMmpZF4jk0+hDE5XAtxCnq/BW0ktw4XqUcWbkgI8MiyQ69bV
         6EmtKQrJhors89PxdxrRDU6g8Q5RiRVtl7unGYeDwTMDcvEvvm4S0Narkj/ur27yc3Zh
         MMQlk/KAFUFM3A86ZzZ3LyOdpUvXKZzfKqPvU0HP0SMIoicyuVgaBNV9/HKQgK7T88hj
         lkYg==
X-Forwarded-Encrypted: i=1; AJvYcCVK0KdGnSncE+MMrrICVWRzL4atExj75qVri6QZtssWytMOpuWVhOOlzgwf9BrzkdzHSeq54/zMv0vO@vger.kernel.org, AJvYcCWU+WU+jEqxt6CyEW+4ncnCJjxYoQ3sAabe/nmt4H55YzvuX1rwgClunA7pEJWDV+rxOJcftW9zgcq9RjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJD4yT8SLGZAh684Jz0/vQ72DHWApGaZyllKdnCdGyYNwjtSeq
	y/oVRXa8EISqxOZ4xd5mtHyk8ccaET4Qi2aH8T2UbEw0/0e7mj50cJu9
X-Gm-Gg: ASbGncv5FHQa0IU4bz1uFL5PXkoEIo2WMSVQWOH59gneGCW9HUr+xdho48UTPmgdFRI
	Ud42ZkN97ulnGDp2x8Sh/M02WnI6tHxvFstWrFnMG8vt5/Fd6zpCeQO7vJAfAiBTW0/APK68qQY
	E0IPiLgjXdbCLoazuSVsPa/wF1aOBZuGZk4J9wZqrvG4/47L87PNp/pDOgUskGljmQ4qNHRib2Z
	khmIu2Flq8dZTsVeJIsb1F+/FOHSC65h+/T7DefkwBdRbCYgDdBcHQdfIMsCd68XIn0riz+Hhqf
	OOhw1MQnDFNFYZCxnLieksqWaSoiZ2IHCbQPQBpkH/3pRTetFN1OCjqwZazWEmAv95P2mQW9iQa
	4PFIKNNCdvDeuHAvGfqPvKGKUAZoVF6jcneDuao0=
X-Google-Smtp-Source: AGHT+IELU39npPsioIjK/aIzVWdwKUcxn2a+0FLJWMu4ekO8pE1bBOW8nhtZYXsgHpwrsveJdb5sCg==
X-Received: by 2002:a17:902:d4cf:b0:245:f88a:704a with SMTP id d9443c01a7336-2462ef4030dmr15002295ad.31.1755818562465;
        Thu, 21 Aug 2025 16:22:42 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51c7c8sm65809805ad.140.2025.08.21.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:22:42 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Thu, 21 Aug 2025 16:22:38 -0700
Message-ID: <20250821232239.599523-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821232239.599523-1-thepacketgeek@gmail.com>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
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


