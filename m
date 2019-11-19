Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1987102E92
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 22:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfKSVuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 16:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfKSVuA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 16:50:00 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4176F22463;
        Tue, 19 Nov 2019 21:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574200199;
        bh=3V2L09toUxptX2c4GyIIq3dB2l2q1UOY0O+e0/o+suM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rxwMl4PFySKcal9t5bQekScNqvYp8/V7Vg4OFziNDWOAHrkDPZP1x+FBFhN/dUhY0
         IlYDw1UnAekPNEJwf2FSp8//tLhGUv3I3l7CccB4rt2bmHTcQudOSWWNWgBbAlnX6+
         Lg8TIQZi3wAjKzdlyG2C8qgByeqH9JZb/zo7DQ84=
Date:   Tue, 19 Nov 2019 15:49:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191119214955.GA223696@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017121901.13699-1-kherbst@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Dave]

On Thu, Oct 17, 2019 at 02:19:01PM +0200, Karol Herbst wrote:
> Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> states.
> 
> v2: convert to pci_dev quirk
>     put a proper technical explanation of the issue as a in-code comment
> v3: disable it only for certain combinations of intel and nvidia hardware
> v4: simplify quirk by setting flag on the GPU itself

I have zero confidence that we understand the real problem, but we do
need to do something with this.  I'll merge it for v5.5 if we get the
minor procedural stuff below straightened out.

> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Mika Westerberg <mika.westerberg@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> ---
>  drivers/pci/pci.c    |  7 ++++++
>  drivers/pci/quirks.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b97d9e10c9cc..02e71e0bcdd7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -850,6 +850,13 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  	   || (state == PCI_D2 && !dev->d2_support))
>  		return -EIO;
>  
> +	/*
> +	 * check if we have a bad combination of bridge controller and nvidia
> +         * GPU, see quirk_broken_nv_runpm for more info

Whitespace damage.  Capitalized incorrectly (see other comments
nearby).

> +	 */
> +	if (state != PCI_D0 && dev->broken_nv_runpm)
> +		return 0;
> +
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  
>  	/*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44c4ae1abd00..0006c9e37b6f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5268,3 +5268,56 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>  			      PCI_CLASS_DISPLAY_VGA, 8,
>  			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +/*
> + * Some Intel PCIe bridges cause devices to disappear from the PCIe bus after
> + * those were put into D3cold state if they were put into a non D0 PCI PM
> + * device state before doing so.

A device in D3cold is off the bus by definition.

IIUC the problem is that the sequence D0 -> D3hot -> D3cold -> D0 for
the GPU fails in the transition back to D0, while D0 -> D3cold -> D0
works fine.

So I guess the problem is that we can put the device in D3cold with no
problem, but if we put in D3hot before going to D3cold, the device
never comes back to D0.  Right?

> + * This leads to various issue different issues which all manifest differently,

s/issue different//

Actually, I think there's only one underlying issue with several
manifestations.

> + * but have the same root cause:
> + *  - AIML code execution hits an infinite loop (as the coe waits on device
> + *    memory to change).

s/AIML/AML/
s/coe/code/

> + *  - kernel crashes, as all pci reads return -1, which most code isn't able
> + *    to handle well enough.

s/pci/PCI/

More details about these crashes would be useful as we look at places
that *should* be able to handle errors like this.

> + *  - sudden shutdowns, as the kernel identified an unrecoverable error after
> + *    userspace tries to access the GPU.

This doesn't fit with the others and more details might be
informative here as well.

> + * In all cases dmesg will contain at least one line like this:
> + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
> + * followed by a lot of nouveau timeouts.
> + *
> + * ACPI code writes bit 0x80 to the not documented PCI register 0x248 of the
> + * PCIe bridge controller in order to power down the GPU.
> + * Nonetheless, there are other code paths inside the ACPI firmware which use
> + * other registers, which seem to work fine:
> + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
> + *  - 0xb0 bit 0x10 (link disable)

All these register addresses are device-specific, so they're useless
without identifying the device.  "lspci -vvnn" output would let us at
least connect this with something.  It would be nice to have that info
archived along with your acpidump and python repro scripts in a
bugzilla with the URL in the commit log.

These are likely in PCI capabilities.  If I make the leap of assuming
the "link disable" bit is PCI_EXP_LNKCTL_LD, that would mean the Link
Control register is at 0xb0 and the register at 0xbc would be the Root
Control register, and indeed 0x20 in Root Control is reserved.

I don't know what the relevance of all this is, though.  It's not
remarkable that accesses to these registers work.

Unless you mean you can access these registers *after* trying to put
the device back in D0, but other accesses to the device fail.  That
would indeed be very interesting.

> + * Changing the conditions inside the firmware by poking into the relevant
> + * addresses does resolve the issue, but it seemed to be ACPI private memory
> + * and not any device accessible memory at all, so there is no portable way of
> + * changing the conditions.
> + *
> + * The only systems where this behavior can be seen are hybrid graphics laptops
> + * with a secondary Nvidia Pascal GPU. It cannot be ruled out that this issue
> + * only occurs in combination with listed Intel PCIe bridge controllers and
> + * the mentioned GPUs or if it's only a hw bug in the bridge controller.
> + *
> + * But because this issue was NOT seen on laptops with an Nvidia Pascal GPU
> + * and an Intel Coffee Lake SoC, there is a higher chance of there being a bug
> + * in the bridge controller rather than in the GPU.

I don't think we can conclude anything about where the defect is and I
don't think speculating here will help future readers of this code.

I *would* still like to see a bugzilla listing the systems where this
problem has been seen with the "lspci -vvnn", dmesg logs, and at least
one acpidump.  I think there's more to this story, and I suspect we
may be revisiting this in the future.

> + * This issue was not able to be reproduced on non laptop systems.
> + */
> +
> +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
> +
> +	if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> +	    bridge->device == 0x1901)

pci_upstream_bridge() may return NULL, so you need

  if (bridge && bridge->vendor == PCI_VENDOR_ID_INTEL ...

https://lore.kernel.org/r/20190927144421.22608-1-kherbst@redhat.com
says Skylake and Kaby Lake SoCs are affected.  But here you only check
for one Device ID?

> +		dev->broken_nv_runpm = 1;
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +			      PCI_BASE_CLASS_DISPLAY, 16,
> +			      quirk_broken_nv_runpm);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ac8a6c4e1792..903a0b3a39ec 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -416,6 +416,7 @@ struct pci_dev {
>  	unsigned int	__aer_firmware_first_valid:1;
>  	unsigned int	__aer_firmware_first:1;
>  	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
> +	unsigned int	broken_nv_runpm:1;	/* some combinations of intel bridge controller and nvidia GPUs break rtd3 */
>  	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
>  	unsigned int	irq_managed:1;
>  	unsigned int	has_secondary_link:1;
> -- 
> 2.21.0
> 
