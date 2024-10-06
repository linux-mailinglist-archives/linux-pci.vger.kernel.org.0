Return-Path: <linux-pci+bounces-13892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850A2992051
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133251F2194F
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C784189B9B;
	Sun,  6 Oct 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co0K4oK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1114AD17;
	Sun,  6 Oct 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238500; cv=none; b=W/p4zTkAHf34DnaZVvUP5rnkMJbitCLe+LL/HuQ4mvV5ICu+89KrJwrsM8HYbQFNOlBkBOdnlmHgc8TPjwHuECqL/ogeMQAAwUADZAc13bKHgltN6SqSxw3J8/KU0FLOF444YJF70khiehKgvY+CvzfvPMz5+0Wn2Yl1zdmXubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238500; c=relaxed/simple;
	bh=/hOW2Mvu0AOmF+JeWIgccZ0Xm+OFoIHR5wTdAdxpALQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpkEyfOPgJLPwUJODvi5m1hxbf8AZF9KXJIb2xTpBGuChMIzylmaVkDdfhskoXCENy7nF/RBUKpdVgdmrKKIr5QlbMujZr2Zibh36Qg7r8OssjbztMsBsBykQi4O1HfPmNQv/Cdm4MR7C6E6ApghKRBtyxrizk3ykA0g/+lyOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co0K4oK0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so2531657a91.2;
        Sun, 06 Oct 2024 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728238497; x=1728843297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIiaV4Ox+gLOn9Mc+aj8cfaNVwn8b8YJ5I4FANpYiac=;
        b=Co0K4oK0qGqEOov7TBA9uVLkL7ihDTnHDhqI1wuacqOAOVfGlfbrgoWcYaWLQb1EOE
         V/LqOWF4OK76cmYfIdZN3Yut8R9UJbqrJ3ApCxylrWFSFsOIuxG7/B7mOBt1RLjdFC5y
         wojK16Fyv0m+h0btbDGCL5JypQeVcVCZ1+fF5bzRsuhuEZHBOWM0n4K+v7UMfxoVSrux
         FFE59wEP8RZA6gINT0Qdkd+tka3vXEmCeQvx61NPJJEfLDCfB7kfKNjTe3Y9n27HsxL6
         1N0fKSkWRIVYOu8Q8w1tN8oCUZU7FvLyMMFgNwPA3ZnNXO/KRTOdhJZzU6WA6AoRy3N/
         ZpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238497; x=1728843297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIiaV4Ox+gLOn9Mc+aj8cfaNVwn8b8YJ5I4FANpYiac=;
        b=pQjTv8SaDjRm/MB/lzTfotyh5f+rMTKMfMNdpdyZ44ziMiHEP6DnM4UDai/rFk7EnH
         HehjY1V5PLV7hjaRb4AzUqnJ/J00MGODs1KqnaZO7QTu3N7lvT4RKkhWgkZZZukM9ZEB
         oTozD5+vpYlWx03lgk4P+Jkty4F2e3DNcb7dNm0ku9klmxuhXncS8R+d5vFWBjyVulO8
         fnO6JduB1pFh8Us/AIiKVrERAENSjQIV7mqDChX6tPtJEhdHDRn2XjIaMa513lufn7eA
         HQT8fyFE0HvT9s8XF8iPByVm4mqSkyR5wxDxBsPrQTN5jZG3dly3SaJDxyLK9orkLDdM
         JhFA==
X-Forwarded-Encrypted: i=1; AJvYcCVVBG7jwh1mBadNIzmSopl0ATMMA7DzcxtjWzo8IUiBZM5fLIqrtQODGLgjIV604HzaYVwTvxVx/58e1ao=@vger.kernel.org, AJvYcCWRwI1pd+pMInTx+TBt9wLHrY0GgMJuuCKe4W/9UKN+qChxpzzA1tuWthNFUDH77PX1O3xFkVHEoY32@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dDjrJiH9NaTmF2a7/Hlz8oatMwrtPCrQpN8v0AWApo9P8Iyw
	wXCKkA+V5HDX9pUkppGW/kB2AmIrVMtOfWd8BjhcLRoR28j+P6YB
X-Google-Smtp-Source: AGHT+IHbLEKPnkSYdGjQG7BHfuYrbU5QsTB8Cpg3j4Q0pGaV2cTQa6D/D2pga5c7Q9fBP+hdjA4owQ==
X-Received: by 2002:a17:90a:ce8a:b0:2e0:adbd:dafb with SMTP id 98e67ed59e1d1-2e1e621e9acmr10715304a91.11.1728238497099;
        Sun, 06 Oct 2024 11:14:57 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d9ab8sm5403095a91.29.2024.10.06.11.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:14:56 -0700 (PDT)
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
Subject: [PATCH v6 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Sun,  6 Oct 2024 23:44:28 +0530
Message-ID: <20241006181436.3439-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241006181436.3439-1-linux.amoon@gmail.com>
References: <20241006181436.3439-1-linux.amoon@gmail.com>
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

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
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


