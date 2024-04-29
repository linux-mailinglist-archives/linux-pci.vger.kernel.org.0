Return-Path: <linux-pci+bounces-6764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773FA8B5537
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17B81F22554
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E803DB97;
	Mon, 29 Apr 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+2uC1Nk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF937719;
	Mon, 29 Apr 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386326; cv=none; b=DsoXlDsffy9QGzEZKl5WdgcxFHG6ZkjgUd+o1y7UZZ0GK3ndXgjvhHVH5PVwAdFIjT0FTn5RPoLtE1fcbDoVnkZtqjACiNYJZ0DRfXCaQBw8lGngcAmH/Z0DAlhG6rCQ+b/3wshWjrBYDy/hUoYVINDkWRf6tGPsBfPF5jeZEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386326; c=relaxed/simple;
	bh=/87+Jpunp1P/a+YS0O7wEX1PysDjoquFgBulttW7SNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY6ReBXChz+diq/FYZLkvsP8WU6F0FEa+yetBOA6KvG7IirFk0ZG1TtdK/ssRCFXtMea8sTVfpDeNwTanNZQpq+muENdZ5XtD9ilHAnKDvue8E1WGpmz303v5J/8yp5fQ52nNnvpr9lyXIyrZNtPWfnAueD4mASztCNIvrSIR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+2uC1Nk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714386325; x=1745922325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/87+Jpunp1P/a+YS0O7wEX1PysDjoquFgBulttW7SNk=;
  b=d+2uC1NkvB/nTto0oUwSzg6Gn+0uuTqkAUe/Llg2+i7m4TV6sHAPRMt1
   Pho0wT9El1Q4TX1dboGTdKrySkbcoo48I4SRfYV9vzkKW4IRQsJwVSi0t
   xzrwvznN1vfL9Ynho/hVIN7PgwV885ZUINo4QvuaJjF2psQiO+JoVtSBP
   wcKYqtPtpAciKDToMulVpHGVW/8iWWc9iPZgo2bvkPVh0yg0f4T/qTzXh
   AmlIIdZ7vvzFLKfKZExBf46qHw8YRiE2i2Jt7NsTUY1ONoZUr3tmwpB3S
   2dEWB+ybZM6HqgAne+Slh0Bn3QnEIVozLNf6WnzVWb2c+Qwaf3KX9fHZm
   Q==;
X-CSE-ConnectionGUID: yxSQwe3hQXaTFOJVHUznNw==
X-CSE-MsgGUID: Vkn94p6RRJCX0sFfbl+S/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13827942"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="13827942"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:25:22 -0700
X-CSE-ConnectionGUID: aWnvLQKuQtOqZY6wYM1MvA==
X-CSE-MsgGUID: bPFGkKK8S6CWF7cZGoE+BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26475174"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 03:25:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9324BCB; Mon, 29 Apr 2024 13:25:11 +0300 (EEST)
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
Subject: [PATCH v3 1/5] PCI: dra7xx: Add missing header inclusion
Date: Mon, 29 Apr 2024 13:23:18 +0300
Message-ID: <20240429102510.2665280-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
References: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is using chained_irq_*() APIs, add the respective inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d2d17d37d3e0..b67071a63f8a 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


