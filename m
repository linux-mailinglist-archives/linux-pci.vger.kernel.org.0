Return-Path: <linux-pci+bounces-40970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEC1C51371
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323271881F2D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464542C026D;
	Wed, 12 Nov 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGALw/eL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBB274FDC;
	Wed, 12 Nov 2025 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937788; cv=none; b=cYEOAlZuHyBLCL9cCnw+q3emJ2LER9+1suFfiIHyLDnhf1pgxdIyYVI/hD/xqbm7rJUvtM8ErPDLqKcrJOlJCmHVBKt3QwQoDZOB3Sj3Vz2VyRCuNFtnxuJhKfFgvTCSiBgET6ghEaIVmTkt8j/yUPzjTv5sgBI7bBDE7QIpDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937788; c=relaxed/simple;
	bh=sl+zfwNpML36ev1KM+JlgPIGMQCZVqEo/fI0Ku9iDIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBcC1vhx6vSEBKH88qEeg1TAL168Eg2vemM6A1aUYFY6nOJhZd34KNnvsqq1oi4rPGiLOFeXnfd8IYK/1nT7a5mFlRmTBBV6mW5a5p1UgUDH8qGj5767dteJjJGwcxsp54pZopfSxVJStcjtTy/pchFLy8g3PM9KPbaGgbHeBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGALw/eL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762937786; x=1794473786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sl+zfwNpML36ev1KM+JlgPIGMQCZVqEo/fI0Ku9iDIM=;
  b=fGALw/eLaZVSh94xsKsEmSEf+Jgfvg94Wfdf3CnLOAilqPx5Sk2fMp5h
   oc6OL1VWJyxDZBcEAgvWbmvCVBAnhFa1QA7GsVBi5Fk77ggskZbRf5+EM
   SFJ6PkyFBOd80+2TzAVDXi0mh4xy9V8rwf9m30EE+SoTDevrJNemJfkCH
   GcPlbv7loaXx3wbAUsxUeujVS8/lidWMiehlbNGFVES8P9fdnuxEtUiCZ
   WGJb8h4/xh+1vsHpNDd3r+PDH7Bv21ejMTcokQhMEteQb35FucbELuFf1
   W9/upKLS1FjlxyqM1tyXh+nRrCfzkHA4591bNONarKwoaT6dePGko8BB6
   Q==;
X-CSE-ConnectionGUID: kA67iLmmQaSi4rtdiqzlNQ==
X-CSE-MsgGUID: Ccpr96QWQcW/hH5kxGX2Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="90470255"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="90470255"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:56:24 -0800
X-CSE-ConnectionGUID: 6iy+RXr/QdiJ/GHS8641Ig==
X-CSE-MsgGUID: qqOSY0sjRGOCddFGLQVfKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="188806184"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2025 00:56:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id EC9B495; Wed, 12 Nov 2025 09:56:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Bruel <christian.bruel@foss.st.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v1 1/1] PCI: stm32-ep: Don't use "proxy" headers
Date: Wed, 12 Nov 2025 09:56:20 +0100
Message-ID: <20251112085620.1452826-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

In this case replace of_gpio.h, which is subject to remove by the GPIOLIB
subsystem, with the respective headers that are being used by the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/pcie-stm32-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
index 3400c7cd2d88..2b9b451306fc 100644
--- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
+++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
@@ -7,9 +7,9 @@
  */
 
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.50.1


