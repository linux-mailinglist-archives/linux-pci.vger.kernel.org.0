Return-Path: <linux-pci+bounces-6306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE18A633D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 07:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9BDB21C04
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC9D3B2A1;
	Tue, 16 Apr 2024 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVc6c6sV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8B539C;
	Tue, 16 Apr 2024 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246742; cv=none; b=g0jmJVBSplV/erwhTgCaxGy4eBwL9kvrLxOgaHmY+RsanKpI5NNGGm9pyimpNZHKGD/g5o+2ygjVjucS5wKXPjr8A1eynwz0BrfXu8ton8+uxo1bUHbk32pn90+vStOGGXVuRHFFe6wvESDFHt9ZcxtuOdvsjcVnjKlkeYV3Se8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246742; c=relaxed/simple;
	bh=rYtvgcjAY58+B3BGDANfkQN4/Z8fGaWlixcG4jUdpdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrnhoIeMs+2UE2lqBuJhbZ1aKDW8bO6+djEQ5jvHI80LUdhsf1uwdW4vAR8aJAYhASXhwQBP63v86OH+l/VRWffP80izTxjr8rAuiSqtHAiJ+pQ3WlR2n/LhJzotwt491KYlHiUgYTcKf7UcC/8wW+xGRopt6OC/EPm3mm6+kmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVc6c6sV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713246741; x=1744782741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rYtvgcjAY58+B3BGDANfkQN4/Z8fGaWlixcG4jUdpdw=;
  b=TVc6c6sVoZg9EmPUo7SnQsTIrJUWj/bpethBv/UG5vEW0Ik8eIvwrjaj
   YTIEQUFw4ESdLLSMr0jwZUWkGt2r/xMM2Js6tJnZVCUJAVcuMgMFtmH6U
   iMVGkme6Orvfr+dxvxXsIioCAMsgMvHFi/uNX5vEJdxErKBzwp1BfApst
   FwgrhDOiqMoxQxitqKMDLzoOoQNhsnSj1IMcsTjgvX7vkvLawo1tmxy71
   k1jHDaeXzV3hrtq5M9MJqmUKSM//n05E+Y0xBZFeG2Q5jpHsvjcCUE5s4
   iuJXRUtLsxOGw566kMxNytBKjiqVNgeZdZVr5rUVQXb7kbBCNkFUDBb/l
   Q==;
X-CSE-ConnectionGUID: jLYzQdLRSTK8oJEG+ofHfA==
X-CSE-MsgGUID: bdS0aOjwTKGQqgpdACoUyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8526697"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8526697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:52:20 -0700
X-CSE-ConnectionGUID: kiYzeiKRTQeGeWLx8Um2cw==
X-CSE-MsgGUID: OSEm3P45RyyKyoFFmmJB3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26937659"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:52:20 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v1] PCI/AER: Update aer-inject tool source URL
Date: Tue, 16 Apr 2024 05:50:35 +0000
Message-Id: <20240416055035.200085-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aer-inject tool is no longer maintained in the original repository
and is missing a fix related to the musl library. So, with the author's
(Huang Ying) consent, it has been moved to a new repository [1]. All
references to the repository link have been updated.

Link: https://github.com/intel/aer-inject.git [1]
CC: Huang Ying <ying.huang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 Documentation/PCI/pcieaer-howto.rst | 2 +-
 drivers/pci/pcie/Kconfig            | 2 +-
 drivers/pci/pcie/aer_inject.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index e00d63971695..f013f3b27c82 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -241,7 +241,7 @@ After reboot with new kernel or insert the module, a device file named
 Then, you need a user space tool named aer-inject, which can be gotten
 from:
 
-    https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
+    https://github.com/intel/aer-inject.git
 
 More information about aer-inject can be found in the document in
 its source code.
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 8999fcebde6a..17919b99fa66 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -47,7 +47,7 @@ config PCIEAER_INJECT
 	  error injection can fake almost all kinds of errors with the
 	  help of a user space helper tool aer-inject, which can be
 	  gotten from:
-	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
+	     https://github.com/intel/aer-inject.git
 
 config PCIEAER_CXL
 	bool "PCI Express CXL RAS support"
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 2dab275d252f..f81b2303bf6a 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -6,7 +6,7 @@
  * trigger various real hardware errors. Software based error
  * injection can fake almost all kinds of errors with the help of a
  * user space helper tool aer-inject, which can be gotten from:
- *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
+ *   https://github.com/intel/aer-inject.git
  *
  * Copyright 2009 Intel Corporation.
  *     Huang Ying <ying.huang@intel.com>
-- 
2.25.1


