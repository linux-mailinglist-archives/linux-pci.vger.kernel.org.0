Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0958C25C883
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 20:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgICSLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 14:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICSLZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 14:11:25 -0400
Received: from localhost (55.sub-174-234-138.myvzw.com [174.234.138.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E17A20716;
        Thu,  3 Sep 2020 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599156684;
        bh=9OQ6/l82T1f7wosSp1Pg7MtoE6PYah+luXycZs6L/OM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KLjXtvFZMcMfcu3r4VRJUp0fWh0EnayfDlHlwFTOgpfVICGogs1eWfgbqX39Yr78h
         qaSRdtUZtGWLxe1afF4vOdEtYpkW/83mRW5wc74yt8XYBcH3eYH1Mzpfo0D3NZL6mg
         aSikEVDrBjGCWdsB5Bl6/i71zWElSP1w2F7QosbA=
Date:   Thu, 3 Sep 2020 13:11:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add a quirk to skip 1000 ms default link activation
 delay on some devices
Message-ID: <20200903181122.GA313490@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831093147.36775-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 31, 2020 at 12:31:47PM +0300, Mika Westerberg wrote:
> Kai-Heng Feng reported that it takes a long time (> 1 s) to resume
> Thunderbolt-connected devices from both runtime suspend and system sleep
> (s2idle).
> 
> This was because some Downstream Ports that support > 5 GT/s do not also
> support Data Link Layer Link Active reporting.  Per PCIe r5.0 sec 6.6.1:
> 
>   With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
>   software must wait a minimum of 100 ms after Link training completes
>   before sending a Configuration Request to the device immediately below
>   that Port. Software can determine when Link training completes by
>   polling the Data Link Layer Link Active bit or by setting up an
>   associated interrupt (see Section 6.7.3.3).
> 
> Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting,
> but at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and
> Intel JHL7540 Thunderbolt 3 Bridge [8086:15e7, 8086:15ea, 8086:15ef] do
> not.

Is there any erratum about this?  I'm just hoping to avoid the
maintenance hassle of adding new devices to the quirk.  If Intel
acknowledges this as a defect and has a plan to fix it, that would
help a lot.  If they *don't* think it's a defect, then maybe they have
a hint about how we should handle this generically.

> This adds a quirk for these devices that skips the the 1000 ms default
> link activation delay.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837
> Link: https://lore.kernel.org/r/20200514133043.27429-1-mika.westerberg@linux.intel.com
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Hi all,
> 
> The previous version of the patch can be found below:
> 
>   https://www.spinics.net/lists/linux-pci/msg97860.html
> 
> This version adds a quirk instead covering the two devices Kai-Heng Feng
> reported. I added Titan Ridge DD and 2C because I think they are affected
> as well.
> 
> Since the PCI IDs of these devices are now used in two places, I moved them
> from TBT driver to pci_ids.h.
> 
> @Kai-Heng, if you still have access to this hardware, it would be great if
> you could try this out.
> 
>  drivers/pci/pci.c         |  2 ++
>  drivers/pci/quirks.c      | 23 +++++++++++++++++++++++
>  drivers/thunderbolt/nhi.h |  4 ----
>  include/linux/pci.h       |  5 +++++
>  include/linux/pci_ids.h   |  4 ++++
>  5 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e39c5499770f..16b61def1d46 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4674,6 +4674,8 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>  	 * case, we wait for 1000 ms + any delay requested by the caller.
>  	 */
>  	if (!pdev->link_active_reporting) {
> +		if (active && pdev->skip_default_link_activation_delay)
> +			timeout = 0;
>  		msleep(timeout + delay);
>  		return true;
>  	}
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2a589b6d6ed8..9269abb6455d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3621,6 +3621,29 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
>  			quirk_thunderbolt_hotplug_msi);
>  
> +/*
> + * https://bugzilla.kernel.org/show_bug.cgi?id=206837
> + *
> + * Non-hotplug PCIe downstream ports of these devices do not support active
> + * link reporting but they are known to train the link within 100ms.
> + */
> +static void quirk_skip_default_link_activation_delay(struct pci_dev *pdev)
> +{
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
> +	    !pdev->link_active_reporting && !pdev->is_hotplug_bridge) {
> +		pci_dbg(pdev, "skipping 1000 ms default link activation delay\n");
> +		pdev->skip_default_link_activation_delay = true;
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE,
> +			quirk_skip_default_link_activation_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE,
> +			quirk_skip_default_link_activation_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE,
> +			quirk_skip_default_link_activation_delay);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE,
> +			quirk_skip_default_link_activation_delay);
> +
>  #ifdef CONFIG_ACPI
>  /*
>   * Apple: Shutdown Cactus Ridge Thunderbolt controller.
> diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
> index 80162e4b013f..c023091f6b4e 100644
> --- a/drivers/thunderbolt/nhi.h
> +++ b/drivers/thunderbolt/nhi.h
> @@ -58,7 +58,6 @@ extern const struct tb_nhi_ops icl_nhi_ops;
>  #define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_NHI            0x157d
>  #define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_BRIDGE         0x157e
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_NHI		0x15bf
> -#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE	0x15c0
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_NHI	0x15d2
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE	0x15d3
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_NHI	0x15d9
> @@ -66,11 +65,8 @@ extern const struct tb_nhi_ops icl_nhi_ops;
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI	0x15dc
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI	0x15dd
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI	0x15de
> -#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE	0x15e7
>  #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI		0x15e8
> -#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE	0x15ea
>  #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI		0x15eb
> -#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE	0x15ef
>  #define PCI_DEVICE_ID_INTEL_ICL_NHI1			0x8a0d
>  #define PCI_DEVICE_ID_INTEL_ICL_NHI0			0x8a17
>  #define PCI_DEVICE_ID_INTEL_TGL_NHI0			0x9a1b
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 835530605c0d..c44ee4337a2a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -444,6 +444,11 @@ struct pci_dev {
>  	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
>  	unsigned int	is_probed:1;		/* Device probing in progress */
>  	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
> +	/*
> +	 * Skip default 1000 ms wait on ports that do not support active
> +	 * link reporting (link_active_reporting == 0).
> +	 */
> +	unsigned int	skip_default_link_activation_delay:1;
>  	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1ab1e24bcbce..315b555b3444 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2711,6 +2711,10 @@
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE  0x1576
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
> +#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE  0x15c0
> +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE   0x15e7
> +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE   0x15ea
> +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE   0x15ef
>  #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
>  #define PCI_DEVICE_ID_INTEL_QAT_C3XXX	0x19e2
>  #define PCI_DEVICE_ID_INTEL_QAT_C3XXX_VF	0x19e3
> -- 
> 2.28.0
> 
