Return-Path: <linux-pci+bounces-40789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1081EC4993C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E226188F928
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC68E33B6DC;
	Mon, 10 Nov 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSH/qDu3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE6339B41;
	Mon, 10 Nov 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813789; cv=none; b=hO+PV5FF63PMB/aCwk+UX2XQDqsnY5hjfDOj1vUDk81B9AVA8JJYWe1eDnTZ35zXjQAIXeaEPIR9BqVfKzr+aKiLPde2W/rPIVTKqkdv+GT341btxyTlFKIKwpA5NCG9FWIAPhzMPxUjzn+XXMV67kr0trb9Z0gPedUZq/UuWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813789; c=relaxed/simple;
	bh=WqBmW56nEto4UkhSZTHwBsWNvqFedV083kEiNxjS+bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avi8hSYswXSzXXc8w3JQZQd0YVPWzM7E2+teXgxNsFzvbdGKMT9rRHHtCaqb05j91KDvC4FFMnl2QoH1UqDpGKJUsK6O5aSfx78lM4/lNuRYxqmdg89S40TPvwgAxDup/XMlompVigCNTueHY5cVGlaU1iPuCGSk/8E7ElXS1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSH/qDu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E40FC19423;
	Mon, 10 Nov 2025 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762813788;
	bh=WqBmW56nEto4UkhSZTHwBsWNvqFedV083kEiNxjS+bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSH/qDu3I+WPGt8EIT8/xSvN4JCrzgGTbMVQKq5Rw6TTf1XxdV+laSUjFMCrZDLwO
	 iMuR+S1OXSZOUTHtZ4huQD42ZzR+0ct3iKWsIUPtwgd6Afblq+2pFWPo86I2g+ghGT
	 htoo4KtejYV+UthOuk0uWENhzgFnlkwD+w4pvDAKcx7K7yZD9cIVX+iFZ9WSb983ON
	 gvxu2G5MnUHvzTo+RhXuMns64NMvHukjneoMDXmqaN6X4qagON3Tu2AXA8VxM6m8ZR
	 ++8hkZwDOHDaNk1mvDW2StaTbVnkGXF8leKwg0sYvweG2RW6Z/Lc1oIzyrllPg5Oqm
	 pGbe7LF9aj3eA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>,
	Al <al@datazap.net>,
	Roland <rol7and@gmx.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/4] PCI/ASPM: Cache L0s/L1 Supported so advertised link states can be overridden
Date: Mon, 10 Nov 2025 16:22:25 -0600
Message-ID: <20251110222929.2140564-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110222929.2140564-1-helgaas@kernel.org>
References: <20251110222929.2140564-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Defective devices sometimes advertise support for ASPM L0s or L1 states
even if they don't work correctly.

Cache the L0s Supported and L1 Supported bits early in enumeration so
HEADER quirks can override the ASPM states advertised in Link Capabilities
before pcie_aspm_cap_init() enables ASPM.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 12 ++++--------
 drivers/pci/probe.c     |  7 +++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7cc8281e7011..15d50c089070 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -830,7 +830,6 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
-	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus = parent->subordinate;
 
@@ -845,9 +844,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
 	 */
-	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
-	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
-	if (!(parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPMS))
+	if (!(parent->aspm_l0s_support && child->aspm_l0s_support) &&
+	    !(parent->aspm_l1_support && child->aspm_l1_support))
 		return;
 
 	/* Configure common clock before checking latencies */
@@ -859,8 +857,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * read-only Link Capabilities may change depending on common clock
 	 * configuration (PCIe r5.0, sec 7.5.3.6).
 	 */
-	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
-	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
 	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 
@@ -880,7 +876,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * given link unless components on both sides of the link each
 	 * support L0s.
 	 */
-	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
+	if (parent->aspm_l0s_support && child->aspm_l0s_support)
 		link->aspm_support |= PCIE_LINK_STATE_L0S;
 
 	if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
@@ -889,7 +885,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= PCIE_LINK_STATE_L0S_DW;
 
 	/* Setup L1 state */
-	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
+	if (parent->aspm_l1_support && child->aspm_l1_support)
 		link->aspm_support |= PCIE_LINK_STATE_L1;
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec12..de72ceaea285 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1663,6 +1663,13 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	if (reg32 & PCI_EXP_LNKCAP_DLLLARC)
 		pdev->link_active_reporting = 1;
 
+#ifdef CONFIG_PCIEASPM
+	if (reg32 & PCI_EXP_LNKCAP_ASPM_L0S)
+		pdev->aspm_l0s_support = 1;
+	if (reg32 & PCI_EXP_LNKCAP_ASPM_L1)
+		pdev->aspm_l1_support = 1;
+#endif
+
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
 		return;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..bf97d49c23cf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -412,6 +412,8 @@ struct pci_dev {
 	u16		l1ss;		/* L1SS Capability pointer */
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
+	unsigned int	aspm_l0s_support:1;	/* ASPM L0s support */
+	unsigned int	aspm_l1_support:1;	/* ASPM L1 support */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 #endif
-- 
2.43.0


