Return-Path: <linux-pci+bounces-8580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F9903C31
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1284284FA3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880CA17C7AC;
	Tue, 11 Jun 2024 12:51:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B017C213;
	Tue, 11 Jun 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110269; cv=none; b=jBTgiOroZjIZ2j7r4tfKKPo/jK5WkYNIM6HnGcLyWZC6Fh0g0dysXZfLiib/qspjrOtNdRENEW9WzpbuvSAkYb0Re0XbX3KwfaSkWIC7UbrDiQxBitVdYehBlN9gx+xLT0e1mwdWIQf7okDYqaQpDjXa+RBNnxOFRBsM42xmSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110269; c=relaxed/simple;
	bh=Kb+D628CEHKpo9KY8JPhLtMpFlYRZZXD8jfyDESS7Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/uFAU85SRgs9lRxxv2dvG+CxtJgnR3p1OCJhl9zAwyD6DW2zM79BkbP5mwHIp14N/H/kBkX5Sp20fuWODM34TAAOQimr2Mtvl/D8k37TgOIZ+F/bicLJ1ww8y2AC8e1ehHyYwz3o0GCIj1wvYn+tS8jSzR3ubTz6UbgDQFAihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.08,230,1712588400"; 
   d="scan'208";a="207497069"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Jun 2024 21:51:06 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F3C6F40104E9;
	Tue, 11 Jun 2024 21:51:05 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v9 2/5] PCI: rcar-gen4: Add rcar_gen4_pcie_drvdata
Date: Tue, 11 Jun 2024 21:50:54 +0900
Message-Id: <20240611125057.1232873-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support future SoCs such as r8a779g0 and r8a779h0 that
require different initialization settings, introduce SoC specific
driver data with the initial member being the device mode.
No functional change.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 32 +++++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index cfeccc2f9ee1..eb3ea4a5fd0a 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -48,11 +48,15 @@
 #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
 #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
 
+struct rcar_gen4_pcie_drvdata {
+	enum dw_pcie_device_mode mode;
+};
+
 struct rcar_gen4_pcie {
 	struct dw_pcie dw;
 	void __iomem *base;
 	struct platform_device *pdev;
-	enum dw_pcie_device_mode mode;
+	const struct rcar_gen4_pcie_drvdata *drvdata;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
@@ -137,7 +141,7 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
 	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
 	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
 	 */
-	if (changes && rcar->mode == DW_PCIE_RC_TYPE)
+	if (changes && rcar->drvdata->mode == DW_PCIE_RC_TYPE)
 		changes--;
 
 	for (i = 0; i < changes; i++) {
@@ -172,9 +176,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 
 	val = readl(rcar->base + PCIEMSR0);
-	if (rcar->mode == DW_PCIE_RC_TYPE) {
+	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
 		val |= DEVICE_TYPE_RC;
-	} else if (rcar->mode == DW_PCIE_EP_TYPE) {
+	} else if (rcar->drvdata->mode == DW_PCIE_EP_TYPE) {
 		val |= DEVICE_TYPE_EP;
 	} else {
 		ret = -EINVAL;
@@ -451,9 +455,11 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 /* Common */
 static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
 {
-	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
+	rcar->drvdata = of_device_get_match_data(&rcar->pdev->dev);
+	if (!rcar->drvdata)
+		return -EINVAL;
 
-	switch (rcar->mode) {
+	switch (rcar->drvdata->mode) {
 	case DW_PCIE_RC_TYPE:
 		return rcar_gen4_add_dw_pcie_rp(rcar);
 	case DW_PCIE_EP_TYPE:
@@ -494,7 +500,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 static void rcar_gen4_remove_dw_pcie(struct rcar_gen4_pcie *rcar)
 {
-	switch (rcar->mode) {
+	switch (rcar->drvdata->mode) {
 	case DW_PCIE_RC_TYPE:
 		rcar_gen4_remove_dw_pcie_rp(rcar);
 		break;
@@ -514,14 +520,22 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 	rcar_gen4_pcie_unprepare(rcar);
 }
 
+static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static const struct of_device_id rcar_gen4_pcie_of_match[] = {
 	{
 		.compatible = "renesas,rcar-gen4-pcie",
-		.data = (void *)DW_PCIE_RC_TYPE,
+		.data = &drvdata_rcar_gen4_pcie,
 	},
 	{
 		.compatible = "renesas,rcar-gen4-pcie-ep",
-		.data = (void *)DW_PCIE_EP_TYPE,
+		.data = &drvdata_rcar_gen4_pcie_ep,
 	},
 	{},
 };
-- 
2.25.1


