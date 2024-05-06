Return-Path: <linux-pci+bounces-7113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1030E8BD016
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4DC28A1B5
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFA13DDCC;
	Mon,  6 May 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Byk190pG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147513DDBC;
	Mon,  6 May 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005314; cv=none; b=njgA/nOWsk7pESJSt3ByyKcO4S9DMNZ3SZ2dE5UELbFGmAcjsqWDa1TnoX7E2i3xAs/3WHFmv0PxJIUUmK4tHa5yH4SxLS9L4YSRvv4s4cpazrr9y59n5tgM/DWXQ/rSFpn2Hi427UgGduCoJoWXb1aPiOLz4uIjywQR7jkW9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005314; c=relaxed/simple;
	bh=mnVWFiBfYUU2lpuKyQVuWsMjv4lrzOkciv18t8WSb+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrcUAnO2TVn2RQQgN/GWA/UrxSbYCWAHiNfPg9sa0/DW6811jX5fYR3lO7N2l+PtnbFUt69zlkXLsCKc1yGcieFa9JIsRe2RLapMBCwS2gl50QfZ6eamkpE5Q2lg1anX4PhBwbsDXPpV1pO15WgPWYTolHkJ97F1vucA8oYe0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Byk190pG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715005313; x=1746541313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mnVWFiBfYUU2lpuKyQVuWsMjv4lrzOkciv18t8WSb+Q=;
  b=Byk190pGGn5QTg9UwNXztsgiSFqSMKonxbz/FZzvu4N81asfEQzbi6Tz
   yt4qiuaY5q++vf9Yak7qgS4tTKU6N9/A0R+2cE0brhMuf/k7jgJwVIajF
   vc8UQoaYc1UpRaWidPj6dQGDBjDzXBNqP89aqNQrfiuy1H1g7AD1q3mOu
   xx/45C6/JjdyXrR16TMPBJJ/dOszNP7IrbIyaXYYxQVlauZMUJSzquJpl
   I7ZwIdZHFEJC0e7ZzsoFxVBqXTkQhEM0/6gJKQMzUn+Gt9OnvhogzhciX
   IkJ3tTAmRXJ0DjAz9PtXakUwwJTk2TQJXL/cAYEqCOo39ROvynKEYX4df
   w==;
X-CSE-ConnectionGUID: JN9eoUOcQ2OgI88y+3wXyA==
X-CSE-MsgGUID: iL3D8yjoSKyVKmuootIvzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10631810"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10631810"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:21:51 -0700
X-CSE-ConnectionGUID: v6vxQqJzQgqtr/xtC6HB+Q==
X-CSE-MsgGUID: FLhmLFrsTPe4VWRVLgvWFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32652260"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 06 May 2024 07:21:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1AACF43E; Mon, 06 May 2024 17:21:43 +0300 (EEST)
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
Subject: [PATCH v4 2/5] PCI: aardvark: Remove unused of_gpio.h
Date: Mon,  6 May 2024 17:20:38 +0300
Message-ID: <20240506142142.4042810-3-andriy.shevchenko@linux.intel.com>
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
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 71ecd7ddcc8a..8b3e1a079cf3 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -23,7 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
-#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 
 #include "../pci.h"
-- 
2.43.0.rc1.1336.g36b5255a03ac


