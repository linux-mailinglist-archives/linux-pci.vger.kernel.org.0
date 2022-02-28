Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA614C7E35
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 00:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiB1XWy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 18:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiB1XWx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 18:22:53 -0500
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD819A27A2;
        Mon, 28 Feb 2022 15:22:10 -0800 (PST)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=rainbowdash)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nOpLD-000510-L9; Mon, 28 Feb 2022 23:22:07 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nOpLD-00CHuf-3I;
        Mon, 28 Feb 2022 23:22:07 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     helgaas@kernel.org, linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC] PCI: fu740: Force Gen1 to fix initial device probing on some boards
Date:   Mon, 28 Feb 2022 23:22:06 +0000
Message-Id: <20220228232206.2928784-1-ben.dooks@codethink.co.uk>
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
board without this fix (or having U-Boot explicitly start the PCIe via
either boot-script or user command). The fix is to start the link at
Gen1 speeds and once the link is up then change the speed back.

The U-Boot driver claims to set the link-speed to Gen1 to get the probe
to work (and U-Boot does print link up at Gen1) in the following code:
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
Note, this patch has had significant re-work since the previous 4
sets, including trying to fix style, message, reliance on the U-Boot
fix and the comments about usage of LINK_CAP and reserved fields.
---
 drivers/pci/controller/dwc/pcie-fu740.c | 51 ++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 842b7202b96e..16ad52f53490 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -181,10 +181,59 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct fu740_pcie *afp = dev_get_drvdata(dev);
+	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	int ret;
+	u32 orig, tmp;
+
+	/*
+	 * Force Gen1 when starting link, due to some devices not
+	 * probing at higher speeds. This happens with the PCIe switch
+	 * on the Unmatched board. The fix in U-Boot is to force Gen1
+	 * and hope later resets will clear this capaility.
+	 */
+
+	dev_dbg(dev, "cap_exp at %x\n", cap_exp);
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	tmp = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCAP);
+	orig = tmp & PCI_EXP_LNKCAP_SLS;
+	tmp &= ~PCI_EXP_LNKCAP_SLS;
+	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
+	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
 
 	/* Enable LTSSM */
 	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
-	return 0;
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret) {
+		dev_err(dev, "error: link did not start\n");
+		goto err;
+	}
+
+	tmp = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCAP);
+	if ((tmp & PCI_EXP_LNKCAP_SLS) != orig) {
+		dev_dbg(dev, "changing speed back to original\n");
+
+		tmp &= ~PCI_EXP_LNKCAP_SLS;
+		tmp |= orig;
+		dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
+
+		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		tmp |= PORT_LOGIC_SPEED_CHANGE;
+		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret) {
+			dev_err(dev, "error: link did not start at new speed\n");
+			goto err;
+		}
+	}
+
+	ret = 0;
+err:
+	// todo - if we do have an unliekly error, what do we do here?
+	dw_pcie_dbi_ro_wr_dis(pci);
+	return ret;
 }
 
 static int fu740_pcie_host_init(struct pcie_port *pp)
-- 
2.34.1

