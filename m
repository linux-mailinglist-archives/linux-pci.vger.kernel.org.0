Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4933270E10B
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbjEWPw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbjEWPwv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 11:52:51 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17697
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 08:52:49 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:b0ac:7afd:272:4cff])
        by laurent.telenet-ops.be with bizsmtp
        id 0Fsn2A00N0Jkz7G01FsnZc; Tue, 23 May 2023 17:52:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1UJN-002t6k-At;
        Tue, 23 May 2023 17:52:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1UJb-00CksO-NR;
        Tue, 23 May 2023 17:52:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] PCI: rcar-host: Remove unused static pcie_base and pcie_dev
Date:   Tue, 23 May 2023 17:52:44 +0200
Message-Id: <f29a8c37bd906dfbe23208cc2b089da17e339a75.1684857051.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
Probably this was not noticed before due to two function parameters with
the same name, thus shadowing the static globals.

v2:
  - Add Reviewed-by.
---
 drivers/pci/controller/pcie-rcar-host.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e80e56b2a84243e5..7ffcd0f5aa45c989 100644
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

