Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B887BB29F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 09:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjJFHsd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjJFHsc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 03:48:32 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2998CE4;
        Fri,  6 Oct 2023 00:48:30 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qofZT-0004lD-0L;
        Fri, 06 Oct 2023 07:48:27 +0000
Date:   Fri, 6 Oct 2023 09:45:58 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] PCI: mediatek-gen3: fix PCIe #PERST being de-asserted too
 early
Message-ID: <ZR-7Nm2c5s4kuOp0@pidgin.makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver for MediaTek gen3 PCIe hosts de-asserts all reset
signals at the same time using a single register write operation.
Delay the de-assertion of the #PERST signal by 100ms as required by
PCIe CEM clause 2.2, some PCIe devices fail to come up otherwise.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index e0e27645fdf4..ba8cfce03aad 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -350,7 +350,13 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	msleep(100);
 
 	/* De-assert reset signals */
-	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
+	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
+	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+
+	msleep(100);
+
+	/* De-assert PERST# signals */
+	val &= ~(PCIE_PE_RSTB);
 	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 
 	/* Check if the link is up or not */
-- 
2.42.0

