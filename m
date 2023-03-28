Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47C16CC1BA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjC1OIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjC1OIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 10:08:52 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0924C669
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 07:07:36 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id dq6u2900G1C8whw06q6uGC; Tue, 28 Mar 2023 16:06:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ph9tW-00F8ye-CL;
        Tue, 28 Mar 2023 16:02:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ph9uD-006Ft4-SG;
        Tue, 28 Mar 2023 16:02:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: rcar-host: Remove unused static pcie_base and pcie_dev
Date:   Tue, 28 Mar 2023 16:02:32 +0200
Message-Id: <94b369447c38c478c52aef10e493b658a4f755ac.1680011974.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After the L1 link state transition exception handler rework, the static
copies of the remapped PCIe controller address and the PCIe device
pointer became unused.  Remove them.

Fixes: 6e36203bc14ce147 ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Probably this was not noticed before due to two function parameters with
the same name, thus shadowing the static globals.
---
 drivers/pci/controller/pcie-rcar-host.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e4faf90feaf5cf17..825e572b1e02b76f 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -41,21 +41,6 @@ struct rcar_msi {
 	int irq2;
 };
 
-#ifdef CONFIG_ARM
-/*
- * Here we keep a static copy of the remapped PCIe controller address.
- * This is only used on aarch32 systems, all of which have one single
- * PCIe controller, to provide quick access to the PCIe controller in
- * the L1 link state fixup function, called from the ARM fault handler.
- */
-static void __iomem *pcie_base;
-/*
- * Static copy of PCIe device pointer, so we can check whether the
- * device is runtime suspended or not.
- */
-static struct device *pcie_dev;
-#endif
-
 /* Structure representing the PCIe interface */
 struct rcar_pcie_host {
 	struct rcar_pcie	pcie;
@@ -879,12 +864,6 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
 	}
 	host->msi.irq2 = i;
 
-#ifdef CONFIG_ARM
-	/* Cache static copy for L1 link state fixup hook on aarch32 */
-	pcie_base = pcie->base;
-	pcie_dev = pcie->dev;
-#endif
-
 	return 0;
 
 err_irq2:
-- 
2.34.1

