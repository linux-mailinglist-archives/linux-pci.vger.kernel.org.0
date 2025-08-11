Return-Path: <linux-pci+bounces-33778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D65B21372
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D8626A15
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66C72D480C;
	Mon, 11 Aug 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaPcv+oF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E112D47F9;
	Mon, 11 Aug 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933976; cv=none; b=CFQd9+RipyXzTec8slI9liXRou7rjrJI278y+SaBVShVMh94/GjQ/+kYYnhmJvhg6ZmGzsEH0amdxNF0Oh09brgSAdNczIAmGZj67fh/2Hh+lNOzpjgudc8MhOGDXUNVV1w+2uNv6PtUjojMJG0A+dkau6zslrcmpAZVZqiMS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933976; c=relaxed/simple;
	bh=7TtroRd5pPcTYhSknBDgOtBvlln/rtrSpohsr4YwUvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mz2EsLLJVVazD10ANzdhH2LcqbqviFI/ky8KWM2Pu/u3uuDK7nA3xpFd0r0RSt9vhOfg/HcFrFDiAqtmeRsdzDIk3MKIeBWpQGoNzMHAVQD/MkRiuuOwwXYP8GVxJSomGnOyWxZc1sRufWcXcaD7EwtV4I2m05SsRq1KbEPomJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaPcv+oF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24049d16515so39009285ad.1;
        Mon, 11 Aug 2025 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754933974; x=1755538774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzDnONcSpsqvdV7IwgZ4K8ZQ0Lot64n1ajgnKT5KByM=;
        b=FaPcv+oF/bU9igXEOxbcBw/FUVyq9dJMGIZM9wrkQNAK+V+qf9dp9gIWi9uODzOk7F
         52vZim2VB7UXAN0EKoSlVSDqM9cawBIFhIg5KllVrSHGQs2zaMHbFIKhYvZeEVhh92Xi
         yfwrUpIYskcB++OrsWObmsb9fHSOqvjk4+0Ds8WfQkd9TVzddvdKLo7XmRht4SXsmQt9
         h7AlyyA5Wdw1ipv/WIrQd1RpHLQQKMttonKnKvtFaILwllwZ5gUj+26JeOmhwhZxBhlv
         SlYLNx0C3inCOrzys4HNpgdT3jM4G/9ENTERcLSA9uNmV0CZ/tDO+Pe7w0olvchTiGeE
         DFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933974; x=1755538774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzDnONcSpsqvdV7IwgZ4K8ZQ0Lot64n1ajgnKT5KByM=;
        b=u/PZePTlINUdQe7gbo22r2uHRcTu+zo3ibI4f5w9PBKkI9kjvv+vPbf/MgrHGWOUxo
         vDVWkUBn9HiK1o879OwDsCTOhkdtOVABeKP6Nm0yZtabmvaF/3Yi4ysoAXIxQgoqQpGd
         OW5hZb4E8cahq4C4FCAatMyq+v3I9ltmmBcYdyhbP0JYvmgI1z5b8oLphcB9m6qwL757
         mtBPS+WYtdTykypesR+mEc5h5A4ovIVSNAilzLRmXBIOFS5K49n//bjsrjLONuFE4EPk
         +79aMbIY3jCAxnPZqLZD9JcMzO/IifunqhMuMcVPbePFe6+XbiBkvhlAq0oWtsHI0lB6
         ALyA==
X-Forwarded-Encrypted: i=1; AJvYcCUNWAC/4VFqeAI9rtigJKFhkSpceKQomjkEIWz4CuzxTLHVnq37joT7qFBeRoUlvaCaLElJHNhtFrzKd4o=@vger.kernel.org, AJvYcCVeAcJhxNncKIB9if3s6yc4ui8qqEH+6JHBLcqo7rDFzoEwEMuEqAymWGAikJ4qNNcp+S/8gmd+3VNz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+O6TGRioKIJT2E1cuaT4EfmTZNNlIBY0snpPLE5KMyzJpT6r3
	rZ2X3te5rS8wYkXVu53OUZMhwIcCqT4+gAZDBvGRkfiktAOs3OPv7Qjl
X-Gm-Gg: ASbGncu9jZ7VAM3vFL3+tXxQEmy5OkXMYua+1rpv5YMhwWhsMlkBeuZgbz/XE22NY7s
	4brRQKW07/cUxLNa/ROMT59tmbEtfWXaNjv4QPeba1rs/gXqwZkft8pQ8BnAuYpwr7fhSynU4lI
	XTaSIVK636RLpnPQTE9ZwAvxhCNoGp61Lq9zWIcLbB/eNuUu7+01LBEkcADMOw53vVTFAd2KIFs
	LplX2L1W590qyo4zdBaZkRFpOKNFFEhi8ogtJw6iG5py9Qe9tY9p0NDnuNaShpF6D+pkMbwfk/U
	1D6s80uUHCYoiNYoD2Gfh9l5zEcRilxz07XpHQ2NQo9xh8HOJqRjzwi7l2FcxPC1Ao3jcjajHxT
	l9ijIIO2BFlqoTOplPL87toAUUkr4
X-Google-Smtp-Source: AGHT+IFcndukAzoSm+gas6DqMTlUp2NVt58tDSCUQF2KhB0ooZtmn7Prgle76JAAbyLJLa/nCdQZVQ==
X-Received: by 2002:a17:903:3b8c:b0:242:460f:e4a2 with SMTP id d9443c01a7336-242c2004168mr167000765ad.23.1754933974358;
        Mon, 11 Aug 2025 10:39:34 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9257sm280460965ad.153.2025.08.11.10.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:39:34 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Mon, 11 Aug 2025 10:39:30 -0700
Message-ID: <20250811173931.8068-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811173931.8068-1-thepacketgeek@gmail.com>
References: <20250811173931.8068-1-thepacketgeek@gmail.com>
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


