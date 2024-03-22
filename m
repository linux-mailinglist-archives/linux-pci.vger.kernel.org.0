Return-Path: <linux-pci+bounces-4994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE74886C4B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 13:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14716287AD4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219BF41A89;
	Fri, 22 Mar 2024 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPnFRZ6A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0CA4437A;
	Fri, 22 Mar 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111216; cv=none; b=Ry+R1eGKqdMWqG4j1r8Xptne41fsQfxmTZ9TtvBREic5a0jQLn2DK/DHd+fxwzHpn9ZMAU0q5fEVdpu+Qvy1fbNCIFAHFf2MF0CKFuy/8Df4a4IppswHiQLq0e5yF6xV6emL2rZO0C8RkNrLz1INbPJFemNDYourq2xnjECPosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111216; c=relaxed/simple;
	bh=sTG3oGcT28yjB3GYKVupqA5b5jiKmf0iw4C3vBTInvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUwsEq2YsCvGNgI3tKu0wXFjvGliHKMa0pnpKjefGuuUGy9j7cKXrr49M4QD8ggHXHXwe3GvwfiiZuKvCODcWL7vL73Hov8sNxgjUEMCn2BMLpq4TBZhV0P9cbtfFFyjlVRrUxxB7XWcVwf0278hSYt55eg+3h/Y+P65thb0VKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPnFRZ6A; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711111214; x=1742647214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTG3oGcT28yjB3GYKVupqA5b5jiKmf0iw4C3vBTInvY=;
  b=CPnFRZ6A45xnuuPPpdsiqSl8ohg5mpe+ytFcxtvv+7byUGcNyyzKn7zy
   PCNcSKyehrPu+09jvV66+YKuc2OXHBcNoPBeQBzb5r8dmSlNO/8/o3KJ3
   QDC/RoudQhpgJI0vXxbugN0NiTFHz+b55cGIEMnPVOTCoDcrTU5d5kuEt
   AyQ/B5DtOUIobiq9sq6b9OHRmnVxz59xtn4hgNh31od1gNLdBKM9ypyCA
   ns26jv35TcmSz1rVarkFfCsSt0lKstQEifmE+Ac3FZMz4D1JkrIh8kCZJ
   uj7fIMvsYtyCRx7vsVOJJEYEPVvEn9SzXiKUGbl1WcNv7DhBV0ViTw+bw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9919057"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="9919057"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="45895504"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:40:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] PCI/ASPM: Consolidate link state defines
Date: Fri, 22 Mar 2024 14:39:51 +0200
Message-Id: <20240322123952.6384-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322123952.6384-1-ilpo.jarvinen@linux.intel.com>
References: <20240322123952.6384-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The linux/pci.h and aspm.c files define own set of link state related
defines which are almost the same.

Consolidate the use of defines into those defined by linux/pci.h and
expand PCIE_LINK_STATE_L0S to match earlier ASPM_STATE_L0S that is
combination of up and down bits. Rename also the defines that are
internal to aspm.c to start with PCIE_LINK_STATE for consistency.

While PCIE_LINK_STATE_L0S BIT(0) -> (BIT(0) | BIT(1)) transformation is
not 1:1, in practice aspm.c already used ASPM_STATE_L0S that has those
both bits enabled except during mapping.

While at it, place the PCIE_LINK_STATE_CLKPM define last to have more
logical grouping.

Use static_assert() to ensure PCIE_LINK_STATE_L0S is strictly equal to
the combination of PCIE_LINK_STATE_L0S_UP/DW.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 153 ++++++++++++++++++++--------------------
 include/linux/pci.h     |  22 +++---
 2 files changed, 88 insertions(+), 87 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2428d278e015..505af49f48de 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -8,6 +8,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/build_bug.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/math.h>
@@ -190,20 +192,17 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 #define MODULE_PARAM_PREFIX "pcie_aspm."
 
 /* Note: those are not register definitions */
