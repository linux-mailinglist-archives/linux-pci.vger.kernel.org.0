Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42DC570D3F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 00:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiGKWSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 18:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKWSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 18:18:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C512D07;
        Mon, 11 Jul 2022 15:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B937EB815F2;
        Mon, 11 Jul 2022 22:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA0FC341C8;
        Mon, 11 Jul 2022 22:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657577929;
        bh=ETkCB/aehhBtnEDCWccc3Oh1+EJJkiDRqq1zwo6PZ+A=;
        h=From:To:Cc:Subject:Date:From;
        b=COl00AOaSWTtYDKodDOFVEME+H+7AMvnwzMHIYm2LHsKSl8bRSEQccSyXFnPUZB5D
         iyL1y64f2dLz1VcQdTWIcau1DL5DouBqLx4cHGjjgwXUK852SnT81feaJetIdntR1b
         Yv9DW73xNZeEwryJi6Pizbr94rh+j8YYfHGORR/SH8Z+WFJdvs2+QnCSa/lX9slwGf
         SSB07O4OjBBkK0RXj1ElS5H3ulIuIy2IJPa1Klbbsl12m19ILVZzBlX0UGgfqPyHnW
         jaip4TRVuCMkDsbLf/CdkF6uTIZeohfVp2MlfIiV7uNMj1MFgnvYeDUtgRX6TKWf6h
         5eD4w+yP0MnAg==
Received: by pali.im (Postfix)
        id 0E9CE9D7; Tue, 12 Jul 2022 00:18:46 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: aardvark: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge
Date:   Tue, 12 Jul 2022 00:18:23 +0200
Message-Id: <20220711221823.12154-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Register with Subsystem Device/Vendor ID is at offset 0x2c. Export is via
emulated bridge.

After this change Subsystem ID is visible in lspci output at line:

  Capabilities: [40] Subsystem

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 74511f015168..924c9397a9a4 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -32,6 +32,8 @@
 #define PCIE_CORE_DEV_ID_REG					0x0
 #define PCIE_CORE_CMD_STATUS_REG				0x4
 #define PCIE_CORE_DEV_REV_REG					0x8
+#define PCIE_CORE_SSDEV_ID_REG					0x2c
+#define PCIE_CORE_EXP_ROM_BAR_REG				0x30
 #define PCIE_CORE_PCIEXP_CAP					0xc0
 #define PCIE_CORE_ERR_CAPCTL_REG				0x118
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
@@ -982,6 +984,8 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	/* Indicates supports for Completion Retry Status */
 	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
 
+	bridge->subsystem_vendor_id = advk_readl(pcie, PCIE_CORE_SSDEV_ID_REG) & 0xffff;
+	bridge->subsystem_id = advk_readl(pcie, PCIE_CORE_SSDEV_ID_REG) >> 16;
 	bridge->has_pcie = true;
 	bridge->data = pcie;
 	bridge->ops = &advk_pci_bridge_emul_ops;
-- 
2.20.1

