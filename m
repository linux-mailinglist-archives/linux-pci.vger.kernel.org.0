Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5FEC0D6D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 23:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfI0Vm4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 17:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfI0Vm4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 17:42:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA2621655;
        Fri, 27 Sep 2019 21:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569620574;
        bh=woe0ZidU/l62b9rCpbymA++FhqsxoRS+ZiXvjj9sMeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bA51B+GY3JK+tXvmbY6GN1FvBXIECJHNatpEzzJbjStASusXSlvaNiwNoX2vTIST/
         hFmLxZlQt+6FXLDpvWSdX5kwq+dAgthqeEm2fFhAvkbKAPIE0SApGkoR2e1ZEFZmr5
         WgISIXqeBL0G1IOgIHtFmF1ooPEF4YJ4dSWZMm1E=
Date:   Fri, 27 Sep 2019 16:42:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
Message-ID: <20190927214252.GA65801@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927144421.22608-1-kherbst@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Mika, linux-pm]

On Fri, Sep 27, 2019 at 04:44:21PM +0200, Karol Herbst wrote:
> Fixes runpm breakage mainly on Nvidia GPUs as they are not able to resume.

I don't know what runpm is.  Some userspace utility?  Module
parameter?

> Works perfectly with this workaround applied.
> 
> RFC comment:
> We are quite sure that there is a higher amount of bridges affected by this,
> but I was only testing it on my own machine for now.
> 
> I've stresstested runpm by doing 5000 runpm cycles with that patch applied
> and never saw it fail.
> 
> I mainly wanted to get a discussion going on if that's a feasable workaround
> indeed or if we need something better.
> 
> I am also sure, that the nouveau driver itself isn't at fault as I am able
> to reproduce the same issue by poking into some PCI registers on the PCIe
> bridge to put the GPU into D3cold as it's done in ACPI code.
> 
> I've written a little python script to reproduce this issue without the need
> of loading nouveau:
> https://raw.githubusercontent.com/karolherbst/pci-stub-runpm/master/nv_runpm_bug_test.py

Nice script, thanks for sharing it :)  I could learn a lot of useful
python by studying it.

> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> ---
>  drivers/pci/pci.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 088fcdc8d2b4..9dbd29ced1ac 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -799,6 +799,42 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
>  }
>  
> +/*
> + * some intel bridges cause serious issues with runpm if the client device
> + * is put into D1/D2/D3hot before putting the client into D3cold via
> + * platform means (generally ACPI).

You mention Nvidia GPUs above, but I guess the same issue may affect
other devices?  I would really like to chase this down to a more
specific issue, e.g., a hardware defect with erratum, an ACPI defect,
or a Linux defect.  Without the specifics, this is just a band-aid.

I don't see any relevant requirements in the _OFF description, but I
don't know much about ACPI power control.

Your script allows several scenarios; I *guess* the one that causes
the problem is:

  - write 3 (D3hot) to GPU PowerState (PCIE_PM_REG == 0x64, I assume
    PM Capability Control Register)
  - write 3 (D3hot) to bridge PowerState (0x84, I assume PM Capability
    Control Register)
  - run _OFF on the power resource for the bridge

From your script I assume you do:

  - run _ON on the power resource for the bridge
  - write 0 (D0) to the bridge PowerState

You do *not* write the GPU PowerState (which we can't do if the GPU is
in D3cold).  Is there some assumption that it comes out of D3cold via
some other mechanism, e.g., is the _ON supposed to wake up the GPU?

What exactly is the serious issue?  I guess it's that the rescan
doesn't detect the GPU, which means it's not responding to config
accesses?  Is there any timing component here, e.g., maybe we're
missing some delay like the ones Mika is adding to the reset paths?

> + *
> + * skipping this makes runpm work perfectly fine on such devices.
> + *
> + * As far as we know only skylake and kaby lake SoCs are affected.
> + */
> +static unsigned short intel_broken_d3_bridges[] = {
> +	/* kbl */
> +	0x1901,
> +};
> +
> +static inline bool intel_broken_pci_pm(struct pci_bus *bus)
> +{
> +	struct pci_dev *bridge;
> +	int i;
> +
> +	if (!bus || !bus->self)
> +		return false;
> +
> +	bridge = bus->self;
> +	if (bridge->vendor != PCI_VENDOR_ID_INTEL)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(intel_broken_d3_bridges); i++) {
> +		if (bridge->device == intel_broken_d3_bridges[i]) {
> +			pci_err(bridge, "found broken intel bridge\n");

If this ends up being a hardware defect, we should use a quirk to set
a bit in the pci_dev once, as we do for broken_intx_masking and
similar bits.

> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * pci_raw_set_power_state - Use PCI PM registers to set the power state of
>   *			     given PCI device
> @@ -827,6 +863,9 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  	if (state < PCI_D0 || state > PCI_D3hot)
>  		return -EINVAL;
>  
> +	if (state != PCI_D0 && intel_broken_pci_pm(dev->bus))
> +		return 0;
> +
>  	/*
>  	 * Validate current state:
>  	 * Can enter D0 from any state, but if we can only go deeper
> -- 
> 2.21.0
> 
