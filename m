Return-Path: <linux-pci+bounces-1212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2181983F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 06:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6696D288749
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 05:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39F1118C;
	Wed, 20 Dec 2023 05:38:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B006FBE1;
	Wed, 20 Dec 2023 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.04,290,1695654000"; 
   d="scan'208";a="187105323"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2023 14:38:39 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 82B1C416941C;
	Wed, 20 Dec 2023 14:38:39 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lei Chuanhua <lchuanhua@maxlinear.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 1/6] PCI: dwc: Drop host prefix from struct dw_pcie_host_ops
Date: Wed, 20 Dec 2023 14:38:24 +0900
Message-Id: <20231220053829.1921187-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
References: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the name of dw_pcie_host_ops indicates that it's for host
obviously, drop host prefix from the struct.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Lei Chuanhua <lchuanhua@maxlinear.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jonathan Chocron <jonnyc@amazon.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Greentime Hu <greentime.hu@sifive.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c         |  4 +--
 drivers/pci/controller/dwc/pci-keystone.c     |  6 ++--
 drivers/pci/controller/dwc/pci-layerscape.c   |  6 ++--
 drivers/pci/controller/dwc/pci-meson.c        |  2 +-
 drivers/pci/controller/dwc/pcie-al.c          |  2 +-
 drivers/pci/controller/dwc/pcie-armada8k.c    |  2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |  2 +-
 drivers/pci/controller/dwc/pcie-bt1.c         |  4 +--
 .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  8 ++---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  2 +-
 drivers/pci/controller/dwc/pcie-fu740.c       |  2 +-
 drivers/pci/controller/dwc/pcie-histb.c       |  2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  2 +-
 drivers/pci/controller/dwc/pcie-kirin.c       |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 ++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  4 +--
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
 drivers/pci/controller/dwc/pcie-uniphier.c    |  2 +-
 drivers/pci/controller/dwc/pcie-visconti.c    |  2 +-
 23 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index b445ffe95e3f..6125a838f4b1 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -371,7 +371,7 @@ static int dra7xx_pcie_init_irq_domain(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
-	.host_init = dra7xx_pcie_host_init,
+	.init = dra7xx_pcie_host_init,
 };
 
 static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c6bede346932..673ae213203f 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -268,7 +268,7 @@ static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
-	.host_init = exynos_pcie_host_init,
+	.init = exynos_pcie_host_init,
 };
 
 static int exynos_add_pcie_port(struct exynos_pcie *ep,
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec..b02f6f14a411 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1039,8 +1039,8 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
-	.host_init = imx6_pcie_host_init,
-	.host_deinit = imx6_pcie_host_exit,
+	.init = imx6_pcie_host_init,
+	.deinit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 0def919f89fa..3711347ddc87 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -838,12 +838,12 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops ks_pcie_host_ops = {
-	.host_init = ks_pcie_host_init,
-	.msi_host_init = ks_pcie_msi_host_init,
+	.init = ks_pcie_host_init,
+	.msi_init = ks_pcie_msi_host_init,
 };
 
 static const struct dw_pcie_host_ops ks_pcie_am654_host_ops = {
-	.host_init = ks_pcie_host_init,
+	.init = ks_pcie_host_init,
 };
 
 static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 7cdada200de7..ee6f52568133 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -273,12 +273,12 @@ static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
-	.host_init = ls_pcie_host_init,
+	.init = ls_pcie_host_init,
 	.pme_turn_off = ls_pcie_send_turnoff_msg,
 };
 
 static const struct dw_pcie_host_ops ls1021a_pcie_host_ops = {
-	.host_init = ls_pcie_host_init,
+	.init = ls_pcie_host_init,
 	.pme_turn_off = ls1021a_pcie_send_turnoff_msg,
 };
 
