Return-Path: <linux-pci+bounces-2811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE04842965
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6262935CA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7B38DDF;
	Tue, 30 Jan 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVGcVwzg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7F125DA;
	Tue, 30 Jan 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632522; cv=none; b=YAazW5wNUV6IEQdyVk5Wul2dwFG1iBp71OEJKM8crfAAYC9lMtfr6PuOCClcGYLlp4bBLlsnDzNiOXQhsV1meEBMGc5MKvi4xOO3G07AoZ0QUA6lu5pG0XTQx91JB3JAFr0sAkztNJa8nOJTYkSjLrRu93IGeJSJFutznW0KDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632522; c=relaxed/simple;
	bh=LDQoCBJMt2yoZsgxzwkrnfxiZbMQ3oyQgxvBuZK6GWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fEfFppVWlM9iv6LUsxvCp8arkg9fY0yQRQTjLlp/MT3xmdCsuQ5UAARNJ8ic1gPb8CGqY3TWe3LUmyUSae6SDd2gCJnWzCkRRJmVk3+lFfDF2/wdUVKuLser4hej29C7wKh2hoC9wB6O2WLknirn/QTS8HCpt3pDzKrHRzkATns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVGcVwzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0FAC433F1;
	Tue, 30 Jan 2024 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706632521;
	bh=LDQoCBJMt2yoZsgxzwkrnfxiZbMQ3oyQgxvBuZK6GWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fVGcVwzg0pxo8gquIncbT0Sx/BRWRa7EPYa/RRpCWA0lwF2KGg40OQWpCKZVyawfv
	 kKxInbOOe0MiCDSSGAS87NdnOe1apLgnjNbI4p5NjqJlOV3/13x/ThRSfxjQW6a568
	 WHX4hlI/wDmX4yJTae4H8oqLsiBd/V9aqaRapdlX8mRusjjpEAUS0U0Z4YBX/xgB/U
	 VhnHh29X+TFcSAiBpPq0BYS0uJ/2HtZ7ivWxDblLVDx6FaBu8SSmifuyuvKNAtMlXw
	 /6o3o3xpthnzeY/l3//oF9UlvZawStm4m10Lc/e4vXoVKRwtXaRlHm8t2vNsq77C31
	 qqYHWZRFFeSfQ==
Date: Tue, 30 Jan 2024 10:35:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 2/2] PCI: vmd: enable PCI PM's L1 substates of remapped
 PCIe port and NVMe
Message-ID: <20240130163519.GA521777@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130100050.14182-2-jhp@endlessos.org>

Capitalize subject line to match history ("Enable PM L1 Substates ...")

On Tue, Jan 30, 2024 at 06:00:51PM +0800, Jian-Hong Pan wrote:
> The remmapped PCIe port and NVMe have PCI PM L1 substates capability on
> ASUS B1400CEAE, but they are disabled originally:

s/remmapped/remapped/
s/PCIe port/PCIe Root Port/ (all devices with Links have Ports, so we
can be a little more specific here)

I doubt "ASUS B1400CEAE" is relevant here.

> Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
> Substates by following "Section 5.5.4 of PCIe Base Spec Revision 5.0
> Version 0.1". Then, PCI PM's L1 substates control are enabled
> accordingly.

Reference PCIe r6.0 or r6.1, since r5.0 is almost 5 years old now.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
>  drivers/pci/controller/vmd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..b1bbe8e6075a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -738,6 +738,12 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  	vmd_bridge->native_dpc = root_bridge->native_dpc;
>  }
>  
> +static int vmd_power_on_pci_device(struct pci_dev *pdev, void *userdata)
> +{
> +	pci_set_power_state(pdev, PCI_D0);
> +	return 0;
> +}
> +
>  /*
>   * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
>   */
> @@ -928,6 +934,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(vmd->bus);
> +
> +	/*
> +	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
> +	 * Section 5.5.4 of PCIe Base Spec Revision 5.0 Version 0.1
> +	 */
> +	pci_walk_bus(vmd->bus, vmd_power_on_pci_device, NULL);

Sec 5.5.4 indeed says "If setting either or both of the enable bits
for PCI-PM L1 PM Substates, both ports must be configured ... while in
D0."

This applies to *all* PCIe devices, not just those below a VMD bridge,
so I'm not sure this is the right place to do this.  Is there anything
that prevents a similar issue for non-VMD hierarchies?

I guess the bridges (Root Ports and Switch Ports) must already be in
D0, or we wouldn't be able to enumerate anything below them, right?

It would be nice to connect this more closely with the L1 PM Substates
configuration.  I don't quite see the connection here.  The only path
I see for L1SS configuration is this:

  pci_scan_slot
    pcie_aspm_init_link_state
      pcie_aspm_cap_init
	aspm_l1ss_init

which of course is inside pci_scan_child_bus(), which happens *before*
this patch puts the devices in D0.  Where does the L1SS configuration
happen after this vmd_power_on_pci_device()?

>  	vmd_domain_reset(vmd);
>  
>  	/* When Intel VMD is enabled, the OS does not discover the Root Ports
> -- 
> 2.43.0
> 

