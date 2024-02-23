Return-Path: <linux-pci+bounces-3943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B222E861DAD
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9C51F27FA8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B1143C7B;
	Fri, 23 Feb 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g89yUTeP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58313B7A6;
	Fri, 23 Feb 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720514; cv=none; b=GljNobDfvs8+hgoFv/4CubmPtZDGeFRN3Q2enXzmqg1HnmNGl02IlySxRWhvbEnEg+ke+RC1gMBFTIkMUOvafwflgYBwRRU7iHiuUH0lvaJL21Ryk1bUQjMXeQjMRsp8WeE7rhfYnisQ0kG/qo/aEmgD+sXTtDenGh0yH9r0L1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720514; c=relaxed/simple;
	bh=7BQSc2cmfATswOeFfQC9zLfVbFnudPwYYzS+AWBPuPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c9y0ZaycO09IsrccDOES1aN27KvalLX+Lv3nlS5pbTN2aqi9+UbxJgy5k9qSiLhjibb3cPAhjX6Bp6mhL0glwU5o02GjYDNvigr47rFi3UxIZIGPT+iVQi3el6KIsebyPCr9GGbPQ+3jF3ISh6rMf2w5wlQCsr3CcuqYzNJ+MWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g89yUTeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0569C433F1;
	Fri, 23 Feb 2024 20:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708720514;
	bh=7BQSc2cmfATswOeFfQC9zLfVbFnudPwYYzS+AWBPuPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g89yUTePWhkUvcxPW1Db3UVZxwlThZJTC1FcHJqvnEbsBzJlCc17lToYOfnxALO/y
	 GNgNYg7hHoLMQFhJlbatOMA8EVoCwmIHFWVqY3lRAB74qx8cxitIeH0FzjE3AE/Uyd
	 13ieLnrg9JJpldpWNn/SMeyMExWip0pCy2Za5icSW05f07kcvrwqxTHcKGphZXpc/B
	 EAcDJTi9/GKBe6DWZJBgLD5wbRNx+F8y0hBkwOgmE/9DtIpriQ29bwU1Mb4RbQ7pB1
	 0+zUn3VhJLqKuRgsw9wqpZUpD+3VomAwa4qsoQMQ/lzyRMbuZPaXx34JSvFNk5FwMu
	 ua1h8OsU5wvLQ==
Date: Fri, 23 Feb 2024 14:35:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: mika.westerberg@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com, rjw@rjwysocki.net, tasev.stefanoska@skynet.be,
	enriquezmark36@gmail.com, kernel@witt.link, wse@tuxedocomputers.com,
	vidyas@nvidia.com, kai.heng.feng@canonical.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, ricky_wu@realtek.com,
	mario.limonciello@amd.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Always build aspm.c
Message-ID: <20240223203512.GA112491@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129234627.GA487749@bhelgaas>

