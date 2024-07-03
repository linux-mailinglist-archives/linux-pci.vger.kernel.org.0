Return-Path: <linux-pci+bounces-9737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF69265C8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2F1C227D3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C317A59D;
	Wed,  3 Jul 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM5Sp7VS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2E442C;
	Wed,  3 Jul 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023198; cv=none; b=XMMtqj5MYm/SXuws+bvb3r/2qJA/oLLCo2iwaFoGPEjZbNxmfWiQ22VhyJLAQ9v1ur9l178FBvs9FQWe6RDEcDZdg3VsvenCop89iTazQfN0GlZjsV0OgRRy2FX3zGpBcof/LhPMVbBaXRn/qQIGjoQgUC0JwRTiKizoDhpscW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023198; c=relaxed/simple;
	bh=OgKWE5raRMdQzYYFIeI9oRWJDLJrgr/vHR/+EGZ8/l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHMeoERx+rp1qSfy3iW2l+19L/s4E9uCNBn2ECpFE0xL9kccZLTfV2H2OI2+NNMHDiPpzA3moxy3s2/MTOgzsMCMnNJIecs6i6yM27RKf74V5vvftbl+pK47kSfqr5l5QArfpfa0c/tuto66/w4WL9pGxaWq2QTHPzkE/WPByfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM5Sp7VS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F63C2BD10;
	Wed,  3 Jul 2024 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720023198;
	bh=OgKWE5raRMdQzYYFIeI9oRWJDLJrgr/vHR/+EGZ8/l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CM5Sp7VS4JHQPMl34jmwBebrlTfbmNF/sxRFKNCLpCyfiPPTa0GJ0N+39ehNTJ6Ka
	 pK3JEvhgZWeg/kOj9FDm+R3ODmKFeTjGcOXSeLMgSLComuuXkmvWTzvk/hbNFan/hP
	 XsGzOGb2LQeYGarYFUg3lh6jZWhYwIO43QM+3ntd0gH9NwqeWWvydzSijJ1FmTatop
	 u8xqnorZHslzqg+JE4trupmXi5rMMsg1IHW/Z8YADdMKLUcjHo3UKz8FHEc++iGiA6
	 6vAfryIgRTx6yUVnHdhJD5HPwhtW+Y2DtEyy+qGggkB4scs2WXn6Bo8aXuKi3iSsfw
	 FA/tHw4tHYqng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	dd@embedd.com,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v4 2/4] PCI: mediatek-gen3: Add mtk_gen3_pcie_pdata data structure
Date: Wed,  3 Jul 2024 18:12:42 +0200
Message-ID: <c193d1a87505d045e2e0ef33317bce17012ee095.1720022580.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720022580.git.lorenzo@kernel.org>
References: <cover.1720022580.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce mtk_gen3_pcie_pdata data structure in order to define
multiple callbacks for each supported SoC. This is a preliminary
patch to introduce EN7581 PCIe support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 24 ++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 975b3024fb08..db0210803731 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -100,6 +100,16 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
+struct mtk_gen3_pcie;
+
+/**
+ * struct mtk_gen3_pcie_pdata - differentiate between host generations
+ * @power_up: pcie power_up callback
+ */
+struct mtk_gen3_pcie_pdata {
+	int (*power_up)(struct mtk_gen3_pcie *pcie);
+};
+
 /**
  * struct mtk_msi_set - MSI information for each set
  * @base: IO mapped register base
@@ -131,6 +141,7 @@ struct mtk_msi_set {
  * @msi_sets: MSI sets information
  * @lock: lock protecting IRQ bit map
  * @msi_irq_in_use: bit map for assigned MSI IRQ
+ * @soc: pointer to SoC-dependent operations
  */
 struct mtk_gen3_pcie {
 	struct device *dev;
@@ -151,6 +162,8 @@ struct mtk_gen3_pcie {
 	struct mtk_msi_set msi_sets[PCIE_MSI_SET_NUM];
 	struct mutex lock;
 	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
+
+	const struct mtk_gen3_pcie_pdata *soc;
 };
 
 /* LTSSM state in PCIE_LTSSM_STATUS_REG bit[28:24] */
@@ -904,7 +917,7 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	usleep_range(10, 20);
 
 	/* Don't touch the hardware registers before power up */
-	err = mtk_pcie_power_up(pcie);
+	err = pcie->soc->power_up(pcie);
 	if (err)
 		return err;
 
@@ -939,6 +952,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(host);
 
 	pcie->dev = dev;
+	pcie->soc = device_get_match_data(dev);
 	platform_set_drvdata(pdev, pcie);
 
 	err = mtk_pcie_setup(pcie);
@@ -1054,7 +1068,7 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
 	int err;
 
-	err = mtk_pcie_power_up(pcie);
+	err = pcie->soc->power_up(pcie);
 	if (err)
 		return err;
 
@@ -1074,8 +1088,12 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 				  mtk_pcie_resume_noirq)
 };
 
+static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
+	.power_up = mtk_pcie_power_up,
+};
+
 static const struct of_device_id mtk_pcie_of_match[] = {
-	{ .compatible = "mediatek,mt8192-pcie" },
+	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
-- 
2.45.2


