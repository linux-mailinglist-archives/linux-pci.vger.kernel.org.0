Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F1D4B4533
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 10:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbiBNJI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 04:08:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiBNJI6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 04:08:58 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 01:08:50 PST
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41E59A72;
        Mon, 14 Feb 2022 01:08:50 -0800 (PST)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nJWcK-0000ZS-DI; Mon, 14 Feb 2022 08:21:52 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nJWcG-004vz6-3u;
        Mon, 14 Feb 2022 08:21:48 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, bhelgaas@google.comv,
        linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        david.abdurachmanov@gmail.com,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/2] PCI: fu740: Force gen1 for initial device probe
Date:   Mon, 14 Feb 2022 08:21:44 +0000
Message-Id: <20220214082144.1176084-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214082144.1176084-1-ben.dooks@codethink.co.uk>
References: <20220214082144.1176084-1-ben.dooks@codethink.co.uk>
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

The fu740 dw pcie core does not probe devices without this fix from
U-boot. The fix claims to set the link-speed to gen1 to get the probe
to work. As this is a copy from U-boot, the commentary is assumed to
be correct.

Without this in, and without U-boot starting the PCIe the Unmatched
board does not show any PCIe devices after the DW root port.

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

