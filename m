Return-Path: <linux-pci+bounces-8921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452FD90D980
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF12D1F2394A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C76C2139DD;
	Tue, 18 Jun 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beZzDBXM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB78061C;
	Tue, 18 Jun 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728915; cv=none; b=UD7Q57k6n+KYtixQ7ATcQk2rkelZ1tXt3Fh09An43XQaj2KFu0/weWQPTGcF2PtXM4dI0rwKXED+g99mPvIxXp9qBne4HgXIo6SYurzGsAE8L0UmzaZ6QGkaPAbvmobYmyNw+iDHqCbWl4QENT7lZHIvNNMusHYFhWhcSI2R5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728915; c=relaxed/simple;
	bh=AGz5Cda7cXCQtzy8kzeT7lUAn+ZOVKSiIn2uCvKZXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuAS51LgWinxtUmQC63zaGNYYSat30+BQo06cq4bc6GqXnEfM1aDW2rlGGPgIWJlHDaY02oega+5zBx3NbLPmYzElsnBUAu5bCZPtBPfxUvWX9b0gw+rsXbCB1PJWFC3ztNei/cO6mQVjcHQkgmHALiPLQpwonV3GWXUkzGUPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beZzDBXM; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-70a365a4532so1995996a12.1;
        Tue, 18 Jun 2024 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718728913; x=1719333713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEKJAviaww/opy5uOYiRNCbAr4C1pq+2z0zEGSrd6PU=;
        b=beZzDBXMCSHvO+XzbyPepNs1xjyldRSxuYSnWSDAKOBCelnsVACl+P/ICfiBCIW15F
         BYrW5fyI8m4n1GI6wroPfRafnbZ6ZbsYTN95UNLLY6FqCdi1mWncMIDU2sRmkqP+8AK4
         Q0XrA6CpXLb6AJXl6KPMj3RrP7UZWxYb0q8ZGhPsRJT7laDM5QkHzXDCgsdwXfMiu+eO
         f85guehz4G61ADcDgr/zLsfo9CQ0vbkIsxMrJZGlQHfSFVFJOBWIc2NkSYfX1RfwIncn
         rSmBLYA/gw7sg61aBLVXvu/WIBOd9nK1Gr2ieAoS+qbKvkGEafN4OUFGfHqPj6int5I2
         6Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718728913; x=1719333713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEKJAviaww/opy5uOYiRNCbAr4C1pq+2z0zEGSrd6PU=;
        b=tDT0LPJ10RE1/g37v1WpWxjlEuO6BZOykZaJF47kGR5P4kGYpgZl36YniQnBEJCQoE
         eVb5ZfWNma1AE2gLwU3mK2+8AD7m3w/N6yaBYWYc7DdIg6hr/UkRCT3rrSYe5bKNfAQh
         3fQCEBgXrnkuNK193z8DJzhQu2bSeuRl3trErgcD9duY+IVWyzxBdH4m0qL/ytUtysgG
         3bZLdXtZ8nZoQ3uZNftqPaQ31BD9avX/aTf5c+ZEe4Ol3U5yNuLfz+WsuarhyjdRhwga
         U7txM/zRLz6wGomRrNxvelI5hQadktyxzuHBGV+7ujZkpIgkse491WP8qiQBhqPrhZDf
         rL0A==
X-Forwarded-Encrypted: i=1; AJvYcCXSw8ArGYaZsmAXD5at2Tnrsmy7eGje2ciSywq4d5qFyCFF1OIetXlp2dtlltrUqybMQit+EgdC4CkNMfKoIy1O4fZ31h369XjE2CZn8DCaWrOOXwao+hDR2wZLFULAvAIp9mkAkrqB
X-Gm-Message-State: AOJu0YzWA6Ezx3Y8Y4EkaVljffGHw5gEB+xuUNyNHwAHuNj0RH6A/Gjp
	BM999CXyYw1s1YQW5vSQ1j67TFcQjwAFD4gjCAETfNVt7e/V5omr
X-Google-Smtp-Source: AGHT+IE6ycMy8brzP3yQKsR/MLnmyODjfStahN/qCbSdYEUO+jsOWW626LyTQvb+AEorPSXcDg0QYg==
X-Received: by 2002:a17:903:11c7:b0:1f6:7212:75f0 with SMTP id d9443c01a7336-1f9aa3ceb87mr1916655ad.17.1718728912991;
        Tue, 18 Jun 2024 09:41:52 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0175csm99081835ad.191.2024.06.18.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:41:52 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Tue, 18 Jun 2024 22:11:26 +0530
