Return-Path: <linux-pci+bounces-2684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A4783FCF9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 04:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14502283053
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 03:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AC12B75;
	Mon, 29 Jan 2024 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkSWDpE9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01A12E5B;
	Mon, 29 Jan 2024 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500179; cv=none; b=GFmAJEugr/Y4+HVtIDKtIaNV2YybXBJ+epojPOaAnEtH4DABSoGO5Ir07g+qlkO4xfjy9fRjesDa0hAtHON70ak5mghikCnvpbZDW/mM3xtmNymWzKan7yumP4uIwUC5KIOyuWWIr34GfgpuMYgpF0FE6lraOv6Xkdj8CEUQGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500179; c=relaxed/simple;
	bh=dEKy3mt/WPL6E30nghtcx9sbGmG9T5AiLwENf8K/kU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1ad4bZ35DRyD2T0EmX/9PqhaaULnHPEgHnEv4BGJFXtyRsBdhQbd5fMdYRFO2rY24MPGszQEXDkBuMSbKUajjwVhK3sanbg7CytiS/hfX1DKuBtkr0XeVaGQQdoXCj9hj9tyRl8+1md2pPPn5aV+luFeKKXHAAylBJQo1Mhupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkSWDpE9; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706500177; x=1738036177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dEKy3mt/WPL6E30nghtcx9sbGmG9T5AiLwENf8K/kU4=;
  b=YkSWDpE9tyBGA5FfOKWzW1b5QzoNiyQOT66lNbAaAGItk52EOsOtc27a
   AMxDWBdsEq4/Lp0JFqv0buZioATFtDNWmSR4BSD3t3C2eYZyOx+rJP8UW
   UGuuzSTbHo9AO+aUbltn0K3N9c30awnkN+14SLE7qn9r+It68OCtwxP5T
   51qmF8y0gy11xSXH/d+C8NXKclzY+l1OKb/griBzWcdIHp3AF1pEssiIM
   a0SUwSIV25B4HTw20S9K+s6FFuP0S4nVi/0IcJHBBAG1GOK5mlDNWBfMN
   MONTfTWebBaTd0NY4KI3LP8AwZ03NSDMR9oYxmNLGjLeTHH9tuDm4nDZf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406566895"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406566895"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 19:49:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960775187"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="960775187"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2024 19:49:32 -0800
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
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Haorong Ye <yehaorong@bytedance.com>
Subject: [PATCH v12 1/5] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Sun, 28 Jan 2024 22:49:20 -0500
Message-Id: <20240129034924.817005-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
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
index 2336a8d1edab..94118c4cff54 100644
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
index add9368e6314..19dfe5f16fc9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2512,6 +2512,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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


