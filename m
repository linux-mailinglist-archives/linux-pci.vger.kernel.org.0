Return-Path: <linux-pci+bounces-6239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37B48A49E5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 10:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B5E1F24936
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273E237719;
	Mon, 15 Apr 2024 08:11:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC1A374EA;
	Mon, 15 Apr 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168709; cv=none; b=DCcOHEjdH9uRI+t+m4vH4FRiRPxk6rBanRHzYPMT3yVdxdq+Z22tni2Ybte2zrNgT7JxpTFqSu+4SLMXLKqLGnovsZTYQRBoL8bltaxTpRMvbzY530OgiYd5NTHSIrz9maIkIOgnZCKsVqH1/wFo8OYDsmH3ElbWXDTrb9C3jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168709; c=relaxed/simple;
	bh=TgHZapGTrEwN1f9JVsE/MlY5ft6z1uN7Fblr+gsJEHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nb6xhp0bRRmwrcYRyK+NrH/bA+Awu8aOHV6jIIRS880oqIwA6oT4qMHv6bztinPxc0rzs9jx9/Yx5kmG6FxdvPKbCFuxLQXif5HphjfAGl3UsSx5K/gslhJwvxVxGQyMU55IJK18y94hsWniLzOHgB4K/ZUcfe7qgkJYHIUsm30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="205421244"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 17:11:41 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C8A9A400296C;
	Mon, 15 Apr 2024 17:11:41 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v7 4/7] PCI: rcar-gen4: Add rcar_gen4_pcie_drvdata
Date: Mon, 15 Apr 2024 17:11:32 +0900
Message-Id: <20240415081135.3814373-5-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In other to support future SoCs such as r8a779g0 and r8a779h0 that
require different initialization settings, let's introduce SoC
specific driver data with the initial member being the device mode.
No functional change.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++++++-------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 0be760ed420b..3da0a844e1b6 100644
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
@@ -437,9 +441,9 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 /* Common */
 static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
 {
-	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
+	rcar->drvdata = of_device_get_match_data(&rcar->pdev->dev);
 
-	switch (rcar->mode) {
+	switch (rcar->drvdata->mode) {
 	case DW_PCIE_RC_TYPE:
 		return rcar_gen4_add_dw_pcie_rp(rcar);
 	case DW_PCIE_EP_TYPE:
@@ -480,7 +484,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 static void rcar_gen4_remove_dw_pcie(struct rcar_gen4_pcie *rcar)
 {
-	switch (rcar->mode) {
+	switch (rcar->drvdata->mode) {
 	case DW_PCIE_RC_TYPE:
 		rcar_gen4_remove_dw_pcie_rp(rcar);
 		break;
@@ -500,14 +504,22 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
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


