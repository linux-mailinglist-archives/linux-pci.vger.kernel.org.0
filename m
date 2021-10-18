Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20068431115
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 09:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJRHJ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 03:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhJRHJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 03:09:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F13A6128B;
        Mon, 18 Oct 2021 07:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634540865;
        bh=eGAdNAChAZazNNDwWNQN60b0CqUcTDXG2Getq8eVHe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jh12H6MbI1tecV9ZXJ06Y+ylAW7nvUBbbaWORVEMCPdDr7kF3Q139z3+vIfARo2/C
         KDeLPm3/jpG8tgdQZtz4Qd5aRWW1Qc/KyWMKDyTuFsapRD/E7UzQ6KHX+yeIaTqyNw
         4bnrvQKldvBFxARa28aVXRGVh9F3XgK98wPGKbkCceOJPeNjdf+E33CUrJMmZ1u9Dq
         EGywxb3JEEvobH9EBVVnUHo5lKh7JMFJoyexv4ovxBVTn83d4Nl9BCbXk2NYcJPJIQ
         Hbzre/p2cUAlW/1BLnsibeGSwBymi8nCpSqPF860oYkV9fYvxXvsNhyrv7d52x7w29
         UPmd5mVixEvLQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mcMkC-000Id1-QH; Mon, 18 Oct 2021 08:07:36 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Songxiaowei" <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v13 04/10] PCI: kirin: Add support for bridge slot DT schema
Date:   Mon, 18 Oct 2021 08:07:29 +0100
Message-Id: <2058b3059516595ec7f2e7a72197e02235943244.1634539769.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634539769.git.mchehab+huawei@kernel.org>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On HiKey970, there's a PEX 8606 PCI bridge on its PHY with
6 lanes. Only 4 lanes are connected:

	lane 0 - connected to Kirin 970;
	lane 4 - M.2 slot;
	lane 5 - mini PCIe slot;
	lane 6 - in-board Ethernet controller.

Each lane has its own PERST# gpio pin, and needs a clock
request.

Add support to parse a DT schema containing the above data.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 264 +++++++++++++++++++++---
 1 file changed, 232 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 0ea92a521e1c..5c97e91adbb0 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -52,6 +52,19 @@
 #define PCIE_DEBOUNCE_PARAM	0xF0F400
 #define PCIE_OE_BYPASS		(0x3 << 28)
 
