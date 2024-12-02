Return-Path: <linux-pci+bounces-17544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F269E07A2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 16:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E12166711
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2C20B7FF;
	Mon,  2 Dec 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR1JsSuH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374C1D545;
	Mon,  2 Dec 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152340; cv=none; b=MLtFqjd6CBkCTcAF/88186fs5Ze47T0whjxJh6ygHgJHB1su5VSKTFETp6/kgpkvQBmY1q16gjfXwqcIFHnc8e3dGzVQMYY5Y+qRymAUatG4JWKrPpnNvCJSn46eS4MhtmgZa+zTpflNXfWd72QZ9bD6PCVcLKXxpL1IfkIL96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152340; c=relaxed/simple;
	bh=+qV5viiJQWwZcaEk8+kcyyQYNyU4DvJZVUH7veCds6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX5Cl76PSItRhoe1q7tN0cHt56RMlZBrzE0nN6BHGGjbSM6u2+1oTxUv9ZKA53aQAqwzPfsEbiePd8k96HmnSSZhp7JSdki4yzzSEdjI5/byUvqfa6xT/s0w+RIXqczDgqWkDZR0AsYK5/X4lGQ1ODvSKS2KLuF0yPymEz3wFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR1JsSuH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21145812538so35176375ad.0;
        Mon, 02 Dec 2024 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152338; x=1733757138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvWsh4CHPQbPeCk10iBSDzAk8FSASDg2ROsws9NAfLg=;
        b=fR1JsSuHfpX47PeXDtK3bQ7jWEa2515B/OA3Vq6oxWwKEFieiTVbOv7mqkQpt06msk
         fhT4tvLBCcRbDBxcWxoP9f4IJAzgGy664NfOUuZaccmSQYbx5TaYgLqULWo0v/8X2Y1l
         ZcFxSSlkjC+y6xaq7KY6/zMdoWDKGx2vtKLZWLP2SLjtiRL/B2ePeHpC2nDJj2kFAtoM
         Mz8hdG/RP8uistbeLoALcZKdohBKaljGNKz2Vtqc7OxRxLoM371ItSMr3mq/AEjFwfb5
         P42NEDt5LcI1NfBwgjzch7iZa3FRzg5zKWtEZBoUtnVYOGQ6dthilanwgeIzMj88G5Bz
         6VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152338; x=1733757138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvWsh4CHPQbPeCk10iBSDzAk8FSASDg2ROsws9NAfLg=;
        b=CccRAIiSuTAAsux4wnJ6yQb1P82kkLXi9fXKLpN0ROIeTlcNw/jWknn1cIGWbZM3Zo
         LPUhr4RePPQsua6CBZAyCI3ODlzgBz+9W8BaO0a7LrcxcxroIh/vEOJyLlHDf2gUaAc7
         2nnmhsM3n+38q/6YyHeFCVScxWkHFghalJpDHy9mPCZ+MFfHu38uW4Da49Fb4Gk/Z0tF
         hMGhHM86IVNb1z5vqp670FMbMP+GX/5+4J3pa60zKK82AQPgScxUyRSbVR4ZQdV6aLT2
         8kzL1jQs/iSqIf4O4Xe40lZ8aOjC4ORYWqot77XCeFeCDHX7A8iGMN1FJjL1NLvNRea1
         HfNw==
X-Forwarded-Encrypted: i=1; AJvYcCWiPfQ1hDQvjHUaVkBmTNxm84pjOqrOOeeM12tsR+Dh7NGORJMOJflMoA46b2oe08LuAP8eLsHMASAd@vger.kernel.org, AJvYcCXl9TPs8EGFwnhsRvzY0TqXQVN5eJR1DtwAuJx//BsiUobs6j/eXnHVKhLES7DwjYdKXgaN0SKAZXO50Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7PD5nl5/jggSxiY3BA4F0u7AlIttMPcSP4fPaKZB0Muyiz/8g
	sPoc7KrCiMJjkhYQVrqlqpP3DNji5DbOKTf+L9aVDA1vrePJwVegywlMOaS3
X-Gm-Gg: ASbGncsT/xWQoq/rl+63CxdIa9WoMg/E+xcdY2vjoh8EBlomjG/NcZQMrKGw9rlHl0T
	E6ysDI+iD32g7QkoeiyTvp0ftquarIwju2mrJ5KlNFJkCcKnZ8kjc0XySV8+4VHRapJJuMvCSWR
	LBlivVt4EJtNz9o1n+UPWwVmRpaqyQLaF2olfhJ+feOursAPdymW9an3Miyzhp8TYDRTyfnsCN6
	PNTkKUWthQ0OYBZACFUDa5y/xKrmPslu36Iv4BoaS1GiAo9L1FDZXqyXx9ts4OGLA==
X-Google-Smtp-Source: AGHT+IGUskdQ6lyBzZGudv4RLzzi+Ppyu1aUugRi+lBecZa0uN8Qri5vpCuGP0RNCylYJKkcAeb9uA==
X-Received: by 2002:a17:902:e844:b0:212:88cc:d57b with SMTP id d9443c01a7336-2150107d129mr299675765ad.11.1733152338228;
        Mon, 02 Dec 2024 07:12:18 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f1da4sm78524955ad.12.2024.12.02.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:12:17 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/3] PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
