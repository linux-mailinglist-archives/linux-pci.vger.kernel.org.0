Return-Path: <linux-pci+bounces-6586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEB28AF554
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 19:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCAC1C22838
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385313DDA3;
	Tue, 23 Apr 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWCUOG4e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B013D8BB;
	Tue, 23 Apr 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892941; cv=none; b=P5Mzsa6kr6wwwz6D/Duz2kkhCsCQbeacaNCvIx1++RLr7TdP3gzTEdqiir+fZH2OqIsatobS1k9AxZPIyiRWshI5MRdF9HNPKPkZ6IfsUe4FJUSzbiervjDqnUIM1pMBVDciECd65WH2yZlQhKEFduellht9RgkHQNrg+P6QHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892941; c=relaxed/simple;
	bh=wsRKPwSX2fLnfRxf1Lj4oY534LLRz0PskOzRwhMxGZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNvbyRlNfwavUU4gVs5rRbUXhFATyfuB01MFuKrdKjTgAU7mYl67fL8MDPVvQUXclJB0xMm0du2/0l0P40yWD8vRaKcJPAa0xxgk0T3INmJ23aRa+2azbS6B6BkCGhqrMVlBSTj3YaHIro8Kd0dWMllEOciMboVgq/yd+7sTi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWCUOG4e; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713892941; x=1745428941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsRKPwSX2fLnfRxf1Lj4oY534LLRz0PskOzRwhMxGZw=;
  b=XWCUOG4eE2FQRuxaU3hXmtyp5uQ9GbRQvPeOdK/ErKvO8n4mm3aBh91L
   ChNFYb3K3VuJYn6iufy1pLtJowtjRc848XvKeImgi6bQHI96u7ziHXV+i
   T/xpQ2rH4W286AsD5i1DU2WfTdhQKe4CLolUDof2sz5MS+3q0f1GgqKLk
   24xGpx/isFyoTqLJGz/sACWCu4Yv2jvx8sUq4caBfKaaKcl60c5DcygqR
   f3oI65cUwVqviXz8eynQJA33ToPZEgk/lOJrqJCbc+d6Ij5r7+/htTans
   L4SqOvmYKuFVa/mr6ABN+nwttWb0tAu1Q+eVYaHMiHIRRAC5Ld0oi1aPN
   A==;
X-CSE-ConnectionGUID: 5CMOUzfyRWa9HR2r1mtENw==
X-CSE-MsgGUID: UzEkvQ2TTNWaYi4NtgUlfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20911790"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20911790"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:22:20 -0700
X-CSE-ConnectionGUID: snlcJYYeTlakB82V6hD+xg==
X-CSE-MsgGUID: dyiYYpBESA+AbbmcCyycpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="25051423"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 23 Apr 2024 10:22:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 88F6A1C5; Tue, 23 Apr 2024 20:22:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2 2/4] PCI: dwc: Remove unused of_gpio.h
Date: Tue, 23 Apr 2024 20:19:05 +0300
Message-ID: <20240423172208.2723892-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c    | 1 -
 drivers/pci/controller/dwc/pci-meson.c     | 1 -
 drivers/pci/controller/dwc/pcie-qcom.c     | 1 -
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 --
 4 files changed, 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d2d17d37d3e0..2015f51664bc 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -17,7 +17,6 @@
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


