Return-Path: <linux-pci+bounces-26997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD3AA0B49
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 14:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2521B60FE0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C52D0268;
	Tue, 29 Apr 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LpXb+CgH"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2C2C374D;
	Tue, 29 Apr 2025 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928716; cv=none; b=BUhKBN+QaBjAE59i6VNbzTbJvSQTB4V59Rlr1L9lGIcAyw4IeHm1Xr+kF5co6Bo0vYzFwQGOPSguKJ1IFTF5csIiCFLilixNP5zOKTFuFLpmpE6cfM9+vcvLClwwVxpu/H8Zh1b6omV7qnZLaN/VSS6BUSidRD7q+HwanJBwOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928716; c=relaxed/simple;
	bh=DgYZKDBsZ4N4/fS3byYOdhcKtkeSnKvZEUSXGxilFLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4hSZg4CeO7l6DTWcC6Dk/R252GdQQjQgg9GazNxxeHpcWYt1wbG2g9Asztq1v5b7y1GdftgImAiJBlDV0gM5QUk5mEWgwO1aHncuE8QRDXAE1+36OLturTaBgVawmL2Mj0Wr8n3ANZyYQ2KTvy8+jA865K52wJ+KApCx2QXDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LpXb+CgH; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/pFBe
	Gz3nc/9BpGipsGnLRQFDpw33LpxasspdNHhRcY=; b=LpXb+CgHt8Q2n8pFgCwkk
	7nRgg5NRIbsHe/GGa9JJLEMQBqTy5nAs/tkXd+7H66SitbwbGqNSAYMqBPB/A+KS
	ru+3pRx7TyfPT6jnY1rvzBmd42v9Ny9O3FlFUrFNdHV6S8ZXRzDfAaPX8E8xyXx8
	i+azx28pki/746Cyqc6Pp0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHUkXjwRBoU_m0DA--.22532S3;
	Tue, 29 Apr 2025 20:11:19 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org
Cc: cassel@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/3] PCI: dwc: Standardize link status check to return bool
Date: Tue, 29 Apr 2025 20:11:07 +0800
Message-Id: <20250429121109.16864-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250429121109.16864-1-18255117159@163.com>
References: <20250429121109.16864-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHUkXjwRBoU_m0DA--.22532S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3CryfuFy5Cw43uw4xKFyxAFb_yoW8Xw4kJo
	Z3Xw1fC3W7Wr1xXryxJ3ZIgFWUZ3ZFvFW3tFsY9rZ8ua43AFn5trW3Wr15uw15uw40k34U
	Zw4DJwnxAr4Ivr1Un29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RWrWFUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg0+o2gQvatkNAACsW

Modify link_up functions across multiple DWC PCIe controllers to return
bool instead of int. Simplify conditional checks by directly returning
logical evaluations. This improves code clarity and aligns with PCIe
status semantics.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       | 4 ++--
 drivers/pci/controller/dwc/pci-exynos.c       | 4 ++--
 drivers/pci/controller/dwc/pci-keystone.c     | 5 ++---
 drivers/pci/controller/dwc/pci-meson.c        | 6 +++---
 drivers/pci/controller/dwc/pcie-armada8k.c    | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.c  | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h  | 4 ++--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 drivers/pci/controller/dwc/pcie-histb.c       | 9 +++------
 drivers/pci/controller/dwc/pcie-keembay.c     | 2 +-
 drivers/pci/controller/dwc/pcie-kirin.c       | 7 ++-----
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 4 ++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   | 7 ++-----
 drivers/pci/controller/dwc/pcie-tegra194.c    | 4 ++--
 drivers/pci/controller/dwc/pcie-uniphier.c    | 2 +-
 drivers/pci/controller/dwc/pcie-visconti.c    | 4 ++--
 18 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 33d6bf460ffe..58f7d04ff37f 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -118,12 +118,12 @@ static u64 dra7xx_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
 	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;
 }
 
-static int dra7xx_pcie_link_up(struct dw_pcie *pci)
+static bool dra7xx_pcie_link_up(struct dw_pcie *pci)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
 
-	return !!(reg & LINK_UP);
+	return reg & LINK_UP;
 }
 
 static void dra7xx_pcie_stop_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index ace736b025b1..1f0e98d07109 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -209,12 +209,12 @@ static struct pci_ops exynos_pci_ops = {
 	.write = exynos_pcie_wr_own_conf,
 };
 
