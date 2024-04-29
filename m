Return-Path: <linux-pci+bounces-6769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6398B55B0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9961F210CD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFB2941F;
	Mon, 29 Apr 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1NnVp3+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AD1EB2F;
	Mon, 29 Apr 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387629; cv=none; b=EvvHfaF8Y2b9CNxra+NmO93Zn+XPaLyLkK14ayIfX5EWRCJyzV8AicPKQGBSlFkckgbGQZS9XcBDS1I7sdAzWEgpuDsc5o061XW68IOXaBeQFydO4NoqmiG4De4NDlSoLpwHHjWCEsGJFL/NT1eQryYxsjBvBAd7kVQwaAsakmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387629; c=relaxed/simple;
	bh=5RZ+h1IoRyl+mzWTI7YpuHfoFDK7vqb4rzWTaBr0ZpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESpDYlXwyBlsq5/NuWXLXAceZN53F6NI8zAZBEazh7FJShBcCZ+AQc9IzENqvtegXLKy6PLVs6KWsbGio5buVateXXT+TZOPfvNNwKkIE4CZp6KgB7VLofi4wB/DwtyMbZtTKkMSFZliepHrsxtvHRMiiNxBDSiwq2GdTrMQqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1NnVp3+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387627; x=1745923627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5RZ+h1IoRyl+mzWTI7YpuHfoFDK7vqb4rzWTaBr0ZpE=;
  b=C1NnVp3+7Cpd4AFJNVijywjb7JkzPWJH3J11XRC8/Dl+iAgk4olZboNG
   KR80j4gQXW3LSDa4p7nv+KbgSyGYZPmBee/zQWLiBQgnmkYV1QhauIt5g
   uy+tw1iaNT8TrlnEPwv6yp4GsO/892Rf9gZdZETwY1etsC3pix1F9z0jB
   mXccSGazPx5BkHBEUu00kYM9rXwFWvzf7UWl03LbyJTMGTSbUHVc6lU5S
   QoNgR/kFXf3VcsXjRvDsO1/s55XN9ACx9ouVOGd7rxBB6h7c8/F6254bu
   4dkqOw5/mHzYhCRbS5uwqp3JrTjxNhd/as3UrV4s6yLjf2S2bfQg3Hxw9
   A==;
X-CSE-ConnectionGUID: BCDj1uMMSPWr7lri/ZmiPA==
X-CSE-MsgGUID: pfQLVlSeQqSjaInedNxZqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27558897"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="27558897"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:05 -0700
X-CSE-ConnectionGUID: 8t7syE0iRJuBM5i997zQkg==
X-CSE-MsgGUID: BCE0VLeCQZihz3IHH40oOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30896725"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/10] PCI: Add helpers to calculate PCI Conf Type 0/1 addresses
Date: Mon, 29 Apr 2024 13:46:25 +0300
Message-Id: <20240429104633.11060-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Many places in arch and PCI controller code need to calculate PCI
Configuration Space Addresses for Type 0/1 accesses. There are small
variations between archs when it comes to bits outside of [10:2] (Type
0) and [24:2] (Type 1) but the basic calculation can still be
generalized.

drivers/pci/pci.h has PCI_CONF1{,_EXT}_ADDRESS() but due to their
location the use is limited to PCI subsys and the also always enable
PCI_CONF1_ENABLE which is not what all the callers want.

Add generic pci_conf{0,1}_addr() and pci_conf1_ext_addr() helpers into
include/linux/pci.h which can be reused by various parts of the kernel
that have to calculate PCI Conf Type 0/1 addresses.

