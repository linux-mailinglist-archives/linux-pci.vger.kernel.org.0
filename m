Return-Path: <linux-pci+bounces-14356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0A199B106
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02A0B2270B
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 05:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFB2139CEF;
	Sat, 12 Oct 2024 05:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFhWh1ig"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D0139CE9;
	Sat, 12 Oct 2024 05:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728709594; cv=none; b=mFK5HV5RYSMlqoN6wazmyhDxikWJubcHhrQ+ntPuR1HQPWJXB7ZiswatsPvfqsJgYos6MJZcsvxma5fdDYMVBoKnrb0qsJTm6J+OuYdoAAJjKx3lwpmZ2ct2QScq3xwR7nHzBua8Tj/lxh+sKEVNIbfzfO6mmhTfQQlpjh3RM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728709594; c=relaxed/simple;
	bh=UyZLnBHsR+VLzg85cvMsCfu8ZJAOifu39+GTnkHWUQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3moj0qtx5Sdn87BfuWBJ2J9Y2av2gvkbN9GH948hjzvdoPjQ94JRy4U0oDPaEd0DHP92xt4YEw8MzgQGmZRVTNGTnc01agvnoBXKGZzr1QTRowfC4LAdu49sC1XbCGb1s+V3flQoCYjFfTraq75r7obX9dfOWPIeuDsk74k+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFhWh1ig; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e06ba441cso2239641b3a.1;
        Fri, 11 Oct 2024 22:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728709592; x=1729314392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVdwZ9INnz1rSSRJAqZ6l2BLOiXSoUY6Jd3SSqJ9fJ0=;
        b=QFhWh1igKbgG2VmdKLK15jhmlIeyghWn0xrW8sTz1zf4+UvMJUuI6LEK6i/eCsdAB2
         89tn3I5BYYpa6crZUtB33AwNCD6D1LC9FTRZQKaUsG6TinOseO//tgp8/QC6ITmD2a5e
         C40PgVxvi5X5UfjXo0/EGlDccUkCpdRDPWTQFr5s4nYfJcuLKzEfWmbLIuWPtjgvoNzZ
         u18SXHI4IoKgY5YxBZo0nQN9eXcEEpUo0i7BD0ToC30EjNO+PK4vmr/0g6CV+7x2HBUf
         UAtAcDLXLewoEbAwuaHXpNU0TEmu4TppeEhQFCgO6zPhde0eEkU5D0yBawDwWZyj+PnV
         mFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728709592; x=1729314392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVdwZ9INnz1rSSRJAqZ6l2BLOiXSoUY6Jd3SSqJ9fJ0=;
        b=BIHZHWMl2+DSANr/7EJEV/HyQGllhA3B8Y0flvyK7ezQJF2WNGl9JPjoBBLOtqftN3
         oiatmLGmxm/VuPp79/+/nmGJRZI9yzH6DGMxTIzUuoXSohn7OVsFT/RgmGQ2S84hldIM
         +nMu8WvqGAk4GElU21LV1ZSaP6H2utN/PAeBlO0L8B0AzNPLYe0cIuwshZYvTtae5LwX
         FyhGRTpXxY2H17iEPy0HuXJZbeAqlInaHOSXtIMlwNW7xuRXfB/dW91jr/kVuLRGI3Y4
         642J3uHMKzLVAbmzOwLJyOhH4zFIdbPEAZjZwghMZ5AGCyz7bBygcczFGz99RG6MlV7/
         8J1g==
X-Forwarded-Encrypted: i=1; AJvYcCUVJoPu0Bwq9wJkbkAsIF6O0I3TXotW4vaiK1P7DVOO3OyuLw3brbSbOwF0RJEDxzLAMSJQpnpE9wSu4qg=@vger.kernel.org, AJvYcCVXThKj9VGNMy9JmCnUS/13LsRzh12lR9JMS5Fe7mhJuLdjoHAkMzDtdAA41gtOVcNn0ciras2rA3or@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSseiiQCW2ksnB85+gs2H6Ghc+NGPzovjQuC+6MiV9BuWjA/0
	Y7NUNt3RfBlIVIp7toukviZMo/jrFXiLQt9243kG653gL12xovY/qKap1A==
