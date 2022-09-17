Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96275BB816
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIQMDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 08:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIQMDd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 08:03:33 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05BDC3A4B8
        for <linux-pci@vger.kernel.org>; Sat, 17 Sep 2022 05:03:28 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D92579200B3; Sat, 17 Sep 2022 14:03:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D600692009E;
        Sat, 17 Sep 2022 13:03:23 +0100 (BST)
Date:   Sat, 17 Sep 2022 13:03:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] PCI: Execute `quirk_enable_clear_retrain_link'
 earlier
In-Reply-To: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2209100058000.2275@angie.orcam.me.uk>
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

Make `quirk_enable_clear_retrain_link' `pci_fixup_early' so that any later 
fixups can rely on `clear_retrain_link' to have been already initialised.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v5.
---
 drivers/pci/quirks.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

linux-pcie-clear-retrain-link-early.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -2407,9 +2407,9 @@ static void quirk_enable_clear_retrain_l
 	dev->clear_retrain_link = 1;
 	pci_info(dev, "Enable PCIe Retrain Link quirk\n");
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe110, quirk_enable_clear_retrain_link);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe111, quirk_enable_clear_retrain_link);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe130, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PERICOM, 0xe110, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PERICOM, 0xe111, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PERICOM, 0xe130, quirk_enable_clear_retrain_link);
 
 static void fixup_rev1_53c810(struct pci_dev *dev)
 {