-#define ASPM_STATE_L0S_UP	(1)	/* Upstream direction L0s state */
-#define ASPM_STATE_L0S_DW	(2)	/* Downstream direction L0s state */
-#define ASPM_STATE_L1		(4)	/* L1 state */
-#define ASPM_STATE_L1_1		(8)	/* ASPM L1.1 state */
-#define ASPM_STATE_L1_2		(0x10)	/* ASPM L1.2 state */
-#define ASPM_STATE_L1_1_PCIPM	(0x20)	/* PCI PM L1.1 state */
-#define ASPM_STATE_L1_2_PCIPM	(0x40)	/* PCI PM L1.2 state */
-#define ASPM_STATE_L1_SS_PCIPM	(ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1_2_PCIPM)
-#define ASPM_STATE_L1_2_MASK	(ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
-#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
-				 ASPM_STATE_L1_2_MASK)
-#define ASPM_STATE_L0S		(ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)
-#define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
-				 ASPM_STATE_L1SS)
+#define PCIE_LINK_STATE_L0S_UP	BIT(0)	/* Upstream direction L0s state */
+#define PCIE_LINK_STATE_L0S_DW	BIT(1)	/* Downstream direction L0s state */
+static_assert(PCIE_LINK_STATE_L0S == (PCIE_LINK_STATE_L0S_UP | PCIE_LINK_STATE_L0S_DW));
+
+#define PCIE_LINK_STATE_L1_SS_PCIPM	(PCIE_LINK_STATE_L1_1_PCIPM |\
+					 PCIE_LINK_STATE_L1_2_PCIPM)
+#define PCIE_LINK_STATE_L1_2_MASK	(PCIE_LINK_STATE_L1_2 |\
+					 PCIE_LINK_STATE_L1_2_PCIPM)
+#define PCIE_LINK_STATE_L1SS		(PCIE_LINK_STATE_L1_1 |\
+					 PCIE_LINK_STATE_L1_1_PCIPM |\
+					 PCIE_LINK_STATE_L1_2_MASK)
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
@@ -275,10 +274,10 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
 		return 0;
 	case POLICY_POWERSAVE:
 		/* Enable ASPM L0s/L1 */
-		return (ASPM_STATE_L0S | ASPM_STATE_L1);
+		return PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1;
 	case POLICY_POWER_SUPERSAVE:
 		/* Enable Everything */
-		return ASPM_STATE_ALL;
+		return PCIE_LINK_STATE_ASPM_ALL;
 	case POLICY_DEFAULT:
 		return link->aspm_default;
 	}
@@ -581,14 +580,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		latency_dw_l1 = calc_l1_latency(lnkcap_dw);
 
 		/* Check upstream direction L0s latency */
-		if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
+		if ((link->aspm_capable & PCIE_LINK_STATE_L0S_UP) &&
 		    (latency_up_l0s > acceptable_l0s))
-			link->aspm_capable &= ~ASPM_STATE_L0S_UP;
+			link->aspm_capable &= ~PCIE_LINK_STATE_L0S_UP;
 
 		/* Check downstream direction L0s latency */
-		if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
+		if ((link->aspm_capable & PCIE_LINK_STATE_L0S_DW) &&
 		    (latency_dw_l0s > acceptable_l0s))
-			link->aspm_capable &= ~ASPM_STATE_L0S_DW;
+			link->aspm_capable &= ~PCIE_LINK_STATE_L0S_DW;
 		/*
 		 * Check L1 latency.
 		 * Every switch on the path to root complex need 1
@@ -603,9 +602,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * substate latencies (and hence do not do any check).
 		 */
 		latency = max_t(u32, latency_up_l1, latency_dw_l1);
