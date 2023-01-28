Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E067FA30
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jan 2023 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjA1S0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Jan 2023 13:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjA1S02 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jan 2023 13:26:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D602413A;
        Sat, 28 Jan 2023 10:26:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7257960ADB;
        Sat, 28 Jan 2023 18:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77C4C433EF;
        Sat, 28 Jan 2023 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674930385;
        bh=+1HY1X03PRS4RFvuB5J2U+0mVkSoJsfyzQGpeXj1dI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l5AWetFxoXHNYwDitgPfVFSSivHWFsJdRCTSUVrqtfSOKiRgXnX3idLp2lSvPwif2
         YViGIYGaoCpnKXnfcvhnvOFShSNAmjB9QeZBOkK92akvqqRc+AbF/6GiGDJwxvs/k4
         PIozlEdoOXA+ap5owVMqLNJDg+TBTx/NE/ahBMBiyVqT7NsgBQNLOV7+PSmZEG5Qmk
         PXLTDDSei3fPiiZPsdGlrkpsCH3CWCAmFXcA3G5qVaKtXshXPMRTcjxB5t148KwcDE
         Jq/Ip86zHtYRPLujl/IPIwPtWIW7PCxZCGblIOP245jG4kwIzP8HfgXp6fD1KHnEVX
         JLzAlVoA2EdIg==
Date:   Sat, 28 Jan 2023 12:26:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI/ASPM: Update saved buffers with latest ASPM
 configuration
Message-ID: <20230128182624.GA1412510@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125133830.20620-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 25, 2023 at 07:08:30PM +0530, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery System.

This strategy of simply restoring config space after a reset is
common, but I think it's only a 90% solution.

After reset, the device is basically in a "fresh poweron" state [1].
At boot-time or for a hot-added device, we do a lot of setup when we
enumerate the device, and assuming that:

  - device reset, plus
  - current state in the struct pci_dev, plus
  - restoring config space

gets all the device and kernel state to the same place is a pretty big
assumption.

That said, we're pretty invested in this strategy for now, and I think
what you propose here is definitely an improvement.  Minor comments on
the implementation below.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/pci-error-recovery.rst?id=v6.1#n277

> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not with
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
> This patch addresses that issue by updating the saved configuration state
> of the device with the latest info whenever there is a change w.r.t ASPM
> policy.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/pci.h       |  4 ++++
>  drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)

> +++ b/drivers/pci/pci.h
> +void pci_save_aspm_state(struct pci_dev *dev);
> +void pci_restore_aspm_state(struct pci_dev *dev);

This patch only adds calls to these functions in aspm.c, so it doesn't
look like we need declarations here or stubs below.

> +static inline void pci_save_aspm_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aspm_state(struct pci_dev *dev) { }

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53a1fa306e1e..f25e0440d36b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -151,6 +151,7 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  						   PCI_EXP_LNKCTL_CLKREQ_EN,
>  						   val);
>  	link->clkpm_enabled = !!enable;
> +	pci_save_aspm_state(child);
>  }
>  
>  static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> @@ -757,6 +758,39 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  				PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>  
> +void pci_save_aspm_state(struct pci_dev *dev)

I might be missing something because these look like they should be
static.  But the declarations and these being non-static suggest that
you might have something more in mind that isn't part of this patch?

Move these save-state functions higher up if necessary to resolve the
forward reference from pcie_set_clkpm_nocheck().

> +{
> +	int i = 0;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	i++;

"i" looks unnecessary, but I guess I see what you're doing --
mirroring the structure of pci_save_pcie_state() to make sure we put
LNKCTL in the correct element of cap[].

> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
> +}
> +
> +void pci_restore_aspm_state(struct pci_dev *dev)

No callers for this?  And I don't see why you would *need* callers;
this should be restored by pci_restore_pcie_state() already.  So this
looks like it could be removed completely.

> +{
> +	int i = 0;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	i++;
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
> +}
> +
>  void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>  {
>  	struct pci_cap_saved_state *save_state;
> @@ -849,6 +883,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  		pcie_config_aspm_dev(parent, upstream);
>  
>  	link->aspm_enabled = state;
> +
> +	/* Update latest ASPM configuration in saved context */
> +	pci_save_aspm_state(link->downstream);
> +	pci_save_aspm_l1ss_state(link->downstream);
> +	pci_save_aspm_state(parent);
> +	pci_save_aspm_l1ss_state(parent);
>  }
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)
> -- 
> 2.17.1
> 
