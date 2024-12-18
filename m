Return-Path: <linux-pci+bounces-18701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247609F68BA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FA4188BD8E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81881BEF6A;
	Wed, 18 Dec 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHfg5Yhc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7A219ED;
	Wed, 18 Dec 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532689; cv=none; b=jB0eaF9YVZLTdmQJF3K8sA/EVTDvlJOIYX1roJG23/uu53NGRWqfVaQnn5uQNA7BHNFGfF1TkPF6KkYFzvCkzxq3aL9WJtuuqIU///9gMvA7GYB1gE24uRobbKQtKfYttnwzm8dtbJkSuGbQ5LR2SFa1lCypJ/4BRksHqBnJOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532689; c=relaxed/simple;
	bh=pEPLOEVYfxTevDLItm+PDeMI6pv8ZNbePX0cYmjRMKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sb70RXOIQgibcmXeyuWbb/DXZd5avQyNLCIehoQiEDKKpvXIMszL+lwZDzEUbyvjDIZ2moQl4EAKvnEI4BmEuVq2haX0Qn2zWQ3wQ8tF/mNFkm/Sf4/u1XF3ujSpYiCxBHHRkTpCe3rq8vknnNUL7GVYJU+5F428Yo/BWTsKGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHfg5Yhc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734532688; x=1766068688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEPLOEVYfxTevDLItm+PDeMI6pv8ZNbePX0cYmjRMKk=;
  b=WHfg5Yhc4ic2iTZ/oXne6QgHkqXGH8zA25qzUe2uOg4FlvYavXYLVwWL
   uwif8U6T2YBmEp5678iawgTTRQztZnangpAGfPAyd0kcR0hV6Di8q7A48
   gtFOQesfsN5F4GH37iolQwm6Dpzikp+7pbfsyawPmGmR7yfx9UY4/+KKU
   1ZqGFVByPPbsI2AZtgLtN5FWKYuFKm2USlzB7+djTXKZe/DAvYvV3ibmJ
   BblTSCRfEBkc/bkJAhs/RcAKGP8E6rS129YJUKrkSMkn6edLNiCIqBae4
   OqdXX5eNkPmk3jUF2NONSIVUbUwC7ZNzmn0IMObS8C/ZyC7qHEq2fku/X
   A==;
X-CSE-ConnectionGUID: gExSpLSSSHCDPB1yd02Z5A==
X-CSE-MsgGUID: hdOns+5/SiKOLW9Tw5CfAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22597272"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="22597272"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:38:07 -0800
X-CSE-ConnectionGUID: wxrgTiwpT6aNO10AM4Garg==
X-CSE-MsgGUID: YwYqw0fsTo2CERc5vKoceA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102974605"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.138])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:38:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	linux-kernel@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 1/7] PCI: Don't expose pcie_read_tlp_log() outside of PCI subsystem
Date: Wed, 18 Dec 2024 16:37:41 +0200
Message-Id: <20241218143747.3159-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218143747.3159-1-ilpo.jarvinen@linux.intel.com>
References: <20241218143747.3159-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcie_read_tlp_log() was exposed by the commit 0a5a46a6a61b ("PCI/AER:
Generalize TLP Header Log reading") but this is now considered a
mistake. No drivers outside of PCI subsystem should build their own
diagnostic logging but should rely on PCI core doing it for them.

There's currently one driver (ixgbe) doing it independently which was
the initial reason why the export was added but it was decided by the
PCI maintainer that it's something that should be eliminated.

Remove the unwanted EXPORT of pcie_read_tlp_log() and remove it from
include/linux/aer.h.

Link: https://lore.kernel.org/all/20240322193011.GA701027@bhelgaas/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.c   | 1 -
 drivers/pci/pci.h   | 4 ++++
 include/linux/aer.h | 2 --
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b29ec6e8e5e..e0fdc9d10f91 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1125,7 +1125,6 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pcie_read_tlp_log);
 
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..8a60fc9e7786 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,8 @@
 
 #include <linux/pci.h>
 
+struct pcie_tlp_log;
+
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
 
@@ -549,6 +551,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 #endif	/* CONFIG_PCIEAER */
 
+int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
+
 #ifdef CONFIG_PCIEPORTBUS
 /* Cached RCEC Endpoint Association */
 struct rcec_ea {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..190a0a2061cd 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -37,8 +37,6 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
-int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
-
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
-- 
2.39.5


