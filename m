Return-Path: <linux-pci+bounces-19745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACCFA10D1E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5634188B246
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637CE1B21AD;
	Tue, 14 Jan 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMThInhw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE671E764A;
	Tue, 14 Jan 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874585; cv=none; b=YNEzIeP//n0MFZ6OegIsilp7WmHObaYqe0I2/EyILQo8RR8j0NxTqLvgv0HqDxuijJYMyld29laZ/ZPA7/Em2I5Z9Vj4MSMpCr+lxHRA25PIlfRtgi2yAG/PwZOiBgBioKMDDai+WtB9ENQkL833BYI2H7EBVCt/uHkCk6ADL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874585; c=relaxed/simple;
	bh=xfucf1IHbZ4J/bbDFdaj8IaKMFHeHg6WaCRkiKtYejM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swLP7QJ3fiJiczNSqRygxO7FPaPmldLNg9h6sSGQR38wPUbtwN1JA5oqEKWbqNAr8BQ6gEKJYT5vCFvIIPO+ddNLR5UheeLtJvgpBHq3hu+lTp31l9kTfo3zlqwsB25nnNgMoK/VI1Fx9cW+PcYPnu9IZ3xzDtpe4s+GLSLeFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMThInhw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874584; x=1768410584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xfucf1IHbZ4J/bbDFdaj8IaKMFHeHg6WaCRkiKtYejM=;
  b=VMThInhwnUan69Pd9w1XGgQOtpNoRQpGb2Jx78DQA1SGmCoucKaSffVz
   3cgSb9MqfiqEjB4TvBHrT6vjlbsmNNAvkCcZvMEsftRCnU1Aphu2TJNUw
   hTUXY7rdUaVG5kTJSSU7Jp/trsCuxaSuDJSHUCpIg44WQlsY51Y46YcOt
   cl10AW9nGPWPdb3/s3uGYFiz9gfN3onxiSEw7gBkW8HguUm1+fFmZsvRk
   XYEnAKmTKO9WL2/j3tfE39gsDcZrb0TRJrGnK/SH38j5jlUpLBZrUOaSj
   Pp6NZ3/lcXv473dxsx2LT8mwxGQzNARFbdV7A3xkp87FTh/GCLl5RGhBI
   w==;
X-CSE-ConnectionGUID: dYxr5F1+TKeSB5Yy/+A0EA==
X-CSE-MsgGUID: wt9YhCe5T6u/qh7sdZlSyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36465845"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="36465845"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:09:43 -0800
X-CSE-ConnectionGUID: ylfVDdFcReOegH+ez9MdgQ==
X-CSE-MsgGUID: eI9O7YRUTI2BuEW7kFNr5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105452796"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:09:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 6/8] PCI: Store # of supported End-End TLP Prefixes
Date: Tue, 14 Jan 2025 19:08:38 +0200
Message-Id: <20250114170840.1633-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
References: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
are supported by the path or not, the value is only calculated if
CONFIG_PCI_PASID is set.

The Max End-End TLP Prefixes field in the Device Capabilities Register
2 also tells how many (1-4) End-End TLP Prefixes are supported (PCIe
r6.2 sec 7.5.3.15). The number of supported End-End Prefixes is useful
for reading correct number of DWORDs from TLP Prefix Log register in AER
capability (PCIe r6.2 sec 7.8.4.12).

Replace eetlp_prefix_path with eetlp_prefix_max and determine the
number of supported End-End Prefixes regardless of CONFIG_PCI_PASID so
that an upcoming commit generalizing TLP Prefix Log register reading
does not have to read extra DWORDs for End-End Prefixes that never will
be there.

The value stored into eetlp_prefix_max is directly derived from
device's Max End-End TLP Prefixes and does not consider limitations
imposed by bridges or the Root Port beyond supported/not supported
flags. This is intentional for two reasons:

  1) PCIe r6.2 spec sections r6.1 2.2.10.4 & 6.2.4.4 indicate that TLP
  is handled malformed only if the number of prefixes exceed the number
  of Max End-End TLP Prefixes, which seems to be the case even if the
  device could never receive that many prefixes due to smaller maximum
  imposed by a bridge or the Root Port. If TLP parsing is later added,
  this distinction is significant in interpreting what is logged by the
  TLP Prefix Log registers and the value matching to the Malformed TLP
  threshold is going to be more useful.

  2) TLP Prefix handling happens autonomously on a low layer and the
  value in eetlp_prefix_max is not programmed anywhere by the kernel
  (i.e., there is no limiter OS can control to prevent sending more
  than n TLP Prefixes).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/pci/ats.c             |  2 +-
 drivers/pci/probe.c           | 14 +++++++++-----
 include/linux/pci.h           |  2 +-
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 6afff1f1b143..c6b266c772c8 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -410,7 +410,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
+	if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..381c22e3ccdb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2251,8 +2251,8 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 
 static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCI_PASID
 	struct pci_dev *bridge;
+	unsigned int eetlp_max;
 	int pcie_type;
 	u32 cap;
 
@@ -2264,15 +2264,19 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 		return;
 
 	pcie_type = pci_pcie_type(dev);
+
+	eetlp_max = FIELD_GET(PCI_EXP_DEVCAP2_EE_PREFIX_MAX, cap);
+	/* 00b means 4 */
+	eetlp_max = eetlp_max ?: 4;
+
 	if (pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
 	    pcie_type == PCI_EXP_TYPE_RC_END)
-		dev->eetlp_prefix_path = 1;
+		dev->eetlp_prefix_max = eetlp_max;
 	else {
 		bridge = pci_upstream_bridge(dev);
-		if (bridge && bridge->eetlp_prefix_path)
-			dev->eetlp_prefix_path = 1;
+		if (bridge && bridge->eetlp_prefix_max)
+			dev->eetlp_prefix_max = eetlp_max;
 	}
-#endif
 }
 
 static void pci_configure_serr(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eef..21be5a1edf1a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -407,7 +407,7 @@ struct pci_dev {
 					   supported from root to here */
 #endif
 	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
-	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
+	unsigned int	eetlp_prefix_max:3;	/* Max # of End-End TLP Prefixes, 0=not supported */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7ed5fab..14a6306c4ce1 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -665,6 +665,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX_MAX	0x00c00000 /* Max End-End TLP Prefixes */
 #define PCI_EXP_DEVCTL2		0x28	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
-- 
2.39.5


