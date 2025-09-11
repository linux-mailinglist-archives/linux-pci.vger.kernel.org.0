Return-Path: <linux-pci+bounces-35868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DCCB52AC6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F56A08073
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867692C235A;
	Thu, 11 Sep 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaeylxRW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97F2C1590;
	Thu, 11 Sep 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577409; cv=none; b=hwzbXJ9kVS9ytenWxlnHlkekHQ+h+yQs2EjXw82/yJCS1MOUXCNfJTCQ6gc2lKYryjDI0waXxO2JFe+mfb+mPVR6EXsk0ztcZ9LkG7zd9xOcWMPDTxiQCYK4WRQQ5fkJeJjk3qozpQocMjPRTyj25rvccNn2Ji1LP0SD08dQlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577409; c=relaxed/simple;
	bh=SkTWiDM07Pv01AmI8V3nn+Bcv4Ej0HFus6Xxyk8l27I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKOX249uxRQjkFp07mcSLVN0JgRBPGAoIl0j3FNjOCif08/asUV2GQ5mZj+0RW286ELCtx2bDYwoBNn34iCy5wTWmgXRQ9v2gjZeOhQYfXNhTdnoBBnOUPliYQP1/vkGusE0egQGNcHODuyloNa5D7KFk596A5WYAWVk94xEDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaeylxRW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757577408; x=1789113408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkTWiDM07Pv01AmI8V3nn+Bcv4Ej0HFus6Xxyk8l27I=;
  b=HaeylxRWNaIFbUaAYx0u5AxOCfUe1znGFDnEOSQnZG+WSwnpV31d4BKh
   MBQ6sQiPSQk1gZbQLQzUUNKvm+8XHDBhjvKGJL+JLT6eM9+pOWRwhPtJk
   y7ZIbC0lMdTfdhVoJ4TcLAQmnmTGNt8sO4gwmqNePAqOTakJPCaVGbxez
   2mSGBdjdftXmiCh2pk1KZ6IwLS0YwtlyBUXW2jLMwpbSj2UtNwSFCce1t
   V3YsCnOy6lH35usiCRrasYKu1wGSGLfjXUo2B1cZrjxqonIbXFpMFJCBQ
   XQlZZTPgn+/ABUFiQ9gt+md61c3xhCZNgJ4ISlCLvavd8sknf7+tXRtHz
   A==;
X-CSE-ConnectionGUID: 2l7xYJ4jTJeZ3/WlgTBOHg==
X-CSE-MsgGUID: gS1JWT3JTZyON/vFFoD1+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="60012531"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="60012531"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:56:47 -0700
X-CSE-ConnectionGUID: vbdtxzA3RCyRsmebXrL/BQ==
X-CSE-MsgGUID: zBK8wFg/SwaGIZ8jBWABJw==
X-ExtLoop1: 1
Received: from opintica-mobl1 (HELO localhost) ([10.245.245.187])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:56:39 -0700
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
	?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/11] PCI: Cleanup pci_rebar_bytes_to_size() and move into rebar.c
Date: Thu, 11 Sep 2025 10:55:56 +0300
Message-Id: <20250911075605.5277-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
References: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move pci_rebar_bytes_to_size() from include/linux/pci.h into rebar.c as
it does not look very trivial and is not expected to be performance
critical.

Convert literals to use a newly added PCI_REBAR_MIN_SIZE define.

Also add kernel doc for the function as the function is exported.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/rebar.c | 23 +++++++++++++++++++++++
 include/linux/pci.h | 10 +++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index b87cfa6fb3ef..961bd43be02b 100644
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
+ * Return: BAR Size as defined in the PCIe spec (0=1MB, bit 31=128TB).
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
index 59876de13860..894e9020b07d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1418,16 +1418,12 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 void pci_release_resource(struct pci_dev *dev, int resno);
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
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
+
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
-- 
2.39.5


