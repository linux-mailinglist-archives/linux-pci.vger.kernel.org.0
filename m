Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B775540AF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 04:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356251AbiFVC5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356308AbiFVC5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 22:57:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C3033A32;
        Tue, 21 Jun 2022 19:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28E6FB81C06;
        Wed, 22 Jun 2022 02:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77B3C341C7;
        Wed, 22 Jun 2022 02:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655866666;
        bh=QNzTpoGr4shSjLv0sk0M1WLeZIItPNE1fT8ivdONYmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/f+fiDA3xJ6T1elwyfgYgH0uVhQ0NIE94Uawid8Puy808OI40xxKeHbjb7/dosNZ
         N+1FZOywA42QllCOHTm0TPzdIcHznORZKILSnjMjHDHbQX50sOarPn7pvhVHH/JEIG
         0Sc7IKvcZmhWtLu7FPBkfR/zvZjqMKru//M+1+HEPkRtd1PI5z61qafuEtC2+J2hXo
         xEyrL9FXeP2eX5HmWDfb2CxFBCA8yenMYT5nzLTFLEDeRkaMiqfdnhOlU95kJ5U2CG
         WaFmd5TEa7aQOgUydNzlhPzVXPg1P4PmLf613697CufhUQNZRSwzLERDMFxkCXn5zq
         FMvx0dDTnicYg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Liang He <windhl@126.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] PCI: rcar: Resolve of_find_matching_node() reference leak
Date:   Tue, 21 Jun 2022 21:57:32 -0500
Message-Id: <20220622025732.1359389-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622025732.1359389-1-helgaas@kernel.org>
References: <20220622025732.1359389-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, rcar_pcie_init() used of_find_matching_node() to search the
entire device tree for compatible strings for which we need to install an
abort handler.  If we found one, we got a device_node with refcount
incremented, but we discarded the pointer and never released that
reference.

Extend the struct rcar_variant to indicate whether each variant requires an
abort handler.  Install the handler in rcar_pcie_probe() when needed.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Liang He <windhl@126.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 60 +++++++++++--------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index ccf13aafa1e5..139a0274b9e0 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -60,6 +60,7 @@ struct rcar_pcie_host;
 
 struct rcar_variant {
 	int	(*phy_init_fn)(struct rcar_pcie_host *host);
+	bool	hook_aborts;
 };
 
 /* Structure representing the PCIe interface */
@@ -964,12 +965,35 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie_host *host)
 	return err;
 }
 
+#ifdef CONFIG_ARM
+static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
+		unsigned int fsr, struct pt_regs *regs)
+{
+	return !fixup_exception(regs);
+}
+#endif
+
+static void rcar_pcie_hook_aborts(void)
+{
+#ifdef CONFIG_ARM
+#ifdef CONFIG_ARM_LPAE
+	hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
+			"asynchronous external abort");
+#else
+	hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
+			"imprecise external abort");
+#endif
+#endif
+}
+
 static const struct rcar_variant rcar_h1_data = {
 	.phy_init_fn = rcar_pcie_phy_init_h1,
+	.hook_aborts = true,
 };
 
 static const struct rcar_variant rcar_gen2_data = {
 	.phy_init_fn = rcar_pcie_phy_init_gen2,
+	.hook_aborts = true,
 };
 
 static const struct rcar_variant rcar_gen3_data = {
@@ -1035,6 +1059,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
+	if (host->variant->hook_aborts)
+		rcar_pcie_hook_aborts();
+
 	/* Failure to get a link might just be that no cards are inserted */
 	if (rcar_pcie_hw_init(pcie)) {
 		dev_info(dev, "PCIe link down\n");
@@ -1153,37 +1180,4 @@ static struct platform_driver rcar_pcie_driver = {
 	},
 	.probe = rcar_pcie_probe,
 };
-
-#ifdef CONFIG_ARM
-static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
-		unsigned int fsr, struct pt_regs *regs)
-{
-	return !fixup_exception(regs);
-}
-
-static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
-	{ .compatible = "renesas,pcie-r8a7779" },
-	{ .compatible = "renesas,pcie-r8a7790" },
-	{ .compatible = "renesas,pcie-r8a7791" },
-	{ .compatible = "renesas,pcie-rcar-gen2" },
-	{},
-};
-
-static int __init rcar_pcie_init(void)
-{
-	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
-#ifdef CONFIG_ARM_LPAE
-		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
-				"asynchronous external abort");
-#else
-		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
-				"imprecise external abort");
-#endif
-	}
-
-	return platform_driver_register(&rcar_pcie_driver);
-}
-device_initcall(rcar_pcie_init);
-#else
 builtin_platform_driver(rcar_pcie_driver);
-#endif
-- 
2.25.1

