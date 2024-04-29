Return-Path: <linux-pci+bounces-6770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0708B55B2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9083B1C2232C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776203A8F7;
	Mon, 29 Apr 2024 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7UnnBF+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07273BBF9;
	Mon, 29 Apr 2024 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387635; cv=none; b=BkPGa1yV1TWbshwZ5wIrOY6S3j43Ng1Xvc83zLSlqNpNWGa7ePCi7bSgP6028R1ULQGeHzxMiQ9b2/qXaoePtGWPz9ybc3iVC/lcTG9aBzc1vglK8rVF5FLjcncLMNv2xqAny7nJsjsTtsFPs3gFRH04cK8brRIRvZjz5vkTnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387635; c=relaxed/simple;
	bh=WdCmZ4jx3b0oIOMBkGiXkCJsrYOJWNmYImReokvOXZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSgqngpuU+X6UfNySG1SYNufGRaXtas3OIY6N+d8kLddKSIT3HU4FpNu0HC69ylTOJWtReLxC34f7/UOEvzcjFZKA4szbUZsEgz9D5FkBJvYC4zZ/s2d7rq7XBMw9D3lJyBI8nS0SKmhCZLKEPmaok+ZU0H7AjryXbSyMJa7YDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7UnnBF+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387634; x=1745923634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WdCmZ4jx3b0oIOMBkGiXkCJsrYOJWNmYImReokvOXZQ=;
  b=J7UnnBF+OB6LPuz/RbN/V82c7J7ibI0fH1XjOO7HExeMN0csQuYfRWGo
   KNj+pSIXaRLnOWgk/tbX1AAdMKVriH41L7WGgoSr7FWT2dwIyVtA9MS9Z
   ABOVHoLcnPCWfBVbGorRCv5msQTfenO+MABLlRHVUqcZzbqFHJBI1dbZv
   unuysnzYIrfEGPSwALq1mjkaLbQuAKdJIH0QXkwbe6WLbDeycLQC1WaeB
   jvV+Y3hfISV/NiilJ3ppRHnZOrksgb9K2VDsMO/99A32IGz5hLHq085NY
   l85pp31s3I/N2qse2/YJArVMRPwzvL1Nj/cRIA/KK+aQEXOp/4Oge3YVN
   Q==;
X-CSE-ConnectionGUID: piFqYSDxTOW3vNEYNZEA5Q==
X-CSE-MsgGUID: 6eWig0gpRDaZfCn9DXVhPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9966393"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9966393"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:13 -0700
X-CSE-ConnectionGUID: stDX6XgTSJuv+E6+WewvQg==
X-CSE-MsgGUID: rEQrG+G5SKmYxHUm7cDUyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26037436"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/10] ARM: orion5x: Pass devfn to orion5x_pci_hw_{rd,wr}_conf()
Date: Mon, 29 Apr 2024 13:46:26 +0300
Message-Id: <20240429104633.11060-4-ilpo.jarvinen@linux.intel.com>
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

Pass the usual devfn instead of individual components into
orion5x_pci_hw_{rd,wr}_conf() to make the change into
pci_conf1_offset() in an upcoming commit easier.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/arm/mach-orion5x/pci.c | 45 +++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 77ddab90f448..6376e1db6386 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -270,15 +270,15 @@ static int orion5x_pci_local_bus_nr(void)
 	return((conf & PCI_P2P_BUS_MASK) >> PCI_P2P_BUS_OFFS);
 }
 