Message-ID: <20240618164133.223194-2-linux.amoon@gmail.com>
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

Refactors the clock handling in the Rockchip PCIe driver,
introducing a more robust and efficient method for enabling and
disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
the clock handling for the core clocks becomes much simpler.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 64 ++++----------------------
 drivers/pci/controller/pcie-rockchip.h | 14 ++++--
 2 files changed, 20 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0ef2e622d36e..166dad666a35 100644
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
@@ -127,28 +127,13 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 					     "failed to get ep GPIO\n");
 	}
 
-	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
-	if (IS_ERR(rockchip->aclk_pcie)) {
-		dev_err(dev, "aclk clock not found\n");
-		return PTR_ERR(rockchip->aclk_pcie);
-	}
-
-	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
-	if (IS_ERR(rockchip->aclk_perf_pcie)) {
-		dev_err(dev, "aclk_perf clock not found\n");
-		return PTR_ERR(rockchip->aclk_perf_pcie);
-	}
-
-	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
-	if (IS_ERR(rockchip->hclk_pcie)) {
-		dev_err(dev, "hclk clock not found\n");
-		return PTR_ERR(rockchip->hclk_pcie);
-	}
+	for (i = 0; i < ROCKCHIP_NUM_CLKS; i++)
+		rockchip->clks[i].id = rockchip_pci_clks[i];
 
-	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
-	if (IS_ERR(rockchip->clk_pcie_pm)) {
-		dev_err(dev, "pm clock not found\n");
-		return PTR_ERR(rockchip->clk_pcie_pm);
+	err = devm_clk_bulk_get(dev, ROCKCHIP_NUM_CLKS, rockchip->clks);
+	if (err) {
+		dev_err(dev, "rockchip clk bulk get failed\n");
+		return err;
 	}
 
 	return 0;
@@ -372,39 +357,13 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 	struct device *dev = rockchip->dev;
 	int err;
 
-	err = clk_prepare_enable(rockchip->aclk_pcie);
+	err = clk_bulk_prepare_enable(ROCKCHIP_NUM_CLKS, rockchip->clks);
 	if (err) {
-		dev_err(dev, "unable to enable aclk_pcie clock\n");
+		dev_err(dev, "rockchip clk bulk prepare enable failed\n");
 		return err;
 	}
 
-	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
-		goto err_aclk_perf_pcie;
-	}
-
-	err = clk_prepare_enable(rockchip->hclk_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_hclk_pcie;
-	}
-
-	err = clk_prepare_enable(rockchip->clk_pcie_pm);
-	if (err) {
-		dev_err(dev, "unable to enable clk_pcie_pm clock\n");
-		goto err_clk_pcie_pm;
-	}
-
 	return 0;
-
-err_clk_pcie_pm:
-	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
-	clk_disable_unprepare(rockchip->aclk_pcie);
-	return err;
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
 
@@ -412,10 +371,7 @@ void rockchip_pcie_disable_clocks(void *data)
 {
 	struct rockchip_pcie *rockchip = data;
 
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->aclk_pcie);
+	clk_bulk_disable_unprepare(ROCKCHIP_NUM_CLKS, rockchip->clks);
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 6111de35f84c..f256cdf4fa49 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -287,6 +287,15 @@
 		(((c) << ((b) * 8 + 5)) & \
 		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
 
+#define ROCKCHIP_NUM_CLKS	ARRAY_SIZE(rockchip_pci_clks)
+
+static const char * const rockchip_pci_clks[] = {
+	"aclk",
+	"aclk-perf",
+	"hclk",
+	"pm",
+};
+
 struct rockchip_pcie {
 	void	__iomem *reg_base;		/* DT axi-base */
 	void	__iomem *apb_base;		/* DT apb-base */
@@ -299,10 +308,7 @@ struct rockchip_pcie {
 	struct	reset_control *pm_rst;
 	struct	reset_control *aclk_rst;
 	struct	reset_control *pclk_rst;
-	struct	clk *aclk_pcie;
-	struct	clk *aclk_perf_pcie;
-	struct	clk *hclk_pcie;
-	struct	clk *clk_pcie_pm;
+	struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
 	struct	regulator *vpcie12v; /* 12V power supply */
 	struct	regulator *vpcie3v3; /* 3.3V power supply */
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
-- 
2.44.0


