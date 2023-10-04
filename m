Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8A07B97E9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 00:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjJDWXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 18:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbjJDWXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 18:23:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7F910FF
        for <linux-pci@vger.kernel.org>; Wed,  4 Oct 2023 15:23:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FFCC433C7;
        Wed,  4 Oct 2023 22:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696458206;
        bh=22Yzuca4YGz3cct/tpVjCWNj3ZT/9Ns24dC3UBowUm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gRwCPSauIR/kEAopGnnPLJcIr6jXaeh2M5nny3wORtTmCIKCGMBvywWsdVxj1zjOA
         VoeZHGjru8hMO/QrHc3NiB+KhbkcxnlnIZDu9qwq/495ooiFaJuR/V7WZPJscMSOcL
         LXxNIcV0a0OZ6CKQVRU3iNlbP1+3KAsiHvJaj7JJnMC1+Z3wBLJ346Ox9FhQo8cRis
         +7icxXWHbXUPLNnkTP4Ont/wfh8a4jnarXZ8GYeWPXA2rZESMRrpwvFEkcMe6DJOs5
         ycp0o28jZxVRfsgD9kRG1CXFkSFrrvieU4SsjEAyMDwXdsRa2X2zmkzqtncEsNhPJG
         mUBTOICyznoHA==
Date:   Wed, 4 Oct 2023 17:23:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20231004222324.GA718849@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002070044.2299644-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 02, 2023 at 10:00:44AM +0300, Mika Westerberg wrote:
> Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
> for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
> due to a regression that caused resume from suspend to fail on certain
> systems. However, we never added this capability back and this is now
> causing systems fail to enter low power CPU states, drawing more power
> from the battery.

AFAICT, the save (suspend) side is effectively the same in
4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume") (the change reverted by a7152be79b62) and in this
patch.  There are minor ordering differences with respect to DPC and
AER, but I don't think they're relevant.

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
>   2) ASPM is first enabled on the upstream component and then downstream
>      (this is already forced by the parent-child ordering of Linux
>      Device Power Management framework).
> 
>   3) Program ASPM L1 PM substate configuration before L1 enables.
> 
>   4) Program ASPM L1 PM substate enables last after rest of the fields
>      in the capability are programmed.

This patch changes the restore (resume) side.  4ff116d0d5fd restored
L1SS state followed by LNKCTL.

This patch instead restores LNKCTL (with ASPM *disabled*) before the
L1SS state, and then restores the full LNKCTL (including ASPM config).

