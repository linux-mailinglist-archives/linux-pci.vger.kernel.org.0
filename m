Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA295BB80F
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 14:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIQMDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 08:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIQMDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 08:03:13 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9064303FA
        for <linux-pci@vger.kernel.org>; Sat, 17 Sep 2022 05:03:12 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 13F2192009C; Sat, 17 Sep 2022 14:03:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0E49D92009B;
        Sat, 17 Sep 2022 13:03:10 +0100 (BST)
Date:   Sat, 17 Sep 2022 13:03:09 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] PCI: Consistently report presence of PCIe link
 registers
In-Reply-To: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2209100057070.2275@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Consistently with commit c8b303d0206b ("PCI: Remove PCIe Capability 
version checks") only consider the PCI Express capability's Link Control 
2, etc. registers present if the Link Control register is.

Before said commit with PCI Express capability versions higher than one 
all link registers used to be considered present, however starting from 
said commit Link Control, etc. original registers are only considered 
present in devices with links, but Link Control 2, etc. registers 
continue being considered always present even though likewise they are 
only present in devices with links.

Fix the inconsistency then.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v5.
---
 drivers/pci/access.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

linux-pcie-cap-has-lnkctl2.diff
Index: linux-macro/drivers/pci/access.c
===================================================================
--- linux-macro.orig/drivers/pci/access.c
+++ linux-macro/drivers/pci/access.c
@@ -350,6 +350,11 @@ bool pcie_cap_has_lnkctl(const struct pc
 	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
 }
 
+static inline bool pcie_cap_has_lnkctl2(const struct pci_dev *dev)
+{
+	return pcie_cap_has_lnkctl(dev) && pcie_cap_version(dev) > 1;
+}
+
 static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
 {
 	return pcie_downstream_port(dev) &&
@@ -390,10 +395,11 @@ static bool pcie_capability_reg_implemen
 		return pcie_cap_has_rtctl(dev);
 	case PCI_EXP_DEVCAP2:
 	case PCI_EXP_DEVCTL2:
+		return pcie_cap_version(dev) > 1;
 	case PCI_EXP_LNKCAP2:
 	case PCI_EXP_LNKCTL2:
 	case PCI_EXP_LNKSTA2:
-		return pcie_cap_version(dev) > 1;
+		return pcie_cap_has_lnkctl2(dev);
 	default:
 		return false;
 	}
