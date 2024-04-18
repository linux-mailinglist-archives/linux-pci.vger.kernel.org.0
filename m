Return-Path: <linux-pci+bounces-6455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5AB8AA200
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 20:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1136280FAF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EF9179204;
	Thu, 18 Apr 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahfZudeT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2E177980
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464816; cv=none; b=HEpLwHj5iAcENNWi6JgVMGJ9mkd2Awoeho3MA8vco17mX8EaB19ZEBfynZZDbYMqMghn+xdyURJgliZyFkMkpGWn75aWUOHRvL+wK8Fi5PPW6TUrx4JvJ+xfPCth/qvyEN6xhL0SuNA3m1YLddAp0MreciFYgveiTKT74Wlr2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464816; c=relaxed/simple;
	bh=05nvQ3xl+x0Pu/fxyncjMwnz7bqzBIEFYqfRUk8q+wI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wlyq4kyTetaHNtNIvdu3tC0TIuKfvMZUFnxIRZxwgJiFb3mUK9hk9Q7zT9KZ639TU6f6tFdJ+/nd7TSMl8kpsapCBA7DFd1ZsLTebvygmDEq98RR+hb8kQhverMr0TjjUobak1xKbfdG3Tcua/Cl8YUzi9yCkU/oWD7dzii7UrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahfZudeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7256FC113CC;
	Thu, 18 Apr 2024 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713464815;
	bh=05nvQ3xl+x0Pu/fxyncjMwnz7bqzBIEFYqfRUk8q+wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ahfZudeT58wssTfTBHL2D7D15G+yJkTPXDZvXpNDGSbXdrrmSvVGL1CPFRMgXaz60
	 yKIobJdGE60jvorYFYZ3EnnwePmB+vM0XJXCMfGa2SO7ljJ0IUarpsDQLno5sCFL21
	 miq3GRnWR9k2T0WC2hh2VykbC3frZcbLHErp6gq7jFacX0V67wNvcOKWPSfwInEwYr
	 IJ9GeV6KfgeqG1ARcpIRbxEepFZxn6nIfI8WfPTGsWS8ymq7N3HInMnBk7D0cxTUoT
	 Hs6JA36DrNB6dW+6H23qie7K0mvlfCIGcDOlJtRxVoLs4mZeRMKmhUWJGLuYTa0kZR
	 bOBdIWaScMefQ==
Date: Thu, 18 Apr 2024 13:26:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240418182653.GA216968@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417201542.102-1-paul.m.stillwell.jr@intel.com>

[+cc Keith]

On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
> Adding documentation for the Intel VMD driver and updating the index
> file to include it.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  Documentation/PCI/controller/vmd.rst | 51 ++++++++++++++++++++++++++++
>  Documentation/PCI/index.rst          |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/PCI/controller/vmd.rst
> 
> diff --git a/Documentation/PCI/controller/vmd.rst b/Documentation/PCI/controller/vmd.rst
> new file mode 100644
> index 000000000000..e1a019035245
> --- /dev/null
> +++ b/Documentation/PCI/controller/vmd.rst
> @@ -0,0 +1,51 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +=================================================================
> +Linux Base Driver for the Intel(R) Volume Management Device (VMD)
> +=================================================================
> +
> +Intel vmd Linux driver.
> +
> +Contents
> +========
> +
> +- Overview
> +- Features
> +- Limitations
> +
> +The Intel VMD provides the means to provide volume management across separate
> +PCI Express HBAs and SSDs without requiring operating system support or
> +communication between drivers. It does this by obscuring each storage
> +controller from the OS, but allowing a single driver to be loaded that would
> +control each storage controller. A Volume Management Device (VMD) provides a
> +single device for a single storage driver. The VMD resides in the IIO root

I'm not sure IIO (and PCH below) are really relevant to this.  I think
we really just care about the PCI topology enumerable by the OS.  If
they are relevant, expand them on first use as you did for VMD so we
have a hint about how to learn more about it.

> +complex and it appears to the OS as a root bus integrated endpoint. In the IIO,

I suspect "root bus integrated endpoint" means the same as "Root
Complex Integrated Endpoint" as defined by the PCIe spec?  If so,
please use that term and capitalize it so there's no confusion.

> +the VMD is in a central location to manipulate access to storage devices which
> +may be attached directly to the IIO or indirectly through the PCH. Instead of
> +allowing individual storage devices to be detected by the OS and allow it to
> +load a separate driver instance for each, the VMD provides configuration
> +settings to allow specific devices and root ports on the root bus to be
> +invisible to the OS.

How are these settings configured?  BIOS setup menu?

> +VMD works by creating separate PCI domains for each VMD device in the system.
> +This makes VMD look more like a host bridge than an endpoint so VMD must try
> +to adhere to the ACPI Operating System Capabilities (_OSC) flags of the system.

As Keith pointed out, I think this needs more details about how the
hardware itself works.  I don't think there's enough information here
to maintain the OS/platform interface on an ongoing basis.

I think "creating a separate PCI domain" is a consequence of providing
a new config access mechanism, e.g., a new ECAM region, for devices
below the VMD bridge.  That hardware mechanism is important to
understand because it means those downstream devices are unknown to
anything that doesn't grok the config access mechanism.  For example,
firmware wouldn't know anything about them unless it had a VMD driver.

Some of the pieces that might help figure this out:

  - Which devices (VMD bridge, VMD Root Ports, devices below VMD Root
    Ports) are enumerated in the host?

  - Which devices are passed through to a virtual guest and enumerated
    there?

  - Where does the vmd driver run (host or guest or both)?

  - Who (host or guest) runs the _OSC for the new VMD domain?

  - What happens to interrupts generated by devices downstream from
    VMD, e.g., AER interrupts from VMD Root Ports, hotplug interrupts
    from VMD Root Ports or switch downstream ports?  Who fields them?
    In general firmware would field them unless it grants ownership
    via _OSC.  If firmware grants ownership (or the OS forcibly takes
    it by overriding it for hotplug), I guess the OS that requested
    ownership would field them?

  - How do interrupts (hotplug, AER, etc) for things below VMD work?
    Assuming the OS owns the feature, how does the OS discover them?
    I guess probably the usual PCIe Capability and MSI/MSI-X
    Capabilities?  Which OS (host or guest) fields them?

> +A couple of the _OSC flags regard hotplug support.  Hotplug is a feature that
> +is always enabled when using VMD regardless of the _OSC flags.

We log the _OSC negotiation in dmesg, so if we ignore or override _OSC
for hotplug, maybe that should be made explicit in the logging
somehow?

> +Features
> +========
> +
> +- Virtualization
> +- MSIX interrupts
> +- Power Management
> +- Hotplug

s/MSIX/MSI-X/ to match spec usage.

I'm not sure what this list is telling us.

> +Limitations
> +===========
> +
> +When VMD is enabled and used in a hypervisor the _OSC flags provided by the
> +hypervisor BIOS may not be correct. The most critical of these flags are the
> +hotplug bits. If these bits are incorrect then the storage devices behind the
> +VMD will not be able to be hotplugged. The driver always supports hotplug for
> +the devices behind it so the hotplug bits reported by the OS are not used.

"_OSC may not be correct" sounds kind of problematic.  How does the
OS deal with this?  How does the OS know whether to pay attention to
_OSC or ignore it because it tells us garbage?

If we ignore _OSC hotplug bits because "we know what we want, and we
know we won't conflict with firmware," how do we deal with other _OSC
bits?  AER?  PME?  What about bits that may be added in the future?
Is there some kind of roadmap to help answer these questions?

Bjorn

