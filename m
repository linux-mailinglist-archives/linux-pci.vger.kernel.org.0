Return-Path: <linux-pci+bounces-9060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82991911C11
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 08:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025581F245A0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E81667F6;
	Fri, 21 Jun 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbYwXriI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5712156255;
	Fri, 21 Jun 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952304; cv=none; b=STALmNCa3KDD+GKenXCjLjOGheuXvqz/FLIlNRWd9RF2TvgIUH6clp1N2s2EpXNoQ0mQer1nF6qPQgRa2ddOh2G9D2oucEkRnsTOZ5n4TVDieqWIwQC1KdNrjZSKY+rm57rULamrz7C6XdWOq71aNcK8kwLOq2fOFD+cTM2DzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952304; c=relaxed/simple;
	bh=bOAOpB7dVKydRPjsPJ3/3Z4gKdCLdwKiRfXS4eARVt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJlY6R8DNQQJ/1MWO+bKrvIGI2FZsC1o/8t6Oh4An/BWHBxIMfhQH/A0aU8KbFDRrIU6AEhbmo+tRvD8RfFLo4bjVbJuQ87mbLZIC5V967n3CEseR9scx67+U/BFRDQxG3qrw2QspSJueMng7LgRilbUv0Bede4QfJFPWgzLLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbYwXriI; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b5254f9c32so773966eaf.0;
        Thu, 20 Jun 2024 23:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718952302; x=1719557102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oM3ItnukudfPSjacUNsBaUKyLolfdMbpOCb7tOfpFSc=;
        b=YbYwXriIYaaQAr0PWrHI31wN3YBD6iwbtdmfCTwoK/zupK+Vjo0q9FHlX3OPCn81Jy
         ftlaL/JOkAw1mQ0/+2Rl2Q3tCL4IgrllDd+EV2d6Be25BoOUK4Ec/rVy6x/VuH7oKCQr
         p1tf1dfeGinHIS9v1b7QgSBnNHE+kKzTi52hdSGcjd730vKUYQ78PsL6p7BiaStDITa0
         w6u7LI0I69M8xK/ez8Jo5XnPqatJ9bV+468Hxz3sLD/3cv9Fv4JSAC5DU9AAvgNx1sta
         Pc/borENP/HokrPLyW+CZEDkp6M6OgKOmvJC1lGAIF0X6oUynj9eqvKLpLOw0hxYWhi6
         3nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718952302; x=1719557102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM3ItnukudfPSjacUNsBaUKyLolfdMbpOCb7tOfpFSc=;
        b=A0ZvI/k7x2glFm+7/jBrrLgd+T+MG6hXFx+YDYuisY/phTHhFKo86k1errqRiQCpaA
         6Ng8JvD/ctDspngCAMADgEMrN/UwcWipyjeFRkyyAxggc5xvOOaxj1LvEd32AxE66QvL
         G77yIkiDXpdul7FOo1TLtrZ6W7tSJ2w7rRcOzVS8vZ3zK1EDF3NfYB0C7L9+52ABjYkT
         widPSc8HNuwPKhVvZRyCDeGNMnxLw86F9TliaSS1+ceq/8zS2dOLbVfNaDxKqkZ/CIBP
         N47GYuoEqbDI+o8Is5coJ4OXOM+63h2U5lt3tjeegWjyE3Pw3/VYYRyZOOyvOfPfR+1B
         V68Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvVw3ihqD/Kwd4W4gY1tUIHSPo3l1tX17bqZRi6PC7MtmLDCCrhkrMHzkLvQV81JIlCetmPP7sughlJDY3hL9JYSymUQ1KwAUnHkj5MvihTfzQhZRzqjOeY10GIEZUslvAZX7QQt6R
X-Gm-Message-State: AOJu0YwRoxq1LItYx8OJfaWYIeTuv7Bgf6pDpLbLt3Px0rbSgu7Y7vs9
	qpyav7mAPOYum4UQcloojsMU3L03sWTGM/Hhj0NGKkCbX3dXqgsz
X-Google-Smtp-Source: AGHT+IEbBzdQwiRjqR4y3v1rWDL1v5yalWbizkktabDpr8Ar27TT3aqBRN1VEIr4V47mZdBBKvXSQA==
X-Received: by 2002:a05:6871:82c:b0:24f:c7cf:17fb with SMTP id 586e51a60fabf-25c949901f1mr8202912fac.22.1718952301635;
        Thu, 20 Jun 2024 23:45:01 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651194776sm683117b3a.67.2024.06.20.23.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:45:01 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	kernel test robot <lkp@intel.com>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Fri, 21 Jun 2024 12:14:20 +0530
Message-ID: <20240621064426.282048-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406200818.CQ7DXNSZ-lkp@intel.com/
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Fix compilation error reported by Intel test robot
---
 drivers/pci/controller/pcie-rockchip.c | 64 ++++----------------------
 drivers/pci/controller/pcie-rockchip.h | 15 ++++--
 2 files changed, 21 insertions(+), 58 deletions(-)

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
index 6111de35f84c..72346e17e45e 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -11,6 +11,7 @@
 #ifndef _PCIE_ROCKCHIP_H
 #define _PCIE_ROCKCHIP_H
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
@@ -287,6 +288,15 @@
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
@@ -299,10 +309,7 @@ struct rockchip_pcie {
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

base-commit: 50736169ecc8387247fe6a00932852ce7b057083
-- 
2.44.0


