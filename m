Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3017D7A4935
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 14:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbjIRMHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 08:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241843AbjIRMGa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 08:06:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED296CE2
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695038753; x=1726574753;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hCwjbYk+tLY4KWufN+WBSOpXE9kWTmNLfEWTMygRxpo=;
  b=d3gKM+XYzF745PeRQvsxN1jBdy0qK1T+T/U7ykcsQUHl3hnvNn5qwm3h
   MfasyijcW+6nU/An0hR37b75c2gr+aXFlwkMCk9v/0hiZ4w74pw9/2LAs
   8yem1vZsWb+BG+dF3p3asIL6YxU/nRVCp9iZTH8zv2LzmhXJIGLvo8vF9
   hbNcR9lwaV4DqZHaiwCQYMYmyhM5S2aJZyY85q9QqAaQ0x9I14AxhVTL6
   PrPJrvaZSLSpqZBEp5x0UBPtHQQWESbbWS2Ii1cC2zt9jsqvHDMKOL3CT
   nGZyysiMOy0G4KLlZ2WPsu5g0mY5ybe2ixmv5x4Yr9qwp2R0taUG5GfMO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364677575"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364677575"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:59:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="1076558189"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="1076558189"
Received: from nprotaso-mobl1.ccr.corp.intel.com ([10.252.49.156])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:59:30 -0700
Date:   Mon, 18 Sep 2023 14:59:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
In-Reply-To: <20230915023354.939-3-mario.limonciello@amd.com>
Message-ID: <9d3ea5-da3a-cd60-bc6c-442eae404073@linux.intel.com>
References: <20230915023354.939-1-mario.limonciello@amd.com> <20230915023354.939-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Sep 2023, Mario Limonciello wrote:

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
> 
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

FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);

-- 
 i.

> +}
> +
> +static void quirk_disable_pme_suspend(struct pci_dev *dev)
> +{
> +	int mask;
> +
> +	if (pm_suspend_via_firmware())
> +		return;
> +
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
> 
