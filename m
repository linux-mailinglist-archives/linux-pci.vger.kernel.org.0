Return-Path: <linux-pci+bounces-6590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8168AF570
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8549B265B4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEAC13FD92;
	Tue, 23 Apr 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hycmtpeh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2013E40C;
	Tue, 23 Apr 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892944; cv=none; b=j1Zx1Omh+4F8Itb2oQZaPZDb/ljsW3QShiTICkZGvp0MUknhPpaQE/zndTweWVa5DzDUo2TAk7YdprpQ0+j24hG1Zaj+6CpiixYb5Inq4kARcwHw9IzLCUvWN4l+7zTGqD37PfJRFbYGQ2YzDyvCC4Hw+coGskI1L3W07PNyaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892944; c=relaxed/simple;
	bh=wS6mLiwTSrStK6wq/zzMd+gLFuAwWxuYlHIG5FjkkyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2+UDGQ1RwVBo0WhLbrIQiOd/jBCult6Kx7Yjtb7/mb8Gu0rlvUPx3LwMpGD11kYZPqUQtdZ4/e1i0Lt8CnG9sdjumn7YYaRetVYiwcrVM8RUKs7gMiG1HJbsy3nWh62kpQk3vGvRceGROciE8+ejgefShtmIvL14WBBVDwfgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hycmtpeh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713892943; x=1745428943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wS6mLiwTSrStK6wq/zzMd+gLFuAwWxuYlHIG5FjkkyY=;
  b=HycmtpehrL2ixjfPJ3repiM/CRe6mPEdeC1LLwDzKCU5hzxh1VJ8nvzU
   LlFVaF3e7x6tN7zUAAB5VXvKuWg6/vnKjn4wGZpmLCYNumNkTBeVKvFh+
   Y1L9W/DotGgp+vZvU/YbzspHqlANcIRSLGJR5eTXvbdksZql4tw5IT8sp
   bPG7mpgrmUwJUNpJVLAh+gJWKU8HKtBAyF/uoChGZabAHc37td3cn37Cx
   t/RrRa9VuYG6igXiCC6wFzMznQ4skbQH+a3SDLkQLp2qsr9VGbgvV1emt
   CPf6sNUs2NkTuZiz9YiVt7iWW1cO+j0keBr4+uMxlFU06hTWvyIZnA68V
   g==;
X-CSE-ConnectionGUID: gJZDvhprQCGDh7lJC35VaQ==
X-CSE-MsgGUID: iDFvOyR8STqQHSmY46f39g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20898283"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20898283"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:22:20 -0700
X-CSE-ConnectionGUID: Dr85zdv8Ry67lMcR78sHfg==
X-CSE-MsgGUID: T1Zw1WYoQVO/2Au0vKgZZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55410233"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 23 Apr 2024 10:22:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6E4F8192; Tue, 23 Apr 2024 20:22:10 +0300 (EEST)
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
Subject: [PATCH v2 0/4] PCI: controller: Move to agnostic GPIO API
Date: Tue, 23 Apr 2024 20:19:03 +0300
Message-ID: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the PCI controller drivers to use GPIO agnostic API.
While at it, remove of_gpio.h leftover from some of the drivers.

In v2:
- combined previously sent patches into a series (Manivannan)
- added tags (Rob, Manivannan)
- converted iMX.6 driver (Manivannan)
- dropped leftover in aadvark drivers (Manivannan)

Andy Shevchenko (4):
  PCI: aardvark: Remove unused of_gpio.h
  PCI: dwc: Remove unused of_gpio.h
  PCI: imx6: Convert to agnostic GPIO API
  PCI: kirin: Convert to agnostic GPIO API

 drivers/pci/controller/dwc/pci-dra7xx.c    |   1 -
 drivers/pci/controller/dwc/pci-imx6.c      |  37 +++-----
 drivers/pci/controller/dwc/pci-meson.c     |   1 -
 drivers/pci/controller/dwc/pcie-kirin.c    | 105 +++++++--------------
 drivers/pci/controller/dwc/pcie-qcom.c     |   1 -
 drivers/pci/controller/dwc/pcie-tegra194.c |   2 -
 drivers/pci/controller/pci-aardvark.c      |   1 -
 7 files changed, 49 insertions(+), 99 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


