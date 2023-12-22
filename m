Return-Path: <linux-pci+bounces-1289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A998581C858
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 11:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF931C21623
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF5012B65;
	Fri, 22 Dec 2023 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHvsp3X2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A371173C;
	Fri, 22 Dec 2023 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703241675; x=1734777675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TljuoHGjQTdNL/8N4wKTVKbm0YrUiASyUSEokPW3tOo=;
  b=GHvsp3X2rDlXtVP+VgDxssiWaiXYlKnrn02U1L9n98Gk5sGpBX3YKKMb
   y7jd7lY2YiCBB/Ou0ZOYWDoJ4qnljTcj/RsaHp3Ovt5JnzJOimXKh+Zzm
   ItImd7rgzDwCUvVlPfx5znGhNfR82ZTR1wpnbcSeo7VuehggOR5ZgdUZN
   huFZ3fAnOI215JQsg5fRs0d2uPTXZMjisCmBNVG1HjzVFJpKmo3oEpSOD
   +XGjlW31wwqnQz84yBZbwnB1l3m69cnhA4kyjGrvo1xx47Srb0zbnUY6X
   D8JAp92fhP8WrnxhFUSHwEkh68zIvd6T9QXGogmHZpYn9OzF1n5l9v4G+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="399924254"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="399924254"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 02:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="11430762"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmviesa002.fm.intel.com with ESMTP; 22 Dec 2023 02:41:13 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 1/3] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Fri, 22 Dec 2023 05:41:06 -0500
Message-Id: <20231222104108.18499-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231222104108.18499-1-haifeng.zhao@linux.intel.com>
References: <20231222104108.18499-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move pci_dev_is_disconnected() from driver/pci/pci.h to public
include/linux/pci.h for other driver's reference.
no function change.

Tested-by: Haorong Ye <yehaorong@bytedance.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/pci/pci.h   | 5 -----
 include/linux/pci.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..75fa2084492f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -366,11 +366,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
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
index 60ca768bc867..869f2ec97a84 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2503,6 +2503,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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


