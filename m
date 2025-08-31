Return-Path: <linux-pci+bounces-35199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC409B3D4C7
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 21:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F891898430
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 19:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD7219A8E;
	Sun, 31 Aug 2025 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClPTYhDt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9A45029;
	Sun, 31 Aug 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756666873; cv=none; b=Gqx9hG3zc6CKgRAwlXVIWFooRqdHERzmfwiHC5NpXAkNag0yo3KZSrH+EueUaBJPC6e7oaq3iDncGLOp3maCh3c9iwbTV7cTfowNvxnTJQjFZLFi7arHxsSpwMo2VZQya4O9CpdUkZ9wu3VE/ULYLIxjtbqXcQrBYh8TteRF70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756666873; c=relaxed/simple;
	bh=O9u4jrsWcgSJLjwEuGvkoBAQFbNEzPmu9PE45MwSOAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVck3N39k40zmS9N3rwtibaRBJq8LdxYMEC1LN07J9O3C1Pajfn0OJ44UIVASRzHQenofsmi9wYHXFyW00lJLBp+SX8X+gLDqQAKN45EeERBcRFEEtzXAaxPCQi4sjQcFjqc7SeD+QDgbVOeQPFvMWgg5TwFusmKszhAjirTM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClPTYhDt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-248cb0b37dfso33517585ad.3;
        Sun, 31 Aug 2025 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756666871; x=1757271671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz1CsfcxYUfcEfB+BVPvSDyn0EY8q3EVhwHouH3qFEc=;
        b=ClPTYhDtNMRMy4dpaAwb+rVKG2Do+xnd47slaMnVk8whbuDnsN8AOgOb2Ib+Mpuarg
         lLVltESwno4g9B8wiZR67rvNIC9RYtRqoDiCc3n1HdpF8IwqhUX1cEKAc1aaMSs13Lgc
         vhyVhkuaH/AqreZWqn02EyLqRbHrwBxelO6C1m3zlm/qbhscIBQzULMpkkUIL+TcvTdY
         nOJJNLBnI3Hmhavc4DkQFg45fqpEI2eHoiPERNppeCvkVzfbGKPRXDALuucJmDK5Uuz8
         RPaGXKsCOJcXpyz74B2jhXz9gh45lmztoHDA9LkF8uRugsU1SIclc8FrNTFn1WHm42l+
         SUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756666871; x=1757271671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz1CsfcxYUfcEfB+BVPvSDyn0EY8q3EVhwHouH3qFEc=;
        b=XjxkwPTonu1Xp+jqpFJzLFd2rChRDlgchgktK/FJQmZgrlB4AB9L9RbqDTdJFDsFUK
         XnG/iU247z4lHf8Eh4LhM8bt4B0rtCsf2/YB1M30WKlz1yWIPd8fVeX3hFDWA6MwJFSO
         8KJYZfI1NTYX+EDzWCsBwfaHFG3n7s6mkcLQk44w3D6dVPKiLPE9+X9ORHGJDu0TMs8X
         YGDzy3V2fk3fplunMXuGll+ap0xer8Ro0Sdy4vYw348qknPPbezyExtHEClvjm7/E4Vj
         JMIe+CwUwj1roQDoEBeYgAgnufMXrprW+l359ilKSRFhVaoFyfQc4eLtOGN3sEBkapaP
         uoiw==
X-Forwarded-Encrypted: i=1; AJvYcCUS7NMASZ3h3+0zw5Ey0kEeMc0St3ddWyZfDH7aF8JGtDjGd1sFOwMUVwzETJoMvHYIMR41+dQ9x5XPMQY=@vger.kernel.org, AJvYcCWWKNyBMdmcjigFeKrm5a12Hz3k8/mpodC7cRqkVejqDUtyrgsuulmpzeVbhc20gMgQKE1/BFQRnMFO5Uk=@vger.kernel.org, AJvYcCXupf0SYE8W6WRI+N25fvfqZ7RiNbX6t5r/VzpcthdrLX800+hI2uYTjfbI/B6Q4sHZed8G0LJwO03G@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxd1csa+iCx1qvUJ3VjKWKBiCP9ixGEJvek9r/xuvNuXRlF3Sk
	VnAkmO4OiH7ew6zQJvQ3OhqRIsaeWhFCN6+tIS5+tfRngP2x+xV8gi8R
X-Gm-Gg: ASbGncuMZUm8XcfQ4377OnldrjrKLUplj9P0wJRiLq6ryGmV8F2+lyAgy+fphvFl8xN
	kzJ1ZPxtBw7qwpPEEtzB0LJyiXZjZ2iUpNqwolPP2AbmU+yMONJDGDj4Aw/8QBqM0o4f/nxz3ZW
	miCWCu/KHE4II9xmqUNF8bpO6scBoGrp/a1rER31o8WcWPNrJxETxW9Br7B1Ny7NTKzpiEC8fD3
	vgZkLmG9q7giVKKg1ohxhWL1djgb1bmXrLmHDqDh7zBdh5iHFm9DwbO8I3U8MGCtYIoD7kiVDfG
	Tfx50VK3j7Dfq1XWvaJzh2UXkByzyb6eA9XPEv8amqqALY56H8wxgvFwMriAoTOKfl2U3lxULFF
	jQpwwTqkwevfCaWwATzPf
X-Google-Smtp-Source: AGHT+IF1CrG1XvAcqmHjcsJ6D5A+Df7Q3ZfsMDiee5420eTBRstxu8GgMXqrKZk/swbFQG2A1Dihow==
X-Received: by 2002:a17:903:1746:b0:248:e6cd:e150 with SMTP id d9443c01a7336-24944af1093mr75152245ad.49.1756666870922;
        Sun, 31 Aug 2025 12:01:10 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490372723fsm81118355ad.39.2025.08.31.12.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 12:01:09 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 1/2] PCI: tegra: Simplify clock handling by using clk_bulk*() functions
