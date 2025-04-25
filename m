Return-Path: <linux-pci+bounces-26730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7646A9C374
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 11:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B6463EAC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4EB21C9EF;
	Fri, 25 Apr 2025 09:29:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765E4C6E
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573346; cv=none; b=KytxrBZbCEZ9S60xv+9J8nhXFruPDrXRuzzgnCe7iXO68Azh+H/hCT+2hnbjss+RVRAaO9TyUE/NL5V8YYdRjx5rGcCaKDBwqheyqQLcUyHMs5H0x2Hhc1s7RNcc/rbzjs35Jgp5ulPGiKkqAVGWvxOmosYm1XzZr6JpVF246f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573346; c=relaxed/simple;
	bh=qZh7R73OEiTz7nMIBMHtFXhxKzMqGt7qKeWOwin131k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=k4+v8PNZ6cnFHwoL0KyIV8AB7v30rt35B7F976fLZdGrCvyZ6OyLiF/qXZA99po8RH0yDDTRDBPI8ezhp/plbyrU0+m0jTuFZ0L8AWb9/1nHPxeZLoodmM8dvoPsyPX8cLewBPXRjWwUwrcj63i3hHyUU0ZNFGSnX1Lmh3mXarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id EAF252C4C3F1;
	Fri, 25 Apr 2025 11:28:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 87AE0ECCCB; Fri, 25 Apr 2025 11:29:03 +0200 (CEST)
Message-Id: <d22a9e5b81d6bd8dd1837607d6156679b3b1199c.1745572340.git.lukas@wunner.de>
In-Reply-To: <cover.1745572340.git.lukas@wunner.de>
References: <cover.1745572340.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 25 Apr 2025 11:24:22 +0200
Subject: [PATCH 2/2] PCI: Limit visibility of match_driver flag to PCI core
To: Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Since commit 58d9a38f6fac ("PCI: Skip attaching driver in device_add()"),
PCI enumeration is split into two steps:  In the first step, all devices
are published in sysfs with device_add().  In the second step, drivers are
bound to the devices with device_attach().  To delay driver binding until
the second step, a "bool match_driver" in struct pci_dev is used.

Instead of a bool, use a bit in the "unsigned long priv_flags" to shrink
struct pci_dev a little and prevent use of the bool outside the PCI core
(as has happened with commit cbbc00be2ce3 ("iommu/amd: Prevent binding
other PCI drivers to IOMMU PCI devices")).

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/bus.c        |  4 +++-
 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.h        | 11 +++++++++++
 drivers/pci/probe.c      |  1 -
 include/linux/pci.h      |  2 --
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index b685110..6904886 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -369,7 +369,9 @@ void pci_bus_add_device(struct pci_dev *dev)
 				pdev->name);
 	}
 
-	dev->match_driver = !dn || of_device_is_available(dn);
+	if (!dn || of_device_is_available(dn))
+		pci_dev_allow_binding(dev);
+
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index c8bd71a..0c5bdb8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1507,7 +1507,7 @@ static int pci_bus_match(struct device *dev, const struct device_driver *drv)
 	struct pci_driver *pci_drv;
 	const struct pci_device_id *found_id;
 
-	if (!pci_dev->match_driver)
+	if (pci_dev_binding_disallowed(pci_dev))
 		return 0;
 
 	pci_drv = (struct pci_driver *)to_pci_driver(drv);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99c..de5d4ef 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -557,6 +557,7 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 #define PCI_DPC_RECOVERED 1
 #define PCI_DPC_RECOVERING 2
 #define PCI_DEV_REMOVED 3
+#define PCI_DEV_ALLOW_BINDING 7
 
 static inline void pci_dev_assign_added(struct pci_dev *dev)
 {
@@ -580,6 +581,16 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
 	return test_and_set_bit(PCI_DEV_REMOVED, &dev->priv_flags);
 }
 
+static inline void pci_dev_allow_binding(struct pci_dev *dev)
+{
+	set_bit(PCI_DEV_ALLOW_BINDING, &dev->priv_flags);
+}
+
+static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
+{
+	return !test_bit(PCI_DEV_ALLOW_BINDING, &dev->priv_flags);
+}
+
 #ifdef CONFIG_PCIEAER
 #include <linux/aer.h>
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a..126ae1e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2711,7 +2711,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	pci_set_msi_domain(dev);
 
 	/* Notifier could use PCI capabilities */
-	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6..e29d7d4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -425,8 +425,6 @@ struct pci_dev {
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 	struct resource driver_exclusive_resource;	 /* driver exclusive resource ranges */
 
-	bool		match_driver;		/* Skip attaching driver */
-
 	unsigned int	transparent:1;		/* Subtractive decode bridge */
 	unsigned int	io_window:1;		/* Bridge has I/O window */
 	unsigned int	pref_window:1;		/* Bridge has pref mem window */
-- 
2.47.2


