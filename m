Return-Path: <linux-pci+bounces-7114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FCA8BD01B
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8FB28264
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296913E02E;
	Mon,  6 May 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gq7zLoTW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736E13DDC0;
	Mon,  6 May 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005316; cv=none; b=Us/NqtzeFvnXan+eCF8WtZB0Jd3+LaHTCJwYyuJb5kA457z1kEwn/iunYuTeuVmkm5J4FEM8nTPBYO1LZElySPgdZj1b+pIVo42t8TT6kMQa0/t/ymIv4bfrMaH6jCRXZ0pr2xey2dugTsh15pMvQUq/2FpaFD8mpAjPolwUmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005316; c=relaxed/simple;
	bh=8rSWiYZvmKFnXcw8ynHscd2dH4mpaWep1+0Q3U6jY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0cvh496I6SYEl9x9g5l7bJCjzZw22+tyMfpHLfIoqiYI954NiX50c6p3KwuF+JEcjtT7/Zzf7f3i+pi0I5boKGoH1RLqcaz79sbsR3kzgHBpWR5k2sWjHmSE1rDkV2w1a8y7vWoDPoADtB/W9Td9uotsmS/LENIC17qWqRf/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gq7zLoTW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715005315; x=1746541315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rSWiYZvmKFnXcw8ynHscd2dH4mpaWep1+0Q3U6jY4c=;
  b=gq7zLoTWDw8zcCrKmhKbAuUjf/Wu7IAXzs1VWBAYyztRQAnUg+AX6sEB
   ZD0bR+JBP84mpocjIXhh1J2SbDeyOHUNr4JxisCrHMK2B7bVBICsU2wc/
   L1uSeZrjmipWTdKnzJfLuebZOOTwBxxfrc2/bTy73jjGDOO0ZKBDThNt6
   tFHKVme9p3SmGsxJPjIiluPhjvpDI2yyd7lYtlKKYnUH8JNzj5/3LzEGk
   8bI4Yxp1LBU2Jg9dPQBo8rrbhsVQuzFaL96rou8NzN1ETACzyQEVOOIwS
   jHOrDLEaQzgwGH62IVMjDrhM7zjoBS/txpgSBuWM3jxK7ERyvSO89q0wq
   A==;
X-CSE-ConnectionGUID: 3rM/Xu6pRxiEhQL9cieFKA==
X-CSE-MsgGUID: g8m6R1i7RICws4nwJGUOuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10631840"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10631840"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:21:52 -0700
X-CSE-ConnectionGUID: dc8p9NFvQJWZ6MHCsO4kmA==
X-CSE-MsgGUID: YEsu2LobRQyrkpY2uDctpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32652261"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 06 May 2024 07:21:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 29B8249F; Mon, 06 May 2024 17:21:43 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 3/5] PCI: dwc: Remove unused of_gpio.h
Date: Mon,  6 May 2024 17:20:39 +0300
Message-ID: <20240506142142.4042810-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
References: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c    | 1 -
 drivers/pci/controller/dwc/pci-meson.c     | 1 -
 drivers/pci/controller/dwc/pcie-qcom.c     | 1 -
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 --
 4 files changed, 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index b67071a63f8a..cf8392190856 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -18,7 +18,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 6477c83262c2..db9482a113e9 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -9,7 +9,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..436076612c8f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93f5433c5c55..e8cd8c1bd4f4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -13,7 +13,6 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
@@ -21,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


