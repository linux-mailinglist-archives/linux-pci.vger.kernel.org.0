Return-Path: <linux-pci+bounces-18920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0246B9F9B12
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 21:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30565188E4C1
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAEF22688C;
	Fri, 20 Dec 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkYSZUH8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE922912C;
	Fri, 20 Dec 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725774; cv=none; b=s0HOJnmDJg5gMT2uJE71gWBRTPzFPFuXzZr8I71WvQXCNnBAW7Qs7IaxwSktRPZjYkdimY3tPJjuTqGYERaSBbyGOZPF0KwrLl4VydwKCWV0spp0KNwsUFdzWxAS+uUuw71WWRf1+2u8d8DJYHIz15cDisfw0cyHUKd4zyaLYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725774; c=relaxed/simple;
	bh=nH6Lg4M9rZoyaMaiFOr1KQ4dMHZFsu2G53TzQJeyyz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOg4NALazs0pvpmW8hUh8iglbMLNHMSCNDiBv/UAOKXH1nT5fE8w0k1rBpt5pegFI+RyZ1tIe7tbhfooc8VA50MOp5jcOcwusmDYPuUMotuRufDIvMUfeS9LHPpdDXn+lKdGjRULB3d5s9wItlZ2Wyt/sW1IqDOj65uhzz5InMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkYSZUH8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734725769; x=1766261769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nH6Lg4M9rZoyaMaiFOr1KQ4dMHZFsu2G53TzQJeyyz4=;
  b=FkYSZUH8ubgk5nzoFUHeUP6aafNf6G2r7u1W1ESn7Ya6DryOFRQ0zHpF
   qWCbpOqZZ2l+iFF+6Xeuk7d1i+HNauMRMxoejEphEvTwBIQ7xy8aMQJbA
   XxjFiUIAS+iNIB0aU5y8OnlyQtTi4W8XOWwRyzXBRVCFB+h0QrKGNzIeN
   LpI3ZX6pgzNLSMeUvWtj6JAP0OKiK+c1Qx8pwHsrlfw9bM+4x+o8MjIIA
   CiogG4sIGXLF1jtPBBkByRkKEvue1yLCfH3sFYMXhKHN36XGjecFsMEfL
   DWvh/QbHGsKYPRw6d1I+j5MV/x5TvuLQm4fNPXsk9uXaRjAnVvXqeCiQc
   w==;
X-CSE-ConnectionGUID: TIZcYYf+TeKRlARHQ9Z4Ow==
X-CSE-MsgGUID: wHRizfRuTaeTT4+o00zU6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46292432"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46292432"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:16:05 -0800
X-CSE-ConnectionGUID: zEO1/R0pR9+4RTQVmvqzzQ==
X-CSE-MsgGUID: c4Y3AEImT52KVaSEj8/55g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102717119"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 12:16:04 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 10/10] ixgbevf: Add support for Intel(R) E610 device
Date: Fri, 20 Dec 2024 12:15:15 -0800
Message-ID: <20241220201521.3363985-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
References: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Add support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 5f08779c0e4e..a9bc96f6399d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_DEFINES_H_
 #define _IXGBEVF_DEFINES_H_
@@ -16,6 +16,9 @@
 #define IXGBE_DEV_ID_X550_VF_HV		0x1564
 #define IXGBE_DEV_ID_X550EM_X_VF_HV	0x15A9
 
+#define IXGBE_DEV_ID_E610_VF		0x57AD
+#define IXGBE_SUBDEV_ID_E610_VF_HV	0x00FF
+
 #define IXGBE_VF_IRQ_CLEAR_MASK		7
 #define IXGBE_VF_MAX_TX_QUEUES		8
 #define IXGBE_VF_MAX_RX_QUEUES		8
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 130cb868774c..9b37f354d78c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_H_
 #define _IXGBEVF_H_
