Return-Path: <linux-pci+bounces-35873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B110B52AE7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E92F1C81B0C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A052D0627;
	Thu, 11 Sep 2025 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFkxP3uI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA562BEFEB;
	Thu, 11 Sep 2025 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577486; cv=none; b=h8YjV625Z2LZfm2XmqU/Sj17wzitSwBwXLkSvfLRKU1kwaB8FqA/yCd4jBED3lp61YHRdRDTc8HUIvCp2QdToKvZtBKLZRgD0VkdmvKWqIXX5+kp6+ieQLPoFOda8yfWi9CfqFFN1RZhtGIOlEuqZ5n2xo4U82cgV9mn4Kaaq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577486; c=relaxed/simple;
	bh=eg1UYhv7Re0EQKia5CuYjI3vnVpbRQ0R1QZ1gddY+LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2TZ2zlMwB8onsgugq7mGKBdONMFzJ9UuZ/G9gdWuHnyx9xAzStHFPRegXIkwLp98zM163DEKEQvEhlAn5rCg1hTYs2bcISdpaqhmpBHWXvELbMx/3r9TS+dXpeMN3/gRrHOvjaYkH1rx0i2Qo/tE+zIo0UeVZG1zMk65+0yjPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFkxP3uI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757577485; x=1789113485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eg1UYhv7Re0EQKia5CuYjI3vnVpbRQ0R1QZ1gddY+LU=;
  b=CFkxP3uIXuTSCz839v5g+qwBD1uSFgi1+ObmHrAtRcWVNmcqP/sUU49/
   oC1sAd6oI9M9/m2yCjsDkVNHDkkp01AbrG9CyXD9yl6mKGJC494lW4TK4
   ONxIULpuEoCSCSerbiEObpwoi+uNrtFXzZ9jtQpC2Pvr66STPyGQKT4oB
   90T+FFt3PqY9cM9TWg8Ezt0gkyo0vrbtfse5JTh7FzgB0i4fuWsitxAPi
   Cg/f2BwN1Vo7knQ7l7pMSo/k0usqe8BSi8vxNnsaxOWqnJmizJrY1nF+c
   nCQhCVuZPYTYrIRWU5FXLJfWdeNyb0G3AugoczuQyCpGCVd/tnRSODPig
   A==;
X-CSE-ConnectionGUID: 8FYYXpFGT92Eqa5hqX7Ygg==
X-CSE-MsgGUID: LvZTb5GfQ8WNb8kqMte46A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63728896"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63728896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:58:04 -0700
X-CSE-ConnectionGUID: CD1NoNyJQZOg/d1t/22LSA==
X-CSE-MsgGUID: GxRSkfKFSa2BxA7V1GRA+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="174422502"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:57:57 -0700
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
Subject: [PATCH 08/11] PCI: Add pci_rebar_get_max_size()
Date: Thu, 11 Sep 2025 10:56:02 +0300
Message-Id: <20250911075605.5277-9-ilpo.jarvinen@linux.intel.com>
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

Add pci_rebar_get_max_size() into PCI core to allow simplifying code
that wants to know the maximum possible size for a Resizable BAR.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/rebar.c | 23 +++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 735d9afd6ab1..76572c7a6e6e 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/ioport.h>
@@ -146,6 +147,28 @@ bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
 }
 EXPORT_SYMBOL_GPL(pci_rebar_size_supported);
 
+/**
+ * pci_rebar_get_max_size - get the maximum supported size of a BAR
+ * @pdev: PCI device
+ * @bar: BAR to query
+ *
+ * Get the largest supported size of a resizable BAR as a size.
+ *
+ * Returns: the maximum BAR size as defined in the PCIe spec (0=1MB, 31=128TB),
+ *	     or %-NOENT on error.
+ */
+int pci_rebar_get_max_size(struct pci_dev *pdev, int bar)
+{
+	u32 sizes;
+
+	sizes = pci_rebar_get_possible_sizes(pdev, bar);
+	if (!sizes)
+		return -ENOENT;
+
+	return __fls(sizes);
+}
+EXPORT_SYMBOL_GPL(pci_rebar_get_max_size);
+
 /**
  * pci_rebar_get_current_size - get the current size of a Resizable BAR
  * @pdev: PCI device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 917c3b897739..a4236aafad24 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1424,6 +1424,7 @@ int pci_rebar_bytes_to_size(u64 bytes);
 resource_size_t pci_rebar_size_to_bytes(int size);
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size);
+int pci_rebar_get_max_size(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
-- 
2.39.5


