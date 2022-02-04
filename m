Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268BF4A9F11
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiBDSdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 13:33:25 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:33904 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377518AbiBDSdY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 13:33:24 -0500
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nG3OY-0001k0-I1; Fri, 04 Feb 2022 18:33:18 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nG3OY-001NZg-7R;
        Fri, 04 Feb 2022 18:33:18 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     paul.walmsley@sifive.com, greentime.hu@sifive.com
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] PCI: fu740: RFC: force gen1 and get devices probing
Date:   Fri,  4 Feb 2022 18:33:16 +0000
Message-Id: <20220204183316.328937-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dw pcie core does not probe devices unless this fix
from u-boot is applied. The link must be changed to gen1
and then the system will see all the other pcie devices
behind the unmatched board's bridge.

This is a quick PoC to try and get our test farm working
when a system does not have the pcie initialised by a
u-boot script.

I will look at a proper patch when I am back in the office
---
 drivers/pci/controller/dwc/pcie-fu740.c | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 960e58ead5f2..44f792764e45 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -181,11 +181,48 @@ static void fu740_pcie_init_phy(struct fu740_pcie *afp)
 	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE3_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
 }
 
+/* u-boot forces system to gen1 otherwise nothing probes... */
+static void pcie_sifive_force_gen1(struct dw_pcie *dw, struct fu740_pcie *afp )
+{
+	unsigned val;
+
+#if 0
+	/* u-boot code */
+        /* ctrl_ro_wr_enable */
+        val = readl(sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
+        val |= DBI_RO_WR_EN;
+        writel(val, sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
+
+        /* configure link cap */
+        linkcap = readl(sv->dw.dbi_base + PF0_PCIE_CAP_LINK_CAP);
+        linkcap |= PCIE_LINK_CAP_MAX_SPEED_MASK;
+        writel(linkcap, sv->dw.dbi_base + PF0_PCIE_CAP_LINK_CAP);
+
+        /* ctrl_ro_wr_disable */
+        val &= ~DBI_RO_WR_EN;
+        writel(val, sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
+#endif
+
+	val = readl_relaxed(dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
+	val |= PCIE_DBI_RO_WR_EN;
+	writel_relaxed(val, dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
+
+	val = readl(dw->dbi_base + 0x70 + 0x0c);
+	val |= 0xf;
+	writel(val, dw->dbi_base + 0x70 + 0x0c);
+
+	val = readl_relaxed(dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
+	val &= ~PCIE_DBI_RO_WR_EN;
+	writel_relaxed(val, dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
+}
+
 static int fu740_pcie_start_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct fu740_pcie *afp = dev_get_drvdata(dev);
 
+	pcie_sifive_force_gen1(pci, afp);
+
 	/* Enable LTSSM */
 	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
 	return 0;
-- 
2.34.1

