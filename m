Return-Path: <linux-pci+bounces-32760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD6B0E66C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 00:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4621C84A16
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 22:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157227A13D;
	Tue, 22 Jul 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxuAbmK9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF210F2
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223630; cv=none; b=JSxhq4uQcGA0Gw2BA/Bj9Resl7r5CFX+OwX0hFHfGslUqFjDQsBte5syAY5ifAs5ptcq8/6xH2XxuS0hiksIjZVGRvQkYDCa5ogTXFK/ZpFmtebRdg0S/UAO9bYlFxPbVMbUmgSJxXI1mxhKmEIUeegiVftp5PTzLIqCHZy5PuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223630; c=relaxed/simple;
	bh=4SjmcqJptCCcLvXydunh2ldjuY/Fx37Yzprf54vkzXw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C/2QE0gGB7lz8LQbF2pLHV0499mSmh7vf+NMT2O+T4LQi58hh+MrE7IQlXu2bnk0S3Tc4125YeUX9QnwbQBfIn3scZVRk6StnpMIzOeWGWUbNEo91TkRaj17lvH45zFZSBCORcD49/xUVlUx6q5GWrQrSFroy3GgGZh+PpXzQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxuAbmK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A3AC4CEEB;
	Tue, 22 Jul 2025 22:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753223629;
	bh=4SjmcqJptCCcLvXydunh2ldjuY/Fx37Yzprf54vkzXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BxuAbmK9I57mxOXKbMBACqC4kkr6CyDlMpsh2iJegtSX26sjDAxSuE3HRD+KGy6UH
	 2gHyTD5WjdEBGI1wU0GZ6TDTMB6PxLDQtkUb+qLHzcgPmntO/Sumg88/VCHmEhHkaV
	 ycnRzfiWfRHeN4l7T+wvWH30526AyinJIr+qBNvtIOLnef+3ILPfJvowzzIW/5ECM5
	 wpK/MzliwbLu+F/2g/OT3BaUWdg13V4eKklmxDfa/8iswKgt0AU3lDF34EnTv3EI68
	 t+v536VHtTja/Z7K5vAxEECtO1ruEXwaq/WRIZk8Boa9wrFKzAQu37pUG01il1cznO
	 AhAUUrGENkjgw==
Date: Tue, 22 Jul 2025 17:33:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Gil Fine <gil.fine@linux.intel.com>,
	Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 5/5] PCI: Set native_pcie_hotplug up front based on
 pcie_ports_native
Message-ID: <20250722223348.GA2856499@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db299ce6-314c-41d2-85a4-118f0ac420e1@linux.intel.com>

On Mon, Jul 14, 2025 at 04:50:45PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 7/14/25 4:00 PM, Sathyanarayanan Kuppuswamy wrote:
> > 
> > On 7/13/25 7:31 AM, Lukas Wunner wrote:
> > > Bjorn suggests to "set host->native_pcie_hotplug up front based on
> > > CONFIG_HOTPLUG_PCI_PCIE and pcie_ports_native, and pciehp_is_native()
> > > would collapse to just an accessor for host->native_pcie_hotplug".
> > > 
> > > Unfortunately only half of this is possible:
> > > 
> > > The check for pcie_ports_native can indeed be moved out of
> > > pciehp_is_native() and into acpi_pci_root_create().
> > > 
> > > The check for CONFIG_HOTPLUG_PCI_PCIE however cannot be eliminated:
> > > 
> > > get_port_device_capability() needs to know whether platform firmware has
> > > granted PCIe Native Hot-Plug control to the operating system. If it has
> > > and CONFIG_HOTPLUG_PCI_PCIE is disabled, the function disables hotplug
> > > interrupts in case BIOS left them enabled.
> > > 
> > > If host->native_pcie_hotplug would be set up front based on
> > > CONFIG_HOTPLUG_PCI_PCIE, it would later on be impossible for
> > > get_port_device_capability() to tell whether it can safely disable hotplug
> > > interrupts:  It wouldn't know whether Native Hot-Plug control was granted.
> > 
> > Since pcie_ports_native is a PCI driver specific override option, I am not
> > sure it is worth referring to this option in ACPI driver, just to reduce the
> > number of pcie_ports_native checks from 2 to 1.
> 
> Never mind. It looks like the goal is to simplify the
> pciehp_is_native() call.

I would actually like to see more uses of pcie_ports_native removed.
It's basically an override of the OS/platform negotiation for control
of features, so I think it would make sense to test it somewhere in
the negotiate_os_control() rats nest or in acpi_pci_root_create().

> > > Link: https://lore.kernel.org/r/20250627025607.GA1650254@bhelgaas/
> > > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > ---
> > >   drivers/acpi/pci_root.c    | 3 ++-
> > >   drivers/pci/pci-acpi.c     | 3 ---
> > >   drivers/pci/pcie/portdrv.c | 2 +-
> > >   3 files changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index 74ade4160314..f3de0dc9c533 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -1028,7 +1028,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> > >           goto out_release_info;
> > >         host_bridge = to_pci_host_bridge(bus->bridge);
> > > -    if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> > > +    if (!pcie_ports_native &&
> > > +        !(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> > >           host_bridge->native_pcie_hotplug = 0;
> > >       if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
> > >           host_bridge->native_shpc_hotplug = 0;
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index ed7ed66a595b..b513826ea293 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -820,9 +820,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
> > >       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> > >           return false;
> > >   -    if (pcie_ports_native)
> > > -        return true;
> > > -
> > >       host = pci_find_host_bridge(bridge->bus);
> > >       return host->native_pcie_hotplug;
> > >   }
> > > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > > index d1b68c18444f..fa83ebdcfecb 100644
> > > --- a/drivers/pci/pcie/portdrv.c
> > > +++ b/drivers/pci/pcie/portdrv.c
> > > @@ -223,7 +223,7 @@ static int get_port_device_capability(struct pci_dev *dev)
> > >       if (dev->is_pciehp &&
> > >           (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > >            pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> > > -        (pcie_ports_native || host->native_pcie_hotplug)) {
> > > +        host->native_pcie_hotplug) {
> > >           services |= PCIE_PORT_SERVICE_HP;
> > >             /*
> > 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

