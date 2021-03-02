Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C4F32B1EB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbhCCB5M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1446885AbhCBMNt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Mar 2021 07:13:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B61E964F6B;
        Tue,  2 Mar 2021 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686250;
        bh=c9d8Nxabf4kZIzvaMyb+3PXWhBlaUpycrmLAB2mLcjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qo+G+g8QGZagd1s2IcHH7xb/LV7/L2QpjS708+/jDjidtdGMs7L8Znx8W8DTmozOz
         eZPnju0dwiS5BIrOF7X5vUGnn6VNDhnUmN/iE88akmjM/VCXh1R2hmqbvhXYCYkImH
         EuZowrw62nbb6OxSM0SbonTe1RuyN8V89kqNifvi6BlxVTLyrVbPHLZaWXKJBVNSJf
         Najcnqdn6IdhWyC1vcflC+YaNbo140Qh8H7IOzIkPtFuAzn4k6+ulSFvXx8dSVbZ8K
         2HKgILTiIXEwxLCcfV9RH44DIbdVMTyfV2oSIfUaBZzq08JBHV60eX+HtytatrR9mP
         TTwGw7Injd9Zw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nadeem Athani <nadeem@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 35/47] PCI: cadence: Retrain Link to work around Gen2 training defect
Date:   Tue,  2 Mar 2021 06:56:34 -0500
Message-Id: <20210302115646.62291-35-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115646.62291-1-sashal@kernel.org>
References: <20210302115646.62291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Nadeem Athani <nadeem@cadence.com>

[ Upstream commit 4740b969aaf58adeca6829947a3ad8da423976cf ]

Cadence controller will not initiate autonomous speed change if strapped
as Gen2. The Retrain Link bit is set as quirk to enable this speed change.

Link: https://lore.kernel.org/r/20210209144622.26683-3-nadeem@cadence.com
Signed-off-by: Nadeem Athani <nadeem@cadence.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pci-j721e.c    |  3 +
 .../controller/cadence/pcie-cadence-host.c    | 81 ++++++++++++++-----
 drivers/pci/controller/cadence/pcie-cadence.h | 11 ++-
 3 files changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 586b9d69fa5e..d34ca0fda0f6 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -63,6 +63,7 @@ enum j721e_pcie_mode {
 
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
+	bool quirk_retrain_flag;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -270,6 +271,7 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
 
 static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
+	.quirk_retrain_flag = true,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
@@ -378,6 +380,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		bridge->ops = &cdns_ti_pcie_host_ops;
 		rc = pci_host_bridge_priv(bridge);
+		rc->quirk_retrain_flag = data->quirk_retrain_flag;
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 811c1cb2e8de..6f591d382578 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -77,6 +77,68 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
+static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_link_up(pcie)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int cdns_pcie_retrain(struct cdns_pcie *pcie)
+{
+	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u16 lnk_stat, lnk_ctl;
+	int ret = 0;
+
+	/*
+	 * Set retrain bit if current speed is 2.5 GB/s,
+	 * but the PCIe root port support is > 2.5 GB/s.
+	 */
+
+	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
+					     PCI_EXP_LNKCAP));
+	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
+		return ret;
+
+	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
+		lnk_ctl = cdns_pcie_rp_readw(pcie,
+					     pcie_cap_off + PCI_EXP_LNKCTL);
+		lnk_ctl |= PCI_EXP_LNKCTL_RL;
+		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
+				    lnk_ctl);
+
+		ret = cdns_pcie_host_wait_for_link(pcie);
+	}
+	return ret;
+}
+
+static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	int ret;
+
+	ret = cdns_pcie_host_wait_for_link(pcie);
+
+	/*
+	 * Retrain link for Gen2 training defect
+	 * if quirk flag is set.
+	 */
+	if (!ret && rc->quirk_retrain_flag)
+		ret = cdns_pcie_retrain(pcie);
+
+	return ret;
+}
 
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
@@ -398,23 +460,6 @@ static int cdns_pcie_host_init(struct device *dev,
 	return cdns_pcie_host_init_address_translation(rc);
 }
 
-static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	int retries;
-
-	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (cdns_pcie_link_up(pcie)) {
-			dev_info(dev, "Link up\n");
-			return 0;
-		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
-	}
-
-	return -ETIMEDOUT;
-}
-
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
@@ -457,7 +502,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		return ret;
 	}
 
-	ret = cdns_pcie_host_wait_for_link(pcie);
+	ret = cdns_pcie_host_start_link(rc);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index feed1e3038f4..6705a5fedfbb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -119,7 +119,7 @@
  * Root Port Registers (PCI configuration space for the root port function)
  */
 #define CDNS_PCIE_RP_BASE	0x00200000
-
+#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
 
 /*
  * Address Translation Registers
@@ -290,6 +290,7 @@ struct cdns_pcie {
  * @device_id: PCI device ID
  * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
  *                available
+ * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -298,6 +299,7 @@ struct cdns_pcie_rc {
 	u32			vendor_id;
 	u32			device_id;
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
+	bool                    quirk_retrain_flag;
 };
 
 /**
@@ -413,6 +415,13 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 	cdns_pcie_write_sz(addr, 0x2, value);
 }
 
+static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	return cdns_pcie_read_sz(addr, 0x2);
+}
+
 /* Endpoint Function register access */
 static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u8 value)
-- 
2.30.1

