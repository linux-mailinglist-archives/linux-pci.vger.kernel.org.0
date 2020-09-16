Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7A26CB0F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgIPUVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 16:21:49 -0400
Received: from foss.arm.com ([217.140.110.172]:34472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgIPRaR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 13:30:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C6281FB;
        Wed, 16 Sep 2020 03:30:52 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.6.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EE3B3F718;
        Wed, 16 Sep 2020 03:30:51 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2] ARM/PCI: Remove unused fields from struct hw_pci
Date:   Wed, 16 Sep 2020 11:30:45 +0100
Message-Id: <20200916103045.28651-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904141607.4066-1-lorenzo.pieralisi@arm.com>
References: <20200904141607.4066-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The msi_ctrl, io_optional and align_resource fields in struct hw_pci are
currently unused by arm/mach PCI host controller drivers and we won't
be adding any new users.

Remove them and related code.

Link: https://lore.kernel.org/r/20200904141607.4066-1-lorenzo.pieralisi@arm.com
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
---
v1->v2

- Removed io_optional and align_resource fields as well

[v1] https://lore.kernel.org/linux-pci/20200904141607.4066-1-lorenzo.pieralisi@arm.com

 arch/arm/include/asm/mach/pci.h |  7 -------
 arch/arm/kernel/bios32.c        | 16 ++--------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 83d340702680..ea9bd08895b7 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -17,10 +17,8 @@ struct pci_host_bridge;
 struct device;
 
 struct hw_pci {
-	struct msi_controller *msi_ctrl;
 	struct pci_ops	*ops;
 	int		nr_controllers;
-	unsigned int	io_optional:1;
 	void		**private_data;
 	int		(*setup)(int nr, struct pci_sys_data *);
 	int		(*scan)(int nr, struct pci_host_bridge *);
@@ -28,11 +26,6 @@ struct hw_pci {
 	void		(*postinit)(void);
 	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
 	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
-	resource_size_t (*align_resource)(struct pci_dev *dev,
-					  const struct resource *res,
-					  resource_size_t start,
-					  resource_size_t size,
-					  resource_size_t align);
 };
 
 /*
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index eecec16aa708..e7ef2b5bea9c 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -394,8 +394,7 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static int pcibios_init_resource(int busnr, struct pci_sys_data *sys,
-				 int io_optional)
+static int pcibios_init_resource(int busnr, struct pci_sys_data *sys)
 {
 	int ret;
 	struct resource_entry *window;
@@ -405,14 +404,6 @@ static int pcibios_init_resource(int busnr, struct pci_sys_data *sys,
 			 &iomem_resource, sys->mem_offset);
 	}
 
-	/*
-	 * If a platform says I/O port support is optional, we don't add
-	 * the default I/O space.  The platform is responsible for adding
-	 * any I/O space it needs.
-	 */
-	if (io_optional)
-		return 0;
-
 	resource_list_for_each_entry(window, &sys->resources)
 		if (resource_type(window->res) == IORESOURCE_IO)
 			return 0;
@@ -462,7 +453,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 
 		if (ret > 0) {
 
-			ret = pcibios_init_resource(nr, sys, hw->io_optional);
+			ret = pcibios_init_resource(nr, sys);
 			if (ret)  {
 				pci_free_host_bridge(bridge);
 				break;
@@ -480,9 +471,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				bridge->sysdata = sys;
 				bridge->busnr = sys->busnr;
 				bridge->ops = hw->ops;
-				bridge->msi = hw->msi_ctrl;
-				bridge->align_resource =
-						hw->align_resource;
 
 				ret = pci_scan_root_bus_bridge(bridge);
 			}
-- 
2.26.1

