Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58C15AD984
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIETZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIETZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969FD1A814;
        Mon,  5 Sep 2022 12:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C8B6130A;
        Mon,  5 Sep 2022 19:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D98C43470;
        Mon,  5 Sep 2022 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662405914;
        bh=tnlQt8uAhD9MRbuUnIAmbky2iGpTR1k2zzQd6YiZe4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6UNZUzL/kVaqNPtX59YFKzyhhy2UBOEwYlujhIpmWIoZyT4Bc2uYKh6a2Ivke5S0
         194cZjBKV7JDTZEc/qiDxPXCY8Yr4dKQIz6MtPSaFnr4Ap5v5XWxY92m6zxuKbTcne
         r3GoyMk6CsyzrBHZGJ05t1FjY3phIwvLrwD8E9/Le8V7GN9tP1CwwRP9zoomIjikM7
         Lkmn9tPkQAJt3OKSni5GT8LrAFxHQ3u++LTEv9Qk/tJxtWhjlbHOY8t+ZzugujlVSx
         HZyfMDvSmuEuJz1abagB/P7c6G7fHT9TQVsprpZULz8u+Lzhw/wn5BkZU1DETLaXZA
         27AanXc0LL1Aw==
Received: by pali.im (Postfix)
        id 1145C20B1; Mon,  5 Sep 2022 21:25:12 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/7] ARM: orion: Move PCIe mbus window mapping from orion5x_setup_wins() to pcie_setup()
Date:   Mon,  5 Sep 2022 21:23:04 +0200
Message-Id: <20220905192310.22786-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220905192310.22786-1-pali@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This would allow to migrate Orion PCIe code to pci-mvebu.c driver as this
driver reads mapping information from device tree files and does not relay
on static mappings.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v3:
* Split it from pci-mvebu.c change to separate patch
---
 arch/arm/mach-orion5x/common.c | 13 -------------
 arch/arm/mach-orion5x/pci.c    | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 2e711b7252c6..df5e7b237946 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -228,19 +228,6 @@ void __init orion5x_init_early(void)
 
 void orion5x_setup_wins(void)
 {
-	/*
-	 * The PCIe windows will no longer be statically allocated
-	 * here once Orion5x is migrated to the pci-mvebu driver.
-	 */
-	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
-					  ORION_MBUS_PCIE_IO_ATTR,
-					  ORION5X_PCIE_IO_PHYS_BASE,
-					  ORION5X_PCIE_IO_SIZE,
-					  ORION5X_PCIE_IO_BUS_BASE);
-	mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
-				    ORION_MBUS_PCIE_MEM_ATTR,
-				    ORION5X_PCIE_MEM_PHYS_BASE,
-				    ORION5X_PCIE_MEM_SIZE);
 	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCI_IO_TARGET,
 					  ORION_MBUS_PCI_IO_ATTR,
 					  ORION5X_PCI_IO_PHYS_BASE,
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 888fdc9099c5..e0836be92f3f 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -147,6 +147,20 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	 */
 	orion_pcie_setup(PCIE_BASE);
 
+	/*
+	 * The PCIe windows will no longer be statically allocated
+	 * here once Orion5x is migrated to the pci-mvebu driver.
+	 */
+	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
+					  ORION_MBUS_PCIE_IO_ATTR,
+					  ORION5X_PCIE_IO_PHYS_BASE,
+					  ORION5X_PCIE_IO_SIZE,
+					  ORION5X_PCIE_IO_BUS_BASE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
+				    ORION_MBUS_PCIE_MEM_ATTR,
+				    ORION5X_PCIE_MEM_PHYS_BASE,
+				    ORION5X_PCIE_MEM_SIZE);
+
 	/*
 	 * Check whether to apply Orion-1/Orion-NAS PCIe config
 	 * read transaction workaround.
-- 
2.20.1

