Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0135BB810
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 14:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIQMD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 08:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIQMDS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 08:03:18 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DB9039BA4
        for <linux-pci@vger.kernel.org>; Sat, 17 Sep 2022 05:03:17 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id EE15F92009C; Sat, 17 Sep 2022 14:03:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E70C492009B;
        Sat, 17 Sep 2022 13:03:14 +0100 (BST)
Date:   Sat, 17 Sep 2022 13:03:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] PCI: Export `pcie_cap_has_lnkctl2'
In-Reply-To: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2209100057300.2275@angie.orcam.me.uk>
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

Export `pcie_cap_has_lnkctl2' for external use.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v5.
---
 drivers/pci/access.c |    2 +-
 drivers/pci/pci.h    |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

linux-pcie-cap-has-lnkctl2-export.diff
Index: linux-macro/drivers/pci/access.c
===================================================================
--- linux-macro.orig/drivers/pci/access.c
+++ linux-macro/drivers/pci/access.c
@@ -350,7 +350,7 @@ bool pcie_cap_has_lnkctl(const struct pc
 	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
 }
 
-static inline bool pcie_cap_has_lnkctl2(const struct pci_dev *dev)
+bool pcie_cap_has_lnkctl2(const struct pci_dev *dev)
 {
 	return pcie_cap_has_lnkctl(dev) && pcie_cap_version(dev) > 1;
 }
Index: linux-macro/drivers/pci/pci.h
===================================================================
--- linux-macro.orig/drivers/pci/pci.h
+++ linux-macro/drivers/pci/pci.h
@@ -15,6 +15,7 @@ extern const unsigned char pcie_link_spe
 extern bool pci_early_dump;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
+bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 
 /* Functions internal to the PCI core code */
