Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7E7A3E0F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Sep 2023 23:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjIQV5F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Sep 2023 17:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjIQV4q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Sep 2023 17:56:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2D122
        for <linux-pci@vger.kernel.org>; Sun, 17 Sep 2023 14:56:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68A7C433C7;
        Sun, 17 Sep 2023 21:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694987800;
        bh=H7w+8L6DLjMFmipNVse8chSG5CosoAAFpnJWimr3MqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LsgV1CK+ZqqfeCAIYi0cVZlnDFU69MoYzhVgGiLxQfjS/HmuIyozssOiZsXzR2056
         IBFVMDntZJaZvlNJAsdbYKMjvRl+MOPVajK0Gva0PqNY+gaDbddZcFY1sUWTR0T/PD
         jogoiiqfjisS2bNGCOQ8N7uF5x91DvEp2/UXWFhDrMUjnwoAoyqjolO0QSku2yTgJk
         LEYFWNjk5i4YNRaI7ds3QwQQp6BPkh26f2R29ln22olEMWpvL6d+N18OxW5v7i4hjF
         I3WnM5hKa1ZzifNnF8T89yA9ZsZAECvNRvyuzHwHKA11k1D9+DTLCKWrR2oMKiVU/X
         k4Zmo13VlvLrg==
Date:   Sun, 17 Sep 2023 16:56:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230917215637.GA172139@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915023354.939-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 09:33:54PM -0500, Mario Limonciello wrote:
> Iain reports that USB devices can't be used to wake a Lenovo Z13
> from suspend. This problem occurs because the PCIe root port has been put
> into D3hot and AMD's platform can't handle USB devices waking the platform
> from a hardware sleep state in this case. The platform is put into
> a hardware sleep state by the actions of the amd-pmc driver.
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
> suspend").
> 
> The Windows uPEP driver expresses the desired state that should be
> selected for suspend but Linux doesn't, so introduce a quirk for the
> problematic root ports.
> 
> The quirk removes PME support for D3hot and D3cold at suspend time if the
> system will be using s2idle. When the port is configured for wakeup this
> will prevent these states from being selected in pci_target_state().
> 
> After the system is resumes the PME support is re-read from the PM
> capabilities register to allow opportunistic power savings at runtime by
> letting the root port go into D3hot or D3cold.

There's a lot of text here, but I think the essential thing is:

  These Root Ports advertise D3hot and D3cold in the PME_Support
  register, but PMEs do not work in those states when the amd-pmc
  driver has put the platform in a sleep state.

> Cc: stable@vger.kernel.org
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/quirks.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..ebc0afbc814e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6188,3 +6188,64 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +
> +/*
> + * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
> + * into D3hot or D3cold downstream USB devices may fail to wakeup the system.
> + * This manifests as a missing wakeup interrupt.
> + *
> + * Prevent the associated root port from using PME to wake from D3hot or
> + * D3cold power states during s2idle.
> + * This will effectively put the root port into D0 power state over s2idle.
> + */
> +static bool child_has_amd_usb4(struct pci_dev *pdev)
> +{
> +	struct pci_dev *child = NULL;
> +
> +	while ((child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child))) {
> +		if (child->vendor != PCI_VENDOR_ID_AMD)
> +			continue;
> +		if (pcie_find_root_port(child) != pdev)
> +			continue;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void quirk_reenable_pme(struct pci_dev *dev)
> +{
> +	u16 pmc;
> +
> +	if (!dev->pm_cap)
> +		return;
> +
> +	if (!child_has_amd_usb4(dev))
> +		return;
> +
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_PMC, &pmc);
> +	pmc &= PCI_PM_CAP_PME_MASK;
> +	dev->pme_support = pmc >> PCI_PM_CAP_PME_SHIFT;
> +}
> +
> +static void quirk_disable_pme_suspend(struct pci_dev *dev)
> +{
> +	int mask;
> +
> +	if (pm_suspend_via_firmware())
> +		return;

There's always something more to confuse me.  Why does
pm_suspend_via_firmware() matter?  I can sort of see that Linux
platform power management, which uses the PMC, is not the same
as platform firmware being invoked at the end of a system-wide power
management transition to a sleep state.

I guess this must have something to do with acpi_suspend_begin() and
acpi_hibernation_begin() (the callers of
pm_set_suspend_via_firmware())?

> +	if (!child_has_amd_usb4(dev))
> +		return;
> +
> +	mask = (PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >> PCI_PM_CAP_PME_SHIFT;
> +	if (!(dev->pme_support & mask))
> +		return;
> +	dev->pme_support &= ~mask;
> +	dev_info_once(&dev->dev, "quirk: disabling PME from D3hot and D3cold at suspend\n");
> +}
> +
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_disable_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_disable_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_reenable_pme);
> -- 
> 2.34.1
> 
