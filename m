Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C29B6E6B4B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjDRRoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjDRRoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 13:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C677AAC;
        Tue, 18 Apr 2023 10:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1D7C63778;
        Tue, 18 Apr 2023 17:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0249EC433EF;
        Tue, 18 Apr 2023 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839840;
        bh=7R/G7Jf8ZUVBVuhsZpi+xJYmZ4Ot/a0lMhqEHtI/eU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rF/gQUn+GXbZFIbkhgRNNFi+ZEvDf3npXbjXmJWe/ZZtnrOFR+v+eayCgBOUWcz/S
         0YgU4hs6Ia+sc1TGqFsZe6LOARqZC6/dwkisn2ItdF4xENDc6wwQlfeUUvR3RpmWj0
         MiPpTxjL4loi9Y+3vZvcHRomKJLsonXMjZSvy5g7vCSWNgC/5V0onMy+Ckal/wzSJj
         +RXv+HhHJDRdfW+zJU8AHBWsH3TFeIBbuE8PMjeUgeV2wVO8TfRdqc2gOiy7Gv0ew5
         VIy04yxbm1NX4Cigqapfc9039U5ob+pd4Sa3ZNvvPgnMujp7pk96e9Bh52qBVLn6+h
         HYd8ecy+SjLrg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 7/7] PCI: mobiveil: Sort Kconfig entries by vendor
Date:   Tue, 18 Apr 2023 12:43:36 -0500
Message-Id: <20230418174336.145585-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418174336.145585-1-helgaas@kernel.org>
References: <20230418174336.145585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Sort Kconfig entries by vendor so they appear in alphabetical order in
menuconfig.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/mobiveil/Kconfig | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index bc9c624cf619..58ce034f701a 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -11,6 +11,15 @@ config PCIE_MOBIVEIL_HOST
 	depends on PCI_MSI
 	select PCIE_MOBIVEIL
 
+config PCIE_LAYERSCAPE_GEN4
+	bool "Freescale Layerscape Gen4 PCIe controller"
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on PCI_MSI
+	select PCIE_MOBIVEIL_HOST
+	help
+	  Say Y here if you want PCIe Gen4 controller support on
+	  Layerscape SoCs.
+
 config PCIE_MOBIVEIL_PLAT
 	bool "Mobiveil AXI PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
@@ -22,12 +31,4 @@ config PCIE_MOBIVEIL_PLAT
 	  Soft IP. It has up to 8 outbound and inbound windows
 	  for address translation and it is a PCIe Gen4 IP.
 
-config PCIE_LAYERSCAPE_GEN4
-	bool "Freescale Layerscape Gen4 PCIe controller"
-	depends on ARCH_LAYERSCAPE || COMPILE_TEST
-	depends on PCI_MSI
-	select PCIE_MOBIVEIL_HOST
-	help
-	  Say Y here if you want PCIe Gen4 controller support on
-	  Layerscape SoCs.
 endmenu
-- 
2.25.1

