Return-Path: <linux-pci+bounces-14636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86519A08A9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7EFB2553A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD9206059;
	Wed, 16 Oct 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgQdPXU2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACAB2076AB;
	Wed, 16 Oct 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079382; cv=none; b=u6deu6DVYIaTXMXp+YM1mgpsbtqiiB4PGCtw0uY1RluN91/MjmqVguuYhkGwvw2wLJQTrNN2xIyfCB/fOnqP+JhH/s9rFJIMqYRptQX49HSSL3h4eO65m6vOie+5CJQM3u8TwhRJDtkjY0YVuZDuy3M+X/jevolWeczlCgKc1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079382; c=relaxed/simple;
	bh=A53dsmBrcra2xP74WwRL8RTvtGNfUfyTxuglWh8UEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnvV8rjuMhhfKdx1zFXrElBkmlnSPLV3ZddCIR3W7xOHYWTAMnfeHZ6UBHfhLRuyuGQy7G5Fwx666xKDQRBqLw42vsuBdqG7/cqR/mLM/TT1UYvS4EpPHFSqSm9RxH7ao5xtthwyc7hjXchhSVqP6Xb6L6bPZJZBNiy/Nog+u0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgQdPXU2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so2956570b3a.0;
        Wed, 16 Oct 2024 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079381; x=1729684181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoPV72K3zqB5w2v37yBUaVaJmuctGH4fv71MwhVCUrI=;
        b=QgQdPXU2CAFvgU24Z1+DTVFcDM0uPjcwOI4P+Sop17wOJrBLD3HGisgUnRvDzrSK7r
         ZbuTzDvAiQDzABIuzbM4IcBJ5zHo2r7+K6G84ejWd6zpO5r5ZlxWK79892Ubr4Z0dJg/
         rFDoGk2vsQfQR4LnArUleEF/B8ASWHo1LJ9vAZtuWOB2broPL2mBhplMksmTmyxDjtLj
         FkciMcsXyUS/ZeafbWkCx9oYxj9ikdBFaI/63+wxvyzUYedEHHYiNqcuWDUa+/+NNCnP
         ptZcf/49TPGgXzlAT/K5wP9fERQo8yc+QHsJGjMCAsSBVZQ4VfeephwaOUWGiLPvXv76
         THaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079381; x=1729684181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoPV72K3zqB5w2v37yBUaVaJmuctGH4fv71MwhVCUrI=;
        b=hschfAhj39T7WDfVcmnij9QDsr1oELd72UKxsC6moBmkAl+PYOB7lTV82HV65+2KAo
         gi8nVcdcHjj4gxPSm4KyQvttzzBWlTIRv7KeOyvY/tLXZ6ERa1FDaNOVIhhIIWIfGgzD
         4OYB3aojNNzbMjiMZKodLNPOIq4CYYhLTHhKmG2SESnJVWTOt8W/2Bc/OYwUnj6DEHuK
         pqU8s4izYFDH3fwwbEFiIAzoN+evsR0v3vVtfvPTUBv0ok7EOYg2JTRH1d3qYIP8JB+Y
         2yhuuGC383zXd5oPoRxCLao2Ixh43mw/POQSE8ndv8MG/2/DLaHSTLSL1kcWy26d+jKH
         zwmw==
X-Forwarded-Encrypted: i=1; AJvYcCW1z8k+7Vuud+FSDfiYw4hG+9johmnUeMTEzm/otAhrOgIB04mBliAbVJ8OQ04Y6rzIdZQiM1zNxCHvB/E=@vger.kernel.org, AJvYcCXA+msQqIpKViVZPQgVLHPQknLt9V36nhhXQ4mA5SXKqndeM3k14fi+m352GyOShNek6AcivUCrE5sC@vger.kernel.org
X-Gm-Message-State: AOJu0YwqzkPCI6gM0jZ1sblw5aDam1nq8Yd4dUvnrIssnNTZDgNLvLl2
	DhcttMdHFnr/Fxv4aduuUye0/4UDTu25mqTh7G3ErESGhmcPI5tn
X-Google-Smtp-Source: AGHT+IH61Tw9AivWIOIjxfbPp652YtRypfJFXtlELdmEUkG2l5moHLv1jw6qWgzI1CxT2jyOARkenA==
X-Received: by 2002:a05:6a20:e616:b0:1d9:78c:dcf2 with SMTP id adf61e73a8af0-1d9078cdd02mr4159085637.43.1729079380548;
        Wed, 16 Oct 2024 04:49:40 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773ea9f2sm2968702b3a.95.2024.10.16.04.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:49:40 -0700 (PDT)
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
Subject: [PATCH v9 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Wed, 16 Oct 2024 17:19:06 +0530
Message-ID: <20241016114915.2823-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016114915.2823-1-linux.amoon@gmail.com>
References: <20241016114915.2823-1-linux.amoon@gmail.com>
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