>   5) Add denylist that skips restoring on the ASUS and TUXEDO systems
>      where these regressions happened, just in case. For the TUXEDO case
>      we only skip restore if the BIOS is involved in system suspend
>      (that's forcing "mem_sleep=deep" in the command line). This is to
>      avoid possible power regression when the default suspend to idle is
>      used, and at the same time make sure the devices continue working
>      after resume when the BIOS is involved.

I looked through the v1, v2, and v3 threads, and I see testing failure
reports from Thomas (TUXEDO) for v1 and "v1.5" [1].  v1.5 looks
functionally identical to this v4 except it lacks the TUXEDO denylist
entry.

I don't see any actual success reports for either ASUS or TUXEDO.

Do we have testing reports for these ASUS and TUXEDO systems showing
that we need this denylist?  I think this patch fixes a real problem
with L1SS save/restore, and unless proven otherwise, I would assume
that it fixes ASUS and TUXEDO as well.

[1] https://lore.kernel.org/linux-pci/20230630104154.GS14638@black.fi.intel.com/

> Reported-by: Koba Ko <koba.ko@canonical.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217321

IIUC, Koba's report is on a Dell Inspiron 15 3530.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216782
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216877

These are the original issues reported with 4ff116d0d5fd: 216782 is
the ASUS UX305FA problem reported by Tasev, and 216877 is the TUXEDO
problem reported by Thomas.

So ... I think this patch definitely fixes a problem.  4ff116d0d5fd
restored L1SS state before LNKCTL on the assumption that ASPM was
disabled at the point, but I don't think we really know that.

This patch explicitly disables ASPM before restoring L1SS, which seems
safer.

But we just punt on the ASUS and TUXEDO systems, when there's no
reason we shouldn't be able to restore ASPM config there as well.  And
unless I missed them, we don't actually have testing reports from
ASUS, TUXEDO, or Koba's Dell.

I think there's still something we're missing.

We restore the LTR config before restoring DEVCTL2 (including the LTR
enable bit) and L1SS state.  I don't think we know the state of ASPM
and L1SS at that point, do we?  Do you think there could be an issue
there, too?

> Cc: Tasev Nikola <tasev.stefanoska@skynet.be>
> Cc: Mark Enriquez <enriquezmark36@gmail.com>
> Cc: Thomas Witt <kernel@witt.link>
> Cc: Werner Sembach <wse@tuxedocomputers.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> Hi all,
> 
> Previous versions of the patch can be found:
> 
> v3: https://lore.kernel.org/linux-pci/20230925074636.2893747-1-mika.westerberg@linux.intel.com/
> v2: https://lore.kernel.org/linux-pci/20230911073352.3472918-1-mika.westerberg@linux.intel.com/
> v1: https://lore.kernel.org/linux-pci/20230627062442.54008-1-mika.westerberg@linux.intel.com/ 
> 
> Changes from v3:
> 
>   - Use pcie_capability_set_word() instead.
> 
>   - Add tag from Ilpo.
> 
> Changes from v2:
> 
>   - Added tested by tag from Kai-Heng Feng.
> 
>   - Dropped the two unneeded (u32 *) casts.
> 
>   - Dropped unnecessary comment.
> 
> Changes from v1:
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
>  drivers/pci/pci.c       |  18 ++++-
>  drivers/pci/pci.h       |   4 ++
>  drivers/pci/pcie/aspm.c | 144 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..7c72d40ec0ff 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1576,7 +1576,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  {
>  	int i = 0;
>  	struct pci_cap_saved_state *save_state;
> -	u16 *cap;
> +	u16 *cap, val;
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>  	if (!save_state)
> @@ -1591,7 +1591,14 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
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
> @@ -1702,6 +1709,7 @@ int pci_save_state(struct pci_dev *dev)
>  	pci_save_ltr_state(dev);
>  	pci_save_dpc_state(dev);
>  	pci_save_aer_state(dev);
> +	pci_save_aspm_state(dev);
>  	pci_save_ptm_state(dev);
>  	return pci_save_vc_state(dev);
>  }
> @@ -1815,6 +1823,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_rebar_state(dev);
>  	pci_restore_dpc_state(dev);
>  	pci_restore_ptm_state(dev);
> +	pci_restore_aspm_state(dev);
>  
>  	pci_aer_clear_status(dev);
>  	pci_restore_aer_state(dev);
> @@ -3507,6 +3516,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
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
> index 39a8932dc340..11cec757a624 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -567,10 +567,14 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
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
> index 1bf630059264..dd0ba59c44b8 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) Shaohua Li (shaohua.li@intel.com)
>   */
>  
> +#include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> @@ -17,6 +18,7 @@
>  #include <linux/pm.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/jiffies.h>
>  #include <linux/delay.h>
>  #include "../pci.h"
> @@ -712,6 +714,148 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  				PCI_L1SS_CTL1_L1SS_MASK, val);
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
> +static int aspm_l1ss_suspend_via_firmware(const struct dmi_system_id *not_used)
> +{
> +	return pm_suspend_via_firmware();
> +}
> +
> +/*
> + * Do not restore L1 substates for the below systems even if BIOS has enabled
> + * it initially. This breaks resume from suspend otherwise on these.
> + */
> +static const struct dmi_system_id aspm_l1ss_denylist[] = {
> +	{
> +		/* https://bugzilla.kernel.org/show_bug.cgi?id=216782 */
> +		.ident = "ASUS UX305FA",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "UX305FA"),
> +		},
> +	},
> +	{
> +		/*
> +		 * https://bugzilla.kernel.org/show_bug.cgi?id=216877
> +		 *
> +		 * This system needs to use suspend to mem instead of its
> +		 * default (suspend to idle) to avoid draining the battery.
> +		 * However, the BIOS gets confused if we try to restore the
> +		 * L1SS registers so avoid doing that if the user forced
> +		 * suspend to mem. The default suspend to idle on the other
> +		 * hand needs restoring L1SS to allow the CPU to enter low
> +		 * power states. This entry should handle both.
> +		 */
> +		.callback = aspm_l1ss_suspend_via_firmware,
> +		.ident = "TUXEDO InfinityBook S 14 v5",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "L140CU"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static bool aspm_l1ss_skip_restore(const struct pci_dev *pdev)
> +{
> +	const struct dmi_system_id *dmi;
> +
> +	dmi = dmi_first_match(aspm_l1ss_denylist);
> +	if (dmi) {
> +		/* If the callback returns zero we can restore L1SS */
> +		if (dmi->callback && !dmi->callback(dmi))
> +			return false;
> +
> +		pci_dbg(pdev, "skipping restoring L1 substates on this system\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void pcie_restore_aspm_l1ss(struct pci_dev *pdev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap, ctl1, ctl2, l1_2_enable;
> +	u16 l1ss = pdev->l1ss;
> +
> +	if (!l1ss)
> +		return;
> +
> +	if (aspm_l1ss_skip_restore(pdev))
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state)
> +		return;
> +
> +	cap = &save_state->cap.data[0];
> +	ctl2 = *cap++;
> +	ctl1 = *cap;
> +
> +	/*
> +	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD
> +	 * in PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
> +	 * enable bits, even though they're all in PCI_L1SS_CTL1.
> +	 */
> +	l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> +	ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
> +
> +	/* Write back without enables first (above we cleared them in ctl1) */
> +	pci_write_config_dword(pdev, l1ss + PCI_L1SS_CTL1, ctl1);
> +	pci_write_config_dword(pdev, l1ss + PCI_L1SS_CTL2, ctl2);
> +
> +	/* Then write back the enables */
> +	if (l1_2_enable)
> +		pci_write_config_dword(pdev, l1ss + PCI_L1SS_CTL1,
> +				       ctl1 | l1_2_enable);
> +}
> +
> +void pci_restore_aspm_state(struct pci_dev *pdev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap, val;
> +
> +	save_state = pci_find_saved_cap(pdev, PCI_CAP_ID_EXP);
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
>  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  {
>  	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> -- 
> 2.40.1
