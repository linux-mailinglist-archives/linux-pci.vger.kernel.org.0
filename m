Return-Path: <linux-pci+bounces-40535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A3C3D156
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FEFD4E42A4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC94A350D5B;
	Thu,  6 Nov 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlLRgdsP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7960350D5D;
	Thu,  6 Nov 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454213; cv=none; b=VrX5B/PtKl8lVauv1LOMTQjsFdbm0SyrMajX+sCmYwWdVE7ANkE8x83U54f05SUG6mfPky3nNU8veU5PHtYPr5CS8HUpIhCTzEl4o4BVFDjkyjQKYRL2OYN+CWbnxhxYPU3uGg3htHOzl59U+r28TQ053P++8vpdTv1hC6vu0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454213; c=relaxed/simple;
	bh=2Cc8x0MTOrIRU3jKRRfaZH/Bk7l6V/9O0wns+z+sth8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwzi4zu8zg0q4djiUceN3nDq41BA6mLLFSf2+3wl6uiPOXym0E/svlTHEsvE7icZtnMU9G2o5/w4v09Slmv4M8rInazkde5nlXfuUGzwwJz8793NgO0fimIkJmWEUf3/o5b7RDd6ku2g1EjCve4ZaUB25X9eBvM82pdFdNyfeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlLRgdsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1DDC16AAE;
	Thu,  6 Nov 2025 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762454212;
	bh=2Cc8x0MTOrIRU3jKRRfaZH/Bk7l6V/9O0wns+z+sth8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlLRgdsPtYwxbIpiQT6oNQY3K5ClZN/VZzDOfOl2peGFQcX7jS45JoVwLl2qlez29
	 vSQXevpveS+evrnr4g8JQOsij8NWAHJUTiMVmHiM794y8pCyFvuR/yZiKfHugjMEms
	 xSCRUu9Wfs+uYi3Zg+Gdg66qHB1Alf5gozRxr6umLGZJdJPjx/vQ59QENSYD9BIsEw
	 sIvbUeQqLOsvwK6sH+QCERUX5ytsonL6TOQK0FpyIpIfMKJNvONUHhxqFkY/v1P5Ep
	 j6UpIgC6gPbjjP33kY2C1aIY5/RcOMUN7lyI/BJViM+Hr/N8BjCODTyHBE9wLze1Xn
	 pLcTMvxpg3GBA==
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
Subject: [PATCH 1/2] PCI/ASPM: Cache Link Capabilities so quirks can override them
Date: Thu,  6 Nov 2025 12:36:38 -0600
Message-ID: <20251106183643.1963801-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106183643.1963801-1-helgaas@kernel.org>
References: <20251106183643.1963801-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Cache the PCIe Link Capabilities register in struct pci_dev so quirks can
remove features to avoid hardware defects.  The idea is:

  - set_pcie_port_type() reads PCIe Link Capabilities and caches it in
    dev->lnkcap

  - HEADER quirks can update the cached dev->lnkcap to remove advertised
    features that don't work correctly

  - pcie_aspm_cap_init() relies on dev->lnkcap and ignores any features not
    advertised there

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++---------------------
 drivers/pci/probe.c     |  5 ++---
 include/linux/pci.h     |  1 +
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7cc8281e7011..07536891f1f6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -391,15 +391,13 @@ static void pcie_clkpm_override_default_link_state(struct pcie_link_state *link,
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	int capable = 1, enabled = 1;
-	u32 reg32;
 	u16 reg16;
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
 
 	/* All functions should have the same cap and state, take the worst */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
-		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
+		if (!(child->lnkcap & PCI_EXP_LNKCAP_CLKPM)) {
 			capable = 0;
 			enabled = 0;
 			break;
@@ -581,7 +579,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, encoding, lnkcap_up, lnkcap_dw;
+	u32 latency, encoding;
 	u32 l1_switch_latency = 0, latency_up_l0s;
 	u32 latency_up_l1, latency_dw_l0s, latency_dw_l1;
 	u32 acceptable_l0s, acceptable_l1;
@@ -606,14 +604,10 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		struct pci_dev *dev = pci_function_0(link->pdev->subordinate);
 
 		/* Read direction exit latencies */
-		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP,
-					   &lnkcap_up);
-		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP,
-					   &lnkcap_dw);
-		latency_up_l0s = calc_l0s_latency(lnkcap_up);
-		latency_up_l1 = calc_l1_latency(lnkcap_up);
-		latency_dw_l0s = calc_l0s_latency(lnkcap_dw);
-		latency_dw_l1 = calc_l1_latency(lnkcap_dw);
+		latency_up_l0s = calc_l0s_latency(link->pdev->lnkcap);
+		latency_up_l1 = calc_l1_latency(link->pdev->lnkcap);
+		latency_dw_l0s = calc_l0s_latency(dev->lnkcap);
+		latency_dw_l1 = calc_l1_latency(dev->lnkcap);
 
 		/* Check upstream direction L0s latency */
 		if ((link->aspm_capable & PCIE_LINK_STATE_L0S_UP) &&
@@ -830,7 +824,7 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
-	u32 parent_lnkcap, child_lnkcap;
+	u32 lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus = parent->subordinate;
 
@@ -845,9 +839,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
 	 */
-	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
-	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
-	if (!(parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPMS))
+	if (!(parent->lnkcap & child->lnkcap & PCI_EXP_LNKCAP_ASPMS))
 		return;
 
 	/* Configure common clock before checking latencies */
@@ -857,10 +849,18 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * Re-read upstream/downstream components' register state after
 	 * clock configuration.  L0s & L1 exit latencies in the otherwise
 	 * read-only Link Capabilities may change depending on common clock
-	 * configuration (PCIe r5.0, sec 7.5.3.6).
+	 * configuration (PCIe r5.0, sec 7.5.3.6).  Update only the exit
+	 * latencies in the cached dev->lnkcap because quirks may have
+	 * removed broken features advertised by the device.
 	 */
-	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
-	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &lnkcap);
+	parent->lnkcap &= ~(PCI_EXP_LNKCAP_L0SEL | PCI_EXP_LNKCAP_L1EL);
+	parent->lnkcap |= lnkcap & (PCI_EXP_LNKCAP_L0SEL | PCI_EXP_LNKCAP_L1EL);
+
+	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &lnkcap);
+	child->lnkcap &= ~(PCI_EXP_LNKCAP_L0SEL | PCI_EXP_LNKCAP_L1EL);
+	child->lnkcap |= lnkcap & (PCI_EXP_LNKCAP_L0SEL | PCI_EXP_LNKCAP_L1EL);
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
 	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 