X-Google-Smtp-Source: AGHT+IG6hfffFkqnW00YmxEtnyyslCZ1TgJ6ch7+yc84KUAa5gHmGPezTpWnj8SUYjLC034jL5kBbg==
X-Received: by 2002:a05:6a00:3d4b:b0:71d:fbf3:f771 with SMTP id d2e1a72fcca58-71e380bb0dbmr7375679b3a.24.1728709591850;
        Fri, 11 Oct 2024 22:06:31 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4ad1b9f7sm859809b3a.190.2024.10.11.22.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 22:06:31 -0700 (PDT)
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
Subject: [PATCH v7 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Sat, 12 Oct 2024 10:36:03 +0530
Message-ID: <20241012050611.1908-2-linux.amoon@gmail.com>
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

Refactor the clock handling in the Rockchip PCIe driver,
introducing a more robust and efficient method for enabling and
disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
the clock handling for the core clocks becomes much simpler.

- Replace devm_clk_get() with devm_clk_bulk_get_all().
- Replace clk_prepare_enable() with clk_bulk_prepare_enable().
- Replace clk_disable_unprepare() with clk_bulk_disable_unprepare().

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: Update the functional change in commmit message.
v6: None.
v5: switch to use use devm_clk_bulk_get_all()? gets rid of hardcoding the
       clock names in driver.
v4: use dev_err_probe for error patch.
v3: Fix typo in commit message, dropped reported by.
v2: Fix compilation error reported by Intel test robot.
---
 drivers/pci/controller/pcie-rockchip.c | 65 +++-----------------------
 drivers/pci/controller/pcie-rockchip.h |  7 ++-
 2 files changed, 10 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index c07d7129f1c7..2777ef0cb599 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -127,29 +127,9 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
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
-
-	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
-	if (IS_ERR(rockchip->clk_pcie_pm)) {
-		dev_err(dev, "pm clock not found\n");
-		return PTR_ERR(rockchip->clk_pcie_pm);
-	}
+	rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
+	if (rockchip->num_clks < 0)
+		return dev_err_probe(dev, err, "failed to get clocks\n");
 
 	return 0;
 }
@@ -372,39 +352,11 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 	struct device *dev = rockchip->dev;
 	int err;
 
-	err = clk_prepare_enable(rockchip->aclk_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable aclk_pcie clock\n");
-		return err;
-	}
-
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
+	err = clk_bulk_prepare_enable(rockchip->num_clks, rockchip->clks);
+	if (err)
+		return dev_err_probe(dev, err, "failed to enable clocks\n");
 
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
 
@@ -412,10 +364,7 @@ void rockchip_pcie_disable_clocks(void *data)
 {
 	struct rockchip_pcie *rockchip = data;
 
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->aclk_pcie);
+	clk_bulk_disable_unprepare(rockchip->num_clks, rockchip->clks);
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 6111de35f84c..bebab80c9553 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -11,6 +11,7 @@
 #ifndef _PCIE_ROCKCHIP_H
 #define _PCIE_ROCKCHIP_H
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
@@ -299,10 +300,8 @@ struct rockchip_pcie {
 	struct	reset_control *pm_rst;
 	struct	reset_control *aclk_rst;
 	struct	reset_control *pclk_rst;
-	struct	clk *aclk_pcie;
-	struct	clk *aclk_perf_pcie;
-	struct	clk *hclk_pcie;
-	struct	clk *clk_pcie_pm;
+	struct  clk_bulk_data *clks;
+	int	num_clks;
 	struct	regulator *vpcie12v; /* 12V power supply */
 	struct	regulator *vpcie3v3; /* 3.3V power supply */
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
-- 
2.44.0


