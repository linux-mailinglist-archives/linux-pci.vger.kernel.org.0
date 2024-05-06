Return-Path: <linux-pci+bounces-7117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B85C8BD029
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47841F25BB8
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023C13E897;
	Mon,  6 May 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f42JOPrn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04D13E403;
	Mon,  6 May 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005320; cv=none; b=cGj4ncpXnEpiGWbPx05UsLh6kjUG/lcALf4COHVuVGbOlhbZQNONp4GQXcycmpj77Ng4yYXgJsoqW0W4aP1uuQL95M/ki6oh9Y/yaj2tVA0rajxcwn5+q/VXDQSnGUqpJ/c+RS5rhu9CLRh7D0XsyGTC7SUNcpBFkM1yUw4nNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005320; c=relaxed/simple;
	bh=Q6wvxPR0ih++7Mokt01obdSM7aO9GEPlMf6UMIVpETA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpvXd5EMmSazQuUyh3bF5Zz9KWwyNQoBhwJEhhL9qO4sbTGLQIvZQqA287vZFaLrj9ZrtUdaD23VjxD+GbN1aYzQ5BMjkqYHWNaVoWuRrJEEc+jlOYFMdZTc20brx/jywWpxsAQCdgc2gVmTUdAJKPy47HZR2gP8HJolW7yqewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f42JOPrn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715005319; x=1746541319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q6wvxPR0ih++7Mokt01obdSM7aO9GEPlMf6UMIVpETA=;
  b=f42JOPrn5brQwjNTba+GdMpZEXUMokdMYAbQJQMcZxQ0PvRVgjC6bKJe
   2X0l+Dlh7dAbuGMjk5ysxfVIy7BH0IPiXyJm/zvkYLYPJrzKfWIpdJ4IS
   au5QREBVGqGdT9T+cqRWnJH+Lde9LOd66uaHxK59JMW5JJ1szVxLPsM4R
   lZ5AUGpMbxx+jcJXVdEGaqt9rpmfwgq4LtyvTnVOBz9/NRr77cbyk6hdY
   cPF/n3yk5XGENsc6HA5qFPYBx1bxvXCLfqHlJEYS3Iy7h8HVCU3gY9GhU
   SwPUA5Uk72sjbvIyNK5Ia4UqHKGzb49QD2gzie/6KKnOYOffcmXCzlpQ8
   Q==;
X-CSE-ConnectionGUID: qEJFt31eSEyo4+r3uoNUVw==
X-CSE-MsgGUID: Qsl9Esn9RROidfffE9SFtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22155569"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="22155569"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:21:53 -0700
X-CSE-ConnectionGUID: qvt0cQ2DQUCIlIa75LChlA==
X-CSE-MsgGUID: 6EhTFntRRUmP7O47GmpzcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32988757"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 06 May 2024 07:21:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 00749161; Mon, 06 May 2024 17:21:42 +0300 (EEST)
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
Subject: [PATCH v4 0/5] PCI: controller: Move to agnostic GPIO API
Date: Mon,  6 May 2024 17:20:36 +0300
Message-ID: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While at it, remove of_gpio.h leftover from some of the drivers.

In v4:
- added tag (Mani)
- fixed a polarity bug in iMX.6 driver (Linus)

In v3:
- added precursor patch 1 to avoid build errors (LKP)
- used GPIOD_OUT_LOW instead of GPIOD_ASIS (Mani)
- added tags (Mani, Frank)

In v2:
- combined previously sent patches into a series (Manivannan)
- added tags (Rob, Manivannan)
- converted iMX.6 driver (Manivannan)
- dropped leftover in aadvark drivers (Manivannan)

Andy Shevchenko (5):
  PCI: dra7xx: Add missing header inclusion
  PCI: aardvark: Remove unused of_gpio.h
  PCI: dwc: Remove unused of_gpio.h
  PCI: imx6: Convert to agnostic GPIO API
  PCI: kirin: Convert to agnostic GPIO API

 drivers/pci/controller/dwc/pci-dra7xx.c    |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c      |  36 ++-----
 drivers/pci/controller/dwc/pci-meson.c     |   1 -
 drivers/pci/controller/dwc/pcie-kirin.c    | 105 +++++++--------------
 drivers/pci/controller/dwc/pcie-qcom.c     |   1 -
 drivers/pci/controller/dwc/pcie-tegra194.c |   2 -
 drivers/pci/controller/pci-aardvark.c      |   1 -
 7 files changed, 46 insertions(+), 102 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