-		if ((link->aspm_capable & ASPM_STATE_L1) &&
+		if ((link->aspm_capable & PCIE_LINK_STATE_L1) &&
 		    (latency + l1_switch_latency > acceptable_l1))
-			link->aspm_capable &= ~ASPM_STATE_L1;
+			link->aspm_capable &= ~PCIE_LINK_STATE_L1;
 		l1_switch_latency += NSEC_PER_USEC;
 
 		link = link->parent;
@@ -741,13 +740,13 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 		child_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
 
 	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
-		link->aspm_support |= ASPM_STATE_L1_1;
+		link->aspm_support |= PCIE_LINK_STATE_L1_1;
 	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
-		link->aspm_support |= ASPM_STATE_L1_2;
+		link->aspm_support |= PCIE_LINK_STATE_L1_2;
 	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
-		link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
+		link->aspm_support |= PCIE_LINK_STATE_L1_1_PCIPM;
 	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
-		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
+		link->aspm_support |= PCIE_LINK_STATE_L1_2_PCIPM;
 
 	if (parent_l1ss_cap)
 		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
@@ -757,15 +756,15 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 				      &child_l1ss_ctl1);
 
 	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
-		link->aspm_enabled |= ASPM_STATE_L1_1;
+		link->aspm_enabled |= PCIE_LINK_STATE_L1_1;
 	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
-		link->aspm_enabled |= ASPM_STATE_L1_2;
+		link->aspm_enabled |= PCIE_LINK_STATE_L1_2;
 	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
-		link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
+		link->aspm_enabled |= PCIE_LINK_STATE_L1_1_PCIPM;
 	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
-		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
+		link->aspm_enabled |= PCIE_LINK_STATE_L1_2_PCIPM;
 
-	if (link->aspm_support & ASPM_STATE_L1_2_MASK)
+	if (link->aspm_support & PCIE_LINK_STATE_L1_2_MASK)
 		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
 }
 
@@ -778,8 +777,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	if (blacklist) {
 		/* Set enabled/disable so that we will disable ASPM later */
-		link->aspm_enabled = ASPM_STATE_ALL;
-		link->aspm_disable = ASPM_STATE_ALL;
+		link->aspm_enabled = PCIE_LINK_STATE_ASPM_ALL;
+		link->aspm_disable = PCIE_LINK_STATE_ASPM_ALL;
 		return;
 	}
 
@@ -814,19 +813,19 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * support L0s.
 	 */
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
-		link->aspm_support |= ASPM_STATE_L0S;
+		link->aspm_support |= PCIE_LINK_STATE_L0S;
 
 	if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
-		link->aspm_enabled |= ASPM_STATE_L0S_UP;
+		link->aspm_enabled |= PCIE_LINK_STATE_L0S_UP;
 	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
-		link->aspm_enabled |= ASPM_STATE_L0S_DW;
+		link->aspm_enabled |= PCIE_LINK_STATE_L0S_DW;
 
 	/* Setup L1 state */
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
-		link->aspm_support |= ASPM_STATE_L1;
+		link->aspm_support |= PCIE_LINK_STATE_L1;
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
-		link->aspm_enabled |= ASPM_STATE_L1;
+		link->aspm_enabled |= PCIE_LINK_STATE_L1;
 
 	aspm_l1ss_init(link);
 
@@ -876,7 +875,7 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	 * If needed, disable L1, and it gets enabled later
 	 * in pcie_config_aspm_link().
 	 */
-	if (enable_req & (ASPM_STATE_L1_1 | ASPM_STATE_L1_2)) {
+	if (enable_req & (PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)) {
 		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
 					   PCI_EXP_LNKCTL_ASPM_L1);
 		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
@@ -884,13 +883,13 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	}
 
 	val = 0;
-	if (state & ASPM_STATE_L1_1)
+	if (state & PCIE_LINK_STATE_L1_1)
 		val |= PCI_L1SS_CTL1_ASPM_L1_1;
-	if (state & ASPM_STATE_L1_2)
+	if (state & PCIE_LINK_STATE_L1_2)
 		val |= PCI_L1SS_CTL1_ASPM_L1_2;
-	if (state & ASPM_STATE_L1_1_PCIPM)
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
 		val |= PCI_L1SS_CTL1_PCIPM_L1_1;
-	if (state & ASPM_STATE_L1_2_PCIPM)
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
 		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
 
 	/* Enable what we need to enable */
@@ -916,29 +915,29 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	state &= (link->aspm_capable & ~link->aspm_disable);
 
 	/* Can't enable any substates if L1 is not enabled */
