Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4D7BA8DC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjJESOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjJESOp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:14:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA059B
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 11:14:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FF1C433AD;
        Thu,  5 Oct 2023 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696529682;
        bh=L/fFYneJdQhKT4ax4LAwDZ4AnEjBoTl2j2ZNpiAQ/aU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p9bz735MRhlNHiJbCEKcIwoB0+H3j9oEwpjsLBGntGOF7ytI9v3XSyrwG1oNqIZe0
         Upmju+k6F7qT6L4jz6dFL3+6oEP+F3SFL2dgrC4Pv2Rc8UWHrD1eY0NB+JK/jUBteu
         KyEwJ5mQXfXhuFrE3vjNjS7to/FuYFXlgEVSev/hYAAWEQHZnPLGi/nmMhV4Ip7n+U
         fvCd73ucK4sFShxXmMvHsioRJk0RMSJ/GQsxK36qjNmHmGGPoCGJavKjDeIJvvaQeC
         bmAaxUFU8mx1u/BYNv/yWMdH1nwgLkWA5GtbbG5XD8acHvHraU4Uxjzg61zKQkssat
         dComqzrO7eUmA==
Date:   Thu, 5 Oct 2023 13:14:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v22] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231005181440.GA783423@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004144959.158840-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 04, 2023 at 09:49:59AM -0500, Mario Limonciello wrote:
> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
> suspend.  This occurs because on some AMD platforms, even though the Root
> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
> messages and generate wakeup interrupts from those states when amd-pmc has
> put the platform in a hardware sleep state.
> 
> Iain reported this on an AMD Rembrandt platform, but it also affects
> Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
> generates the PME. To avoid this issue, disable D3 for the root port
> associated with USB4 controllers at suspend time.
> 
> Restore D3 support at resume so that it can be used by runtime suspend.
> The amd-pmc driver doesn't put the platform in a hardware sleep state for
> runtime suspend, so PMEs work as advertised.
> 
> Cc: stable@vger.kernel.org
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to pci/pm for v6.7, thanks for all your patience!

I tweaked the commit log a bit to make it clearer that it only affects
USB4 devices and expand on the amd-pmc connection.  I also dropped the
microsoft.com link because I didn't see anything there that seemed
directly related to this patch:

    PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4
    
    Iain reports that USB devices can't be used to wake a Lenovo Z13 from
    suspend.  This occurs because on some AMD platforms, even though the Root
    Ports advertise PME_Support for D3hot and D3cold, wakeup events from
    devices on a USB4 controller don't result in wakeup interrupts from the
    Root Port when amd-pmc has put the platform in a hardware sleep state.
    
    If amd-pmc will be involved in the suspend, remove D3hot and D3cold from
    the PME_Support mask of Root Ports above USB4 controllers so we avoid those
    states if we need wakeups.
    
    Restore D3 support at resume so that it can be used by runtime suspend.
    
    This affects both AMD Rembrandt and Phoenix SoCs.
    
    "pm_suspend_target_state == PM_SUSPEND_ON" means we're doing runtime
    suspend, and amd-pmc will not be involved.  In that case PMEs work as
    advertised in D3hot/D3cold, so we don't need to do anything.
    
    Note that amd-pmc is technically optional, and there's no need for this
    quirk if it's not present, but we assume it's always present because power
    consumption is so high without it.
    
    Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
    Link: https://lore.kernel.org/r/20231004144959.158840-1-mario.limonciello@amd.com
    Reported-by: Iain Lane <iain@orangesquash.org.uk>
    Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org
> ---
> v21->v22:
>  * Back to PME to avoid implications for wakeup (Bjorn)
>  * This is the submission that Bjorn sent in the mailing in response to v21.  It
>    tests well, so Bjorn please add a Co-Developed-by/Signed-off-by for your
>    self if you feel it's appropriate.
> v20-v21:
>  * Rewrite commit message, lifting most of what Bjorn clipped down to on v20.
>  * Use pci_d3cold_disable()/pci_d3cold_enable() instead
>  * Do the quirk on the USB4 controller instead of RP->USB->RP
> ---
>  drivers/pci/quirks.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..4b601b1c0830 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6188,3 +6188,60 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +
> +#ifdef CONFIG_SUSPEND
> +/*
> + * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
> + * if the SoC is put into a hardware sleep state by the amd-pmc driver, the
> + * Root Ports don't generate wakeup interrupts for USB devices.
> + *
> + * When suspending, remove D3hot and D3cold from the PME_Support advertised
> + * by the Root Port so we don't use those states if we're expecting wakeup
> + * interrupts.  Restore the advertised PME_Support when resuming.
> + */
> +static void amd_rp_pme_suspend(struct pci_dev *dev)
> +{
> +	struct pci_dev *rp;
> +
> +	/*
> +	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
> +	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
> +	 *
> +	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
> +	 * sleep state, but we assume amd-pmc is always present.
> +	 */
> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
> +		return;
> +
> +	rp = pcie_find_root_port(dev);
> +	if (!rp->pm_cap)
> +		return;
> +
> +	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
> +				    PCI_PM_CAP_PME_SHIFT);
> +	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
> +}
> +
> +static void amd_rp_pme_resume(struct pci_dev *dev)
> +{
> +	struct pci_dev *rp;
> +	u16 pmc;
> +
> +	rp = pcie_find_root_port(dev);
> +	if (!rp->pm_cap)
> +		return;
> +
> +	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
> +	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
> +}
> +/* Rembrandt (yellow_carp) */
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_resume);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_resume);
> +/* Phoenix (pink_sardine) */
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_resume);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_resume);
> +#endif /* CONFIG_SUSPEND */
> -- 
> 2.34.1
> 
