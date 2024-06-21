Return-Path: <linux-pci+bounces-9077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B67912868
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFFA1F29AFF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB8374DD;
	Fri, 21 Jun 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbzw3Erx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293D2231F;
	Fri, 21 Jun 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981361; cv=none; b=uHobTFb6VUdCrJeE3IA3ET/rRcQiZzI3cKpFk/tS55NUYlqP1emmMrT2dsUvyRV3zS/KwlmhCAWCnezlN9hTOFF4+t/Q8iNTtyt4TAsVBJ+hu0npqzAEx1ezdRgd6w0uTu9Uc/wfFXLq/CKr/i5dGAku+ud2y/iNM6pLyA4l2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981361; c=relaxed/simple;
	bh=9F7O07gma7ZSq8wSpr6tX5daMjGrvBoRc8UPNXsrYD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAW7Ku1NaliD2nK0+4REyhnAUUHMc467aKV7E9Vm6kxdF6Qk09bL9rW70+Aqg05OaoX89yMwu94LOobEf7yb5o2odu34TOsmGb/AxJg2BEtb84ogq7eSTspSbvl//kI3k8mNMkAt7jBnka/lbJwYOEGJ2sV3dcdgNco8k1DtZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbzw3Erx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7D1C2BBFC;
	Fri, 21 Jun 2024 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718981360;
	bh=9F7O07gma7ZSq8wSpr6tX5daMjGrvBoRc8UPNXsrYD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sbzw3ErxbdSmwwH0qh3xUwnR7Vi04Kqb9+BjIm+OMZC0exdo3t9spThEQNYOWDN15
	 mujoSNXoQZbwazoIGqiFrNvpF/GJItFEGMsPpNJGjTiV4rKwAaBN4QmYlNMGZpVwfy
	 tlHeNzREPhz2pUxTKEfaLjclv4Ux71ymvwMeMfw4omuaMpl0PQVOS5fJVZBLhqFjZF
	 ibBrc2zKHSOkDEA+mcDEvoFo65snDMa2IHp3TuGwbvqfE5cTrnQEl5g63nBjecHql3
	 zwpesg7GIVpjQygZr2FRCfzw01n4/62lDxzlUt2zsVG6gZvtHwvDSRAIGF9ilBLNCu
	 MDNqArK07SY7w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
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
Subject: [PATCH 2/4] PCI: mediatek-gen3: Add mtk_pcie_soc data structure
Date: Fri, 21 Jun 2024 16:48:48 +0200
Message-ID: <a49a36c4ca336dee909e16865d6fec0dd83b3f38.1718980864.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718980864.git.lorenzo@kernel.org>
References: <cover.1718980864.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce mtk_pcie_soc data structure in order to define multiple
callbacks for each supported SoC. This is a preliminary patch to
introduce EN7581 pcie support.

Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 24 ++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 975b3024fb08..4859bd875bc4 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -100,6 +100,16 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
+struct mtk_gen3_pcie;
+
+/**
+ * struct mtk_pcie_soc - differentiate between host generations
+ * @power_up: pcie power_up callback
+ */
+struct mtk_pcie_soc {
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
+	const struct mtk_pcie_soc *soc;
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
+	pcie->soc = of_device_get_match_data(dev);
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
 
+static const struct mtk_pcie_soc mtk_pcie_soc_mt8192 = {
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


