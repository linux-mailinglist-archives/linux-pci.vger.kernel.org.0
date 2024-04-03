Return-Path: <linux-pci+bounces-5587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C53896424
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 07:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D104284C80
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 05:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD5481B9;
	Wed,  3 Apr 2024 05:33:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB84EB5F;
	Wed,  3 Apr 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122399; cv=none; b=PXU3oL/QgthatHHPDugmow4Z7YR6pCtbN1RrO2Pr2SDWwReTvWllapWoDIgyyrTa7rMTg1/v4Ne8xWEfw21eFnzebyHlfkfLZDD3MXZpaIIL/HA6qERWPUE+N3V/9j5la3PgAAAJ5llJJyQB8PhFYA7Fyvfe+10V0rcnVLROXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122399; c=relaxed/simple;
	bh=JvBtad0J2pVqMkVoLq9W0c2q+s1EJrC8zTxmJmrQfvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiD9vADMNkcPCeZuQvDkKSeg2FXeRlPwlhr8LqK+P7dxarJw5otIPotBfAQLgq1kOHotmbtGPlcw7lq/Lrj4W/AJH85Ta+l0AeDs8+t5Yn/hOqnbmz1/t0P/kO9GA1ZztVD9h4QIb1xKjEl0gRTbUO5D2gRRH1pdKs15knHVTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="204148825"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Apr 2024 14:33:09 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4054B40029A6;
	Wed,  3 Apr 2024 14:33:09 +0900 (JST)
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
Subject: [PATCH v4 5/7] PCI: dwc: rcar-gen4: Add .ltssm_enable() for other SoC support
Date: Wed,  3 Apr 2024 14:33:02 +0900
Message-Id: <20240403053304.3695096-6-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver can reuse other R-Car Gen4 SoCs support like r8a779g0 and
r8a779h0. However, r8a779g0 and r8a779h0 require other initializing
settings that differ than r8a779f0. So, add a new function pointer
.ltssm_enable() for it. No behavior changes.

After applied this patch, probing SoCs by rcar_gen4_pcie_of_match[]
will be changed like below:

- r8a779f0 as "renesas,r8a779f0-pcie" and "renesas,r8a779f0-pcie-ep"

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 41 ++++++++++++++++++---
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index da2821d6efce..e760bcd30c4e 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -48,7 +48,9 @@
 #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
 #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
 
+struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_platdata {
+	int (*ltssm_enable)(struct rcar_gen4_pcie *rcar);
 	enum dw_pcie_device_mode mode;
 };
 
@@ -61,8 +63,8 @@ struct rcar_gen4_pcie {
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
 /* Common */
-static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
-					bool enable)
+static void rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar,
+					 bool enable)
 {
 	u32 val;
 
@@ -127,9 +129,13 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
 static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
 {
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
-	int i, changes;
+	int i, changes, ret;
 
-	rcar_gen4_pcie_ltssm_enable(rcar, true);
+	if (rcar->platdata->ltssm_enable) {
+		ret = rcar->platdata->ltssm_enable(rcar);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Require direct speed change with retrying here if the link_gen is
@@ -157,7 +163,7 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
 {
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	rcar_gen4_pcie_ltssm_enable(rcar, false);
+	rcar_gen4_pcie_ltssm_control(rcar, false);
 }
 
 static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
@@ -504,6 +510,23 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 	rcar_gen4_pcie_unprepare(rcar);
 }
 
+static int r8a779f0_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar)
+{
+	rcar_gen4_pcie_ltssm_control(rcar, true);
+
+	return 0;
+}
+
+static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie = {
+	.ltssm_enable = r8a779f0_pcie_ltssm_enable,
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie_ep = {
+	.ltssm_enable = r8a779f0_pcie_ltssm_enable,
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie = {
 	.mode = DW_PCIE_RC_TYPE,
 };
@@ -513,6 +536,14 @@ static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep = {
 };
 
 static const struct of_device_id rcar_gen4_pcie_of_match[] = {
+	{
+		.compatible = "renesas,r8a779f0-pcie",
+		.data = &platdata_r8a779f0_pcie,
+	},
+	{
+		.compatible = "renesas,r8a779f04-pcie-ep",
+		.data = &platdata_r8a779f0_pcie_ep,
+	},
 	{
 		.compatible = "renesas,rcar-gen4-pcie",
 		.data = &platdata_rcar_gen4_pcie,
-- 
2.25.1


