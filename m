Return-Path: <linux-pci+bounces-9111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC7F913254
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 08:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C31C21B37
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 06:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39D13D61A;
	Sat, 22 Jun 2024 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYWwHNvO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5414B959;
	Sat, 22 Jun 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719037154; cv=none; b=GyUR2mT5Y7gXwP6FVLF2sl5Xuk+BtsmpsOd1WDaOlCmI8f+vS9FbmWHwZZW1gpZDc8KnlOtToU53JVnXg2bewkfwgCIBdtu+Thmdck71mRD5A37Ifj2mcg38stSH2BHs1nZS/DTpHeP0tQ8o+8Rsffz9roOYmfOej2bveSrFEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719037154; c=relaxed/simple;
	bh=Y0rbTh9JaDi3RQOLTm/L9VOa/Yf2UtaZiuVte6NT2hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4Pl30bmFsF3IdEiTH+/aU/Pz2cfLA0P7PbbwSzy1ifr0F4G36MiZqp8zGt6dE/G7hGN0ap1NMln0res7GvljMzbiu6i6nIi13TommThOC3DmiPx2v/93ttP3uuF5MvlgmdhAKDNgTio9fzP+mSESK9jlXkUJWtKdQgxijec9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYWwHNvO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70661cd46d2so703817b3a.3;
        Fri, 21 Jun 2024 23:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719037152; x=1719641952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxxJJ1Zq1TKyO6LKePArVEGh9zB2iohdz0TZ1bWdXnA=;
        b=XYWwHNvOgbJ6fqWlDfY0MnKzVx7taOwkQkcvJkJU7bkdZKKiU3zX4I0em1aS5uoo7p
         LN67qYOx/ODEFtB5pt9jXBgwQzfPphc5AJm3XiQlXOFy7UiXuwUTmS1C1EW9KxBhir2E
         bIBcnNu9aZXSq7F3qOZ0Y2Y0oPLBXSEhBGKR8rdVrrNkUoHg8syt7aKC76gMV6bmb1Db
         SqpMg3+l/r4hozqiOtXn4doEhHdh9r+0O2w1AzfYlnkJgxjXbVLepR+MieFIFfZDzmPt
         yXBN9JFR8cERvc1PO6+i2yDPpepnJbu0wIedFLQ2NRbWhcZRukYqUjfG8k0W4kqo84VQ
         Rkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719037152; x=1719641952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxxJJ1Zq1TKyO6LKePArVEGh9zB2iohdz0TZ1bWdXnA=;
        b=UQ9wqzq1ShYmgRzAGG6qjvCKveGe5mIv7sQNaTQ93MzGe41G0Ra8nAwhFxvWf+g2/r
         KQOK6zIJlpFpgwWLOOwqWcG0mxlUWtUPu+B9NOIj/q/G9MBDnJErD1VoZFx4XVDvvKu/
         ImXKOwM0ziqmWioubboKq1GwRhxjFkTKOrhjLhm/ofbWwYjVsfZKbojMruY08zwx8Viu
         QL5562hDQZx5TiUHFEv9zczrb2XGQLaLgf2ERiDzI5OBez3DbysmAWANNhQ1JfkDg1l+
         QF2ouYhowsD51ZxyTbZsN29R5jboNlPbVnMMjdYh4PL4EFtD60O1BEhDQbXoXs2t293r
         N0cg==
X-Forwarded-Encrypted: i=1; AJvYcCUv33nY7FIBFffdoTz30flnMAt+Qmmaevxg9xfyyCty2u1VwY2rYEiZxFRADAaDuhbj5hhaeNFupVP30DYD6lUCK+6NhoNNFow6lhudOYWe6+VmzASlQO9WYnPIh/0kppO6PtgBxNfP
X-Gm-Message-State: AOJu0YxyQqTSfUVfPOKG6oyHEWE1L1kr+Mdo4XJkwPPl2eEPiCGNi4dV
	Bg0hDgX5iR20iiQ2mvczhrzVNEG3cOqjE6td133gU08DFwVDtQrN
