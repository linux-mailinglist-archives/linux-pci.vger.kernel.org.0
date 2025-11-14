Return-Path: <linux-pci+bounces-41271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C9C5EFDC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 20:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 971224F9F78
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70F2DC353;
	Fri, 14 Nov 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdZU2x2V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F42ECD0F;
	Fri, 14 Nov 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147025; cv=none; b=aSGRXF3EI6d4OfHtUGg+PR00IW0aP/Fc2m6elZSFyry6/QLDxBoPI/BZpLgK8Y5uR/cM3h9tRmPys5m7TS6hLsC5RNS3KBxr5iYrfw9Z5OVUTcA3ceQiPEIDjBzY/ZWDR0TN2uLHabD44WraayH3zcLEuzUZMzX/BzhA+yedSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147025; c=relaxed/simple;
	bh=Dym/pfPU9DLIbudGmaXmsPCZxOSh2XiLLb064rHEO3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=offgZPkCB1V2LFnOQNdM0WJmgrGAEgorRFS77k86ZXe5Ecm1oNGa7m5Vx4AWs7wIFhsWEKdm5FUgXPlyGIZbFwIJYfRexno9oQmjPEbZD6yvNVWh00WwWsOPHEs3BawPZwMG2h5RwKpgCXNfvAylX+z30EaKFOcv3njh0uHRcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdZU2x2V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763147023; x=1794683023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dym/pfPU9DLIbudGmaXmsPCZxOSh2XiLLb064rHEO3A=;
  b=VdZU2x2VKXnVWtWctzTR5nRJDg8cETcsshi/vLl6WK437V77VkFqXj3w
   Uzms0zzElpEyHJ+/Mly0sPTcrcSICgBNwkOBjU3CkwkckK4fiVBv8bkby
   PRsigd9I9PWHE+dCGvByZmEJGMI4tfphTvtmNT2y5oibzXxxTJ/yMI3Oa
   /LuRbSVbFDRmmPRZZ5C4mhAEUrKZOK/PYHR468p1Sxa20sq6ED/oeBWKH
   /GuCtT2woK4gLKkYjqqVfgzUW4nlA3nI0r9oe5g7FZXsfzC1TVKzCPBLK
   0RqPkFjT4NE2Uk5Xm2YQ3Bq8w/OOFxxiT+M3HwacQFhwF1f50ke5VNYmD
   Q==;
X-CSE-ConnectionGUID: yoU8wm9wSvukuLi0/Sin9A==
X-CSE-MsgGUID: p/1hQRqGSH6U+d0ysZJBeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="87896161"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="87896161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 11:03:43 -0800
X-CSE-ConnectionGUID: Y3M1gm+YRxme2H3VOXGn5Q==
X-CSE-MsgGUID: ZFiGynYVRpC+9bZ21AGmqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="195002153"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 14 Nov 2025 11:03:41 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B1D2F94; Fri, 14 Nov 2025 19:55:36 +0100 (CET)
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
Subject: [PATCH v2 1/1] PCI: stm32: Don't use "proxy" headers
Date: Fri, 14 Nov 2025 19:52:01 +0100
Message-ID: <20251114185534.3287497-1-andriy.shevchenko@linux.intel.com>
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

In particular, replace of_gpio.h, which is subject to remove by the GPIOLIB
subsystem, with the respective headers that are being used by the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: took care of pci-stm32.* as well (Christian)

 drivers/pci/controller/dwc/pcie-stm32-ep.c |  2 +-
 drivers/pci/controller/dwc/pcie-stm32.c    | 14 +++++++++++++-
 drivers/pci/controller/dwc/pcie-stm32.h    |  3 +++
 3 files changed, 17 insertions(+), 2 deletions(-)

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
diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
index 96a5fb893af4..a9e77478443b 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.c
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -7,18 +7,30 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/irq.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/stddef.h>
+
+#include "../../pci.h"
+
 #include "pcie-designware.h"
 #include "pcie-stm32.h"
-#include "../../pci.h"
 
 struct stm32_pcie {
 	struct dw_pcie pci;
diff --git a/drivers/pci/controller/dwc/pcie-stm32.h b/drivers/pci/controller/dwc/pcie-stm32.h
index 09d39f04e469..419cf1ff669d 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.h
+++ b/drivers/pci/controller/dwc/pcie-stm32.h
@@ -6,6 +6,9 @@
  * Author: Christian Bruel <christian.bruel@foss.st.com>
  */
 
+#include <linux/bits.h>
+#include <linux/device.h>
+
 #define to_stm32_pcie(x)	dev_get_drvdata((x)->dev)
 
 #define STM32MP25_PCIECR_TYPE_MASK	GENMASK(11, 8)
-- 
2.50.1


