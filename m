Return-Path: <linux-pci+bounces-7116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9198BD023
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B080EB2831F
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5D13E052;
	Mon,  6 May 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCt/b/K7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DB13DDCD;
	Mon,  6 May 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005317; cv=none; b=mPGDPYPP2YayhndzkEOFFtSTDjblElOBRygJndHGkMvcIqe+1nAI/mBdEeoSm/UjRrV8rN/Ae8bp7/l3ywVJ9AM9Azw0hlCCXNf+6YXAm43KhzGuP7a65JOmM3HNdFMu6na/9ERNnd97abNH4S8YcnXx4odwrvViJ0aBm/QsjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005317; c=relaxed/simple;
	bh=CNszT9zdbvvsTrnr/o0AApgAShmBR0yidgvxQsMHIno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMbikBcMUhlzmRMvF6cI5jFKPK2iFfASMuaTJJKaPFxB6frHEs5mouWc6JUSJtissdM/TnW1jwo5TvZGh6xDB8lUp/rH2XSU/VWHNvuFfiGjFcqlbEHpAVbNQTyNeS2HXDik0RNGBElizsmSPJ+UPNvMe8QzF5bPykMTwJ1c/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCt/b/K7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715005316; x=1746541316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNszT9zdbvvsTrnr/o0AApgAShmBR0yidgvxQsMHIno=;
  b=eCt/b/K7JQpkAG940iRvF8P7cnDdXF2SnCTVAjDQkAjU5b00bM/dLlak
   8OaOY/pVxnpIFtO+oS+rt8tUhGwT61tLEvcrgyfYxYgNc+hbBsAav22vV
   r55NOPk8/VaJHquOZRj9nvmNgUNAdQZoSton9OyA1OWo5frh9yk/aGm5U
   kxGiXH6Li5eVvYsxEj76xmKgJEpVLS9uuWx+E/o9UDiSJtEIjGDJiCcls
   M1ek1jvSQ3F/BRa68lJd+UJMOW9eaBJTGZX1M/CjkR8FJjhZqJiMXFC2e
   CyFi2Si8RUNSUjhQ78m1Rh9eqHv0wMP/dxCOecBngkRGvcyHLS0+UyfB0
   w==;
X-CSE-ConnectionGUID: naERyszbQRWA85KgYyJ8KQ==
X-CSE-MsgGUID: JfP/5XQdSsywozko4V7seA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22155549"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="22155549"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:21:53 -0700
X-CSE-ConnectionGUID: tzhk4GXGSGuSvrL4IdOFhQ==
X-CSE-MsgGUID: vhTfbuHiTc29wrruM+hkgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32988756"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 06 May 2024 07:21:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0E48F68; Mon, 06 May 2024 17:21:43 +0300 (EEST)
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
Subject: [PATCH v4 1/5] PCI: dra7xx: Add missing header inclusion
Date: Mon,  6 May 2024 17:20:37 +0300
Message-ID: <20240506142142.4042810-2-andriy.shevchenko@linux.intel.com>
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

Driver is using chained_irq_*() APIs, add the respective inclusion.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