On Mon, Jan 29, 2024 at 05:46:27PM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 28, 2024 at 03:32:07PM -0800, David E. Box wrote:
> > Here is the series to always build aspm.c, add back L1SS save/restore, and
> > consolidate all ASPM related code in aspm.c.
> > 
> > Patch 1 - Moves all PCI core functions running under CONFIG_PCIEASPM into
> > aspm.c and changes they Makefile to always build it. No functional changes.
> > 
> > Patch 2 - Creates a separate function to save the L1SS offset and places it
> > outside of CONFIG_PCIEASPM in aspm.c so that the offset is available for
> > later use by the L1SS save/restore code which needs to run when
> > CONFIG_PCIEASPM=n.
> > 
> > Patch 3 - Updated L1 Substate save/restore patch from previous V5 [1].
> > 
> > Patch 4 - Moves the LTR save/restore state functions into aspm.c outside of
> > CONFIG_PCIEASPM.
> > 
> > Patch 5 - Moves the LTR save/restore state calls into
> > pci_save/restore_pcie_state().
> > 
> > The series does not continue any of the ASPM robustness changes proposed by
> > Ilpo [2]. But if we think it's worth combining with this series I can
> > add it and help continue the work.
> > 
> > [1] https://lore.kernel.org/linux-pci/20231221011250.191599-1-david.e.box@linux.intel.com/
> > [2] https://lore.kernel.org/linux-pci/20230918131103.24119-1-ilpo.jarvinen@linux.intel.com/
> > 
> > David E. Box (5):
> >   PCI: Always build aspm.c
> >   PCI: Create function to save L1SS offset
> >   PCI/ASPM: Add back L1 PM Substate save and restore
> >   PCI: Move pci_save/restore_ltr_state() to aspm.c
> >   PCI: Call LTR save/restore state from PCIe save/restore
> > 
> >  drivers/pci/pci.c         |  91 ++++----------
> >  drivers/pci/pci.h         |  10 +-
> >  drivers/pci/pcie/Makefile |   2 +-
> >  drivers/pci/pcie/aspm.c   | 257 ++++++++++++++++++++++++++++++++++++--
> >  drivers/pci/probe.c       |  62 +--------
> >  include/linux/pci.h       |   4 +-
> >  6 files changed, 283 insertions(+), 143 deletions(-)
> > 
> > 
> > base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> 
> Rebased to v6.8-rc1 and applied to pci/aspm for v6.9, thanks!

I reworked this to accommodate Vidya's "Update saved buffers with
latest ASPM configuration" patch:
https://lore.kernel.org/r/20230125133830.20620-1-vidyas@nvidia.com

It ended up being more work than I expected.  The interdiff is below,
and I put this and Vidya's patch on a pci/aspm-rework branch
temporarily so we can take a look before saying it's done:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=aspm-rework

The main changes are:

  - Rename pci_save_aspm_state() to pci_save_aspm_l1ss_state() (this
    is the main thing for Vidya's patch).

  - Rename pcie_restore_aspm_l1ss() to pci_restore_aspm_l1ss_state()
    to match.

  - Move the PCI_EXP_LNKCTL_ASPMC from pci_restore_aspm_state() to
    pci_restore_pcie_state() so both writes are in the same place.

  - Rename pci_aspm_get_l1ss() to pci_configure_aspm_l1ss() and add
    the save_buffer there as well.

  - Split [1/5] into two patches: move pci_configure_ltr() and
    pci_bridge_reconfigure_ltr() to aspm.c, and build aspm.c
    unconditionally.

  - Squash [2/5] and [3/5] since [2/5] didn't add any functionality
    itself so they seem like a single logical change.

Let me know if you spot anything that I broke.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 00139fad1827..4ea98665172d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1623,7 +1623,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
 	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
 
-	pci_save_aspm_state(dev);
+	pci_save_aspm_l1ss_state(dev);
 	pci_save_ltr_state(dev);
 
 	return 0;
@@ -1633,11 +1633,11 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	int i = 0;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap, val;
+	u16 *cap, lnkctl;
 
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
-	 * LTR itself (in the PCIe capability).
+	 * LTR itself in PCI_EXP_DEVCTL2.
 	 */
 	pci_restore_ltr_state(dev);
 
@@ -1655,19 +1655,22 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	cap = (u16 *)&save_state->cap.data[0];
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
 
-	/*
-	 * Restore only the LNKCTL register with the ASPM control field
-	 * clear. ASPM will be restored in pci_restore_aspm_state().
-	 */
-	val = cap[i++] & ~PCI_EXP_LNKCTL_ASPMC;
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
+	/* Restore LNKCTL register with ASPM control field clear */
+	lnkctl = cap[i++];
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL,
+				   lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
 
-	pci_restore_aspm_state(dev);
+	pci_restore_aspm_l1ss_state(dev);
+
+	/* Restore ASPM control after restoring L1SS state */
+	pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
+				 lnkctl & PCI_EXP_LNKCTL_ASPMC);
 }
 
 static int pci_save_pcix_state(struct pci_dev *dev)
