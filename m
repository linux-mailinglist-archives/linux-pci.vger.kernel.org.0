Return-Path: <linux-pci+bounces-36132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14CB57484
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCCA443925
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA32F4A17;
	Mon, 15 Sep 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azdfyOHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD982F3C3E;
	Mon, 15 Sep 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927762; cv=none; b=Rb3zhp01fXbdzKJbqCTDQTO8Ee7DyJsGKwXQ9uuyiYNNx8t5W1gjNvV6jlxYj0HVX3jz5T7WUw7TJ8AAEhE0C/Ud168ALX5c54PiVcjcuFsG3qrHJm05BCdrBr5fbCE/Gl7q56lOtdjzGru7wDh1U3tzcLH/mQH3cD3ltp0o2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927762; c=relaxed/simple;
	bh=kJY4djo7eguzCOM2nO94dvcUe+mrAxeDCViFz7bzar8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGREc49tZHj5XHNV25iJYC1aRo2m9ifgO+rABxbtNEPz97w31QdvDyvvkFJQQshwK6hIv1cnfcx0ODI+Qcf1vTu2zFTpa6SVx5GrlbLUktiwkXjzqP1HOxVdL/KqZiMGIim/gL2gwrAFlK+r2d3dASH1mpwJKiaD0QMdTnF0Vho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azdfyOHZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757927760; x=1789463760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kJY4djo7eguzCOM2nO94dvcUe+mrAxeDCViFz7bzar8=;
  b=azdfyOHZI6pNmPs3FfOopKUogsJ9XH6zLKnzKmdwo0hHKUJ1Ezik5EWC
   rPsutpxDg1E5Nbznt5zvAdIZRR9nrBhAk1E4+I3NTI56LHSuMcszVoG0o
   TdQLFMT49kYv78we3eeOmZ/CdJVLy1bRTL5G15ueV72MHomPMj6dwigW0
   83OdNGKjcCmj+jIDWTjfm9rbFa6r2PBQEb576Yc8k0Wi6il+uOVb2z6ai
   3jlPad8RMvtYys45Vsk3zHNX1pWk3fs0KnxbPyfwNwkRfv4/8P8pvPlFh
   4v6Fpdoz1Yy0vyTS+vKevHy7Q3W9lh/ngPRDiAXlpfPgCGo9bPyFeKOpI
   g==;
X-CSE-ConnectionGUID: CLxUVEQtQheAd58lcyTYWA==
X-CSE-MsgGUID: UksWRWtxQhGfqvjfLRBtHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59401335"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59401335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:15:59 -0700
X-CSE-ConnectionGUID: AeOe3DUOSxy6O09tWHlr1g==
X-CSE-MsgGUID: YoiRCdCPQPa9rHSu4f3y4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="175364064"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:15:52 -0700
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
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/11] PCI: Add pci_rebar_get_max_size()
Date: Mon, 15 Sep 2025 12:13:55 +0300
Message-Id: <20250915091358.9203-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/rebar.c | 23 +++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 81e01cbadde7..27185892ada4 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/ioport.h>
@@ -142,6 +143,28 @@ bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
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