Date: Mon,  2 Dec 2024 20:41:43 +0530
Message-ID: <20241202151150.7393-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202151150.7393-1-linux.amoon@gmail.com>
References: <20241202151150.7393-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver acquires and asserts/deasserts the resets
individually thereby making the driver complex to read. But this
can be simplified by using the reset_control_bulk APIs.
Use devm_reset_control_bulk_get_exclusive() API to acquire all
the resets and use reset_control_bulk_{assert/deassert}() APIs to
assert/deassert them in bulk.

Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':

1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
as Root Complex'.

2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per
section '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
reset_control_bulk APIs.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V11: added R-B Manivannan, Fix small typo.
v10: Fix some typo
v9: Improved the commit message and try to fix few review comments.
v8: I tried to address reviews and comments from Mani.
    Follow the sequence of De-assert as per the driver code.
    Drop the comment in the driver.
    Improve the commit message with the description of the TMP section.
    Improve the reason for the core functional changes in the commit
    description.
    Improve the error handling messages of the code.
v7: replace devm_reset_control_bulk_get_optional_exclusive()
        with devm_reset_control_bulk_get_exclusive()
    update the functional changes.
V6: Add reason for the split of the RESET pins.
v5: Fix the De-assert reset core as per the TRM
    De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
    simultaneously.
v4: use dev_err_probe in error path.
v3: Fix typo in commit message, dropped reported by.
v2: Fix compilation error reported by Intel test robot
    fixed checkpatch warning.
---
 drivers/pci/controller/pcie-rockchip.c | 154 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  26 +++--
 2 files changed, 48 insertions(+), 132 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 53aaba03aca6..693aadc99d6c 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -30,7 +30,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *node = dev->of_node;
 	struct resource *regs;
-	int err;
+	int err, i;
 
 	if (rockchip->is_rc) {
 		regs = platform_get_resource_byname(pdev,
@@ -69,55 +69,23 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
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
-	}
+	err = devm_reset_control_bulk_get_exclusive(dev,
+						    ROCKCHIP_NUM_PM_RSTS,
+						    rockchip->pm_rsts);
+	if (err)
+		return dev_err_probe(dev, err, "Cannot get the PM reset\n");
 
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
-	}
+	err = devm_reset_control_bulk_get_exclusive(dev,
+						    ROCKCHIP_NUM_CORE_RSTS,
+						    rockchip->core_rsts);
+	if (err)
+		return dev_err_probe(dev, err, "Cannot get the Core resets\n");
 
 	if (rockchip->is_rc)
 		rockchip->perst_gpio = devm_gpiod_get_optional(dev, "ep",
@@ -149,23 +117,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	int err, i;
 	u32 regs;
 
-	err = reset_control_assert(rockchip->aclk_rst);
-	if (err) {
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
-		return err;
-	}
+	err = reset_control_bulk_assert(ROCKCHIP_NUM_PM_RSTS,
+					rockchip->pm_rsts);
+	if (err)
+		return dev_err_probe(dev, err, "Couldn't assert PM resets\n");
 
 	for (i = 0; i < MAX_LANE_NUM; i++) {
 		err = phy_init(rockchip->phys[i]);
@@ -175,47 +130,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
-	err = reset_control_assert(rockchip->core_rst);
-	if (err) {
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
-		goto err_exit_phy;
-	}
+	err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
+					rockchip->core_rsts);
+	if (err)
+		return dev_err_probe(dev, err, "Couldn't assert Core resets\n");
 
 	udelay(10);
 
-	err = reset_control_deassert(rockchip->pm_rst);
-	if (err) {
-		dev_err(dev, "deassert pm_rst err %d\n", err);
-		goto err_exit_phy;
-	}
-
-	err = reset_control_deassert(rockchip->aclk_rst);
+	err = reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
+					  rockchip->pm_rsts);
 	if (err) {
-		dev_err(dev, "deassert aclk_rst err %d\n", err);
-		goto err_exit_phy;
-	}
-
-	err = reset_control_deassert(rockchip->pclk_rst);
-	if (err) {
-		dev_err(dev, "deassert pclk_rst err %d\n", err);
+		dev_err(dev, "Couldn't deassert PM resets %d\n", err);
 		goto err_exit_phy;
 	}
 
@@ -255,31 +180,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		goto err_power_off_phy;
 	}
 
-	/*
-	 * Please don't reorder the deassert sequence of the following
-	 * four reset pins.
-	 */
-	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
-	if (err) {
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
+	err = reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
+					  rockchip->core_rsts);
 	if (err) {
-		dev_err(dev, "deassert pipe_rst err %d\n", err);
+		dev_err(dev, "Couldn't deassert Core reset %d\n", err);
 		goto err_power_off_phy;
 	}
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index f79c0a1cbbd0..87041ed88b38 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
+#include <linux/reset.h>
 
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
@@ -310,18 +311,29 @@
 		(((c) << ((b) * 8 + 5)) & \
 		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
 
+#define ROCKCHIP_NUM_PM_RSTS   ARRAY_SIZE(rockchip_pci_pm_rsts)
+#define ROCKCHIP_NUM_CORE_RSTS ARRAY_SIZE(rockchip_pci_core_rsts)
+
+static const char * const rockchip_pci_pm_rsts[] = {
+	"pm",
+	"pclk",
+	"aclk",
+};
+
+static const char * const rockchip_pci_core_rsts[] = {
+	"mgmt-sticky",
+	"core",
+	"mgmt",
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
 	struct  clk_bulk_data *clks;
 	int	num_clks;
 	struct	regulator *vpcie12v; /* 12V power supply */
-- 
2.47.0


