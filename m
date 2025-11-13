Return-Path: <linux-pci+bounces-41150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D8BC59539
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00E1D34D605
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE0346791;
	Thu, 13 Nov 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHVARSFP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15229BD95;
	Thu, 13 Nov 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056899; cv=none; b=hg7fmi0r4nO6KZqk4UnEz9D4Pk6lyi3s+acEaPkmZyefQgjXST4JqRWto1cveBGUSV8JK4Ew7ntYG35KEkYUZhw21ztTQ90joOp16opxcdE1Yos4zyzGJO8g8MAWyA+D8Smvo8GfgwgVtb5au2mqS0DnJlpc9a31r2QALXdjsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056899; c=relaxed/simple;
	bh=Mhb9W5CShBH9lUW5aOdaQ3Fc0vAw/2EZR+ZRatwurTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHhVjQszhnQXAttuAMmzUwOlyzuhYBFAN7BqXqJzPxZXON/ey6sfdv/pxRdL4pEtB+JW3ALUGr1eiqKJynrIMathmOQotdKOSeVyCRGMj3hli+rC1fUgXS18hJHPjcwLbWqnJ7O3Dya0kitWwluW0+bospC8vXAyb8m0B+omt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHVARSFP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763056898; x=1794592898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mhb9W5CShBH9lUW5aOdaQ3Fc0vAw/2EZR+ZRatwurTQ=;
  b=MHVARSFPH/dQuzUF0E4FjL0BfK+idNxEknvVbVw5/W7N+6jl8IX6jlEk
   ig7TSl3S1aYpLxCJO3Y5+Tu9sedTGKAX4+Sb0KEg15ihTEE/Ae7NX65eF
   qCIQOE9Bk29dnuAsj/TVFgU48NccQn9yqCQNq7GEWKZo+0bURwHzdYTXB
   07NqFc48L8l1SD64BINt+HbrZipflXn/VGyAufkzV1AtaqtQA54C6vva2
   0v4o1NGIMJ1mf1ileEMx9FJsX3PjA1acXWU1IGt102QO1hxGiT8JeH5w/
   Q/BdSoWyJJ+1L5/mBCuYXGjWl36cOo/vdN2lmS4iBWGeoLXqCLdtBQN2m
   g==;
X-CSE-ConnectionGUID: EvELzVvGT5eBaA08PZxh/g==
X-CSE-MsgGUID: 9ncLbq2CTl+55vjkD3EqAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="52710946"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="52710946"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:36 -0800
X-CSE-ConnectionGUID: C+/nr2tmSy2iDXrs8M2vFQ==
X-CSE-MsgGUID: XLm8AHb6RteJDIg01Kchxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189574021"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 02/11] PCI: Clean up pci_rebar_bytes_to_size() and move to rebar.c
Date: Thu, 13 Nov 2025 20:00:44 +0200
Message-Id: <20251113180053.27944-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
References: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move pci_rebar_bytes_to_size() from include/linux/pci.h to rebar.c as it
does not look very trivial and is not expected to be performance critical.

Convert literals to use a newly added PCI_REBAR_MIN_SIZE define.

Also add kernel doc for the function as the function is exported.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Michael J. Ruhl <mjruhl@habana.ai>
---
 drivers/pci/rebar.c | 23 +++++++++++++++++++++++
 include/linux/pci.h | 10 +++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index f6ed7e4893a7..0eb6fc445703 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -7,11 +7,34 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/ioport.h>
+#include <linux/log2.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 
 #include "pci.h"
 
+#define PCI_REBAR_MIN_SIZE	((resource_size_t)SZ_1M)
+
+/**
+ * pci_rebar_bytes_to_size - Convert size in bytes to PCI BAR Size
+ * @bytes: size in bytes
+ *
+ * Convert bytes to BAR Size in Resizable BAR Capability (PCIe r6.2,
+ * sec. 7.8.6.3).
+ *
+ * Return: BAR Size as defined in the PCIe spec (0=1MB, 31=128TB).
+ */
+int pci_rebar_bytes_to_size(u64 bytes)
+{
+	int rebar_minsize = ilog2(PCI_REBAR_MIN_SIZE);
+
+	bytes = roundup_pow_of_two(bytes);
+
+	return max(ilog2(bytes), rebar_minsize) - rebar_minsize;
+}
+EXPORT_SYMBOL_GPL(pci_rebar_bytes_to_size);
+
 void pci_rebar_init(struct pci_dev *pdev)
 {
 	pdev->rebar_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 34ff295cd2e3..628dda63b9e0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1419,17 +1419,13 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int pci_release_resource(struct pci_dev *dev, int resno);
-static inline int pci_rebar_bytes_to_size(u64 bytes)
-{
-	bytes = roundup_pow_of_two(bytes);
-
-	/* Return BAR size as defined in the resizable BAR specification */
-	return max(ilog2(bytes), 20) - 20;
-}
 
+/* Resizable BAR related routines */
+int pci_rebar_bytes_to_size(u64 bytes);
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
 				     int exclude_bars);
+
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
-- 
2.39.5


