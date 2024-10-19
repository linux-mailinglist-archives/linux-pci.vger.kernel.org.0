Return-Path: <linux-pci+bounces-14894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4359A4B75
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 08:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5131F23573
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 06:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FAA1DC04B;
	Sat, 19 Oct 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy6cjKP8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670F1DD86A;
	Sat, 19 Oct 2024 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317736; cv=none; b=DS74Hmn21pLMLbC5oRHjdi0LeoOIAQ0534FRbmBOsNOXiXbdZncP60iHROilUctID1OdbCvV15tYBPasPr6pAcprHpAo3Ewa4WG90aqh2IInsgUHcZRqE3OvY99oGGtFoz45KDMKjN40RJ0OTzTUogj3F2ixl/N1BjBAhGY41Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317736; c=relaxed/simple;
	bh=IzikBY/OH6+xQaBkfO8EJOK8e/JXHMUoIT8Kg/2/jEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTyI6A8APghaowsN0pDC3dLB6NwjtpJEiN5cVjN1ipqP3+bdlYNtnUY4gVC1OZ9c6m2LiOoo64I7olHevHwZ3I9eQClFcdDidMHviUOixU0wDdxMRygQ+oriyS79BMhg8XXk6xdpM3KEuwv0zomiY08tZVpaL9HFRcs1gw99s6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy6cjKP8; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so2542201a12.0;
        Fri, 18 Oct 2024 23:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729317733; x=1729922533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JrcPMHlcV9adMy48c1ZXkfyShK78vxkzdeJ59aYVBU=;
        b=hy6cjKP8UKSl9UGZ0qiucmRlxax39WapDS0hfgFRcK+4EXZsMC1Laz8qnSslsdSjII
         VxrEiKIfbJxHoj2/TBhO072YZHHZNh4cfAreT/sYT1/306ju9pcKKF8q99FhtkBgfUUA
         IQdUqtHmVurl7413FqLgGxnFEQDRcssTXHqy9mnUQwyQ3a3YECactLkuxsYQVqXn2DNl
         MbiSdNLD7yMAhzf6TJuzIDNIcTRI0ubFrwWpI7Ct9BBFjax3oEFSQEzL6Lq1XVME+sxx
         opOlAgeRTZrXZiH04Vega6ovz+rlqIuS83apSQRYH0VraKOrIknhcR9BEqOfNEmnDomy
         DBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729317733; x=1729922533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JrcPMHlcV9adMy48c1ZXkfyShK78vxkzdeJ59aYVBU=;
        b=Hpk/nLuvdZOob3i74NHxz77ZaWbWTC4t9EFFjIPYlC5d0o1MSwOUXjCSMZNqXi9H/9
         N6lB73578hIhVee6lje4/E+2T9ccjurKULQiqq90Hy7IwO1cbVIw6kqyZnXM980jv/EF
         HJ4taVXlVCnwqX9i7CaXs1/ypx6p3HyqNI5PqKZBqTLFx/NdgyCqSLnFc/V7mEaH8Jpg
         S8uMuzuIffra9BE7w3XnDpHyIB1GJRu94wOTqtkthe98czY5us/7JW5P5QsxbbvjCxPZ
         f3YehzQLFAgXvlTstMjxl4+yr97LxpEa8mzZqjurAsPuQSsCoRAJ/EswVIbb5UfV49ly
         ze9g==
X-Forwarded-Encrypted: i=1; AJvYcCVybrTQyGaqh0yhlHVd5RhOWHfjLl5z4aU9JQRrcghlPXLJptGz1iOyudR7hhAIEzQRYm04OXZqnOCuaGs=@vger.kernel.org, AJvYcCWuifnj/Ys9DsA4zoV6P9e9MuMTjXgCYx8pFui/ja/dlk0OZba2wtORulJZLbSLIf53p+o6vIwZThe0@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxYkDa2L7O7s8dJEBCY+N+yFuGaoo81jyj9BQl3FJ4eomL+0u
	a0OGvps/mTTTaGSjDvEH8n9lIVKRtFgcFecYyMpzCC4/2M0wz88E
X-Google-Smtp-Source: AGHT+IF1v0BNH63HxjbOIJwreaZipLghsjw86hUnMZmXwLtJbLY6R+EAWcyTBBcnLiDNjkm7xwzcsg==
X-Received: by 2002:a05:6a21:3a94:b0:1d9:21c7:5af7 with SMTP id adf61e73a8af0-1d92c4e0698mr7051092637.15.1729317733198;
        Fri, 18 Oct 2024 23:02:13 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333e94fsm2424237b3a.69.2024.10.18.23.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 23:02:12 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v10 2/3] PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
Date: Sat, 19 Oct 2024 11:31:34 +0530
Message-ID: <20241019060141.2489-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241019060141.2489-1-linux.amoon@gmail.com>
References: <20241019060141.2489-1-linux.amoon@gmail.com>
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

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
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
index 2777ef0cb599..c17aa8ec80b9 100644
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
 
 	if (rockchip->is_rc) {
 		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
@@ -147,23 +115,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
@@ -173,47 +128,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
 
@@ -252,31 +177,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
+		dev_err(dev, "Couldn't deassert Core %d\n", err);
 		goto err_power_off_phy;
 	}
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index bebab80c9553..cc667c73d42f 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
+#include <linux/reset.h>
 
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
@@ -288,18 +289,29 @@
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
2.44.0


