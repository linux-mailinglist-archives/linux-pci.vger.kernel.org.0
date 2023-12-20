Return-Path: <linux-pci+bounces-1196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC688195F6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 01:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFC5B237DC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 00:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0461FC9;
	Wed, 20 Dec 2023 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiV8BXng"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974FBE52;
	Wed, 20 Dec 2023 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703033552; x=1734569552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bq2s9gwLh3Oh742hJuC8CK1tg4+GUxCgWKtcAn88usw=;
  b=fiV8BXngQ6KeWmqvcxgpebmdHL7k5vcxx73zZnzZTwU7LjMiccn10IDg
   KJt7ezzFr6qDp+ZxF7EiUn9FZbuRzh7iwzmJ5nxPZK+qyCrdIqP43fRKE
   ZkD67W1de+OY5OKQbRC9gJNcPZQAmT8pMc2yj/rwqN0eygB66NX/ooOg5
   bQBlZUcnmoBniQ458BP/snTYPWLgBcaCJt3BfFRWP0Q/TW7mF9Wn12LWb
   5PrgnYYFcr30lbfg7tEpMx+wqVijpSw5jBOfYFdz9MxVlNWeSYjplwNoB
   tHJBv++xFSMRkqZtwhUK9AWJ9bidxT11QcJ/DW2Vc1wJRg10x0KBm/hwH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2566070"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="2566070"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1107551574"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="1107551574"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2023 16:51:59 -0800
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
Subject: [PATCH v4 1/2] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Tue, 19 Dec 2023 19:51:52 -0500
Message-Id: <20231220005153.3984502-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231220005153.3984502-1-haifeng.zhao@linux.intel.com>
References: <20231220005153.3984502-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make pci_dev_is_disconnected() public so that it can be called from
Intel vt-d driver to quickly fix/workaround the SURPPRISE_REMOVAL unplug
hang issue for those ATS capable devices on PCIe switch downstream 
ports.

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


