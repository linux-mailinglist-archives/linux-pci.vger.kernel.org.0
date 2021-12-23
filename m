Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC347E926
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 22:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350374AbhLWViB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 16:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350360AbhLWViB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 16:38:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F58BC061756;
        Thu, 23 Dec 2021 13:38:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53E4ECE2200;
        Thu, 23 Dec 2021 21:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE86C36AE9;
        Thu, 23 Dec 2021 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640295477;
        bh=44GMKBWOMz8CYw7hOFvtvXHi1D2y4pTa6iH6EqHFN9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oB6RVHIFmFVg4Zy7m8F1ScDCmnhFSsKsfVz9m94zXw3ZMjvvROSubpQW31hC3GQ2k
         5cyFOPeQ+qDcr6VbrlBLHkjXuma26s6ECtHfgyzLNCVHlabNrhzWbWACQ4Pv5HZtbA
         XJ6zyFpxXE4bjxbyLK271TwjBz+SuQ5dhHq66hVcFbyOc5B4NnepWjXy5GPf+0FXuj
         U1gso8lasZHIjYZiWMXAwmrmUo0gnKk85sL2oHXcL5VZ7RwqqRVyOsCtBZkZMwj/Ja
         u2DKF/NXKv8h5l/f7DyJiMRQ1xQfclNx4u6F/LI8Ln0B5+gdCTJDY3C6DcE2aW3jkA
         H4m8YRL1eGV6w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Pratyush Anand <pratyush.anand@gmail.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI: spear13xx: Avoid invalid address space conversions
Date:   Thu, 23 Dec 2021 15:37:49 -0600
Message-Id: <20211223213749.1314142-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223213749.1314142-1-helgaas@kernel.org>
References: <20211223213749.1314142-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The sparse checker complains about converting pointers between address
spaces.  We correctly stored an __iomem pointer in struct spear13xx_pcie,
but discarded the __iomem when extracting app_base, causing one warning.
Then we passed the non-__iomem pointer to writel(), which expects an
__iomem pointer, causing another warning.

Add the appropriate annotations.

The sparse warnings look like this:

  $ make C=2 drivers/pci/controller/
  drivers/pci/controller/dwc/pcie-spear13xx.c:72:54: warning: incorrect type in initializer (different address spaces)
  drivers/pci/controller/dwc/pcie-spear13xx.c:72:54:    expected struct pcie_app_reg *app_reg
  drivers/pci/controller/dwc/pcie-spear13xx.c:72:54:    got void [noderef] __iomem *app_base
  drivers/pci/controller/dwc/pcie-spear13xx.c:78:26: warning: incorrect type in argument 2 (different address spaces)
  drivers/pci/controller/dwc/pcie-spear13xx.c:78:26:    expected void volatile [noderef] __iomem *addr
  drivers/pci/controller/dwc/pcie-spear13xx.c:78:26:    got unsigned int *

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 1a9e353bef55..1569e82b5568 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -69,7 +69,7 @@ struct pcie_app_reg {
 static int spear13xx_pcie_start_link(struct dw_pcie *pci)
 {
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
-	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct pcie_app_reg __iomem *app_reg = spear13xx_pcie->app_base;
 
 	/* enable ltssm */
 	writel(DEVICE_TYPE_RC | (1 << MISCTRL_EN_ID)
@@ -83,7 +83,7 @@ static int spear13xx_pcie_start_link(struct dw_pcie *pci)
 static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct spear13xx_pcie *spear13xx_pcie = arg;
-	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct pcie_app_reg __iomem *app_reg = spear13xx_pcie->app_base;
 	struct dw_pcie *pci = spear13xx_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	unsigned int status;
@@ -102,7 +102,7 @@ static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 
 static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pcie)
 {
-	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct pcie_app_reg __iomem *app_reg = spear13xx_pcie->app_base;
 
 	/* Enable MSI interrupt */
 	if (IS_ENABLED(CONFIG_PCI_MSI))
@@ -113,7 +113,7 @@ static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pc
 static int spear13xx_pcie_link_up(struct dw_pcie *pci)
 {
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
-	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct pcie_app_reg __iomem *app_reg = spear13xx_pcie->app_base;
 
 	if (readl(&app_reg->app_status_1) & XMLH_LINK_UP)
 		return 1;
-- 
2.25.1

