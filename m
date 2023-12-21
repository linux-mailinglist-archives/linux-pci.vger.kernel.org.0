Return-Path: <linux-pci+bounces-1260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5509381B415
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 11:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC41B25175
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E06A32D;
	Thu, 21 Dec 2023 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5jXFX8i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9A6BB3D
	for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703155402; x=1734691402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gbgpCy1USl0NhecbyqXvjkSAqQrv7hmtR8dk6gsTvG0=;
  b=g5jXFX8iKh+f46hEFBy9kNHMt/lHqTYIWWrclXoM7IzpRuHfRV9gpij0
   0cX4HcJLx1Sgf6f8cDis/92nQCZMBeyMmls9zgVSiERXyN266DRcJcBQF
   IEvvipCF7Hsz/ehV06JQ02qJrt1bBFCboZ5rmy2F9sjnvDKT0hJfNal+7
   Tyr5NDV9zsz26OwsEyYSgAn82vwbx79R9v31EUYtAczaOCeRVxyox4uom
   MTBUILZlYS/oS4hZmGoMJzo96sYK4dstkuN1cpcXk1SvsrZ69qcuWhge0
   aOTRuMnov0omoJTnZ5i8qGpMPxVABhMC5wDvgWO+0OCTzXbipwvzVJims
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="399786698"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="399786698"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 02:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="780158812"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="780158812"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 21 Dec 2023 02:43:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id DCFDDB8; Thu, 21 Dec 2023 12:43:15 +0200 (EET)
Date: Thu, 21 Dec 2023 12:43:15 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	vidyas@nvidia.com, rafael.j.wysocki@intel.com,
	kai.heng.feng@canonical.com, tasev.stefanoska@skynet.be,
	enriquezmark36@gmail.com, kernel@witt.link, koba.ko@canonical.com,
	wse@tuxedocomputers.com, ilpo.jarvinen@linux.intel.com,
	ricky_wu@realtek.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20231221104315.GD2543524@black.fi.intel.com>
References: <20231221011250.191599-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231221011250.191599-1-david.e.box@linux.intel.com>

Hi David,

On Wed, Dec 20, 2023 at 05:12:50PM -0800, David E. Box wrote:
> Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
> for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
> due to a regression that caused resume from suspend to fail on certain
> systems. However, we never added this capability back and this is now
> causing systems fail to enter low power CPU states, drawing more power
> from the battery.
> 
> The original revert mentioned that we restore L1 PM substate configuration
> even though ASPM L1 may already be enabled. This is due the fact that
> the pci_restore_aspm_l1ss_state() was called before pci_restore_pcie_state().
> 
> Try to enable this functionality again following PCIe r6.0.1, sec 5.5.4
> more closely by:
> 
>   1) Do not restore ASPM configuration in pci_restore_pcie_state() but
>      do that after PCIe capability is restored in pci_restore_aspm_state()
>      following PCIe r6.0, sec 5.5.4.
> 
>   2) If BIOS reenables L1SS on us, particularly L1.2, we need to clear the
>      enables in the right order, downstream before upstream. Defer restoring
>      the L1SS config until we are at the downstream component. Then update
>      the config for both ends of the link in the prescribed order.
> 
>   3) Program ASPM L1 PM substate configuration before L1 enables.
> 
>   4) Program ASPM L1 PM substate enables last after rest of the fields
>      in the capability are programmed.
> 
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217321
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216782
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216877
> Cc: Tasev Nikola <tasev.stefanoska@skynet.be>
> Cc: Mark Enriquez <enriquezmark36@gmail.com>
> Cc: Thomas Witt <kernel@witt.link>
> Cc: Werner Sembach <wse@tuxedocomputers.com>
> Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Co-developed-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> Hi all,
> 
> Previous versions of the patch can be found:
> 
> v4: https://lore.kernel.org/linux-pci/20231002070044.2299644-1-mika.westerberg@linux.intel.com/
> v3: https://lore.kernel.org/linux-pci/20230925074636.2893747-1-mika.westerberg@linux.intel.com/
> v2: https://lore.kernel.org/linux-pci/20230911073352.3472918-1-mika.westerberg@linux.intel.com/
> v1: https://lore.kernel.org/linux-pci/20230627062442.54008-1-mika.westerberg@linux.intel.com/ 
> 
> Changes from v4 (David):
>   - Defer restoring upstream component until at downstream component and
>     handle both together in the prescribed order:
>        - Disable L1SS on child then parent
>        - Restore configuration on both without enables
>        - Enable L1SS on parent then child
>     This fixes a similar hang observed on my system but still needs
>     reporters to test.
>   - Removed denylist and associated code.
>   - Removed Reviewed-by and Tested-by since I've modified Mika's patch and
>     the changes need to be retested. Added Co-developed-by.