The PCI_CONF* defines are needed by the new helpers so move also them
to include/linux/pci.h. The new helpers use true bitmasks and
FIELD_PREP() instead of open coded masking and shifting so adjust
PCI_CONF* definitions to match that.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   | 43 ++---------------------
 include/linux/pci.h | 85 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..cf0530a60105 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -833,49 +833,12 @@ struct pci_devres {
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
 
-/*
- * Config Address for PCI Configuration Mechanism #1
- *
- * See PCI Local Bus Specification, Revision 3.0,
- * Section 3.2.2.3.2, Figure 3-2, p. 50.
- */
-
-#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
-#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
-#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
-
-#define PCI_CONF1_BUS_MASK	0xff
-#define PCI_CONF1_DEV_MASK	0x1f
-#define PCI_CONF1_FUNC_MASK	0x7
-#define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
-
-#define PCI_CONF1_ENABLE	BIT(31)
-#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
-#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
-#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
-#define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
-
 #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
 	(PCI_CONF1_ENABLE | \
-	 PCI_CONF1_BUS(bus) | \
-	 PCI_CONF1_DEV(dev) | \
-	 PCI_CONF1_FUNC(func) | \
-	 PCI_CONF1_REG(reg))
-
-/*
- * Extension of PCI Config Address for accessing extended PCIe registers
- *
- * No standardized specification, but used on lot of non-ECAM-compliant ARM SoCs
- * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Config Address
- * are used for specifying additional 4 high bits of PCI Express register.
- */
-
-#define PCI_CONF1_EXT_REG_SHIFT	16
-#define PCI_CONF1_EXT_REG_MASK	0xf00
-#define PCI_CONF1_EXT_REG(x)	(((x) & PCI_CONF1_EXT_REG_MASK) << PCI_CONF1_EXT_REG_SHIFT)
+	 pci_conf1_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
 
 #define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
-	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
-	 PCI_CONF1_EXT_REG(reg))
+	(PCI_CONF1_ENABLE | \
+	 pci_conf1_ext_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
 
 #endif /* DRIVERS_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..4c4e3bb52a0a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -26,6 +26,8 @@
 #include <linux/args.h>
 #include <linux/mod_devicetable.h>
 
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -1183,6 +1185,89 @@ void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
 
+/*
+ * Config Address for PCI Configuration Mechanism #0/1
+ *
+ * See PCI Local Bus Specification, Revision 3.0,
+ * Section 3.2.2.3.2, Figure 3-1 and 3-2, p. 48-50.
+ */
+#define PCI_CONF_REG		0x000000ffU	/* common for Type 0/1 */
+#define PCI_CONF_FUNC		0x00000700U	/* common for Type 0/1 */
+#define PCI_CONF1_DEV		0x0000f800U
+#define PCI_CONF1_BUS		0x00ff0000U
+#define PCI_CONF1_ENABLE	BIT(31)
+
+/**
+ * pci_conf0_addr - PCI Base Configuration Space address for Type 0 access
+ * @devfn:      Device and function numbers (device number will be ignored)
+ * @reg:        Base configuration space offset
+ *
+ * Calculates the PCI Configuration Space address for Type 0 accesses.
+ *
+ * Note: the caller is responsible for adding the bits outside of [10:0].
+ *
+ * Return: Base Configuration Space address.
+ */
+static inline u32 pci_conf0_addr(u8 devfn, u8 reg)
+{
+	return FIELD_PREP(PCI_CONF_FUNC, PCI_FUNC(devfn)) |
+	       FIELD_PREP(PCI_CONF_REG, reg & ~3);
+}
+
+/**
+ * pci_conf1_addr - PCI Base Configuration Space address for Type 1 access
+ * @bus:	Bus number of the device
+ * @devfn:	Device and function numbers
+ * @reg:	Base configuration space offset
+ * @enable:	Assert enable bit (bit 31)
+ *
+ * Calculates the PCI Base Configuration Space (first 256 bytes) address for
+ * Type 1 accesses.
+ *
+ * Note: the caller is responsible for adding the bits outside of [24:2]
+ * and enable bit.
+ *
+ * Return: PCI Base Configuration Space address.
+ */
+static inline u32 pci_conf1_addr(u8 bus, u8 devfn, u8 reg, bool enable)
+{
+	return (enable ? PCI_CONF1_ENABLE : 0) |
+	       FIELD_PREP(PCI_CONF1_BUS, bus) |
+	       FIELD_PREP(PCI_CONF1_DEV | PCI_CONF_FUNC, devfn) |
+	       FIELD_PREP(PCI_CONF_REG, reg & ~3);
+}
+
+/*
+ * Extension of PCI Config Address for accessing extended PCIe registers
+ *
+ * No standardized specification, but used on lot of non-ECAM-compliant ARM SoCs
+ * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Config Address
+ * are used for specifying additional 4 high bits of PCI Express register.
+ */
+#define PCI_CONF1_EXT_REG	0x0f000000UL
+
+/**
+ * pci_conf1_ext_addr - PCI Configuration Space address for Type 1 access
+ * @bus:	Bus number of the device
+ * @devfn:	Device and function numbers
+ * @reg:	Base or Extended Configuration space offset
+ * @enable:	Assert enable bit (bit 31)
+ *
+ * Calculates the PCI Base and Extended (4096 bytes per PCI function)
+ * Configuration Space address for Type 1 accesses. This function assumes
+ * the Extended Conguration Space is using the reserved bits [27:24].
+ *
+ * Note: the caller is responsible for adding the bits outside of [27:2] and
+ * enable bit.
+ *
+ * Return: PCI Configuration Space address.
+ */
+static inline u32 pci_conf1_ext_addr(u8 bus, u8 devfn, u16 reg, bool enable)
+{
+	return FIELD_PREP(PCI_CONF1_EXT_REG, (reg & 0xf00) >> 8) |
+	       pci_conf1_addr(bus, devfn, reg & 0xff, enable);
+}
+
 /* Generic PCI functions exported to card drivers */
 
 u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
-- 
2.39.2


