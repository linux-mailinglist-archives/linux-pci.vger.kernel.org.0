Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C834F179E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 16:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347083AbiDDOvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378340AbiDDOvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 10:51:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C01FCD0;
        Mon,  4 Apr 2022 07:49:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2DE141F44AAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649083743;
        bh=gqGXxJTgo2QFByPlVeChgiuVrlRNuS1ZqugUAimLnDE=;
        h=From:To:Cc:Subject:Date:From;
        b=jcyi3ieeRTjx/TdSizLK3y7evsfkq7a7xC3FvBhuFTx2x+b7kVS446Fprm0R/mAoU
         zN37Pr2DLQw/YLDqdp9zQuPItVJVXNxLiK+OGeN5zw9sRSww8pSiL6pk6AnoA/2TtS
         XwBlOD8E0NmBHlUnZn2djZfHFu1cywvz+AG0uDauu0yd5Ov+qp04WUiGYdvdPUB3+e
         5B/EtU1UW1YPHhIbN11kRC1gJp4gWaoIbL5weuuwD1wGsePQNMkrzpRh26+Vvo8V6y
         6NXbUfvLmlVI6uGudg7raD0STAbijI4jgg2oAwomRywa3sXrYub1barMRAAot6jNN+
         sgAzvMHjOiU8Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     ryder.lee@mediatek.com
Cc:     jianjun.wang@mediatek.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] PCI: mediatek-gen3: Assert resets to ensure expected init state
Date:   Mon,  4 Apr 2022 16:48:58 +0200
Message-Id: <20220404144858.92390-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The controller may have been left out of reset by the bootloader,
in which case, before the powerup sequence, the controller will be
found preconfigured with values that were set before booting the
kernel: this produces a controller failure, with the result of
a failure during the mtk_pcie_startup_port() sequence as the PCIe
link never gets up.

To ensure that we get a clean start in an expected state, assert
both the PHY and MAC resets before executing the controller
power-up sequence.

Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index f7048ea4c020..dccdfce12b1c 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -838,6 +838,14 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	if (err)
 		return err;
 
+	/*
+	 * The controller may have been left out of reset by the bootloader
+	 * so make sure that we get a clean start by asserting resets here.
+	 */
+	reset_control_assert(pcie->phy_reset);
+	reset_control_assert(pcie->mac_reset);
+	usleep_range(10, 20);
+
 	/* Don't touch the hardware registers before power up */
 	err = mtk_pcie_power_up(pcie);
 	if (err)
-- 
2.35.1

