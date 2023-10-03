Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57F7B6FA9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 19:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbjJCRYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 13:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjJCRYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 13:24:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35795;
        Tue,  3 Oct 2023 10:24:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F53C433C8;
        Tue,  3 Oct 2023 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696353889;
        bh=t5TcwtsV75eUu3K2UjTEvRlUunCyPNKs2VnPat85+zQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P1JZ8MamuBpf8X+5XKHGBmCngnqcmcmRz/Gt+QzvIDAB7iZyRJYDMKOpzNMcHcjRH
         /0zdnzFrs2qrYHOH5ocvnp3hmRuAOelgG2C7n9vWhCtXwrHysn+t7mTkCskBiW9UWt
         ZPavDslsiqztB0CzRT09uYPNLVrS482xFGB4IesY4jYj1VIMKhjgBGXx4tJgNnpIXX
         J5Pz+6o/A5AezKOrt+yya55Owihn6Vp9QwNgNkxevvg4aq0ALCSk/kgWAFb0xeXKGb
         VhD88mesrKvJh6dRDl0mN4xM0yO5n+7lmaW6UvMlLVNXP/+xouv0g/Gfip16X0DMPm
         Af1yGX2kg044A==
Date:   Tue, 3 Oct 2023 12:24:47 -0500
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
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231003172447.GA679295@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002180906.82089-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
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
> Cc: stable@vger.kernel.org # 6.1.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
> Cc: stable@vger.kernel.org # 6.5.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
> Cc: stable@vger.kernel.org # 6.6.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v20-v21:
>  * Rewrite commit message, lifting most of what Bjorn clipped down to on v20.
>  * Use pci_d3cold_disable()/pci_d3cold_enable() instead
>  * Do the quirk on the USB4 controller instead of RP->USB->RP
> ---
>  drivers/pci/quirks.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..5674065011e7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6188,3 +6188,47 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
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
> + * When suspending, disable D3 support for the Root Port so we don't use it.
> + * Restore D3 support when resuming.
> + */
> +static void quirk_enable_rp_d3cold(struct pci_dev *dev)
> +{
> +	pci_d3cold_enable(pcie_find_root_port(dev));
> +}
> +
> +static void quirk_disable_rp_d3cold_suspend(struct pci_dev *dev)
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
> +	pci_d3cold_disable(rp);

I think this prevents D3cold from being used at all, right?

Two questions:

  - PME also doesn't work in D3hot, right?

  - Is it OK to use D3hot and D3cold if we don't have a wakeup device
    below the Root Port?  I assume that scenario is possible?

I like the fact that we don't have to walk the hierarchy with
pci_walk_bus().

> +	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
> +}
> +/* Rembrandt (yellow_carp) */
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, quirk_disable_rp_d3cold_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, quirk_enable_rp_d3cold);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, quirk_disable_rp_d3cold_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, quirk_enable_rp_d3cold);
> +/* Phoenix (pink_sardine) */
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, quirk_disable_rp_d3cold_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, quirk_enable_rp_d3cold);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, quirk_disable_rp_d3cold_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, quirk_enable_rp_d3cold);
> +#endif /* CONFIG_SUSPEND */
> -- 
> 2.34.1
> 
