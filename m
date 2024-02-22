Return-Path: <linux-pci+bounces-3852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4D85F3D0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 10:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A2E2853A9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADCE364C1;
	Thu, 22 Feb 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPtVE1rM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F52261F;
	Thu, 22 Feb 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592600; cv=none; b=bgAmgNy09GXei7DLfkBYHE93Z6G07sW5la1NoJgyaA68slq9vZ+PIepaFWMGvwIHw3hHmbeCnQKsDRlVSNe2jwXXIzqtRIIPMZfdBC7XzUcq69f7Hl4aUfPE+jUumb63GbddupmokzfP0U8IgsiDKMbieOjYoCuXkwoP+5Dt2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592600; c=relaxed/simple;
	bh=qGvJdjdFOeQfZsaVurZBwtpkSGEkZOdq9FP4c2dHoM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=To5J69wEInxLDajnhYrGD4sWKv0/CMO1Xf7bMJLn+GgJRhdOeZnHJh4D//7Zx8gRmSD0kEMILgCXwH0R8mLa92mrzZF2YEBiGE5rXHZhZC6sOUULvFMC2eQK1EgrVcLUWezV679hpQsV7vlnEDucN4Iv0v/RyS/fL+GUxHqbdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPtVE1rM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708592599; x=1740128599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGvJdjdFOeQfZsaVurZBwtpkSGEkZOdq9FP4c2dHoM4=;
  b=jPtVE1rMxKHh2Ugo3xYKE74tM0fGb/N47Igw5vE6QKjmAqbwzWy5ah8F
   vCeoD31d4w92b8bJ+dxNoFj+C5+2XJb29DFfm/8von0aL2p7ouWok9UH9
   GOo+ap0J8tGGdQEH/Rh70MbD45rwnco6BAoifXnPRKqjqkvu3taT0fX0q
   nreS5Ho0hsULeVVTEB03xvRF4xGzbRimA7tW47X2gvZYSZnWfIEdrRDwS
   1KXkHYuHmFDqz0+0HbeGi5gjOAoHtcaJPFxpoUu+Yl2VGGm6KrmwN+oVq
   SV91V0GeP+r6PK9IrIO5XRTq4tjhLNU4MqokRc5mYS2E4yO9eTE7dFNpm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25264451"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25264451"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10122632"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa003.jf.intel.com with ESMTP; 22 Feb 2024 01:03:14 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Haorong Ye <yehaorong@bytedance.com>
Subject: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Thu, 22 Feb 2024 04:02:49 -0500
Message-Id: <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make pci_dev_is_disconnected() public so that it can be called from
Intel VT-d driver to quickly fix/workaround the surprise removal
unplug hang issue for those ATS capable devices on PCIe switch downstream
hotplug capable ports.

Beside pci_device_is_present() function, this one has no config space
space access, so is light enough to optimize the normal pure surprise
removal and safe removal flow.

Tested-by: Haorong Ye <yehaorong@bytedance.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/pci/pci.h   | 5 -----
 include/linux/pci.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e9750b1b19ba..bfc56f7bee1c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -368,11 +368,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	return 0;
 }
 
-static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
-{
-	return dev->error_state == pci_channel_io_perm_failure;
-}
-
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 #define PCI_DPC_RECOVERED 1
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ab0d13672da..213109d3c601 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2517,6 +2517,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	return NULL;
 }
 
+static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
+{
+	return dev->error_state == pci_channel_io_perm_failure;
+}
+
 void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
-- 
2.31.1