-static int exynos_pcie_link_up(struct dw_pcie *pci)
+static bool exynos_pcie_link_up(struct dw_pcie *pci)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
 
-	return (val & PCIE_ELBI_XMLH_LINKUP);
+	return val & PCIE_ELBI_XMLH_LINKUP;
 }
 
 static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 76a37368ae4f..968464530e3d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -492,13 +492,12 @@ static struct pci_ops ks_pcie_ops = {
  * @pci: A pointer to the dw_pcie structure which holds the DesignWare PCIe host
  *	 controller driver information.
  */
-static int ks_pcie_link_up(struct dw_pcie *pci)
+static bool ks_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
-	val &= PORT_LOGIC_LTSSM_STATE_MASK;
-	return (val == PORT_LOGIC_LTSSM_STATE_L0);
+	return (val & PORT_LOGIC_LTSSM_STATE_MASK) == PORT_LOGIC_LTSSM_STATE_L0;
 }
 
 static void ks_pcie_stop_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index db9482a113e9..787469d1b396 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -335,7 +335,7 @@ static struct pci_ops meson_pci_ops = {
 	.write = pci_generic_config_write,
 };
 
-static int meson_pcie_link_up(struct dw_pcie *pci)
+static bool meson_pcie_link_up(struct dw_pcie *pci)
 {
 	struct meson_pcie *mp = to_meson_pcie(pci);
 	struct device *dev = pci->dev;
@@ -363,7 +363,7 @@ static int meson_pcie_link_up(struct dw_pcie *pci)
 			dev_dbg(dev, "speed_okay\n");
 
 		if (smlh_up && rdlh_up && ltssm_up && speed_okay)
-			return 1;
+			return true;
 
 		cnt++;
 
@@ -371,7 +371,7 @@ static int meson_pcie_link_up(struct dw_pcie *pci)
 	} while (cnt < WAIT_LINKUP_TIMEOUT);
 
 	dev_err(dev, "error: wait linkup timeout\n");
-	return 0;
+	return false;
 }
 
 static int meson_pcie_host_init(struct dw_pcie_rp *pp)
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b5c599ccaacf..c2650fd0d458 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -139,7 +139,7 @@ static int armada8k_pcie_setup_phys(struct armada8k_pcie *pcie)
 	return ret;
 }
 
-static int armada8k_pcie_link_up(struct dw_pcie *pci)
+static bool armada8k_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
@@ -147,10 +147,10 @@ static int armada8k_pcie_link_up(struct dw_pcie *pci)
 	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_STATUS_REG);
 
 	if ((reg & mask) == mask)
-		return 1;
+		return true;
 
 	dev_dbg(pci->dev, "No link detected (Global-Status: 0x%08x).\n", reg);
-	return 0;
+	return false;
 }
 
 static int armada8k_pcie_start_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 97d76d3dc066..b3615d125942 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -711,7 +711,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
 
-int dw_pcie_link_up(struct dw_pcie *pci)
+bool dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 56aafdbcdaca..4dd16aa4b39e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -462,7 +462,7 @@ struct dw_pcie_ops {
 			     size_t size, u32 val);
 	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			      size_t size, u32 val);
-	int	(*link_up)(struct dw_pcie *pcie);
+	bool	(*link_up)(struct dw_pcie *pcie);
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
@@ -537,7 +537,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val);
 u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
-int dw_pcie_link_up(struct dw_pcie *pci);
+bool dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3c6ab71c996e..ae171a545df6 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -183,7 +183,7 @@ static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
 				 PCIE_CLIENT_GENERAL_CON);
 }
 
-static int rockchip_pcie_link_up(struct dw_pcie *pci)
+static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 val = rockchip_pcie_get_ltssm(rockchip);
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 1f2f4c28a949..a52071589377 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -151,7 +151,7 @@ static struct pci_ops histb_pci_ops = {
 	.write = histb_pcie_wr_own_conf,
 };
 