@@ -290,7 +290,7 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
 };
 
 static const struct dw_pcie_host_ops ls1043a_pcie_host_ops = {
-	.host_init = ls_pcie_host_init,
+	.init = ls_pcie_host_init,
 	.pme_turn_off = ls1043a_pcie_send_turnoff_msg,
 };
 
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 407558f5d74a..6477c83262c2 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -389,7 +389,7 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops meson_pcie_host_ops = {
-	.host_init = meson_pcie_host_init,
+	.init = meson_pcie_host_init,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index b8cb77c9c4bd..6dfdda59f328 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -311,7 +311,7 @@ static int al_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops al_pcie_host_ops = {
-	.host_init = al_pcie_host_init,
+	.init = al_pcie_host_init,
 };
 
 static int al_pcie_probe(struct platform_device *pdev)
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 5c999e15c357..b5c599ccaacf 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -225,7 +225,7 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 }
 
 static const struct dw_pcie_host_ops armada8k_pcie_host_ops = {
-	.host_init = armada8k_pcie_host_init,
+	.init = armada8k_pcie_host_init,
 };
 
 static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 9b572a2b2c9a..2f32fcd8933c 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -333,7 +333,7 @@ static int artpec6_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops artpec6_pcie_host_ops = {
-	.host_init = artpec6_pcie_host_init,
+	.init = artpec6_pcie_host_init,
 };
 
 static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 17e696797ff5..76d0ddea8007 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -559,8 +559,8 @@ static void bt1_pcie_host_deinit(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops bt1_pcie_host_ops = {
-	.host_init = bt1_pcie_host_init,
-	.host_deinit = bt1_pcie_host_deinit,
+	.init = bt1_pcie_host_init,
+	.deinit = bt1_pcie_host_deinit,
 };
 
 static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7991f0e179b2..d5fc31f8345f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -441,14 +441,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
 
-	if (pp->ops->host_init) {
-		ret = pp->ops->host_init(pp);
+	if (pp->ops->init) {
+		ret = pp->ops->init(pp);
 		if (ret)
 			return ret;
 	}
 
 	if (pci_msi_enabled()) {
-		pp->has_msi_ctrl = !(pp->ops->msi_host_init ||
+		pp->has_msi_ctrl = !(pp->ops->msi_init ||
 				     of_property_read_bool(np, "msi-parent") ||
 				     of_property_read_bool(np, "msi-map"));
 
@@ -464,8 +464,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_deinit_host;
 		}
 
-		if (pp->ops->msi_host_init) {
-			ret = pp->ops->msi_host_init(pp);
+		if (pp->ops->msi_init) {
+			ret = pp->ops->msi_init(pp);
 			if (ret < 0)
 				goto err_deinit_host;
 		} else if (pp->has_msi_ctrl) {
@@ -502,8 +502,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_stop_link;
 
-	if (pp->ops->host_post_init)
-		pp->ops->host_post_init(pp);
+	if (pp->ops->post_init)
+		pp->ops->post_init(pp);
 
 	return 0;
 
@@ -518,8 +518,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		dw_pcie_free_msi(pp);
 
 err_deinit_host:
-	if (pp->ops->host_deinit)
-		pp->ops->host_deinit(pp);
+	if (pp->ops->deinit)
+		pp->ops->deinit(pp);
 
 	return ret;
 }
@@ -539,8 +539,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 
-	if (pp->ops->host_deinit)
-		pp->ops->host_deinit(pp);
+	if (pp->ops->deinit)
+		pp->ops->deinit(pp);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
@@ -842,8 +842,8 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 		return ret;
 	}
 
-	if (pci->pp.ops->host_deinit)
-		pci->pp.ops->host_deinit(&pci->pp);
+	if (pci->pp.ops->deinit)
+		pci->pp.ops->deinit(&pci->pp);
 
 	pci->suspended = true;
 
@@ -860,8 +860,8 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 
 	pci->suspended = false;
 
-	if (pci->pp.ops->host_init) {
-		ret = pci->pp.ops->host_init(&pci->pp);
+	if (pci->pp.ops->init) {
+		ret = pci->pp.ops->init(&pci->pp);
 		if (ret) {
 			dev_err(pci->dev, "Host init failed: %d\n", ret);
 			return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d384..5c4518ad1bec 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -300,10 +300,10 @@ enum dw_pcie_ltssm {
 };
 
 struct dw_pcie_host_ops {
-	int (*host_init)(struct dw_pcie_rp *pp);
-	void (*host_deinit)(struct dw_pcie_rp *pp);
-	void (*host_post_init)(struct dw_pcie_rp *pp);
-	int (*msi_host_init)(struct dw_pcie_rp *pp);
+	int (*init)(struct dw_pcie_rp *pp);
+	void (*deinit)(struct dw_pcie_rp *pp);
+	void (*post_init)(struct dw_pcie_rp *pp);
+	int (*msi_init)(struct dw_pcie_rp *pp);
 	void (*pme_turn_off)(struct dw_pcie_rp *pp);
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 2fe42c70097f..961dabcb1ec8 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -215,7 +215,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
-	.host_init = rockchip_pcie_host_init,
+	.init = rockchip_pcie_host_init,
 };
 
 static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 1e9b44b8bba4..66367252032b 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -279,7 +279,7 @@ static int fu740_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops fu740_pcie_host_ops = {
-	.host_init = fu740_pcie_host_init,
+	.init = fu740_pcie_host_init,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index fd484cc7c481..7a11c618b9d9 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -198,7 +198,7 @@ static int histb_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops histb_pcie_host_ops = {
-	.host_init = histb_pcie_host_init,
+	.init = histb_pcie_host_init,
 };
 
 static void histb_pcie_host_disable(struct histb_pcie *hipcie)
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index c9c93524e01d..be52e9db44af 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -391,7 +391,7 @@ static const struct dw_pcie_ops intel_pcie_ops = {
 };
 
 static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
-	.host_init =		intel_pcie_rc_init,
+	.init =		intel_pcie_rc_init,
 };
 
 static int intel_pcie_probe(struct platform_device *pdev)
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 2ee146767971..c50e183f88d6 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -672,7 +672,7 @@ static const struct dw_pcie_ops kirin_dw_pcie_ops = {
 };
 
 static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
-	.host_init = kirin_pcie_host_init,
+	.init = kirin_pcie_host_init,
 };
 
 static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6902e97719d1..cd986f50ec4a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1244,9 +1244,9 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
-	.host_init	= qcom_pcie_host_init,
-	.host_deinit	= qcom_pcie_host_deinit,
-	.host_post_init	= qcom_pcie_host_post_init,
+	.init		= qcom_pcie_host_init,
+	.deinit		= qcom_pcie_host_deinit,
+	.post_init	= qcom_pcie_host_post_init,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 2ca5b7983d62..cede060e0af8 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -307,8 +307,8 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
-	.host_init = rcar_gen4_pcie_host_init,
-	.host_deinit = rcar_gen4_pcie_host_deinit,
+	.init = rcar_gen4_pcie_host_init,
+	.deinit = rcar_gen4_pcie_host_deinit,
 };
 
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 99d47ae80331..201dced209f0 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -148,7 +148,7 @@ static int spear13xx_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops spear13xx_pcie_host_ops = {
-	.host_init = spear13xx_pcie_host_init,
+	.init = spear13xx_pcie_host_init,
 };
 
 static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0fe113598ebb..52e26ed61380 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1060,7 +1060,7 @@ static const struct dw_pcie_ops tegra_dw_pcie_ops = {
 };
 
 static const struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
-	.host_init = tegra_pcie_dw_host_init,
+	.init = tegra_pcie_dw_host_init,
 };
 
 static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 48c3eba817b4..354fb3bd0a19 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -311,7 +311,7 @@ static int uniphier_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
-	.host_init = uniphier_pcie_host_init,
+	.init = uniphier_pcie_host_init,
 };
 
 static int uniphier_pcie_host_enable(struct uniphier_pcie *pcie)
diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index 71026fefa366..318c278e65c8 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -236,7 +236,7 @@ static int visconti_pcie_host_init(struct dw_pcie_rp *pp)
 }
 
 static const struct dw_pcie_host_ops visconti_pcie_host_ops = {
-	.host_init = visconti_pcie_host_init,
+	.init = visconti_pcie_host_init,
 };
 
 static int visconti_get_resources(struct platform_device *pdev,
-- 
2.25.1


