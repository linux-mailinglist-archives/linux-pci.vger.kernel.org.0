Return-Path: <linux-pci+bounces-7334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6239F8C21AA
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43111F238B0
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B388165FDB;
	Fri, 10 May 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXO54RaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFA165FC4;
	Fri, 10 May 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335706; cv=none; b=YaL91t5IpmXUgp07fwVJa4IdIlwI87JCs+rxyp7KJaUXGh2Df5Kka/r81IE1wvCelfSiqwj0X2CjvdGkx0GqJStMxMnUoHTB1CfWV9hTkIGdu12WTHVQFJWRG5bUC0Ue3zF/r246R/ZPUEgbV+46xQf0XOxIRwnxZho+rV6vo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335706; c=relaxed/simple;
	bh=ycAlJAFDIexTuV0gkyQkoIj4+wwZGM3l2xmJQx719nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3Uhwcvpu2WXlXoyArAGf8+oGZqc8Gxv13igdSM1jQax/yi3YDnavK0P3Lc8cO160KeuvtNusWTVJ6M1RU99hC/9DsHmOXOu6URxl7ufDSpvNX5BiKOc2XRWi2aQeq1s/lsxm54UysorIn7nrLqlwnUcK38KK2iP1vFzquiWXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXO54RaS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715335705; x=1746871705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycAlJAFDIexTuV0gkyQkoIj4+wwZGM3l2xmJQx719nA=;
  b=ZXO54RaSHwSxyReEQ7JuZSJXDe8h2Obz1L0iIXVu/AKjdZpxVg53mqKF
   4hzyBS+fpjbDMWcFBohARhLZ0ZSFhivoe3NLDqPRWogOCcDaiimUN6RuP
   ADHBXKI8hAquoXc/dVYSk4+GtXKjsaFA1V8VOMiW5KlQe5kdSeW9sL4lx
   1mX7oWIAy9uBvXZN3gTZLUpEXHQ9i/58hXUgD3ZMSuAo29MUqsg6BZN4F
   XHOME3PZJNyrwNt62q/NJ1q9oH1+QSsASnJSsvIsRe8n3NT5fLkXlFaR+
   b/rvJwfPrZ79VA2VE0vT2Y7yLVDtaBz5/tFSQ30iKbwEzAbBqc5eDR68Z
   A==;
X-CSE-ConnectionGUID: BMtCfJ4hQ/OSFxPa3QOPjg==
X-CSE-MsgGUID: Mw797VzwSeWwfxSjyomkPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21884188"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21884188"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:08:23 -0700
X-CSE-ConnectionGUID: rFfR3aNcREWrwsQpH8kLlA==
X-CSE-MsgGUID: ikeVDMsfRKOQLAyZAug4qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="30125306"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:08:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 5/7] PCI: Store # of supported End-End TLP Prefixes
Date: Fri, 10 May 2024 13:07:28 +0300
Message-Id: <20240510100730.18805-6-ilpo.jarvinen@linux.intel.com>
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

eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
are supported by the path or not, the value is only calculated if
CONFIG_PCI_PASID is set.

The Max End-End TLP Prefixes field in the Device Capabilities Register
2 also tells how many (1-4) End-End TLP Prefixes are supported (PCIe r6
sec 7.5.3.15). The number of supported End-End Prefixes is useful for
reading correct number of DWORDs from TLP Prefix Log register in AER
capability (PCIe r6 sec 7.8.4.12).

Replace eetlp_prefix_path with eetlp_prefix_max and determine the
number of supported End-End Prefixes regardless of CONFIG_PCI_PASID so
that an upcoming commit generalizing TLP Prefix Log register reading
does not have to read extra DWORDs for End-End Prefixes that never will
be there.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/ats.c             |  2 +-
 drivers/pci/probe.c           | 14 +++++++++-----
 include/linux/pci.h           |  2 +-
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c570892b2090..e13433dcfc82 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -377,7 +377,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
+	if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..02035b005a53 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2211,8 +2211,8 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 
 static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCI_PASID
 	struct pci_dev *bridge;
+	unsigned int eetlp_max;
 	int pcie_type;
 	u32 cap;
 
@@ -2224,15 +2224,19 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
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
index 16493426a04f..29c51325b1d9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -397,7 +397,7 @@ struct pci_dev {
 					   supported from root to here */
 #endif
 	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
-	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
+	unsigned int	eetlp_prefix_max:3;	/* Max # of End-End TLP Prefixes, 0=not supported */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..09e0c300c952 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -661,6 +661,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX_MAX	0x00c00000 /* Max End-End TLP Prefixes */
 #define PCI_EXP_DEVCTL2		0x28	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
-- 
2.39.2