@@ -3532,11 +3535,6 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
-	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
-					    2 * sizeof(u32));
-	if (error)
-		pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
-
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ecceb690fbbb..eca5938deb07 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -97,11 +97,6 @@ void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
-void pci_aspm_get_l1ss(struct pci_dev *pdev);
-void pci_save_aspm_state(struct pci_dev *pdev);
-void pci_restore_aspm_state(struct pci_dev *pdev);
-void pci_save_ltr_state(struct pci_dev *dev);
-void pci_restore_ltr_state(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
@@ -572,6 +567,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
+
+/* ASPM-related functionality we need even without CONFIG_PCIEASPM */
+void pci_save_ltr_state(struct pci_dev *dev);
+void pci_restore_ltr_state(struct pci_dev *dev);
+void pci_configure_aspm_l1ss(struct pci_dev *dev);
+void pci_save_aspm_l1ss_state(struct pci_dev *dev);
+void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
+
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 60716fbf40a9..977eca893b2a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -24,126 +24,6 @@
 
 #include "../pci.h"
 
-void pci_aspm_get_l1ss(struct pci_dev *pdev)
-{
-	/* Read L1 PM substate capabilities */
-	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-}
-
-void pci_save_aspm_state(struct pci_dev *pdev)
-{
-	struct pci_cap_saved_state *save_state;
-	u16 l1ss = pdev->l1ss;
-	u32 *cap;
-
-	/*
-	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
-	 * is already saved in pci_save_pcie_state().
-	 */
-	if (!l1ss)
-		return;
-
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
-
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
-}
-
-static void pcie_restore_aspm_l1ss(struct pci_dev *pdev)
-{
-	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
-	struct pci_dev *parent = pdev->bus->self;
-	u32 *cap, pl_ctl1, pl_ctl2, pl_l1_2_enable;
-	u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
-
-	/*
-	 * In case BIOS enabled L1.2 after resume, we need to disable it first
-	 * on the downstream component before the upstream. So, don't attempt to
-	 * restore either until we are at the downstream component.
-	 */
-	if (pcie_downstream_port(pdev) || !parent)
-		return;
-
-	if (!pdev->l1ss || !parent->l1ss)
-		return;
-
-	cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
-	pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
-	if (!cl_save_state || !pl_save_state)
-		return;
-
-	cap = &cl_save_state->cap.data[0];
-	cl_ctl2 = *cap++;
-	cl_ctl1 = *cap;
-	cap = &pl_save_state->cap.data[0];
-	pl_ctl2 = *cap++;
-	pl_ctl1 = *cap;
-
-
-	/*
-	 * Disable L1.2 on this downstream endpoint device first, followed
-	 * by the upstream
-	 */
-	pci_clear_and_set_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_L1_2_MASK, 0);
-	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_L1_2_MASK, 0);
-
-	/*
-	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD
-	 * in PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
-	 * enable bits, even though they're all in PCI_L1SS_CTL1.
-	 */
-	pl_l1_2_enable = pl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
-	pl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
-	cl_l1_2_enable = cl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
-	cl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
-
-	/* Write back without enables first (above we cleared them in ctl1) */
-	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, pl_ctl2);
-	pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cl_ctl2);
-	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, pl_ctl1);
-	pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cl_ctl1);
-
-
-	/* Then write back the enables */
-	if (pl_l1_2_enable || cl_l1_2_enable) {
-		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				       pl_ctl1 | pl_l1_2_enable);
-		pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
-				       cl_ctl1 | cl_l1_2_enable);
-	}
-}
-
-void pci_restore_aspm_state(struct pci_dev *pdev)
-{
-	struct pci_cap_saved_state *save_state;
-	u16 *cap, val;
-
-	save_state = pci_find_saved_cap(pdev, PCI_CAP_ID_EXP);
-
-	if (!save_state)
-		return;
-
-	cap = (u16 *)&save_state->cap.data[0];
-	/* Must match the ordering in pci_save/restore_pcie_state() */
-	val = cap[1] & PCI_EXP_LNKCTL_ASPMC;
-	if (!val)
-		return;
-
-	/*
-	 * We restore L1 substate configuration first before enabling L1
-	 * as the PCIe spec 6.1 sec 5.5.4 suggests.
-	 */
-	pcie_restore_aspm_l1ss(pdev);
-
-	/* Re-enable L0s/L1 */
-	pcie_capability_set_word(pdev, PCI_EXP_LNKCTL, val);
-}
-
 void pci_save_ltr_state(struct pci_dev *dev)
 {
 	int ltr;
@@ -184,6 +64,105 @@ void pci_restore_ltr_state(struct pci_dev *dev)
 	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
 }
 
