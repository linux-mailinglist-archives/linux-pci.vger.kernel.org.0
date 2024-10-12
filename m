Return-Path: <linux-pci+bounces-14357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25F99B108
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2461F22F8F
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 05:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D49131182;
	Sat, 12 Oct 2024 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0JvwQ3p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAE12F588;
	Sat, 12 Oct 2024 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728709599; cv=none; b=a+01K/rkVAygax1DqB5q6ufYOlK1eZEvpaPIt/tkE61NCii9uQKRNxz1VHwpeuieciSIBIYYmI+kAH9fy1Di9BIZSFLv/pyDPYN2+obCNQMEc+FnagkpP8vvqNdWZlrH9WSUxOrXasUZYFU7WM6zBKzlpamdU1hOCz+rSm0uzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728709599; c=relaxed/simple;
	bh=B7mXjWmXjnLhhF/ML2pcFrTTYi2DFefxW71JuLO+KHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsvfkx7Ly2tEyaI4ZWVvXTwc5ZepPGIxONkPiX9QXdI1j5Q46f1UeVIZnZq5bDJRthk4QGZHEUOIiELDaa/8myHfKngrFR8Yw5x/mpEbTN4Q8llDlBDfQuVayNEg1oAXZ7s5o96cuzDzW/WYAO3fM+yYtfALHQJ6imNHyRQqaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0JvwQ3p; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71df8585a42so2077912b3a.3;
        Fri, 11 Oct 2024 22:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728709597; x=1729314397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wpn7B9Wtu3Iag2UMSF/s43VYHpuMNQiv15wMhgNrH0=;
        b=D0JvwQ3pE+Lgm1UCQW0PFUAWxCq2iIr2T+PGLWBKXxjrElzO9tGU0FdT60Q/gW/jlI
         a8fngQ7aNgZup/mVhF4Fs++RBUPs4Rwkepr0eUi8cvZDJcCe8nt8W2T5cFiWsEFcLzYG
         zf9EHx38rkVmi9BT3lVOUkqmARUtvMUlER6X/ti/gmciuZHFAaQ8rEbb1DrYguePhu8B
         HSgjORWpIKZ9H6ydKAP9gCeLFcZcCIM307jCzvzMxmOlv2B8bxgbekOyP4NBNNcVKtBe
         4nEc03v/uwkwHMk+3iWr88eyKaz7QksxWFij0q55V+LSocSa/ectcRuwRLsIEHQGZoJ9
         RwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728709597; x=1729314397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wpn7B9Wtu3Iag2UMSF/s43VYHpuMNQiv15wMhgNrH0=;
        b=nM/+YIeczuTZz98pMswYoo5pnRTE8cmS57i2RN21jGZjGBxuCdgUmtUuYRBMyOb5se
         0JXCtYsxNgSYlKzPtNEWeG1Ky+VVmrWiDeRBPd2qclzi6BP596FAnlsY8M9Pa43srsG8
         t7up+jnAb8d7kAG7XXjpjG2lQxSTMzXQ3EEv7NaAS8Quf7WUHu4uxIU3i5xwB6PE7icQ
         4R6ucrqSVTZpY3wkiuXzFWPHT2delQh1g5HFp9kH77braMbo7D0iXqN4isfb03IX5PYR
         OiwPZdfFoNUg/fMeUceZkmD8gU72ElxNJ8JGNpYQXgrDk7KrW3ZC2TSiMhoOfXILiIMn
         IpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLVr1hFUvmXqJBhSP3wSvXnQBPxXz0wzZWHr9uD2EsklhTcPAyy1OFTPTF3g4GA/aS1ITX6g4kAouW@vger.kernel.org, AJvYcCXmmzYvlqSX0bTzKGpbzxUatqCmnuSkQ8JAZoPjt7Ovasp7YbTaYgZQ9XGW5c6QAhPoH3DcXIyIa2xj9U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UD8MDZrN7Ag5Q3lBMMLR7mcyfgfPld1uSe97oVqQdpvVkkf9
	uDZfPbnsMHQErl57iE+rcIETMm9P+f0vD0bH9xnzwZ98LRzZ/CJy
X-Google-Smtp-Source: AGHT+IHdgxQSWB1iZ5ATGcBFggAhGVl31eDwJP8ZSAoh7j+MvFbLYIWYD4qCh22mXfzqB+Gvgd12JQ==
X-Received: by 2002:a05:6a00:14c2:b0:71e:989:e714 with SMTP id d2e1a72fcca58-71e37ec58c6mr8669206b3a.11.1728709597460;
        Fri, 11 Oct 2024 22:06:37 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4ad1b9f7sm859809b3a.190.2024.10.11.22.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 22:06:37 -0700 (PDT)
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
Subject: [PATCH v7 2/3] PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
Date: Sat, 12 Oct 2024 10:36:04 +0530
Message-ID: <20241012050611.1908-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241012050611.1908-1-linux.amoon@gmail.com>
References: <20241012050611.1908-1-linux.amoon@gmail.com>
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

Spilt the reset controller in two groups as pre the RK3399 TRM.
After power up, the software driver should de-assert the reset of PCIe PHY,
then wait the PLL locked by polling the status, if PLL
has locked, then can de-assert the reset simultaneously
driver need to De-assert the reset pins simultionaly.

  PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.

- replace devm_reset_control_get_exclusive() with
	devm_reset_control_bulk_get_exclusive().
- replace reset_control_assert with
	reset_control_bulk_assert().
- replace reset_control_deassert with
	reset_control_bulk_deassert().

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
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
 drivers/pci/controller/pcie-rockchip.c | 151 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  26 +++--
 2 files changed, 49 insertions(+), 128 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 2777ef0cb599..9a118e2b8cbd 100644
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
+		return dev_err_probe(dev, err, "cannot get the reset control\n");
 
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
+		return dev_err_probe(dev, err, "cannot get the reset control\n");
 
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
+		return dev_err_probe(dev, err, "reset bulk assert pm reset\n");
 
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
+		return dev_err_probe(dev, err, "reset bulk assert core reset\n");
 
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
+		dev_err(dev, "reset bulk deassert pm err %d\n", err);
 		goto err_exit_phy;
 	}
 
@@ -256,31 +181,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 * Please don't reorder the deassert sequence of the following
 	 * four reset pins.
 	 */
-	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
-	if (err) {
-		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
-		goto err_power_off_phy;
-	}
-
-	err = reset_control_deassert(rockchip->core_rst);
+	err = reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
+					  rockchip->core_rsts);
 	if (err) {
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
+		dev_err(dev, "reset bulk deassert core err %d\n", err);
 		goto err_power_off_phy;
 	}
 
 	return 0;
+
 err_power_off_phy:
 	while (i--)
 		phy_power_off(rockchip->phys[i]);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index bebab80c9553..2761699f670b 100644
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
+	"mgmt",
+	"core",
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


