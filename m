Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47A827FA6D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 09:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJAHoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 03:44:11 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35426 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAHoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 03:44:10 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 981363B380A;
        Thu,  1 Oct 2020 07:43:12 +0000 (UTC)
Received: from localhost (lfbn-tou-1-420-199.w86-206.abo.wanadoo.fr [86.206.245.199])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A7DD020000A;
        Thu,  1 Oct 2020 07:42:50 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 2/2] PCI: dwc: spear13xx driver needs OF
Date:   Thu,  1 Oct 2020 09:42:44 +0200
Message-Id: <20201001074244.349443-2-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001074244.349443-1-thomas.petazzoni@bootlin.com>
References: <20201001074244.349443-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes the following build warning when CONFIG_OF is disabled:

drivers/pci/controller/dwc/pcie-spear13xx.c:297:34: warning: ‘spear13xx_pcie_of_match’ defined but not used [-Wunused-const-variable=]
  297 | static const struct of_device_id spear13xx_pcie_of_match[] = {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 96994b715f26..62f6671d7e12 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -96,7 +96,7 @@ config PCI_IMX6
 
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
-	depends on ARCH_SPEAR13XX || COMPILE_TEST
+	depends on OF && (ARCH_SPEAR13XX || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-- 
2.26.2

