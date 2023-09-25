Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418F57ACF66
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 07:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIYFUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 01:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIYFUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 01:20:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C49CB3
        for <linux-pci@vger.kernel.org>; Sun, 24 Sep 2023 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695619207; x=1727155207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ItqVNKMrgLMoeW5Wrb+w5dJH/svfQBdwraQeiYAD4q0=;
  b=UH1UvzrE0f8dAyT256lLxRQ+Wz8++OR/rhKrtpZOhUxAB+G36ZVkLw0m
   Pc4kc9JetWv/0eN31V+To0sacEHWFqSI7rnsmQ5xbgvQ7IUxxB33ik6/9
   7piU5ynw4cDSD34jMuelK4SRh9iTQhRGLcbKZnxmgue/IpksGLKAEvINo
   qyAmzfiQUMs1i3qCVtGjYSXpq3K9Qmk1gBNMMrVq/wPrxzQbYBEtsTcvS
   8fsU4DI7wIhXYxd0D3jyur9NjJswOl42YvRPWikz4lKJNT0d7szMyQmYQ
   Lssh6e827VxtpV5VPD7AXB1LhVNM97sBoofT6iktlBQIdSmAGZZjoAn4i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360553345"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360553345"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 22:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="724861056"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="724861056"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Sep 2023 22:20:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0E8391C7; Mon, 25 Sep 2023 08:20:02 +0300 (EEST)
Date:   Mon, 25 Sep 2023 08:20:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v20 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230925052001.GK3208943@black.fi.intel.com>
References: <20230920032724.71083-1-mario.limonciello@amd.com>
 <20230920032724.71083-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920032724.71083-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 10:27:24PM -0500, Mario Limonciello wrote:
> Iain reports that USB devices can't be used to wake a Lenovo Z13
> from suspend. This problem occurs because the PCIe root port has been put
> into D3hot and AMD's platform can't handle the PME associated with USB
> devices waking the platform from a hardware sleep state in this case.
> The platform is put into a hardware sleep state by the actions of the
> amd-pmc driver.
> 
> Although the issue is initially reported on a single model it actually
> affects all Yellow Carp (Rembrandt) and Pink Sardine (Phoenix) SoCs.
> This problem only occurs on Linux specifically when attempting to
> wake the platform from a hardware sleep state.
> Comparing the behavior on Windows and Linux, Windows doesn't put
> the root ports into D3 at this time.
> 
> Linux decides the target state to put the device into at suspend by
> this policy:
> 1. If platform_pci_power_manageable():
>    Use platform_pci_choose_state()
> 2. If the device is armed for wakeup:
>    Select the deepest D-state that supports a PME.
> 3. Else:
>    Use D3hot.
> 
> Devices are considered power manageable by the platform when they have
> one or more objects described in the table in section 7.3 of the ACPI 6.5
> specification [1]. In this case the root ports are not power manageable.
> 
> If devices are not considered power manageable; specs are ambiguous as
> to what should happen.  In this situation Windows 11 puts PCIe ports
> in D0 ostensibly due the policy from the "uPEP driver" which is a
> complimentary driver the Linux "amd-pmc" driver.
> 
> Linux chooses to allow D3 for these root ports due to the policy
> introduced by commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
> suspend"). Since Linux allows D3 for these ports, it follows the
> assertion that a PME can be used to wake from D3hot or D3cold and selects
> D3hot at suspend time.
> 
> Even though the PCIe PM capabilities advertise PME from D3hot or D3cold
> the Windows uPEP driver expresses the desired state that should be
> selected for suspend is still D30.  As Linux doesn't use this information,
> for makin ga policy decision introduce a quirk for the problematic root
> ports.
> 
> The quirk removes PME support for D3hot and D3cold at system suspend time.
> When the port is configured for wakeup this will prevent these states
> from being selected in pci_target_state().
> 
> After the system is resumes the PME support is re-read from the PM
> capabilities register to allow opportunistic power savings at runtime by
> letting the root port go into D3hot or D3cold.
> 
> Cc: stable@vger.kernel.org
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

One super-minor comment, no need to send a new version just for this.

> ---
> v19->v20:
>  * Adjust commit message (Bjorn)
>  * Use FIELD_GET (Ilpo)
>  * Use pci_walk_bus (Lukas)
> ---
>  drivers/pci/quirks.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..4159b7f20fd5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6188,3 +6188,74 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +
> +#ifdef CONFIG_SUSPEND
> +/*
> + * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
> + * into D3hot or D3cold downstream USB devices may fail to wakeup the system
> + * from suspend to idle.  This manifests as a missing wakeup interrupt.
> + *
> + * Prevent the associated root port from using PME to wake from D3hot or
> + * D3cold power states during suspend.
> + * This will effectively put the root port into D0 power state over suspend.
> + */
> +#define PCI_PM_CAP_D3_PME_MASK	((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) \
> +				>> PCI_PM_CAP_PME_SHIFT)
> +static int modify_pme_amd_usb4(struct pci_dev *dev, void *data)
> +{
> +	bool *suspend = (bool *)data;

You could also pass the bool as value because void * can hold it so

	bool suspend = (bool)data;

> +	struct pci_dev *rp;
> +	u16 pmc;
> +
> +	if (dev->vendor != PCI_VENDOR_ID_AMD ||
> +	    dev->class != PCI_CLASS_SERIAL_USB_USB4)
> +		return 0;
> +	rp = pcie_find_root_port(dev);
> +	if (!rp->pm_cap)
> +		return -ENODEV;
> +
> +	if (*suspend) {
> +		if (!(rp->pme_support & PCI_PM_CAP_D3_PME_MASK))
> +			return -EINVAL;
> +
> +		rp->pme_support &= ~PCI_PM_CAP_D3_PME_MASK;
> +		dev_info_once(&rp->dev, "quirk: disabling PME from D3hot and D3cold at suspend\n");
> +
> +		/* no need to check any more devices, found and applied quirk */
> +		return -EEXIST;
> +	}
> +
> +	/* already done */
> +	if (rp->pme_support & PCI_PM_CAP_D3_PME_MASK)
> +		return -EINVAL;
> +
> +	/* restore hardware defaults so runtime suspend can use it */
> +	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
> +	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
> +
> +	return -EEXIST;
> +}
> +
> +static void quirk_reenable_pme(struct pci_dev *dev)
> +{
> +	bool suspend = FALSE;
> +
> +	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);

and here

	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)false);

> +}
> +
> +static void quirk_disable_pme_suspend(struct pci_dev *dev)
> +{
> +	bool suspend = TRUE;
> +
> +	/* skip for runtime suspend */
> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
> +		return;
> +
> +	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);

here

	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)true);
> +}
> +
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_disable_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_disable_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_reenable_pme);
> +#endif /* CONFIG_SUSPEND */
> -- 
> 2.34.1