+void pci_configure_aspm_l1ss(struct pci_dev *pdev)
+{
+	int rc;
+
+	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+
+	rc = pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_L1SS,
+					 2 * sizeof(u32));
+	if (rc)
+		pci_err(pdev, "unable to allocate ASPM L1SS save buffer (%pe)\n",
+			ERR_PTR(rc));
+}
+
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 l1ss = pdev->l1ss;
+	u32 *cap;
+
+	/*
+	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
+	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
+	 */
+	if (!l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
+}
+
+void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
+	struct pci_dev *parent = pdev->bus->self;
+	u32 *cap, pl_ctl1, pl_ctl2, pl_l1_2_enable;
+	u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
+
+	/*
+	 * In case BIOS enabled L1.2 when resuming, we need to disable it first
+	 * on the downstream component before the upstream. So, don't attempt to
+	 * restore either until we are at the downstream component.
+	 */
+	if (pcie_downstream_port(pdev) || !parent)
+		return;
+
+	if (!pdev->l1ss || !parent->l1ss)
+		return;
+
+	cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
+	if (!cl_save_state || !pl_save_state)
+		return;
+
+	cap = &cl_save_state->cap.data[0];
+	cl_ctl2 = *cap++;
+	cl_ctl1 = *cap;
+	cap = &pl_save_state->cap.data[0];
+	pl_ctl2 = *cap++;
+	pl_ctl1 = *cap;
+
+	/*
+	 * Disable L1.2 on this downstream endpoint device first, followed
+	 * by the upstream
+	 */
+	pci_clear_and_set_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1_2_MASK, 0);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1_2_MASK, 0);
+
+	/*
+	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD
+	 * in PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
+	 * enable bits, even though they're all in PCI_L1SS_CTL1.
+	 */
+	pl_l1_2_enable = pl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	pl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+	cl_l1_2_enable = cl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	cl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+
+	/* Write back without enables first (above we cleared them in ctl1) */
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, pl_ctl2);
+	pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cl_ctl2);
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, pl_ctl1);
+	pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cl_ctl1);
+
+	/* Then write back the enables */
+	if (pl_l1_2_enable || cl_l1_2_enable) {
+		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       pl_ctl1 | pl_l1_2_enable);
+		pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
+				       cl_ctl1 | cl_l1_2_enable);
+	}
+}
+
 #ifdef CONFIG_PCIEASPM
 
 #ifdef MODULE_PARAM_PREFIX
@@ -1676,4 +1655,5 @@ bool pcie_aspm_support_enabled(void)
 {
 	return aspm_support_enabled;
 }
+
 #endif /* CONFIG_PCIEASPM */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b5ccf5a16dc1..1434bf495db3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2258,8 +2258,8 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
-	pci_aspm_get_l1ss(dev);
 	pci_configure_ltr(dev);
+	pci_configure_aspm_l1ss(dev);
 	pci_configure_eetlp_prefix(dev);
 	pci_configure_serr(dev);
 

