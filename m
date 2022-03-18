Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C664DDCBC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 16:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiCRPZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiCRPZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 11:25:52 -0400
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67848A996D;
        Fri, 18 Mar 2022 08:24:33 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=rainbowdash)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nVESt-0005AT-HY; Fri, 18 Mar 2022 15:24:31 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nVESt-002CvF-2s;
        Fri, 18 Mar 2022 15:24:31 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [V3] PCI: fu740: Drop to 2.5GT/s to fix initial device probing on some boards
Date:   Fri, 18 Mar 2022 15:24:30 +0000
Message-Id: <20220318152430.526320-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.35.1
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
2.5GT/s speeds and once the link is up then change the maximum speed back
to the default.

The U-Boot driver claims to set the link-speed to 2.5GT/s to get the probe
to work (and U-Boot does print link up at 2.5GT/s) in the following code:
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
Note, this patch has had significant re-work since the previous 4
sets, including trying to fix style, message, reliance on the U-Boot
fix and the comments about usage of LINK_CAP and reserved fields.

v2:
- fix issues with Gen1/2.5GTs
- updated comment on the initial probe
- run tests with both uninitialised and initialsed pcie from uboot
---
 drivers/pci/controller/dwc/pcie-fu740.c | 52 ++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 842b7202b96e..ecac0364178a 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -181,10 +181,60 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct fu740_pcie *afp = dev_get_drvdata(dev);
+	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	int ret;
+	u32 orig, tmp;
+
+	/*
+	 * Force 2.5GT/s when starting the link, due to some devices not
+	 * probing at higher speeds. This happens with the PCIe switch
+	 * on the Unmatched board when U-Boot has not initialised the PCIe.
+	 * The fix in U-Boot is to force 2.5GT/s, which then gets cleared
+	 * by the soft reset does by this driver.
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
+	WARN_ON(ret);	/* we assume that errors will be very rare */
+	dw_pcie_dbi_ro_wr_dis(pci);
+	return ret;
 }
 
 static int fu740_pcie_host_init(struct pcie_port *pp)
-- 
2.35.1

