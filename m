Return-Path: <linux-pci+bounces-36126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F4B5744C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B17416F924
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473B2F3604;
	Mon, 15 Sep 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLj5o6bR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F42F290A;
	Mon, 15 Sep 2025 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927682; cv=none; b=fGKaDxDJEKoFFNBHHkoucNrY+tY5QUm6BSQr6Y6ObwiOaXtg54Ep3aknCw+Bl+VajCzIpQO2xgVZRRJObNZAgd8VX0RMamSb2iwVsf5X1e2JiUce79OxLsU2VqMv1yynF8I1M6FKNdKFwSuEAfsnS0lEZf1dkDPj/lTlt0F1gjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927682; c=relaxed/simple;
	bh=zHNp+IHOuGFj5PYwtPXkP1AexpoGkJ1GE7C2FeSyOxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ltz6loRcRraXybWfmS+d8TUsFDS2+wO2i+OaHI9rUZj9f4b1U4ZZbq+e0MYGBvk65mwVx5kMrS8RxnvYMQFCqX44pdQRjRpngc5/YOm9KuiWlq92L1YmPHXic8PUH4wJMsoKIRPePoiyXAaS1g5BHHpyd7ID6S+bKH0C0HfyyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLj5o6bR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757927681; x=1789463681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zHNp+IHOuGFj5PYwtPXkP1AexpoGkJ1GE7C2FeSyOxY=;
  b=ZLj5o6bR8jRIuzCe8haAlJGdre+dPQf32D2OYGql+Hqk6gOC6XzQsfZj
   olNlO89CriFyxXeWguQ8oAKxbNkY08jcMI9TSFrUKsJIqxqFL2mv0FQq/
   nPeVWibnYRb5Ly9HJwOEybkut9jTOqB5I+Nr5O3go/l8oiQaykmWH6dHi
   LNeAbOascYdTMw0wfSj9Gu4wdlDggb0hHt4KMKrnvAp14EDVustMxuxxr
   fgYXsV+cZIUXUL754V3dKQcqNJabBgrMhVYbQOCvR+4jv4PO3YWQoA/0/
   nTtjSuXhnEgFO99bFUrOns1BMRF6Ydg1+VtrW8K+J2CXjd9eBlKTkoBTl
   w==;
X-CSE-ConnectionGUID: OncSYiJjRg+cksXd0CJBDA==
X-CSE-MsgGUID: utoXqL4TSLaWD5XRF96wLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="82764102"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="82764102"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:14:41 -0700
X-CSE-ConnectionGUID: aiwACXQ6QfW8Ny+LF9J7GQ==
X-CSE-MsgGUID: Bd6vWJqbR7C+klUG8Exa0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="173860675"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:14:32 -0700
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
Subject: [PATCH v2 02/11] PCI: Cleanup pci_rebar_bytes_to_size() and move into rebar.c
Date: Mon, 15 Sep 2025 12:13:49 +0300
Message-Id: <20250915091358.9203-3-ilpo.jarvinen@linux.intel.com>
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

Move pci_rebar_bytes_to_size() from include/linux/pci.h into rebar.c as
it does not look very trivial and is not expected to be performance
critical.

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
index b87cfa6fb3ef..95e00d8e0c89 100644
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