@@ -880,7 +880,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * given link unless components on both sides of the link each
 	 * support L0s.
 	 */
-	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
+	if (parent->lnkcap & child->lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
 		link->aspm_support |= PCIE_LINK_STATE_L0S;
 
 	if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
@@ -889,7 +889,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= PCIE_LINK_STATE_L0S_DW;
 
 	/* Setup L1 state */
-	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
+	if (parent->lnkcap & child->lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
 		link->aspm_support |= PCIE_LINK_STATE_L1;
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec12..db4635b1ec47 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1640,7 +1640,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
 {
 	int pos;
 	u16 reg16;
-	u32 reg32;
 	int type;
 	struct pci_dev *parent;
 
@@ -1659,8 +1658,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
 	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
 
-	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &reg32);
-	if (reg32 & PCI_EXP_LNKCAP_DLLLARC)
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &pdev->lnkcap);
+	if (pdev->lnkcap & PCI_EXP_LNKCAP_DLLLARC)
 		pdev->link_active_reporting = 1;
 
 	parent = pci_upstream_bridge(pdev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..ec4133ae9cae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -361,6 +361,7 @@ struct pci_dev {
 	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
 	u32		devcap;		/* PCIe Device Capabilities */
+	u32		lnkcap;		/* PCIe Link Capabilities */
 	u16		rebar_cap;	/* Resizable BAR capability offset */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
-- 
2.43.0


