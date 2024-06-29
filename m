Return-Path: <linux-pci+bounces-9446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36391CD75
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 15:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6E1281E8F
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FFB80C09;
	Sat, 29 Jun 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F70fcC+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00280BF3;
	Sat, 29 Jun 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719669166; cv=none; b=pu8DDgMhsL4fXfUSNZaKQ1V3LnSWtBsocl2aTNrLfYXDtOqCtoPBL82uyCcHwFGf0g6pEwsTZq81YEOJ3NidvpEUtALsrYo6RQXc3Jkyoi/2dfmQ4mClFh4EXATmB4EdbcDPykgOCYidA39Z+k5x/jccMRQP/QqA8eCS2iWxJrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719669166; c=relaxed/simple;
	bh=OgKWE5raRMdQzYYFIeI9oRWJDLJrgr/vHR/+EGZ8/l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni1WZlMgYWCXWTbv93WvfnUpqFZbVD5V32iN52nkLdoBRzIJbCjKhBnsvaG2SnBvUNyqA+7l5igClpkqxMbm8PSazlv5I2VQMDHX0A3/DiRZ6UnEbq54peQuVF0cRroG7cJOcDRb6vEuAt0mSQeRREvb+rA3hoPKiseFOSCfzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F70fcC+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED540C2BBFC;
	Sat, 29 Jun 2024 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719669166;
	bh=OgKWE5raRMdQzYYFIeI9oRWJDLJrgr/vHR/+EGZ8/l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F70fcC+8IgkQNQpHdzkIs7hPd9oP5o3oqaTGeKgJKpJeEVpSehvw+Vj3DDsj7zgCz
	 MVdgnTj3lga7hYGg83tLw81a92Nj9PVrQfma4JaFPGwCl5maC826pM99bAb+R7tydq
	 cXluf2ezmZu0e8ZK1yczgpuyxtX3uNyVqgt0kARiUcSjV7DIRfPn5hjLwdnzSTDaY8
	 NgONiOK0acP24b+lOi9ftpb5uhoAdFV3IVnkkwhr9Y9pw8hMwICkXMDDlF9NQyTtvr
	 ZobruG58fezSipuxb6OjkTm2MWguuP5ikadr4Qss6G5EkjNTW0EMCUdT273B4HXVFb
	 HmZxAlIkok1gg==
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
Subject: [PATCH v3 2/4] PCI: mediatek-gen3: Add mtk_gen3_pcie_pdata data structure
Date: Sat, 29 Jun 2024 15:51:52 +0200
Message-ID: <88ea0574f0bd4ee7cd30540f48177ec3ba997a07.1719668763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719668763.git.lorenzo@kernel.org>
References: <cover.1719668763.git.lorenzo@kernel.org>
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