Date: Mon,  1 Sep 2025 00:30:50 +0530
Message-ID: <20250831190055.7952-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250831190055.7952-1-linux.amoon@gmail.com>
References: <20250831190055.7952-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver acquires clocks and prepare/enable/disable/unprepare
the clocks individually thereby making the driver complex to read.

The driver can be simplified by using the clk_bulk*() APIs.

Use:
  - devm_clk_bulk_get_all() API to acquire all the clocks
  - clk_bulk_prepare_enable() to prepare/enable clocks
  - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk

As part of this cleanup, the legacy has_cml_clk flag and explicit handling
of individual clocks (pex, afi, pll_e, cml) are removed. Clock sequencing
is now implicitly determined by the order defined in the device tree,
eliminating hardcoded logic and improving maintainability.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pci-tegra.c | 71 +++++-------------------------
 1 file changed, 12 insertions(+), 59 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 467ddc701adce..3841489198b64 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -297,7 +297,6 @@ struct tegra_pcie_soc {
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
-	bool has_cml_clk;
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
@@ -330,10 +329,8 @@ struct tegra_pcie {
 
 	struct resource cs;
 
-	struct clk *pex_clk;
-	struct clk *afi_clk;
-	struct clk *pll_e;
-	struct clk *cml_clk;
+	struct clk_bulk_data *clks;
+	int    num_clks;
 
 	struct reset_control *pex_rst;
 	struct reset_control *afi_rst;
@@ -1153,15 +1150,11 @@ static void tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
 	reset_control_assert(pcie->afi_rst);
 
-	clk_disable_unprepare(pcie->pll_e);
-	if (soc->has_cml_clk)
-		clk_disable_unprepare(pcie->cml_clk);
-	clk_disable_unprepare(pcie->afi_clk);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
 	if (!dev->pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
@@ -1174,7 +1167,6 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
 	reset_control_assert(pcie->pcie_xrst);
@@ -1202,35 +1194,16 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 		}
 	}
 
-	err = clk_prepare_enable(pcie->afi_clk);
+	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (err < 0) {
-		dev_err(dev, "failed to enable AFI clock: %d\n", err);
+		dev_err(dev, "filed to enable clocks: %d\n", err);
 		goto powergate;
 	}
 
-	if (soc->has_cml_clk) {
-		err = clk_prepare_enable(pcie->cml_clk);
-		if (err < 0) {
-			dev_err(dev, "failed to enable CML clock: %d\n", err);
-			goto disable_afi_clk;
-		}
-	}
-
-	err = clk_prepare_enable(pcie->pll_e);
-	if (err < 0) {
-		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
-		goto disable_cml_clk;
-	}
-
 	reset_control_deassert(pcie->afi_rst);
 
 	return 0;
 
-disable_cml_clk:
-	if (soc->has_cml_clk)
-		clk_disable_unprepare(pcie->cml_clk);
-disable_afi_clk:
-	clk_disable_unprepare(pcie->afi_clk);
 powergate:
 	if (!dev->pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
@@ -1254,25 +1227,11 @@ static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
-
-	pcie->pex_clk = devm_clk_get(dev, "pex");
-	if (IS_ERR(pcie->pex_clk))
-		return PTR_ERR(pcie->pex_clk);
 
-	pcie->afi_clk = devm_clk_get(dev, "afi");
-	if (IS_ERR(pcie->afi_clk))
-		return PTR_ERR(pcie->afi_clk);
-
-	pcie->pll_e = devm_clk_get(dev, "pll_e");
-	if (IS_ERR(pcie->pll_e))
-		return PTR_ERR(pcie->pll_e);
-
-	if (soc->has_cml_clk) {
-		pcie->cml_clk = devm_clk_get(dev, "cml");
-		if (IS_ERR(pcie->cml_clk))
-			return PTR_ERR(pcie->cml_clk);
-	}
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, pcie->num_clks,
+				     "failed to get clocks\n");
 
 	return 0;
 }
@@ -2345,7 +2304,6 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_pex_clkreq_en = false,
 	.has_pex_bias_ctrl = false,
 	.has_intr_prsnt_sense = false,
-	.has_cml_clk = false,
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
@@ -2374,7 +2332,6 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_cml_clk = true,
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
@@ -2395,7 +2352,6 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_cml_clk = true,
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
@@ -2418,7 +2374,6 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_cml_clk = true,
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
@@ -2459,7 +2414,6 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_cml_clk = false,
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
@@ -2672,7 +2626,7 @@ static int tegra_pcie_pm_suspend(struct device *dev)
 	}
 
 	reset_control_assert(pcie->pex_rst);
-	clk_disable_unprepare(pcie->pex_clk);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
@@ -2706,9 +2660,9 @@ static int tegra_pcie_pm_resume(struct device *dev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_enable_msi(pcie);
 
-	err = clk_prepare_enable(pcie->pex_clk);
+	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (err) {
-		dev_err(dev, "failed to enable PEX clock: %d\n", err);
+		dev_err(dev, "failed to enable clock: %d\n", err);
 		goto pex_dpd_enable;
 	}
 
@@ -2729,7 +2683,6 @@ static int tegra_pcie_pm_resume(struct device *dev)
 
 disable_pex_clk:
 	reset_control_assert(pcie->pex_rst);
-	clk_disable_unprepare(pcie->pex_clk);
 pex_dpd_enable:
 	pinctrl_pm_select_idle_state(dev);
 poweroff:
-- 
2.50.1


