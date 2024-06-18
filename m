Return-Path: <linux-pci+bounces-8922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E890D984
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72ABC1F244C2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25766502BE;
	Tue, 18 Jun 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEP+MTEl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D78061C;
	Tue, 18 Jun 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728921; cv=none; b=QqHfit4KQhhhriOaMFlx+RRyw5ZueTAntDxkD0hzQo6WeVoIVLGix3pUe0rJuWuJQmezQLmVQFkxeXQqPKpZl+pWjt4qmYwP8Zad5ESyvTMw5sLOb53JiqsRJFZnUHkYhhzlWjrkrhyxYeZWaFkPKV/Jtirq+GdpNfEIvrzwDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728921; c=relaxed/simple;
	bh=1t9Fd8hjLD9GE1UrBYXKrwectYleGkf2r0eJDop+PcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUny8aGnOQavF9uf/9w2cHxpyawMVUEkmG/e/CA/KVU2uRta9uZEhM8bAnID3B9EamTiJVQ9VcMas0GjnjV/t++zELvXSjdHisqRXTko0WeKLqWUMNouUc6uHnK9ejglZnO/yC+e+fD+Xc3VXu3OpXRScN9hyvyT4aY28ZPcYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEP+MTEl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d10so46140515ad.1;
        Tue, 18 Jun 2024 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718728919; x=1719333719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESixGGC9u5ovZQ6bWKTTIZp88BSFjHh98tzqZjNcDpA=;
        b=QEP+MTEl+x86kRQ8p56VPCWlZ88ljLRuOKg+o3JxwbCT0H4grAbaVg6mz/lqeeNHck
         EHvsXjmlkpsg/3kzxOxhcQdttU+xUFs7sQAr12fLa5aMxusclLdz3wy0ySOlsm3KfsjN
         C5RuUicZOIyY2m5D0cHWGbZZjS0MGsvzsmrMXxBPQKWZ/0EkMOw4j+hTlu0gVUGfB8VD
         46/GtlPbYHHa4KJex5N68PlRyNTHbRFcDuWS4S1R9NpMEwb2kQC6gKWyj/Ojz7fYLGCP
         LZUceFRaBC+4T5kcGmCoQ72gIz3lpdyyBja4m+BlY5bHOIWvtfwU0q0Iv+TAOzfLrM8R
         0MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718728919; x=1719333719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESixGGC9u5ovZQ6bWKTTIZp88BSFjHh98tzqZjNcDpA=;
        b=Yzd7FJRvw3O9DGDL8JN3309jzk/Nkx+7420mOCTaHhcnxLdU49z2nSvX5swuHv2Hv3
         VCdZeiQHdzvIsYUtH5UppUvSDFsfLV2smyxUp2/cjHVHxEZ56nO2XMixT+oVEleXgycF
         d5U1CVT80bWXoP1ioYcSDwH2tUrWDctEUzjkbeIwSgWk6e1ry5tD2+q3mE+tXR9RLdPc
         V/QEBH2pt6kJI3ypgIRbpgmNgeUnQC4iLWjC5pR0G9miTkU8wo+F/WQ4elAub695z8ht
         DaST8RFV6xM3Wj+0AD/N6FBw01/Lm+QAhGj4ty3D3Lyxaa0w3pxfWb6O4sIudf3d/yLO
         XEyA==
X-Forwarded-Encrypted: i=1; AJvYcCUsmIBD9c1KMtiz7LPgoT19s1PUDdium+sSWmgH2OJhwE3nerNiGdWEQo9U6hHXwxFXZ90/7oJjR0haoQ2wNH2vzspIJPkFd7KGZPQ60PGPxFv5Ce75+KPX2djm3ZQnx8CeueIx2RmE
X-Gm-Message-State: AOJu0YzGTB5beqhviIBX5SgrQQoQpEssZII+h+wTVbzIlpNRxnlQ5ZrR
	dAzTtp45L57CIIUAL3GCPF6SPCY2uVDhdd0KHHcKyVlxb3AdphLq
X-Google-Smtp-Source: AGHT+IFg4ssYvnK3V3MlBPc+TJw7hIS0CzI9EisxKeWciJMuK5xzpw7EkR0LYYrUHnpvSR2nd0UgwQ==
X-Received: by 2002:a17:902:6b4a:b0:1f6:e4ab:a1f2 with SMTP id d9443c01a7336-1f9aa3d3cddmr1315805ad.25.1718728918640;
        Tue, 18 Jun 2024 09:41:58 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0175csm99081835ad.191.2024.06.18.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:41:58 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