-static int orion5x_pci_hw_rd_conf(int bus, int dev, u32 func,
-					u32 where, u32 size, u32 *val)
+static int orion5x_pci_hw_rd_conf(int bus, u8 devfn, u32 where,
+				  u32 size, u32 *val)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&orion5x_pci_lock, flags);
 
 	writel(PCI_CONF_BUS(bus) |
-		PCI_CONF_DEV(dev) | ORION5X_PCI_CONF_REG(where) |
-		ORION5X_PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
+		PCI_CONF_DEV(PCI_SLOT(devfn)) | ORION5X_PCI_CONF_REG(where) |
+		ORION5X_PCI_CONF_FUNC(PCI_FUNC(devfn)) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
 
 	*val = readl(PCI_CONF_DATA);
 
@@ -292,8 +292,8 @@ static int orion5x_pci_hw_rd_conf(int bus, int dev, u32 func,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int orion5x_pci_hw_wr_conf(int bus, int dev, u32 func,
-					u32 where, u32 size, u32 val)
+static int orion5x_pci_hw_wr_conf(int bus, u8 devfn, u32 where,
+				  u32 size, u32 val)
 {
 	unsigned long flags;
 	int ret = PCIBIOS_SUCCESSFUL;
@@ -301,8 +301,8 @@ static int orion5x_pci_hw_wr_conf(int bus, int dev, u32 func,
 	spin_lock_irqsave(&orion5x_pci_lock, flags);
 
 	writel(PCI_CONF_BUS(bus) |
-		PCI_CONF_DEV(dev) | ORION5X_PCI_CONF_REG(where) |
-		ORION5X_PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
+		PCI_CONF_DEV(PCI_SLOT(devfn)) | ORION5X_PCI_CONF_REG(where) |
+		ORION5X_PCI_CONF_FUNC(PCI_FUNC(devfn)) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
 
 	if (size == 4) {
 		__raw_writel(val, PCI_CONF_DATA);
@@ -347,8 +347,7 @@ static int orion5x_pci_rd_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	return orion5x_pci_hw_rd_conf(bus->number, PCI_SLOT(devfn),
-					PCI_FUNC(devfn), where, size, val);
+	return orion5x_pci_hw_rd_conf(bus->number, devfn, where, size, val);
 }
 
 static int orion5x_pci_wr_conf(struct pci_bus *bus, u32 devfn,
@@ -357,8 +356,7 @@ static int orion5x_pci_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (!orion5x_pci_valid_config(bus->number, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return orion5x_pci_hw_wr_conf(bus->number, PCI_SLOT(devfn),
-					PCI_FUNC(devfn), where, size, val);
+	return orion5x_pci_hw_wr_conf(bus->number, devfn, where, size, val);
 }
 
 static struct pci_ops pci_ops = {
@@ -375,12 +373,14 @@ static void __init orion5x_pci_set_bus_nr(int nr)
 		 * PCI-X mode
 		 */
 		u32 pcix_status, bus, dev;
+		u8 devfn;
 		bus = (p2p & PCI_P2P_BUS_MASK) >> PCI_P2P_BUS_OFFS;
 		dev = (p2p & PCI_P2P_DEV_MASK) >> PCI_P2P_DEV_OFFS;
-		orion5x_pci_hw_rd_conf(bus, dev, 0, PCIX_STAT, 4, &pcix_status);
+		devfn = PCI_DEVFN(dev, 0);
+		orion5x_pci_hw_rd_conf(bus, devfn, PCIX_STAT, 4, &pcix_status);
 		pcix_status &= ~PCIX_STAT_BUS_MASK;
 		pcix_status |= (nr << PCIX_STAT_BUS_OFFS);
-		orion5x_pci_hw_wr_conf(bus, dev, 0, PCIX_STAT, 4, pcix_status);
+		orion5x_pci_hw_wr_conf(bus, devfn, PCIX_STAT, 4, pcix_status);
 	} else {
 		/*
 		 * PCI Conventional mode
@@ -393,15 +393,16 @@ static void __init orion5x_pci_set_bus_nr(int nr)
 
 static void __init orion5x_pci_master_slave_enable(void)
 {
-	int bus_nr, func, reg;
+	int bus_nr, reg;
+	u8 devfn;
 	u32 val;
 
 	bus_nr = orion5x_pci_local_bus_nr();
-	func = PCI_CONF_FUNC_STAT_CMD;
+	devfn = PCI_DEVFN(0, PCI_CONF_FUNC_STAT_CMD);
 	reg = PCI_CONF_REG_STAT_CMD;
-	orion5x_pci_hw_rd_conf(bus_nr, 0, func, reg, 4, &val);
+	orion5x_pci_hw_rd_conf(bus_nr, devfn, reg, 4, &val);
 	val |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-	orion5x_pci_hw_wr_conf(bus_nr, 0, func, reg, 4, val | 0x7);
+	orion5x_pci_hw_wr_conf(bus_nr, devfn, reg, 4, val | 0x7);
 }
 
 static void __init orion5x_setup_pci_wins(void)
@@ -424,7 +425,7 @@ static void __init orion5x_setup_pci_wins(void)
 
 	for (i = 0; i < dram->num_cs; i++) {
 		const struct mbus_dram_window *cs = dram->cs + i;
-		u32 func = PCI_CONF_FUNC_BAR_CS(cs->cs_index);
+		u8 devfn = PCI_DEVFN(0, PCI_CONF_FUNC_BAR_CS(cs->cs_index));
 		u32 reg;
 		u32 val;
 
@@ -432,15 +433,15 @@ static void __init orion5x_setup_pci_wins(void)
 		 * Write DRAM bank base address register.
 		 */
 		reg = PCI_CONF_REG_BAR_LO_CS(cs->cs_index);
-		orion5x_pci_hw_rd_conf(bus, 0, func, reg, 4, &val);
+		orion5x_pci_hw_rd_conf(bus, devfn, reg, 4, &val);
 		val = (cs->base & 0xfffff000) | (val & 0xfff);
-		orion5x_pci_hw_wr_conf(bus, 0, func, reg, 4, val);
+		orion5x_pci_hw_wr_conf(bus, devfn, reg, 4, val);
 
 		/*
 		 * Write DRAM bank size register.
 		 */
 		reg = PCI_CONF_REG_BAR_HI_CS(cs->cs_index);
-		orion5x_pci_hw_wr_conf(bus, 0, func, reg, 4, 0);
+		orion5x_pci_hw_wr_conf(bus, devfn, reg, 4, 0);
 		writel((cs->size - 1) & 0xfffff000,
 			PCI_BAR_SIZE_DDR_CS(cs->cs_index));
 		writel(cs->base & 0xfffff000,
-- 
2.39.2