@@ -418,6 +418,8 @@ enum ixgbevf_boards {
 	board_X550EM_x_vf,
 	board_X550EM_x_vf_hv,
 	board_x550em_a_vf,
+	board_e610_vf,
+	board_e610_vf_hv,
 };
 
 enum ixgbevf_xcast_modes {
@@ -434,11 +436,13 @@ extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_info;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy;
 extern const struct ixgbevf_info ixgbevf_x550em_a_vf_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_info;
 
 extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_hv_info;
 extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 149911e3002a..2829bac9af94 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 /******************************************************************************
  Copyright (c)2006 - 2007 Myricom, Inc. for some LRO specific code
@@ -39,7 +39,7 @@ static const char ixgbevf_driver_string[] =
 	"Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver";
 
 static char ixgbevf_copyright[] =
-	"Copyright (c) 2009 - 2018 Intel Corporation.";
+	"Copyright (c) 2009 - 2024 Intel Corporation.";
 
 static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_82599_vf]	= &ixgbevf_82599_vf_info,
@@ -51,6 +51,8 @@ static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_X550EM_x_vf]	= &ixgbevf_X550EM_x_vf_info,
 	[board_X550EM_x_vf_hv]	= &ixgbevf_X550EM_x_vf_hv_info,
 	[board_x550em_a_vf]	= &ixgbevf_x550em_a_vf_info,
+	[board_e610_vf]         = &ixgbevf_e610_vf_info,
+	[board_e610_vf_hv]      = &ixgbevf_e610_vf_hv_info,
 };
 
 /* ixgbevf_pci_tbl - PCI Device ID Table
@@ -71,6 +73,9 @@ static const struct pci_device_id ixgbevf_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF), board_X550EM_x_vf },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF_HV), board_X550EM_x_vf_hv},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_VF), board_x550em_a_vf },
+	{PCI_VDEVICE_SUB(INTEL, IXGBE_DEV_ID_E610_VF, PCI_ANY_ID,
+			 IXGBE_SUBDEV_ID_E610_VF_HV), board_e610_vf_hv},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_VF), board_e610_vf},
 	/* required last entry */
 	{0, }
 };
@@ -4693,6 +4698,9 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mac_X540_vf:
 		dev_info(&pdev->dev, "Intel(R) X540 Virtual Function\n");
 		break;
+	case ixgbe_mac_e610_vf:
+		dev_info(&pdev->dev, "Intel(R) E610 Virtual Function\n");
+		break;
 	case ixgbe_mac_82599_vf:
 	default:
 		dev_info(&pdev->dev, "Intel(R) 82599 Virtual Function\n");
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 1641d00d8ed3..da7a72ecce7a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #include "vf.h"
 #include "ixgbevf.h"
@@ -1076,3 +1076,13 @@ const struct ixgbevf_info ixgbevf_x550em_a_vf_info = {
 	.mac = ixgbe_mac_x550em_a_vf,
 	.mac_ops = &ixgbevf_mac_ops,
 };
+
+const struct ixgbevf_info ixgbevf_e610_vf_info = {
+	.mac                    = ixgbe_mac_e610_vf,
+	.mac_ops                = &ixgbevf_mac_ops,
+};
+
+const struct ixgbevf_info ixgbevf_e610_vf_hv_info = {
+	.mac            = ixgbe_mac_e610_vf,
+	.mac_ops        = &ixgbevf_hv_mac_ops,
+};
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index b4eef5b6c172..2d791bc26ae4 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef __IXGBE_VF_H__
 #define __IXGBE_VF_H__
@@ -54,6 +54,8 @@ enum ixgbe_mac_type {
 	ixgbe_mac_X550_vf,
 	ixgbe_mac_X550EM_x_vf,
 	ixgbe_mac_x550em_a_vf,
+	ixgbe_mac_e610,
+	ixgbe_mac_e610_vf,
 	ixgbe_num_macs
 };
 
-- 
2.47.1


