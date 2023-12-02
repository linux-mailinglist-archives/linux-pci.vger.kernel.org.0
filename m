Return-Path: <linux-pci+bounces-374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6148018AB
	for <lists+linux-pci@lfdr.de>; Sat,  2 Dec 2023 01:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5EC1C21055
	for <lists+linux-pci@lfdr.de>; Sat,  2 Dec 2023 00:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8C193;
	Sat,  2 Dec 2023 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsliWN0r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF67E3
	for <linux-pci@vger.kernel.org>; Sat,  2 Dec 2023 00:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34F0C433C8;
	Sat,  2 Dec 2023 00:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475626;
	bh=U3ZfPKYPrqpYV93YIVm8COX6PQZ+rUbytLa7eckVlrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hsliWN0rNuZ/y68RhnrzRVhxG2S6mRyLA5xAkZcYpX9gPx0yf1tsI7aR5vcbnkcyv
	 sdpVzxmwm00FDVhobsoVUmVf2ErY+4eB8WWBg3I/IfIxLwgM7KAv598IBbstJuge/z
	 Rqv+FX3cxcpqSVPwj5kSUL57L7s36N9gGdRlkADIAkADAPMRz9MnZgrHVjNLlD2cee
	 oACj0MWA0hDMl/9cQAipXuK/EuMdDhjGAsv66rO3k6hgZXVO6NRogGbkk36eleKrZH
	 nkHmAC51iUA4ygm3BsCHgNj7+mKhBxy67QVbK/ffwNvdm8IZ56cPW1eQw5n7TYYGNA
	 p/31yi7d/qb1g==
Date: Fri, 1 Dec 2023 18:07:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20231202000704.GA529403@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127211729.42668-1-nirmal.patel@linux.intel.com>

On Mon, Nov 27, 2023 at 04:17:29PM -0500, Nirmal Patel wrote:
> Currently VMD copies root bridge setting to enable Hotplug on its
> rootports. This mechanism works fine for Host OS and no issue has
> been observed. However in case of VM, all the HyperVisors don't
> pass the Hotplug setting to the guest BIOS which results in
> assigning default values and disabling Hotplug capability in the
> guest which have been observed by many OEMs.

Can we make this a little more specific?  I'm lacking a lot of
virtualization background here, so I'm going to ask a bunch of stupid
questions here:

"VMD copies root bridge setting" refers to _OSC and the copying done
in vmd_copy_host_bridge_flags()?  Obviously this must be in the Host
OS.

"This mechanism works fine for Host OS and no issue has been
observed."  I guess this means that if the platform grants hotplug
control to the Host OS via _OSC, pciehp in the Host OS works fine to
manage hotplug on Root Ports below the VMD?

If the platform does *not* grant hotplug control to the Host OS, I
guess it means the Host OS pciehp can *not* manage hotplug below VMD?
Is that also what you expect?

"However in case of VM, all the HyperVisors don't pass the Hotplug
setting to the guest BIOS"  What is the mechanism by which they would
pass the hotplug setting?  I guess the guest probably doesn't see the
VMD endpoint itself, right?  The guest sees either virtualized or
passed-through VMD Root Ports?

I assume the guest OS sees a constructed ACPI system (different from
the ACPI environment the host sees), so it sees a PNP0A03 host bridge
with _OSC?  And presumably VMD Root Ports below that host bridge?

So are you saying the _OSC seen by the guest doesn't grant hotplug
control to the guest OS?  And it doesn't do that because the guest
BIOS hasn't implemented _OSC?  Or maybe the guest BIOS relies on the
Slot Capabilities registers of VMD Root Ports to decide whether _OSC
should grant hotplug control?  And those Slot Capabilities don't
advertise hotplug support?

"... which results in assigning default values and disabling Hotplug
capability in the guest."  What default values are these?  Is this
talking about the default host_bridge->native_pcie_hotplug value set
in acpi_pci_root_create(), where the OS assumes hotplug is owned by
the platform unless _OSC grants control to the OS?

> VMD Hotplug can be enabled or disabled based on the VMD rootports'
> Hotplug configuration in BIOS. is_hotplug_bridge is set on each
> VMD rootport based on Hotplug capable bit in SltCap in probe.c.
> Check is_hotplug_bridge and enable or disable native_pcie_hotplug
> based on that value.
> 
> This patch will make sure that Hotplug is enabled properly in Host
> as well as in VM while honoring _OSC settings as well as VMD hotplug
> setting.

"Hotplug is enabled properly in Host as well as in VM" sounds like
we're talking about both the host OS and the guest OS.

In the host OS, this overrides whatever was negotiated via _OSC, I
guess on the principle that _OSC doesn't apply because the host BIOS
doesn't know about the Root Ports below the VMD.  (I'm not sure it's
100% resolved that _OSC doesn't apply to them, so we should mention
that assumption here.)

In the guest OS, this still overrides whatever was negotiated via
_OSC, but presumably the guest BIOS *does* know about the Root Ports,
so I don't think the same principle about overriding _OSC applies
there.

I think it's still a problem that we handle
host_bridge->native_pcie_hotplug differently than all the other
features negotiated via _OSC.  We should at least explain this
somehow.

I suspect part of the reason for doing it differently is to avoid the
interrupt storm that we avoid via 04b12ef163d1 ("PCI: vmd: Honor ACPI
_OSC on PCIe features").  If so, I think 04b12ef163d1 should be
mentioned here because it's an important piece of the picture.

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v1->v2: Updating commit message.
> ---
>  drivers/pci/controller/vmd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..e39eaef5549a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -720,6 +720,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	resource_size_t membar2_offset = 0x2000;
>  	struct pci_bus *child;
>  	struct pci_dev *dev;
> +	struct pci_host_bridge *vmd_bridge;
>  	int ret;
>  
>  	/*
> @@ -886,8 +887,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * and will fail pcie_bus_configure_settings() early. It can instead be
>  	 * run on each of the real root ports.
>  	 */
> -	list_for_each_entry(child, &vmd->bus->children, node)
> +	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
> +	list_for_each_entry(child, &vmd->bus->children, node) {
>  		pcie_bus_configure_settings(child);
> +		/*
> +		 * When Hotplug is enabled on vmd root-port, enable it on vmd
> +		 * bridge.
> +		 */
> +		if (child->self->is_hotplug_bridge)
> +			vmd_bridge->native_pcie_hotplug = 1;

"is_hotplug_bridge" basically means PCI_EXP_SLTCAP_HPC is set, which
means "the hardware of this slot is hot-plug *capable*."

Whether hotplug is *enabled* is a separate policy decision about
whether the OS is allowed to operate the hotplug functionality, so I
think saying "When Hotplug is enabled" in the comment is a little bit
misleading.

Bjorn

> +	}
>  
>  	pci_bus_add_devices(vmd->bus);
>  
> -- 
> 2.31.1
> 

