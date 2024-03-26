Return-Path: <linux-pci+bounces-5144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6DE88B7A8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 03:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F282E786C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 02:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A51128831;
	Tue, 26 Mar 2024 02:51:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62055A7B4;
	Tue, 26 Mar 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421472; cv=none; b=Rj6dWvdFII20e7wbTHG3JQeuwGCMIoF9UN+Mz0JyOYCbwSYgRF2TGy9uQzBnBVIuopD06uaxL0JJvpThQUXvvx1puCTnYQPwF6fjck59/s+PnXnCZGPZ7H1a/nFQA60WpDGGoNCDM7s7An+N8KafJzojAs7PTCh/EMp4j/xHXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421472; c=relaxed/simple;
	bh=MpqMQ/t/Tm6LdEI6CueBw7TL54njv18tTW+sqHAgPUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sn5qR/QZIjGVbD9RKWbf+7RWrcOEVcBud/KeGEFgifDm57AIULeRRSt1WvuSBHHgnsR5CLYTXFk2QjuzGVTLwa/4vrbBGBn6Pp2oPUosQp765h2mqFJlsQZkUi3xS6gwCy+ihmSTRhBkARu+GvqyN5nLziImIG95j1v/UnDHUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,154,1708354800"; 
   d="scan'208";a="199248035"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2024 11:45:58 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1CF43415DFB8;
	Tue, 26 Mar 2024 11:45:58 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 4/6] PCI: dwc: rcar-gen4: Add a new function pointer for other SoC support
Date: Tue, 26 Mar 2024 11:45:38 +0900
Message-Id: <20240326024540.2336155-5-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver can reuse other R-Car Gen4 SoC support. However, some
initializing settings differs between r8a779f0 and others. So, add
a new function pointer start_link_enable() to support other R-Car
Gen4 SoC in the future. No behavior changes.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 57 +++++++++++++++++++--
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 0be760ed420b..a37613dd9ff4 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -53,9 +53,16 @@ struct rcar_gen4_pcie {
 	void __iomem *base;
 	struct platform_device *pdev;
 	enum dw_pcie_device_mode mode;
+
+	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
+struct rcar_gen4_pcie_platdata {
+	enum dw_pcie_device_mode mode;
+	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
+};
+
 /* Common */
 static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
 					bool enable)
@@ -123,9 +130,13 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
 static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
 {
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
-	int i, changes;
+	int i, changes, ret;
 
-	rcar_gen4_pcie_ltssm_enable(rcar, true);
+	if (rcar->start_link_enable) {
+		ret = rcar->start_link_enable(rcar);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Require direct speed change with retrying here if the link_gen is
@@ -437,7 +448,10 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 /* Common */
 static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
 {
-	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
+	const struct rcar_gen4_pcie_platdata *pd = of_device_get_match_data(&rcar->pdev->dev);
+
+	rcar->mode = pd->mode;
+	rcar->start_link_enable = pd->start_link_enable;
 
 	switch (rcar->mode) {
 	case DW_PCIE_RC_TYPE:
@@ -500,14 +514,47 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 	rcar_gen4_pcie_unprepare(rcar);
 }
 
+static int r8a779f0_pcie_start_link_enable(struct rcar_gen4_pcie *rcar)
+{
+	rcar_gen4_pcie_ltssm_enable(rcar, true);
+
+	return 0;
+}
+
+static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie = {
+	.mode = DW_PCIE_RC_TYPE,
+	.start_link_enable = r8a779f0_pcie_start_link_enable,
+};
+
+static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie_ep = {
+	.mode = DW_PCIE_EP_TYPE,
+	.start_link_enable = r8a779f0_pcie_start_link_enable,
+};
+
+static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep = {
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static const struct of_device_id rcar_gen4_pcie_of_match[] = {
+	{
+		.compatible = "renesas,r8a779f0-pcie",
+		.data = &platdata_r8a779f0_pcie,
+	},
+	{
+		.compatible = "renesas,r8a779f0-pcie-ep",
+		.data = &platdata_r8a779f0_pcie_ep,
+	},
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


