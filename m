Return-Path: <linux-pci+bounces-6598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F078AF8D1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 23:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56B31F220E4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93440143864;
	Tue, 23 Apr 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeEf18QK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE864142624;
	Tue, 23 Apr 2024 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907107; cv=none; b=l/S0ZECfTbkYFoq5nsHXj+6JUbfxEJmKvVYzTaBmvjvpjwR9ngRb35Ql7JK42cZr8Ul2VaOtbvPkR5/PCGs1s6AMG6OjdKEtTeHUe6ZP42FCkTUGMRIcVgcoGB4zOzyvajSRmWMWEThtaxZSrL1doQV1iyCWFn+yz/jOvwg0OXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907107; c=relaxed/simple;
	bh=CJmlaW/WMNPHb2CyrsKTyGi+evxiFQAXb/u85TPFwss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+vtauRWffFPQlVDGIUWqmcRaR1R/c3zsFZL/LI3bfvlpMCru/tRuMPduAciSIFGKPOARCGOlqGbwl3yx199xE5UpfirS+b24ew/oXmU9+5uihHDm6pmZOIqSooglTTNSojB/TQ6whuPeNCjbf5MWeygn24GMCxlwc8mF1KzoK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeEf18QK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713907106; x=1745443106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CJmlaW/WMNPHb2CyrsKTyGi+evxiFQAXb/u85TPFwss=;
  b=KeEf18QKitJwhsouG9tcHPOcSfHmoyCoUjmNautjBe0TyL07z4zIedlQ
   r/S8ahZdG9FkgfqZN47p3nRnGvPg83FkSB6KtqjtRvfLPQk3RUwsnEVHB
   L6sPFvuAGhgOXm7/ETN9HpF/vM8uk1/GtT74nW5cFZRTreNASFlAGWgrW
   w4KV/T/gCxz7S+Z/TJC/bSzKtq/FnidYnpEPe7TmZ5VYGOGWZfD7Mutu+
   Stwd71MyctX+6W/QvsyAFveH2SPkoRtx5hZ8svWlWIsjhpAsQPrFKaazL
   V/ZiHFKmg2uCIiNMIcKsXiYQQ8euwb48ZWvApAhOsPxb1Ldsh4ccWlyEN
   Q==;
X-CSE-ConnectionGUID: D9vRfGi6Qk68Osb+XMMWyg==
X-CSE-MsgGUID: fgjZQQB3QJiulhFhc9b1lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13302380"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13302380"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 14:18:25 -0700
X-CSE-ConnectionGUID: oxTR76zQS9Kuda1m6qRMJw==
X-CSE-MsgGUID: EXcF+n1aR165ZtRQG6CROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29139854"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 23 Apr 2024 14:18:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D2E8F28A; Wed, 24 Apr 2024 00:18:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI: dra7xx: Add missing header inclusion
Date: Wed, 24 Apr 2024 00:18:17 +0300
Message-ID: <20240423211817.3995488-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
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
index 2015f51664bc..cf8392190856 100644
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