Thanks a lot for following up and figuring out the root cause!

I have two tiny stylistic comments, the code otherwise looks good.

> Changes from v3 (Mika):
> 
>   - Use pcie_capability_set_word() instead.
> 
>   - Add tag from Ilpo.
> 
> Changes from v2 (Mika):
> 
>   - Added tested by tag from Kai-Heng Feng.
> 
>   - Dropped the two unneeded (u32 *) casts.
> 
>   - Dropped unnecessary comment.
> 
> Changes from v1 (Mika):
> 
>   - We move ASPM enables from pci_restore_pcie_state() into
>     pci_restore_aspm_state() to make sure they are clear when L1SS bits
>     are programmed (as per PCIe spec).
> 
>   - The denylist includes the TUXEDO system as well but only if suspend
>     is done via BIOS (e.g mem_sleep=deep is forced by user). This way
>     the PCIe devices should continue working after S3 resume, and at the
>     same time allow better power savings. If the default s2idle is used
>     then we restore L1SS to allow the CPU enter lower power states. This
>     is the best I was able to come up to make everyone happy.
> 
>  drivers/pci/pci.c       |  18 ++++++-
>  drivers/pci/pci.h       |   4 ++
>  drivers/pci/pcie/aspm.c | 116 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 55bc3576a985..3c4b2647b4ca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1579,7 +1579,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  {
>  	int i = 0;
>  	struct pci_cap_saved_state *save_state;
> -	u16 *cap;
> +	u16 *cap, val;
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>  	if (!save_state)
> @@ -1594,7 +1594,14 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  
>  	cap = (u16 *)&save_state->cap.data[0];
>  	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
> -	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
> +	/*
> +	 * Restoring ASPM L1 substates has special requirements
> +	 * according to the PCIe spec 6.0. So we restore here only the
> +	 * LNKCTL register with the ASPM control field clear. ASPM will
> +	 * be restored in pci_restore_aspm_state().
> +	 */
> +	val = cap[i++] & ~PCI_EXP_LNKCTL_ASPMC;
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
>  	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
> @@ -1705,6 +1712,7 @@ int pci_save_state(struct pci_dev *dev)
>  	pci_save_ltr_state(dev);
>  	pci_save_dpc_state(dev);
>  	pci_save_aer_state(dev);
> +	pci_save_aspm_state(dev);
>  	pci_save_ptm_state(dev);
>  	return pci_save_vc_state(dev);
>  }
> @@ -1817,6 +1825,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_rebar_state(dev);
>  	pci_restore_dpc_state(dev);
>  	pci_restore_ptm_state(dev);
> +	pci_restore_aspm_state(dev);
>  
>  	pci_aer_clear_status(dev);
>  	pci_restore_aer_state(dev);
> @@ -3509,6 +3518,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>  	if (error)
>  		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>  
> +	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> +					    2 * sizeof(u32));
> +	if (error)
> +		pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> +
>  	pci_allocate_vc_save_buffers(dev);
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..2d0f9ae3d9b6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -570,10 +570,14 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pci_save_aspm_state(struct pci_dev *pdev);
> +void pci_restore_aspm_state(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pci_save_aspm_state(struct pci_dev *pdev) { }
> +static inline void pci_restore_aspm_state(struct pci_dev *pdev) { }
>  #endif
>  
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 50b04ae5c394..dc5ea0ff2e07 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1027,6 +1027,122 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  	up_read(&pci_bus_sem);
>  }
>  
> +void pci_save_aspm_state(struct pci_dev *pdev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u16 l1ss = pdev->l1ss;
> +	u32 *cap;
> +
> +	/*
> +	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
> +	 * is already saved in pci_save_pcie_state().
> +	 */
> +	if (!l1ss)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state)
> +		return;
> +
> +	cap = &save_state->cap.data[0];
> +	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
> +	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> +}
> +
> +static void pcie_restore_aspm_l1ss(struct pci_dev *child)
> +{
> +	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
> +	struct pci_dev *parent = child->bus->self;
> +	struct pcie_link_state *link;
> +	u32 *cap, pl_ctl1, pl_ctl2, pl_l1_2_enable;
> +	u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
> +
> +	/*
> +	 * In case BIOS enabled L1.2 after resume, we need to disable it first
> +	 * on the downstream component before the upstream. So, don't attempt to
> +	 * restore either until we are at the downstream component.
> +	 */
> +	if (child->link_state || !parent || !child->l1ss || !parent->l1ss)
> +		return;
> +
> +	link = parent->link_state;
> +	if (!link)
> +		return;
> +
> +	cl_save_state = pci_find_saved_ext_cap(child, PCI_EXT_CAP_ID_L1SS);
> +	pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
> +	if (!cl_save_state || !pl_save_state)
> +		return;
> +
> +	cap = &cl_save_state->cap.data[0];
> +	cl_ctl2 = *cap++;
> +	cl_ctl1 = *cap;
> +	cap = &pl_save_state->cap.data[0];
> +	pl_ctl2 = *cap++;
> +	pl_ctl1 = *cap;
> +
> +

Drop the other empty line.

> +	/*
> +	 * Disable L1.2 on this downstream endpoint device first, followed
> +	 * by the upstream
> +	 */
> +	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
> +				PCI_L1SS_CTL1_L1_2_MASK, 0);
> +	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> +				PCI_L1SS_CTL1_L1_2_MASK, 0);
> +
> +	/*
> +	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD
> +	 * in PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
> +	 * enable bits, even though they're all in PCI_L1SS_CTL1.
> +	 */
> +	pl_l1_2_enable = pl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> +	pl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
> +	cl_l1_2_enable = cl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> +	cl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
> +
> +	/* Write back without enables first (above we cleared them in ctl1) */
> +	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, pl_ctl2);
> +	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, cl_ctl2);
> +	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, pl_ctl1);
> +	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL1, cl_ctl1);
> +
> +

Ditto.

> +	/* Then write back the enables */
> +	if (pl_l1_2_enable || cl_l1_2_enable) {
> +		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> +				       pl_ctl1 | pl_l1_2_enable);
> +		pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
> +				       cl_ctl1 | cl_l1_2_enable);
> +	}
> +}
> +
> +void pci_restore_aspm_state(struct pci_dev *pdev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap, val;
> +
> +	save_state = pci_find_saved_cap(pdev, PCI_CAP_ID_EXP);
> +
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	/* Must match the ordering in pci_save/restore_pcie_state() */
> +	val = cap[1] & PCI_EXP_LNKCTL_ASPMC;
> +	if (!val)
> +		return;
> +
> +	/*
> +	 * We restore L1 substate configuration first before enabling L1
> +	 * as the PCIe spec 6.0 sec 5.5.4 suggests.
> +	 */
> +	pcie_restore_aspm_l1ss(pdev);
> +
> +	/* Re-enable L0s/L1 */
> +	pcie_capability_set_word(pdev, PCI_EXP_LNKCTL, val);
> +}
> +
>  static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
>  {
>  	struct pci_dev *bridge;
> -- 
> 2.34.1

