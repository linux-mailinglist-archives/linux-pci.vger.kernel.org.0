Return-Path: <linux-pci+bounces-5468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E402B893711
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 04:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220F01C20B47
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4079F9;
	Mon,  1 Apr 2024 02:40:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847387F;
	Mon,  1 Apr 2024 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711939204; cv=none; b=cwjh7iW1RyM1zyjiZh864lYlaLzM75vtF/c5jl7xHGKqOJVHoDAicdwB8Dt0fuQ/Ace2pjOGXUSahQNHl27u5trQySSYHqSej+vMjyzA9hTdU8FVlmrl7xCQOl5l/HSoq2ioH99RbuoZG1sNEMC1vo4GYy+H5Y9UrG1IvOmq7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711939204; c=relaxed/simple;
	bh=jPSsJpSsdlsFMK7egSiIcG3k6bRSps+Mgikeex15dGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qjy+pYOzxyqMRJZ1Bc0v6t7vVCol+saz9FnbiW6QZN8XV2VLiV1eUVSGJOV5QubW358GXkMlScDAaZOXGh8ph/8hvPaZHYNAa/EscTcKYhVO58clAJMfGPDUZvwjhQ5fMsX+lmVx6WogX9fcFlLsi0qqFEJmckpBLLAMJpM519o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; 
   d="scan'208";a="199904689"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Apr 2024 11:39:50 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DD6C1410EB80;
	Mon,  1 Apr 2024 11:39:50 +0900 (JST)
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
Subject: [PATCH v3 4/7] PCI: dwc: rcar-gen4: Add rcar_gen4_pcie_platdata
Date: Mon,  1 Apr 2024 11:39:39 +0900
Message-Id: <20240401023942.134704-5-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401023942.134704-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240401023942.134704-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver supports r8a779f0 now. In the future, add support for
r8a779g0 and r8a779h0. To support these new SoCs, need other
initializing settings. So, at first, add rcar_gen4_pcie_platdata
and have a member with mode. No behavior changes.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++++++-------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 0be760ed420b..da2821d6efce 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -48,11 +48,15 @@
 #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
 #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
 
+struct rcar_gen4_pcie_platdata {
+	enum dw_pcie_device_mode mode;
+};
+
 struct rcar_gen4_pcie {
 	struct dw_pcie dw;
 	void __iomem *base;
 	struct platform_device *pdev;
-	enum dw_pcie_device_mode mode;
+	const struct rcar_gen4_pcie_platdata *platdata;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
@@ -137,7 +141,7 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
 	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
 	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
 	 */
-	if (changes && rcar->mode == DW_PCIE_RC_TYPE)
+	if (changes && rcar->platdata->mode == DW_PCIE_RC_TYPE)
 		changes--;
 
 	for (i = 0; i < changes; i++) {
@@ -172,9 +176,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 
 	val = readl(rcar->base + PCIEMSR0);
-	if (rcar->mode == DW_PCIE_RC_TYPE) {
+	if (rcar->platdata->mode == DW_PCIE_RC_TYPE) {
 		val |= DEVICE_TYPE_RC;
-	} else if (rcar->mode == DW_PCIE_EP_TYPE) {
+	} else if (rcar->platdata->mode == DW_PCIE_EP_TYPE) {
 		val |= DEVICE_TYPE_EP;
 	} else {
 		ret = -EINVAL;
@@ -437,9 +441,9 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 /* Common */
 static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
 {
-	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
+	rcar->platdata = of_device_get_match_data(&rcar->pdev->dev);
 
-	switch (rcar->mode) {
+	switch (rcar->platdata->mode) {
 	case DW_PCIE_RC_TYPE:
 		return rcar_gen4_add_dw_pcie_rp(rcar);
 	case DW_PCIE_EP_TYPE:
@@ -480,7 +484,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 static void rcar_gen4_remove_dw_pcie(struct rcar_gen4_pcie *rcar)
 {
-	switch (rcar->mode) {
+	switch (rcar->platdata->mode) {
 	case DW_PCIE_RC_TYPE:
 		rcar_gen4_remove_dw_pcie_rp(rcar);
 		break;
@@ -500,14 +504,22 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 	rcar_gen4_pcie_unprepare(rcar);
 }
 
+static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep = {
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static const struct of_device_id rcar_gen4_pcie_of_match[] = {
 	{
 		.compatible = "renesas,rcar-gen4-pcie",
-		.data = (void *)DW_PCIE_RC_TYPE,
+		.data = &platdata_rcar_gen4_pcie,
 	},
 	{
 		.compatible = "renesas,rcar-gen4-pcie-ep",
-		.data = (void *)DW_PCIE_EP_TYPE,
+		.data = &platdata_rcar_gen4_pcie_ep,
 	},
 	{},
 };
-- 
2.25.1


