Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41FF5BB814
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIQMDf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiIQMD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 08:03:29 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 767553A15A
        for <linux-pci@vger.kernel.org>; Sat, 17 Sep 2022 05:03:22 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E39DC92009C; Sat, 17 Sep 2022 14:03:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id DCEA292009B;
        Sat, 17 Sep 2022 13:03:19 +0100 (BST)
Date:   Sat, 17 Sep 2022 13:03:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] PCI: Export PCI link retrain timeout
In-Reply-To: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2209100057450.2275@angie.orcam.me.uk>
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

Rename LINK_RETRAIN_TIMEOUT to PCIE_LINK_RETRAIN_TIMEOUT and make it
available via "pci.h" for PCI drivers to use.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v5.
---
 drivers/pci/pci.h       |    2 ++
 drivers/pci/pcie/aspm.c |    4 +---
 2 files changed, 3 insertions(+), 3 deletions(-)

linux-pcie-link-retrain-timeout.diff
Index: linux-macro/drivers/pci/pci.h
===================================================================
--- linux-macro.orig/drivers/pci/pci.h
+++ linux-macro/drivers/pci/pci.h
@@ -11,6 +11,8 @@
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
+#define PCIE_LINK_RETRAIN_TIMEOUT HZ
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
Index: linux-macro/drivers/pci/pcie/aspm.c
===================================================================
--- linux-macro.orig/drivers/pci/pcie/aspm.c
+++ linux-macro/drivers/pci/pcie/aspm.c
@@ -89,8 +89,6 @@ static const char *policy_str[] = {
 	[POLICY_POWER_SUPERSAVE] = "powersupersave"
 };
 
-#define LINK_RETRAIN_TIMEOUT HZ
-
 /*
  * The L1 PM substate capability is only implemented in function 0 in a
  * multi function device.
@@ -212,7 +210,7 @@ static bool pcie_retrain_link(struct pci
 	}
 
 	/* Wait for link training end. Break out after waiting for timeout */
-	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	end_jiffies = jiffies + PCIE_LINK_RETRAIN_TIMEOUT;
 	do {
 		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
 		if (!(reg16 & PCI_EXP_LNKSTA_LT))
