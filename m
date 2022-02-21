Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B84BEBF3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 21:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiBUUih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 15:38:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiBUUih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 15:38:37 -0500
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A3237D2;
        Mon, 21 Feb 2022 12:38:13 -0800 (PST)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=rainbowdash)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nMFRc-0001sl-R8; Mon, 21 Feb 2022 20:38:04 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nMFRc-005amP-8f;
        Mon, 21 Feb 2022 20:38:04 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     paul.walmsley@sifive.com, greentime.hu@sifive.com
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [[PATCHv3]] PCI: fu740: Force gen1 for initial device probe
Date:   Mon, 21 Feb 2022 20:38:03 +0000
Message-Id: <20220221203803.1333012-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The fu740 PCIe core does not probe any devices on the SiFive Unmatched
board without this fix from U-Boot (or having U-Boot explicitly start
the PCIe via either boot-script or user command).

The fix claims to set the link-speed to gen1 to get the probe
to work. As this is a copy from U-Boot, the code is assumed to be
correct and does fix the issue on the Unmatched. The code is at:
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c#L271

The code has been this way since the driver was commited in:
https://source.denx.de/u-boot/u-boot/-/commit/416395c772018c6bf52aad36aca163115001793f

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 842b7202b96e..19501ec8c487 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -177,11 +177,30 @@ static void fu740_pcie_init_phy(struct fu740_pcie *afp)
 	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE3_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
 }
 
+/* This is copied from u-boot. Force system to gen1 otherwise nothing probes
+ * as found on the SiFive Unmatched board.
+ */
+static void fu740_pcie_force_gen1(struct dw_pcie *dw, struct fu740_pcie *afp )
+{
+	unsigned val;
+
+	dw_pcie_dbi_ro_wr_en(dw);
+
+	val = dw_pcie_readl_dbi(dw, 0x70 + PCI_EXP_LNKCAP);
+	pr_info("%s: link-cap was %08x\n", __func__, val);
+	dw_pcie_writel_dbi(dw, 0x70 + PCI_EXP_LNKCAP, val | 0xf);
+
+	dw_pcie_dbi_ro_wr_dis(dw);
+}
+
 static int fu740_pcie_start_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct fu740_pcie *afp = dev_get_drvdata(dev);
 
+	/* Force PCIe gen1 otherwise Unmatched board does not probe */
+	fu740_pcie_force_gen1(pci, afp);
+
 	/* Enable LTSSM */
 	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
 	return 0;
-- 
2.34.1

