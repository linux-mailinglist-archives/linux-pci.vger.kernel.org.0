Return-Path: <linux-pci+bounces-2560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9564783D225
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 02:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA4EB252E7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 01:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1FF8BF3;
	Fri, 26 Jan 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFpKaysN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D364522E;
	Fri, 26 Jan 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233229; cv=none; b=mCLAhwEMrgSB+51dMLL4OorBUZvaD9dnjSIb0HeiYUJpBV8P8OPahQ2K8BFQMmEfk19YtOd3GYiQWjbABLyaQclWqcnl5wsPg4JjeK78ilOd7KaJEWG1VM/RRFi4Zljx9swLPrzHuSc7Xj6f+xsKcWPsHu62Bd5/wHEoNRllsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233229; c=relaxed/simple;
	bh=dEKy3mt/WPL6E30nghtcx9sbGmG9T5AiLwENf8K/kU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0JEP5XIEjmP0HMl3vEK3GiWZKPxC0vHgmwR8WHH0gVPjY5eTFa9Ow9hXhh3K4cW2FDyrnj2tGiJ6XKBtxPtX+6XtL/D6RI5obwXYg82vCrdMfVaZ345rWoLIRGNygu8YEsgzLTkV/d0Lh3cCGdV7mGpDK4lex+WIH8vjuNYybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFpKaysN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706233226; x=1737769226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dEKy3mt/WPL6E30nghtcx9sbGmG9T5AiLwENf8K/kU4=;
  b=hFpKaysN3cQSoyCaMPhka0oe39bMBe4cnlyo2WTwxRZPJ9E3WmLq/Jwr
   1YnfoNT/tB5STV24o3KPT3wkzHMqHXPKy7CubtCzFsCynx6MJ/O6CE6kx
   mUGh22/7+/B0pkYhaqez//m/uJ9AroX6SifdpGcgEjX92AhxabvQmSy4F
   oiDzMo4L8cADJcjKNcDths22JyigytfFrYtzGtX28KqbI0PVakdTSLhg0
   koMCU3drEbbU6paCh0w5K6sXmrfBw0xx0wu/e1G/EwGRgjfTm56J23SHF
   De6hbK7CHR9xkZvLX2mqpsoFSO5dNU0DcF5NZ09OwS1hZ5fzNSLeqBytY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15718453"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15718453"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 17:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2533094"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jan 2024 17:40:23 -0800
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
Subject: [PATCH v11 1/5] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Thu, 25 Jan 2024 20:39:58 -0500
Message-Id: <20240126014002.481294-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126014002.481294-1-haifeng.zhao@linux.intel.com>
References: <20240126014002.481294-1-haifeng.zhao@linux.intel.com>
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