-static int histb_pcie_link_up(struct dw_pcie *pci)
+static bool histb_pcie_link_up(struct dw_pcie *pci)
 {
 	struct histb_pcie *hipcie = to_histb_pcie(pci);
 	u32 regval;
@@ -160,11 +160,8 @@ static int histb_pcie_link_up(struct dw_pcie *pci)
 	regval = histb_pcie_readl(hipcie, PCIE_SYS_STAT0);
 	status = histb_pcie_readl(hipcie, PCIE_SYS_STAT4);
 	status &= PCIE_LTSSM_STATE_MASK;
-	if ((regval & PCIE_XMLH_LINK_UP) && (regval & PCIE_RDLH_LINK_UP) &&
-	    (status == PCIE_LTSSM_STATE_ACTIVE))
-		return 1;
-
-	return 0;
+	return ((regval & PCIE_XMLH_LINK_UP) && (regval & PCIE_RDLH_LINK_UP) &&
+		(status == PCIE_LTSSM_STATE_ACTIVE));
 }
 
 static int histb_pcie_start_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 278205db60a2..67dd3337b447 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -101,7 +101,7 @@ static void keembay_pcie_ltssm_set(struct keembay_pcie *pcie, bool enable)
 	writel(val, pcie->apb_base + PCIE_REGS_PCIE_APP_CNTRL);
 }
 
-static int keembay_pcie_link_up(struct dw_pcie *pci)
+static bool keembay_pcie_link_up(struct dw_pcie *pci)
 {
 	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
 	u32 val;
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d0e6a3811b00..91559c8b1866 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -586,16 +586,13 @@ static void kirin_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 	kirin_pcie_sideband_dbi_w_mode(kirin_pcie, false);
 }
 
-static int kirin_pcie_link_up(struct dw_pcie *pci)
+static bool kirin_pcie_link_up(struct dw_pcie *pci)
 {
 	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
 	u32 val;
 
 	regmap_read(kirin_pcie->apb, PCIE_APB_PHY_STATUS0, &val);
-	if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
-		return 1;
-
-	return 0;
+	return (val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE;
 }
 
 static int kirin_pcie_start_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 46b1c6d19974..b3f7f42fa852 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -261,7 +261,7 @@ static void qcom_pcie_ep_configure_tcsr(struct qcom_pcie_ep *pcie_ep)
 	}
 }
 
-static int qcom_pcie_dw_link_up(struct dw_pcie *pci)
+static bool qcom_pcie_dw_link_up(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
 	u32 reg;
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc98ae63362d..ba0dd1717a58 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1221,12 +1221,12 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_link_up(struct dw_pcie *pci)
+static bool qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
-	return !!(val & PCI_EXP_LNKSTA_DLLLA);
+	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fc872dd35029..ccb94f4a215f 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -87,7 +87,7 @@ struct rcar_gen4_pcie {
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
 /* Common */
-static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
+static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
 {
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	u32 val, mask;
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index ff986ced56b2..01794a9d3ad2 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -110,15 +110,12 @@ static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pc
 				MSI_CTRL_INT, &app_reg->int_mask);
 }
 
-static int spear13xx_pcie_link_up(struct dw_pcie *pci)
+static bool spear13xx_pcie_link_up(struct dw_pcie *pci)
 {
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
 	struct pcie_app_reg __iomem *app_reg = spear13xx_pcie->app_base;
 
-	if (readl(&app_reg->app_status_1) & XMLH_LINK_UP)
-		return 1;
-
-	return 0;
+	return readl(&app_reg->app_status_1) & XMLH_LINK_UP;
 }
 
 static int spear13xx_pcie_host_init(struct dw_pcie_rp *pp)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5103995cd6c7..55c47318e65a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1027,12 +1027,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
-static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
+static bool tegra_pcie_dw_link_up(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
 
-	return !!(val & PCI_EXP_LNKSTA_DLLLA);
+	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
 static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 5757ca3803c9..9d05b3a0579e 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -135,7 +135,7 @@ static int uniphier_pcie_wait_rc(struct uniphier_pcie *pcie)
 	return 0;
 }
 
-static int uniphier_pcie_link_up(struct dw_pcie *pci)
+static bool uniphier_pcie_link_up(struct dw_pcie *pci)
 {
 	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	u32 val, mask;
diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index 318c278e65c8..cdeac6177143 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -121,13 +121,13 @@ static u32 visconti_mpu_readl(struct visconti_pcie *pcie, u32 reg)
 	return readl_relaxed(pcie->mpu_base + reg);
 }
 
-static int visconti_pcie_link_up(struct dw_pcie *pci)
+static bool visconti_pcie_link_up(struct dw_pcie *pci)
 {
 	struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
 	void __iomem *addr = pcie->ulreg_base;
 	u32 val = readl_relaxed(addr + PCIE_UL_REG_V_PHY_ST_02);
 
-	return !!(val & PCIE_UL_S_L0);
+	return val & PCIE_UL_S_L0;
 }
 
 static int visconti_pcie_start_link(struct dw_pcie *pci)
-- 
2.25.1