Date: Tue, 18 Jun 2024 22:11:27 +0530
Message-ID: <20240618164133.223194-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618164133.223194-1-linux.amoon@gmail.com>
References: <20240618164133.223194-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactors the reset control clock handling in the Rockchip PCIe driver,
introducing a more robust and efficient method for assert and
deassert reset controller using reset_control_bulk*() API. Using the
reset_control_bulk APIs, the reset handling for the core clocks reset
unit becomes much simpler.

As per rockchip rk3399 TRM SOFTRST_CON8 soft reset controller
have clock reset unit value set to 0x1 for example "pcie_pipe",
"pcie_mgmt_sticky", "pcie_mgmt" and "pci_core", hence group then under
one reset bulk controller.

Where as "pcie_pm", "presetn_pcie", "aresetn_pcie" have reset value
set to 0x0 ,hence group them under reset control bulk controller.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 139 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  24 +++--
 2 files changed, 44 insertions(+), 119 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 166dad666a35..5154dfb1311b 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -69,54 +69,24 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
 		rockchip->link_gen = 2;
 
-	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
-	if (IS_ERR(rockchip->core_rst)) {
-		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing core reset property in node\n");
-		return PTR_ERR(rockchip->core_rst);
-	}
-
-	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
-	if (IS_ERR(rockchip->mgmt_rst)) {
-		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt reset property in node\n");
-		return PTR_ERR(rockchip->mgmt_rst);
-	}
-
-	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
-								"mgmt-sticky");
-	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
-		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt-sticky reset property in node\n");
-		return PTR_ERR(rockchip->mgmt_sticky_rst);
-	}
-
-	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
-	if (IS_ERR(rockchip->pipe_rst)) {
-		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pipe reset property in node\n");
-		return PTR_ERR(rockchip->pipe_rst);
-	}
+	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
+		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
 
-	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
-	if (IS_ERR(rockchip->pm_rst)) {
-		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pm reset property in node\n");
-		return PTR_ERR(rockchip->pm_rst);
+	err = devm_reset_control_bulk_get_optional_exclusive(dev,
+			ROCKCHIP_NUM_PM_RSTS, rockchip->pm_rsts);
+	if (err) {
+		dev_err(dev, "cannot get the devm_reset_control err %d\n", err);
+		return err;
 	}
 
-	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
-	if (IS_ERR(rockchip->pclk_rst)) {
-		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pclk reset property in node\n");
-		return PTR_ERR(rockchip->pclk_rst);
-	}
+	for (i = 0; i < ROCKCHIP_NUM_CORE_RSTS; i++)
+		rockchip->core_rsts[i].id = rockchip_pci_core_rsts[i];
 
-	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
-	if (IS_ERR(rockchip->aclk_rst)) {
-		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing aclk reset property in node\n");
-		return PTR_ERR(rockchip->aclk_rst);
+	err = devm_reset_control_bulk_get_optional_exclusive(dev,
+			ROCKCHIP_NUM_CORE_RSTS, rockchip->core_rsts);
+	if (err) {
+		dev_err(dev, "cannot get the devm_reset_control err %d\n", err);
+		return err;
 	}
 
 	if (rockchip->is_rc) {
@@ -152,21 +122,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	int err, i;
 	u32 regs;
 
-	err = reset_control_assert(rockchip->aclk_rst);
+	err = reset_control_bulk_assert(ROCKCHIP_NUM_PM_RSTS,
+			rockchip->pm_rsts);
 	if (err) {
-		dev_err(dev, "assert aclk_rst err %d\n", err);
-		return err;
-	}
-
-	err = reset_control_assert(rockchip->pclk_rst);
-	if (err) {
-		dev_err(dev, "assert pclk_rst err %d\n", err);
-		return err;
-	}
-
-	err = reset_control_assert(rockchip->pm_rst);
-	if (err) {
-		dev_err(dev, "assert pm_rst err %d\n", err);
+		dev_err(dev, "reset bulk assert pm_rsts err %d\n", err);
 		return err;
 	}
 
@@ -178,47 +137,19 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
-	err = reset_control_assert(rockchip->core_rst);
+	err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
+			rockchip->core_rsts);
 	if (err) {
-		dev_err(dev, "assert core_rst err %d\n", err);
-		goto err_exit_phy;
-	}
-
-	err = reset_control_assert(rockchip->mgmt_rst);
-	if (err) {
-		dev_err(dev, "assert mgmt_rst err %d\n", err);
-		goto err_exit_phy;
-	}
-
-	err = reset_control_assert(rockchip->mgmt_sticky_rst);
-	if (err) {
-		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
-		goto err_exit_phy;
-	}
-
-	err = reset_control_assert(rockchip->pipe_rst);
-	if (err) {
-		dev_err(dev, "assert pipe_rst err %d\n", err);
+		dev_err(dev, "reset bulk assert core_rsts err %d\n", err);
 		goto err_exit_phy;
 	}
 
 	udelay(10);
 
-	err = reset_control_deassert(rockchip->pm_rst);
-	if (err) {
-		dev_err(dev, "deassert pm_rst err %d\n", err);
-		goto err_exit_phy;
-	}
-
-	err = reset_control_deassert(rockchip->aclk_rst);
-	if (err) {
-		dev_err(dev, "deassert aclk_rst err %d\n", err);
-		goto err_exit_phy;
-	}
-
-	err = reset_control_deassert(rockchip->pclk_rst);
+	err = reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
+			rockchip->pm_rsts);
 	if (err) {
-		dev_err(dev, "deassert pclk_rst err %d\n", err);
+		dev_err(dev, "reset bulk deassert pm_rsts err %d\n", err);
 		goto err_exit_phy;
 	}
 
@@ -261,31 +192,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 * Please don't reorder the deassert sequence of the following
 	 * four reset pins.
 	 */
-	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
+	err = reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
+			rockchip->core_rsts);
 	if (err) {
-		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
-		goto err_power_off_phy;
-	}
-
-	err = reset_control_deassert(rockchip->core_rst);
-	if (err) {
-		dev_err(dev, "deassert core_rst err %d\n", err);
-		goto err_power_off_phy;
-	}
-
-	err = reset_control_deassert(rockchip->mgmt_rst);
-	if (err) {
-		dev_err(dev, "deassert mgmt_rst err %d\n", err);
-		goto err_power_off_phy;
-	}
-
-	err = reset_control_deassert(rockchip->pipe_rst);
-	if (err) {
-		dev_err(dev, "deassert pipe_rst err %d\n", err);
+		dev_err(dev, "reset bulk deassert core_rsts err %d\n", err);
 		goto err_power_off_phy;
 	}
 
 	return 0;