-	if (!(state & ASPM_STATE_L1))
-		state &= ~ASPM_STATE_L1SS;
+	if (!(state & PCIE_LINK_STATE_L1))
+		state &= ~PCIE_LINK_STATE_L1SS;
 
 	/* Spec says both ports must be in D0 before enabling PCI PM substates*/
 	if (parent->current_state != PCI_D0 || child->current_state != PCI_D0) {
-		state &= ~ASPM_STATE_L1_SS_PCIPM;
-		state |= (link->aspm_enabled & ASPM_STATE_L1_SS_PCIPM);
+		state &= ~PCIE_LINK_STATE_L1_SS_PCIPM;
+		state |= (link->aspm_enabled & PCIE_LINK_STATE_L1_SS_PCIPM);
 	}
 
 	/* Nothing to do if the link is already in the requested state */
 	if (link->aspm_enabled == state)
 		return;
 	/* Convert ASPM state to upstream/downstream ASPM register state */
-	if (state & ASPM_STATE_L0S_UP)
+	if (state & PCIE_LINK_STATE_L0S_UP)
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;
-	if (state & ASPM_STATE_L0S_DW)
+	if (state & PCIE_LINK_STATE_L0S_DW)
 		upstream |= PCI_EXP_LNKCTL_ASPM_L0S;
-	if (state & ASPM_STATE_L1) {
+	if (state & PCIE_LINK_STATE_L1) {
 		upstream |= PCI_EXP_LNKCTL_ASPM_L1;
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
 	}
 
-	if (link->aspm_capable & ASPM_STATE_L1SS)
+	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
 		pcie_config_aspm_l1ss(link, state);
 
 	/*
@@ -947,11 +946,11 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	 * upstream component first and then downstream, and vice
 	 * versa for disabling ASPM L1. Spec doesn't mention L0S.
 	 */
-	if (state & ASPM_STATE_L1)
+	if (state & PCIE_LINK_STATE_L1)
 		pcie_config_aspm_dev(parent, upstream);
 	list_for_each_entry(child, &linkbus->devices, bus_list)
 		pcie_config_aspm_dev(child, dwstream);
-	if (!(state & ASPM_STATE_L1))
+	if (!(state & PCIE_LINK_STATE_L1))
 		pcie_config_aspm_dev(parent, upstream);
 
 	link->aspm_enabled = state;
@@ -1347,18 +1346,18 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	if (state & PCIE_LINK_STATE_L0S)
-		link->aspm_disable |= ASPM_STATE_L0S;
+		link->aspm_disable |= PCIE_LINK_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
 		/* L1 PM substates require L1 */
-		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+		link->aspm_disable |= PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS;
 	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_disable |= ASPM_STATE_L1_1;
+		link->aspm_disable |= PCIE_LINK_STATE_L1_1;
 	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_disable |= ASPM_STATE_L1_2;
+		link->aspm_disable |= PCIE_LINK_STATE_L1_2;
 	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_disable |= ASPM_STATE_L1_1_PCIPM;
+		link->aspm_disable |= PCIE_LINK_STATE_L1_1_PCIPM;
 	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_disable |= ASPM_STATE_L1_2_PCIPM;
+		link->aspm_disable |= PCIE_LINK_STATE_L1_2_PCIPM;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	if (state & PCIE_LINK_STATE_CLKPM)
@@ -1416,18 +1415,18 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 	mutex_lock(&aspm_lock);
 	link->aspm_default = 0;
 	if (state & PCIE_LINK_STATE_L0S)
-		link->aspm_default |= ASPM_STATE_L0S;
+		link->aspm_default |= PCIE_LINK_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		link->aspm_default |= ASPM_STATE_L1;
+		link->aspm_default |= PCIE_LINK_STATE_L1;
 	/* L1 PM substates require L1 */
 	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
+		link->aspm_default |= PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
+		link->aspm_default |= PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
+		link->aspm_default |= PCIE_LINK_STATE_L1_1_PCIPM | PCIE_LINK_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
+		link->aspm_default |= PCIE_LINK_STATE_L1_2_PCIPM | PCIE_LINK_STATE_L1;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
@@ -1563,12 +1562,12 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 	if (state_enable) {
 		link->aspm_disable &= ~state;
 		/* need to enable L1 for substates */
-		if (state & ASPM_STATE_L1SS)
-			link->aspm_disable &= ~ASPM_STATE_L1;
+		if (state & PCIE_LINK_STATE_L1SS)
+			link->aspm_disable &= ~PCIE_LINK_STATE_L1;
 	} else {
 		link->aspm_disable |= state;
-		if (state & ASPM_STATE_L1)
-			link->aspm_disable |= ASPM_STATE_L1SS;
+		if (state & PCIE_LINK_STATE_L1)
+			link->aspm_disable |= PCIE_LINK_STATE_L1SS;
 	}
 
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
@@ -1582,12 +1581,12 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 #define ASPM_ATTR(_f, _s)						\
 static ssize_t _f##_show(struct device *dev,				\
 			 struct device_attribute *attr, char *buf)	\
