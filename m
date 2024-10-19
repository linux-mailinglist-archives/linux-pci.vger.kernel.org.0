Return-Path: <linux-pci+bounces-14893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3669A4B73
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 08:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68ACA1F22E5C
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 06:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE01CC89D;
	Sat, 19 Oct 2024 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWDL4YMd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A185478E;
	Sat, 19 Oct 2024 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317730; cv=none; b=U8rxjHOcX69z+Nf9pyXzOWr6/eUhMwPL4pn8WvNIG8cf6WIB0BBnSpuW4FHuROVPm3aiPUSrZQlR0RSrxIG2/bnvwOutjnL+IsIhOsr1i+kX8sOyVaZXj/nhGO9rDyIUu7BlPny+EZqDsNx8QRmr31IMBfT1H9y6YDNJJ2teSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317730; c=relaxed/simple;
	bh=1Knhd4x8vCkIG4tTq/OaHl4tUI0uDyc7ojjryyxy4RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKEPr0J/5ZmzaVcDH8sXfEfLFaIsQJYfvYIPIJUf7aI1EQ5k4f+XpHrcZlS9N1CTvHmT9nCGrc1UQHPqAYv+FxuUx/OjqLeCOXdiAQMxFS0MePQq81uAPvOS1lJt51aqj4UPtB8+1qF8SbtIIWxaPwbpkeQGwk5gMlWz9sYZVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWDL4YMd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so2542154a12.0;
        Fri, 18 Oct 2024 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729317727; x=1729922527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQ6be+SEmsFjGTKinqiVprV+9Ah3x45IjGdiVlbmFiU=;
        b=RWDL4YMd7d78lLAo1QKLJx4bBdBrgECnPYzGU8vVbSFr323WGRnDUmOWBOTia4NjAV
         G15RdIwM2ebhIbzXEtpFZoLfrxlPXAwnKGQy9CoPWRqj+GY8YFnprAbheVWf3N2nSFIG
         lmNn4MX6/Lw0CU0P2s/suJ0OkzawBwHWCBh3ALn3Svr7zpG+88ekdAwckzkcMNN/vX9q
         Y8uF6f9nMDGb+pei57d+LcUY5b6a89LyTjUVJv4Hs3GLso/DgV50xH0HyK82EOsZrFFl
         iWGvBaruV7s5ka31ZOaLuXZFREGmKg8PVwVOj/BAMyoJPfUTPoLFm62MTXbRpCtiAX0k
         aBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729317727; x=1729922527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ6be+SEmsFjGTKinqiVprV+9Ah3x45IjGdiVlbmFiU=;
        b=vVm69QOVCaoXemYUmvUi17lFw94ivvI3gY6b3VIWZYyryb4t7kHdUo4cGl/wRpwo7q
         +ZofFTOUnsufEtO5mnqbhnpExsnVB0TD02i5bbXRNXUgzu7yjIPiOk7ZJb3PueFBE1u6
         NjpbLFM68aOmBzqjhj4e/nn9dLa/khjSYgg6BbWYQn4X21PiZiHTXH9FZG7/NW+fnchz
         q72WiDHHZD2FpgXStdT0oZ2qFhoRzhQYhvyI7G+zcNpPgYNmEtqDvsHtEAHYSH0CAPnY
         UyzJeo4ujDuyBsKY0QUpoVpgakuXk8D0gOoRMLWFdkqJznfZhoQV9IbmtX5N0zzR+Sip
         h38Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjPlxiBLIxr8XCRHQL8Mawdwt8WxKzlawBCIPkGTyRxlL3DczoeriXxzPAyMbOPVoJ/RNpv0Cun8zc@vger.kernel.org, AJvYcCXy5pp0eKXNBR6A09mpSPoSBaMyBEy5wd1/tUQABV6N/xJb7yfQS0pC25QoyLcqHo7dgIoZIOEtI/ajNR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7Px4Jc+0j9GlAh3bR9iqnZvrx2jTEQPEMwI8tf4eYua8LjrP
	+q/1eHLY0uFkw/EP+SqAPi31WbsMZIgbFPDBWAxtoDuKLNhVAgl9
X-Google-Smtp-Source: AGHT+IFy+FfUBWUgsF+te5eNb1txluGoVKFLXLnrvrx8BjdXoDOY7NlHg2+3bpRImMOEoXcQpksJLA==
X-Received: by 2002:a05:6a21:2d88:b0:1d2:ef5c:13f6 with SMTP id adf61e73a8af0-1d92c597d59mr7155759637.34.1729317727448;
        Fri, 18 Oct 2024 23:02:07 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333e94fsm2424237b3a.69.2024.10.18.23.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 23:02:07 -0700 (PDT)
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
Subject: [PATCH v10 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Sat, 19 Oct 2024 11:31:33 +0530
Message-ID: <20241019060141.2489-2-linux.amoon@gmail.com>
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

Currently, the driver acquires clks and prepare enable/disable unprepare
the clks individually thereby making the driver complex to read.
But this can be simplified by using the clk_bulk*() APIs.
Use devm_clk_bulk_get_all() API to acquire all the clks and use
clk_bulk_prepare_enable() to prepare enable clks
and clk_bulk_disable_unprepare() APIs disable unprepare them in bulk.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V10: None
v9: Re write the commmit message.
v8: Improve the description of the code changes in commit messagee.
    Add Rb: Manivannan
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