+
 err_power_off_phy:
 	while (i--)
 		phy_power_off(rockchip->phys[i]);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index f256cdf4fa49..fceb6f526b72 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -288,6 +288,8 @@
 		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
 
 #define ROCKCHIP_NUM_CLKS	ARRAY_SIZE(rockchip_pci_clks)
+#define ROCKCHIP_NUM_PM_RSTS	ARRAY_SIZE(rockchip_pci_pm_rsts)
+#define ROCKCHIP_NUM_CORE_RSTS	ARRAY_SIZE(rockchip_pci_core_rsts)
 
 static const char * const rockchip_pci_clks[] = {
 	"aclk",
@@ -296,18 +298,26 @@ static const char * const rockchip_pci_clks[] = {
 	"pm",
 };
 
+static const char * const rockchip_pci_pm_rsts[] = {
+	"pm",
+	"pclk",
+	"aclk",
+};
+
+static const char * const rockchip_pci_core_rsts[] = {
+	"core",
+	"mgmt",
+	"mgmt-sticky",
+	"pipe",
+};
+
 struct rockchip_pcie {
 	void	__iomem *reg_base;		/* DT axi-base */
 	void	__iomem *apb_base;		/* DT apb-base */
 	bool    legacy_phy;
 	struct  phy *phys[MAX_LANE_NUM];
-	struct	reset_control *core_rst;
-	struct	reset_control *mgmt_rst;
-	struct	reset_control *mgmt_sticky_rst;
-	struct	reset_control *pipe_rst;
-	struct	reset_control *pm_rst;
-	struct	reset_control *aclk_rst;
-	struct	reset_control *pclk_rst;
+	struct  reset_control_bulk_data pm_rsts[ROCKCHIP_NUM_PM_RSTS];
+	struct  reset_control_bulk_data core_rsts[ROCKCHIP_NUM_CORE_RSTS];
 	struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
 	struct	regulator *vpcie12v; /* 12V power supply */
 	struct	regulator *vpcie3v3; /* 3.3V power supply */
-- 
2.44.0