-{ return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_##_s); }	\
+{ return aspm_attr_show_common(dev, attr, buf, PCIE_LINK_STATE_##_s); }	\
 									\
 static ssize_t _f##_store(struct device *dev,				\
 			  struct device_attribute *attr,		\
 			  const char *buf, size_t len)			\
-{ return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_##_s); }
+{ return aspm_attr_store_common(dev, attr, buf, len, PCIE_LINK_STATE_##_s); }
 
 ASPM_ATTR(l0s_aspm, L0S)
 ASPM_ATTR(l1_aspm, L1)
@@ -1654,12 +1653,12 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 	static const u8 aspm_state_map[] = {
-		ASPM_STATE_L0S,
-		ASPM_STATE_L1,
-		ASPM_STATE_L1_1,
-		ASPM_STATE_L1_2,
-		ASPM_STATE_L1_1_PCIPM,
-		ASPM_STATE_L1_2_PCIPM,
+		PCIE_LINK_STATE_L0S,
+		PCIE_LINK_STATE_L1,
+		PCIE_LINK_STATE_L1_1,
+		PCIE_LINK_STATE_L1_2,
+		PCIE_LINK_STATE_L1_1_PCIPM,
+		PCIE_LINK_STATE_L1_2_PCIPM,
 	};
 
 	if (aspm_disabled || !link)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..4c46ccb28b98 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1821,17 +1821,19 @@ extern bool pcie_ports_native;
 #define pcie_ports_native	false
 #endif
 
-#define PCIE_LINK_STATE_L0S		BIT(0)
-#define PCIE_LINK_STATE_L1		BIT(1)
-#define PCIE_LINK_STATE_CLKPM		BIT(2)
-#define PCIE_LINK_STATE_L1_1		BIT(3)
-#define PCIE_LINK_STATE_L1_2		BIT(4)
-#define PCIE_LINK_STATE_L1_1_PCIPM	BIT(5)
-#define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)
-#define PCIE_LINK_STATE_ALL		(PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
-					 PCIE_LINK_STATE_CLKPM | PCIE_LINK_STATE_L1_1 |\
-					 PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
+#define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstream & downstream L0s */
+#define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
+#define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
+#define PCIE_LINK_STATE_L1_2		BIT(4)	/* ASPM L1.2 state */
+#define PCIE_LINK_STATE_L1_1_PCIPM	BIT(5)	/* PCI PM L1.1 state */
+#define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)	/* PCI PM L1.2 state */
+#define PCIE_LINK_STATE_ASPM_ALL	(PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
+					 PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2 |\
+					 PCIE_LINK_STATE_L1_1_PCIPM |\
 					 PCIE_LINK_STATE_L1_2_PCIPM)
+#define PCIE_LINK_STATE_CLKPM		BIT(7)
+#define PCIE_LINK_STATE_ALL		(PCIE_LINK_STATE_ASPM_ALL |\
+					 PCIE_LINK_STATE_CLKPM)
 
 #ifdef CONFIG_PCIEASPM
 int pci_disable_link_state(struct pci_dev *pdev, int state);
-- 
2.39.2