X-Google-Smtp-Source: AGHT+IFILJk27iCIxuseIM+02eNcHoN2UkUZo85T5F0tcMNZh2iQMmEr9H9i+zOytBt+aLZnP6rG5g==
X-Received: by 2002:a05:6a20:2a2f:b0:1b7:edea:e3f with SMTP id adf61e73a8af0-1bcbb421cfamr9446767637.12.1719037151750;
        Fri, 21 Jun 2024 23:19:11 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e7bf0sm4692240a91.19.2024.06.21.23.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 23:19:11 -0700 (PDT)
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
Subject: [PATCH v3 2/3] PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
Date: Sat, 22 Jun 2024 11:48:39 +0530
Message-ID: <20240622061845.3678-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240622061845.3678-1-linux.amoon@gmail.com>
References: <20240622061845.3678-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the reset control handling in the Rockchip PCIe driver,
introducing a more robust and efficient method for assert and
deassert reset controller using reset_control_bulk*() API. Using the
reset_control_bulk APIs, the reset handling for the core clocks reset
unit becomes much simpler.

As per rockchip rk3399 TRM SOFTRST_CON8 soft reset controller
have clock reset unit value set to 0x1 for example "pcie_pipe",
"pcie_mgmt_sticky", "pcie_mgmt" and "pci_core", hence group then under
one reset bulk controller.

Where as "pcie_pm", "presetn_pcie", "aresetn_pcie" have reset value
set to 0x0, hence group them under reset control bulk controller.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: Fix typo in commit message, dropped reported by.
v2: Fix compilation error reported by Intel test robot
    fixed checkpatch warning
---
 drivers/pci/controller/pcie-rockchip.c | 141 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  25 +++--
 2 files changed, 47 insertions(+), 119 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 166dad666a35..f79e2b0a965b 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -69,54 +69,26 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
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
+							     ROCKCHIP_NUM_PM_RSTS,
+							     rockchip->pm_rsts);
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
+							     ROCKCHIP_NUM_CORE_RSTS,
+							     rockchip->core_rsts);
+	if (err) {
+		dev_err(dev, "cannot get the devm_reset_control err %d\n", err);
+		return err;
 	}
 
 	if (rockchip->is_rc) {
@@ -152,21 +124,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	int err, i;
 	u32 regs;
 
-	err = reset_control_assert(rockchip->aclk_rst);
+	err = reset_control_bulk_assert(ROCKCHIP_NUM_PM_RSTS,
+					rockchip->pm_rsts);
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
 
@@ -178,47 +139,19 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
-	err = reset_control_assert(rockchip->core_rst);
+	err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
+					rockchip->core_rsts);
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
+					  rockchip->pm_rsts);
 	if (err) {
-		dev_err(dev, "deassert pclk_rst err %d\n", err);
+		dev_err(dev, "reset bulk deassert pm_rsts err %d\n", err);
 		goto err_exit_phy;
 	}
 
@@ -261,31 +194,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 * Please don't reorder the deassert sequence of the following
 	 * four reset pins.
 	 */
-	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
+	err = reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
+					  rockchip->core_rsts);
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
index 72346e17e45e..27e951b41b80 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
+#include <linux/reset.h>
 
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
@@ -289,6 +290,8 @@
 		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
 
 #define ROCKCHIP_NUM_CLKS	ARRAY_SIZE(rockchip_pci_clks)
+#define ROCKCHIP_NUM_PM_RSTS	ARRAY_SIZE(rockchip_pci_pm_rsts)
+#define ROCKCHIP_NUM_CORE_RSTS	ARRAY_SIZE(rockchip_pci_core_rsts)
 
 static const char * const rockchip_pci_clks[] = {
 	"aclk",
@@ -297,18 +300,26 @@ static const char * const rockchip_pci_clks[] = {
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