+/*
+ * Max number of connected PCI slots at an external PCI bridge
+ *
+ * This is used on HiKey 970, which has a PEX 8606 bridge with has
+ * 4 connected lanes (lane 0 upstream, and the other tree lanes,
+ * one connected to an in-board Ethernet adapter and the other two
+ * connected to M.2 and mini PCI slots.
+ *
+ * Each slot has a different clock source and uses a separate PERST#
+ * pin.
+ */
+#define MAX_PCI_SLOTS		3
+
 enum pcie_kirin_phy_type {
 	PCIE_KIRIN_INTERNAL_PHY,
 	PCIE_KIRIN_EXTERNAL_PHY
@@ -64,6 +77,19 @@ struct kirin_pcie {
 	struct regmap   *apb;
 	struct phy	*phy;
 	void		*phy_priv;	/* only for PCIE_KIRIN_INTERNAL_PHY */
+
+	/* DWC PERST# */
+	int		gpio_id_dwc_perst;
+
+	/* Per-slot PERST# */
+	int		num_slots;
+	int		gpio_id_reset[MAX_PCI_SLOTS];
+	const char	*reset_names[MAX_PCI_SLOTS];
+
+	/* Per-slot clkreq */
+	int		n_gpio_clkreq;
+	int		gpio_id_clkreq[MAX_PCI_SLOTS];
+	const char	*clkreq_names[MAX_PCI_SLOTS];
 };
 
 /*
@@ -87,7 +113,7 @@ struct kirin_pcie {
 #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
 
 /* Time for delay */
-#define REF_2_PERST_MIN		20000
+#define REF_2_PERST_MIN		21000
 #define REF_2_PERST_MAX		25000
 #define PERST_2_ACCESS_MIN	10000
 #define PERST_2_ACCESS_MAX	12000
@@ -108,7 +134,6 @@ struct hi3660_pcie_phy {
 	struct clk	*phy_ref_clk;
 	struct clk	*aclk;
 	struct clk	*aux_clk;
-	int		gpio_id_reset;
 };
 
 /* Registers in PCIePHY */
@@ -171,16 +196,6 @@ static int hi3660_pcie_phy_get_resource(struct hi3660_pcie_phy *phy)
 	if (IS_ERR(phy->sysctrl))
 		return PTR_ERR(phy->sysctrl);
 
-	/* gpios */
-	phy->gpio_id_reset = of_get_named_gpio(dev->of_node,
-					       "reset-gpios", 0);
-	if (phy->gpio_id_reset == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (!gpio_is_valid(phy->gpio_id_reset)) {
-		dev_err(phy->dev, "unable to get a valid gpio pin\n");
-		return -ENODEV;
-	}
-
 	return 0;
 }
 
@@ -297,15 +312,7 @@ static int hi3660_pcie_phy_power_on(struct kirin_pcie *pcie)
 	if (ret)
 		goto disable_clks;
 
-	/* perst assert Endpoint */
-	if (!gpio_request(phy->gpio_id_reset, "pcie_perst")) {
-		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
-		ret = gpio_direction_output(phy->gpio_id_reset, 1);
-		if (ret)
-			goto disable_clks;
-		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
-		return 0;
-	}
+	return 0;
 
 disable_clks:
 	hi3660_pcie_phy_clk_ctrl(phy, false);
@@ -347,11 +354,98 @@ static const struct regmap_config pcie_kirin_regmap_conf = {
 	.reg_stride = 4,
 };
 
+static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
+				      struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	char name[32];
+	int ret, i;
+
+	/* This is an optional property */
+	ret = of_gpio_named_count(np, "hisilicon,clken-gpios");
+	if (ret < 0)
+		return 0;
+
+	if (ret > MAX_PCI_SLOTS) {
+		dev_err(dev, "Too many GPIO clock requests!\n");
+		return -EINVAL;
+	}
+
+	pcie->n_gpio_clkreq = ret;
+
+	for (i = 0; i < pcie->n_gpio_clkreq; i++) {
+		pcie->gpio_id_clkreq[i] = of_get_named_gpio(dev->of_node,
+							    "hisilicon,clken-gpios", i);
+		if (pcie->gpio_id_clkreq[i] < 0)
+			return pcie->gpio_id_clkreq[i];
+
+		sprintf(name, "pcie_clkreq_%d", i);
+		pcie->clkreq_names[i] = devm_kstrdup_const(dev, name,
+							    GFP_KERNEL);
+		if (!pcie->clkreq_names[i])
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
+				 struct platform_device *pdev,
+				 struct device_node *node)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *parent, *child;
+	int ret, slot, i;
+	char name[32];
+
+	for_each_available_child_of_node(node, parent) {
+		for_each_available_child_of_node(parent, child) {
+			i = pcie->num_slots;
+
+			pcie->gpio_id_reset[i] = of_get_named_gpio(child,
+								"reset-gpios", 0);
+			if (pcie->gpio_id_reset[i] < 0)
+				continue;
+
+			pcie->num_slots++;
+			if (pcie->num_slots > MAX_PCI_SLOTS) {
+				dev_err(dev, "Too many PCI slots!\n");
+				return -EINVAL;
+			}
+
+			ret = of_pci_get_devfn(child);
+			if (ret < 0) {
+				dev_err(dev, "failed to parse devfn: %d\n", ret);
+				goto put_node;
+			}
+
+			slot = PCI_SLOT(ret);
+
+			sprintf(name, "pcie_perst_%d", slot);
+			pcie->reset_names[i] = devm_kstrdup_const(dev, name,
+								GFP_KERNEL);
+			if (!pcie->reset_names[i]) {
+				ret = -ENOMEM;
+				goto put_node;
+			}
+		}
+	}
+
+	return 0;
+
+put_node:
+	of_node_put(child);
+	return ret;
+}
+
 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				    struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node, *child;
 	void __iomem *apb_base;
+	int ret;
 
 	apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
 	if (IS_ERR(apb_base))
@@ -362,7 +456,32 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	if (IS_ERR(kirin_pcie->apb))
 		return PTR_ERR(kirin_pcie->apb);
 
