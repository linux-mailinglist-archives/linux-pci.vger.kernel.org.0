Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBE67B3AC5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjI2Toc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 15:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjI2Tob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 15:44:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0181B2
        for <linux-pci@vger.kernel.org>; Fri, 29 Sep 2023 12:44:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8446BC433C8;
        Fri, 29 Sep 2023 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696016667;
        bh=VDWO/21XaLNetYHqDVr5Tv98cA2Icv5+ljH0eI0i0dA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dg+gyl1vTEN34qVtItxuhQS1YG71oLT3qoja4ql9JtmpvOwPDRJ56OHz5Mex//VQ2
         Q9BJayGwDrEbs8DeNRk3eurPBuPiVYNlTmrN5nzISABwDQyYDE8JQ3RV9ejt5tMNjn
         7xmL/uF0nqkwM/tP3XanQLQ/LHNBxfWenrgnhmXeJ1YdTi15SL2TfUxygkL7Qn/mOH
         ybWQ+7OAkhIZFKWlxAcftsRGCtRt1mZpF9cH3bvRFxruQl74dt2zNMXrpfWe9OGh8t
         QUlDDfYLopRGIGffka+2VnU3iCIAtkkhK4Ye1XIz3FWkEh5O6nLGJiWqoqnq/EEG7H
         mRzQpcX4EoiwQ==
Date:   Fri, 29 Sep 2023 14:44:25 -0500
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
Subject: Re: [PATCH v20 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230929194425.GA541906@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920032724.71083-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD autolearn=ham autolearn_force=no
        version=3.4.6
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

This is a lot of hassle to look for USB4 devices below the Root Port.
You said earlier that these Root Ports *only* connect to xHCI and
USB4 [1].  If that's the case, why even bother with the search?
Why not just clear PCI_PM_CAP_PME_D3hot and PCI_PM_CAP_PME_D3cold
unconditionally, e.g., the possible patch below?

I have no idea whether it's even possible to have a device other than
xHCI/USB4 below these Root Ports, but I don't think we have any
evidence that the PME failure is specific to USB4, so if it *is*
possible, it's likely that PME from them would fail the same way.

[1] https://lore.kernel.org/r/4a973fe7-e801-49cc-88b8-77d3d0ba3673@amd.com

> +static void quirk_reenable_pme(struct pci_dev *dev)
> +{
> +	bool suspend = FALSE;
> +
> +	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);
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
> +}
> +
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_disable_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_disable_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_reenable_pme);
> +#endif /* CONFIG_SUSPEND */


PCI: Avoid PME from D3hot/cold for AMD Rembrandt and Phoenix

Iain reports that USB devices can't be used to wake a Lenovo Z13 from
suspend.  This occurs because on some AMD platforms, even though the Root
Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
messages and generate wakeup interrupts from those states when amd-pmc has
put the platform in a hardware sleep state.

Iain reported this on an AMD Rembrandt platform, but it also affects
Phoenix SoCs.  On Iain's system, a USB device below the affected Root Port
generates the PME, but there is no reason to believe PMEs from other kinds
of devices would work differently.

To avoid this issue, remove D3hot and D3cold from the Root Port's
PME_Support mask when suspending if we expect amd-pmc to put the platform
in a hardware sleep state.  The effect of this is that if there is a wakeup
device below the Root Port, we will avoid D3hot and D3cold.

Restore the advertised PME_Support mask on resume so D3hot and D3cold can
be used by runtime suspend.  The amd-pmc driver doesn't put the platform in
a hardware sleep state for runtime suspend, so PMEs work as advertised.
---
 drivers/pci/quirks.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..cdf03eb610b0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,3 +6188,57 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+
+#ifdef CONFIG_SUSPEND
+/*
+ * Root Ports on AMD Rembrandt and Phoenix SoCs advertise PME_Support for
+ * D3hot and D3cold, but if the SoC is put into a hardware sleep state by
+ * the amd-pmc driver, the Root Ports don't generate wakeup interrupts from
+ * those states.
+ *
+ * When suspending, remove D3hot and D3cold from the PME_Support advertised
+ * by the Root Port so we don't use those states if we're expecting wakeup
+ * interrupts.  Restore the advertised PME_Support when resuming.
+ */
+#define PCI_PM_CAP_D3_PME_MASK ((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) \
+				>> PCI_PM_CAP_PME_SHIFT)
+
+static void quirk_amd_pme_unsupported(struct pci_dev *dev)
+{
+	if (!dev->pm_cap)
+		return;
+
+	/*
+	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
+	 * amd-pmc will not be involved so PMEs work as advertised.
+	 *
+	 * The PMEs *do* work in D3hot/D3cold if amd-pmc doesn't put the
+	 * SoC in the hardware sleep state, but we assume amd-pmc is always
+	 * present.
+	 */
+	if (pm_suspend_target_state == PM_SUSPEND_ON)
+		return;
+
+	dev->pme_support &= ~PCI_PM_CAP_D3_PME_MASK;
+	dev_info_once(&dev->dev, "D3hot/D3cold PMEs don't work in hardware sleep state\n");
+}
+
+static void quirk_amd_pme_supported(struct pci_dev *dev)
+{
+	u16 pmc;
+
+	if (!dev->pm_cap)
+		return;
+
+	if (dev->pme_support & PCI_PM_CAP_D3_PME_MASK)
+		return;
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_PMC, &pmc);
+	dev->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
+}
+
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_amd_pme_unsupported);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_amd_pme_supported);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_amd_pme_unsupported);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_amd_pme_supported);
+#endif /* CONFIG_SUSPEND */
-- 
2.34.1

