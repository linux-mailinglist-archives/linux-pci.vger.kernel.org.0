Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF16D381C
	for <lists+linux-pci@lfdr.de>; Sun,  2 Apr 2023 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDBNcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Apr 2023 09:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBNcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Apr 2023 09:32:19 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB601B340;
        Sun,  2 Apr 2023 06:32:18 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id C4B5C61CDF;
        Sun,  2 Apr 2023 13:13:23 +0000 (UTC)
Received: from frank-G5.. (fttx-pool-217.61.149.201.bambit.de [217.61.149.201])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 8262B4092B;
        Sun,  2 Apr 2023 13:12:01 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mediatek-gen3: handle PERST after reset
Date:   Sun,  2 Apr 2023 15:11:19 +0200
Message-Id: <20230402131119.98805-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 8b6dfb75-3da6-40a2-b803-4599ce6843ed
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

De-assert PERST in separate step after reset signals to fully comply
the PCIe CEM clause 2.2.

This fixes some NVME detection issues on mt7986.

Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
Patch is taken from user Ruslan aka RRKh61 (permitted me to send it
with me as author).

https://forum.banana-pi.org/t/bpi-r3-nvme-connection-issue/14563/17
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b8612ce5f4d0..176b1a04565d 100644
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
2.34.1