+	/* pcie internal PERST# gpio */
+	kirin_pcie->gpio_id_dwc_perst = of_get_named_gpio(dev->of_node,
+							  "reset-gpios", 0);
+	if (kirin_pcie->gpio_id_dwc_perst == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (!gpio_is_valid(kirin_pcie->gpio_id_dwc_perst)) {
+		dev_err(dev, "unable to get a valid gpio pin\n");
+		return -ENODEV;
+	}
+
+	ret = kirin_pcie_get_gpio_enable(kirin_pcie, pdev);
+	if (ret)
+		return ret;
+
+	/* Parse OF children */
+	for_each_available_child_of_node(node, child) {
+		ret = kirin_pcie_parse_port(kirin_pcie, pdev, child);
+		if (ret)
+			goto put_node;
+	}
+
 	return 0;
+
+put_node:
+	of_node_put(child);
+	return ret;
 }
 
 static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
@@ -419,9 +538,33 @@ static int kirin_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int kirin_pcie_add_bus(struct pci_bus *bus)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
+	int i, ret;
+
+	if (!kirin_pcie->num_slots)
+		return 0;
+
+	/* Send PERST# to each slot */
+	for (i = 0; i < kirin_pcie->num_slots; i++) {
+		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
+		if (ret) {
+			dev_err(pci->dev, "PERST# %s error: %d\n",
+				kirin_pcie->reset_names[i], ret);
+		}
+	}
+	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
+
+	return 0;
+}
+
+
 static struct pci_ops kirin_pci_ops = {
 	.read = kirin_pcie_rd_own_conf,
 	.write = kirin_pcie_wr_own_conf,
+	.add_bus = kirin_pcie_add_bus,
 };
 
 static u32 kirin_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
@@ -477,6 +620,44 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static int kirin_pcie_gpio_request(struct kirin_pcie *kirin_pcie,
+				   struct device *dev)
+{
+	int ret, i;
+
+	for (i = 0; i < kirin_pcie->num_slots; i++) {
+		if (!gpio_is_valid(kirin_pcie->gpio_id_reset[i])) {
+			dev_err(dev, "unable to get a valid %s gpio\n",
+				kirin_pcie->reset_names[i]);
+			return -ENODEV;
+		}
+
+		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[i],
+					kirin_pcie->reset_names[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
+		if (!gpio_is_valid(kirin_pcie->gpio_id_clkreq[i])) {
+			dev_err(dev, "unable to get a valid %s gpio\n",
+				kirin_pcie->clkreq_names[i]);
+			return -ENODEV;
+		}
+
+		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[i],
+					kirin_pcie->clkreq_names[i]);
+		if (ret)
+			return ret;
+
+		ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct dw_pcie_ops kirin_dw_pcie_ops = {
 	.read_dbi = kirin_pcie_read_dbi,
 	.write_dbi = kirin_pcie_write_dbi,
@@ -499,24 +680,43 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 		if (ret)
 			return ret;
 
-		return hi3660_pcie_phy_power_on(kirin_pcie);
+		ret = hi3660_pcie_phy_power_on(kirin_pcie);
+		if (ret)
+			return ret;
+	} else {
+		kirin_pcie->phy = devm_of_phy_get(dev, dev->of_node, NULL);
+		if (IS_ERR(kirin_pcie->phy))
+			return PTR_ERR(kirin_pcie->phy);
+
+		ret = kirin_pcie_gpio_request(kirin_pcie, dev);
+		if (ret)
+			return ret;
+
+		ret = phy_init(kirin_pcie->phy);
+		if (ret)
+			goto err;
+
+		ret = phy_power_on(kirin_pcie->phy);
+		if (ret)
+			goto err;
 	}
 
-	kirin_pcie->phy = devm_of_phy_get(dev, dev->of_node, NULL);
-	if (IS_ERR(kirin_pcie->phy))
-		return PTR_ERR(kirin_pcie->phy);
+	/* perst assert Endpoint */
+	usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
 
-	ret = phy_init(kirin_pcie->phy);
-	if (ret)
-		goto err;
+	if (!gpio_request(kirin_pcie->gpio_id_dwc_perst, "pcie_perst_bridge")) {
+		ret = gpio_direction_output(kirin_pcie->gpio_id_dwc_perst, 1);
+		if (ret)
+			goto err;
+	}
 
-	ret = phy_power_on(kirin_pcie->phy);
-	if (ret)
-		goto err;
+	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
 
 	return 0;
 err:
-	phy_exit(kirin_pcie->phy);
+	if (kirin_pcie->type != PCIE_KIRIN_INTERNAL_PHY)
+		phy_exit(kirin_pcie->phy);
+
 	return ret;
 }
 
-- 
2.31.1

