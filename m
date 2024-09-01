Return-Path: <linux-pci+bounces-12580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2227967BC0
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 20:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADCC1C208A0
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED32D638;
	Sun,  1 Sep 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMdU5GVO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18017BA6;
	Sun,  1 Sep 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725215630; cv=none; b=EjIrcs3ojgwKgNTYbQ0ioes7izd0jN+G4wIC8kWi7+hLWbwcCLPE+1c6ibk7uYGUjh6JiEVraRWu6QROBYldsbZBTMVA5OWduLfkpDZv4JAGTJRIUm8HB3CPzNxNJwcv7DOqgGZmjm4vvAfJTjEv5Ra7JUn1cjvy8ESVUeb741Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725215630; c=relaxed/simple;
	bh=wXbOweBwwZqT39qzdLK0IKtdEoHAjFiljbSWZCN8IWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZVBQoyqmSBIhhE28sNQrHiBTUrB76tlEayfNcx7aGIguBKI57t9kf56fA9PzxG5U6KuY5khXd6690SFqKFVSukjlG8KsbA+wG2yF3CCERBdQDpxpV9/h7OxQwCyx202yiPv9K8BEdzNJTpuUDbgCai9wWYE6+29t2AkMoTilDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMdU5GVO; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70f782d6ba8so508286a34.0;
        Sun, 01 Sep 2024 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725215627; x=1725820427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3hUt2zd/u+MBTYnKj2CxW2ztFShOPGgA2cWNzepJbg=;
        b=QMdU5GVO/E597rGx2dgR504I3ETdVOthRIWIF3g9ccNCIKTRsd2sqHfiYNw4y7CXkp
         74ndtjZxeTUx1nvZF3i2PEtSzWAfmePs5/G0ukrmDNwRtz26njEeeZ47TgpLivhtmnQb
         ZMZQBGl4C4YGXQERMG4tQ0VzEoPB9Ej9qG9RQnwzdCqJS6U3/bVeibAEzlzt8CERHa/5
         hheUFhRtYa8Xl/V6oPMF4vpwV7yjV2sRBSkNVKxnBlG3X43EQlnNlhCI4CwVesy4hExd
         QUEXruh96t0wKE4BlqD6tlcQJM1VxsPZTYegJ/bIXMkTfduVL9zVaiabMDvQpeHsZFta
         irlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725215627; x=1725820427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3hUt2zd/u+MBTYnKj2CxW2ztFShOPGgA2cWNzepJbg=;
        b=C/swjdNZBmbo+ckYHy0Psn9smdiGo3o+Zo9CvRposayhHsbNsPr3b0CcMUbzwzqB5i
         5dsl9L+i8h865LJzLmZFM6ySFN5fsM2o97L6zqni5xN/tUiLIshMo7TCPD71Xk+XC7Yq
         5wkgPjY5AaPIj8S5GY/N6IMBqaImbNn6CdD1I1dmzq8K1uzMsQvJfOE+3fu0FQ31PZzr
         1da6LAZhGKoUdCpIqHbMn4kYl12hpFEE+h8VwHmIkcbYG3+iQ0oDW7WAglhkSGkWWwdF
         BllpmJEod2tNG4J/vtINKQhXGFmtZJ4aFU14bH1+zypKatYTCtSHxWRoKFwrsmqTAnsU
         1INg==
X-Forwarded-Encrypted: i=1; AJvYcCVUcdKz0KWKDx8lymq/Tkvp5TYSYZRDB5tE4qMFYG4nt2L7TdkcEKQP5WcLrTBQEcT+1YKIdD+ctITv@vger.kernel.org, AJvYcCWoj3Hd+0BXDhf07G4WgaK3bUu2/3QR/XAJx+zSWhOACqMadOX+e5zdhUAgWDDlTp6arU3+DvjqZ9YsCnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxg8cEQCmUUfuZd5NAAkZ/orIph0KESC2z4DHgd8IjmposQlwP
	deirYsUsYAWMF4B68MwAIgc8D5XEDxiAEdy//BhEAENQtIZisVo+
X-Google-Smtp-Source: AGHT+IEM0vbTBXGonK13acIuJB+r/E4BPJCq932csQ4rmFWx/7Ec1ForDw5xFtmfdKeysT8EotsWmQ==
X-Received: by 2002:a05:6358:910d:b0:1b1:a811:9e9c with SMTP id e5c5f4694b2df-1b603c44b3fmr1523886655d.18.1725215627503;
        Sun, 01 Sep 2024 11:33:47 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559b793f8sm16262405ad.15.2024.09.01.11.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:33:47 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Mon,  2 Sep 2024 00:02:08 +0530
Message-ID: <20240901183221.240361-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240901183221.240361-1-linux.amoon@gmail.com>
References: <20240901183221.240361-1-linux.amoon@gmail.com>
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
v5: switch to use use devm_clk_bulk_get_all()? gets rid of hardcoding the
    clock names in driver.
v4: use dev_err_probe for error patch.
v3: Fix typo in commit message, dropped reported by.
v2: Fix compilation error reported by Intel test robot.
---
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


