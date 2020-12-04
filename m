Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDA2CF27F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgLDQ70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 11:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbgLDQ70 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 11:59:26 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Alex Dewar <alex.dewar90@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: exynos: add back MSI dependency
Date:   Fri,  4 Dec 2020 17:58:34 +0100
Message-Id: <20201204165841.3845589-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

While the exynos driver does not always need MSI, the generic
deisgnware host code it uses fails to build without it:

WARNING: unmet direct dependencies detected for PCIE_DW_HOST
  Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
  Selected by [y]:
  - PCI_EXYNOS [=y] && PCI [=y] && (ARCH_EXYNOS [=n] || COMPILE_TEST [=y])
drivers/pci/controller/dwc/pcie-designware-host.c:247:19: error: implicit declaration of function 'pci_msi_create_irq_domain' [-Werror,-Wimplicit-function-declaration]
        pp->msi_domain = pci_msi_create_irq_domain(fwnode,
                         ^

Add back the dependency that all other designware controllers have.

Fixes: f0a6743028f9 ("PCI: dwc: exynos: Rework the driver to support Exynos5433 variant")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 020101b58155..e403bb2eeb4c 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -85,6 +85,7 @@ config PCIE_DW_PLAT_EP
 config PCI_EXYNOS
 	tristate "Samsung Exynos PCIe controller"
 	depends on ARCH_EXYNOS || COMPILE_TEST
+	depends on PCI && PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
 	  Enables support for the PCIe controller in the Samsung Exynos SoCs
-- 
2.27.0

