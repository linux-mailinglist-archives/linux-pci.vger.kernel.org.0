Return-Path: <linux-pci+bounces-7330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4188C21A0
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FAB2845E8
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC98165FC8;
	Fri, 10 May 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZMiwdgg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E12165FBF;
	Fri, 10 May 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335672; cv=none; b=FTrvvIbN/aKLpp0ZgLLnDrn+Ej3VJEQU0BtY2ak2EtgAE8hH/d0qqe4KPViufUP0mjVidmwAYGPUwY6x6Y60cjWVk+W7srHJmbr9t+AaeRPnowSoANbJcYWDt/wU6SZJCmPEzyp9ot3f6KiK7to/s5PnX/KWoZZjtdNfI0eY2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335672; c=relaxed/simple;
	bh=nDVHo/uGXMDlWtWQD47FWInWDYtBZPj5d51tV3Jx/N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hoy0JdHXt90v4Yi4MvMI7J8wzIRPwlPOVpNk7AqWfz4lw8P+xXRnyN2n6CJp6tWp4HNWk9VdxeLoMddKsCVKshVfdo8lmi1S97CKl4CfLNeitp1VOnLBRl+ORFVUFoij3ZzKKGpk26s2cKWgp5C52rAOY/SB3RPHY0Ba00R1Yqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZMiwdgg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715335672; x=1746871672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDVHo/uGXMDlWtWQD47FWInWDYtBZPj5d51tV3Jx/N8=;
  b=VZMiwdgggRUq6kb/2d8FnZp8g5SSmY0gihAUf0dSlSd1y35nMidKbLjx
   db+0Cg2qpxxDamisy5NlawNuQuACuliulm5oiX8/jOhPmQrfsPbuSQv8N
   aO+uU70oNqiMgySNSXOUuCNhrYZDeGJ+yoIezWB7zVCKrtJjqVzh5BNy/
   WzxL4pNFVBZfM/zKZFZUR+CuZjsD8fH6tf/Qv0KdqHFLElU4vuA8u2UYD
   n2+ia5bnS1R6oxAO2FO4lDv0NpP0/BhVGLllX3GY916dT9bQdD1S54626
   cqpOhPe3x/MELEt3ues6UUbqYTPJ7hgHKvAhmKbqpda6JbmU1qn2pxD9f
   A==;
X-CSE-ConnectionGUID: RNHkBdnDSe+9HmcrVl/znA==
X-CSE-MsgGUID: FMG+yppzR3+kiFJTFhNcHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11144834"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11144834"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:07:51 -0700
X-CSE-ConnectionGUID: yOnt0tdzTlSsylo/hwrqwA==
X-CSE-MsgGUID: 3R/di1/XRPKcEASqYMoq2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29588248"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:07:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/7] PCI: Don't expose pcie_read_tlp_log() outside of PCI subsystem
Date: Fri, 10 May 2024 13:07:24 +0300
Message-Id: <20240510100730.18805-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
References: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
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
---
 drivers/pci/pci.c   | 1 -
 drivers/pci/pci.h   | 4 ++++
 include/linux/aer.h | 2 --
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..54ab1d6b8e53 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1092,7 +1092,6 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pcie_read_tlp_log);
 
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..9c968df86a92 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,8 @@
 
 #include <linux/pci.h>
 
+struct pcie_tlp_log;
+
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
 
@@ -419,6 +421,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
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
2.39.2


