Return-Path: <linux-pci+bounces-6603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D58AFD71
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 02:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488A12824B1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 00:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807564689;
	Wed, 24 Apr 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6I0TbLt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92823BE
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919655; cv=none; b=hlKMFIKW5HDmu3RWaZWEXK3kD/uNbX/xD7x2cXpWQd8g7BDp73eHqegOq1YPNDHBMv5NPNnMrNYNz7HrWAbULeNWnQz3YxEWDKgGTXfSJhmo8+kxfhCtPft6P09VvI+I1qTeZsXQQKuP/XN7tpHl4tfuZN5o75nCfYktVxAjRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919655; c=relaxed/simple;
	bh=3+Mb/IThOXoIXZB0suNvvn0yq5Gb9g9ovbyzwbbM9Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aHSjsDRD0uMAsBuyAbBiJ3yDspIWkiosmXsl2dhM2LCwPPWlHndyIle6/MWn5hFXFaFFRpVWKOxCR8kbiG7NEXVQ9vqbMOXjY6FkxNNqYuK4ldAux+Z+uNcIrI1aCzjKryueIyMP11pYxkQZzXUQzHubVKwqQP+FF07xXBuiRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6I0TbLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85CFC116B1;
	Wed, 24 Apr 2024 00:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713919654;
	bh=3+Mb/IThOXoIXZB0suNvvn0yq5Gb9g9ovbyzwbbM9Lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b6I0TbLtxLOY68POnvAwadmWXaM2+eo0l3wB/grcI1bLakPEdFl7NEf/txMHBW9Tf
	 B/8tRXlJFPx4hB4RAwrt2uJnJhkTCDMGxVXMuLcqElEp0iFtk7ml4iACjxYuY+lOXo
	 3iXjKhpeZ9W+xOhDFL3WzQlnTYSdVyoOGA7ih7fcfQ2Qp8+AXXLQO76s/276B2qXsL
	 Gj6L/aP4V7KElONq7wMfhziHx2scHgl9KmobKxYQY2pO1MjaMHYfTWDQnBGBiAhtKc
	 Eym1IbRKfdFwLUTuiqysg71lnw5RGjYXVtlrehNaX1oiGceBKGM7aB3bKOV1lYA/wY
	 BQdHiJTqFrQkg==
Date: Tue, 23 Apr 2024 19:47:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240424004733.GA476130@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413d99f0-0af5-477e-a3cb-84f0955407d0@intel.com>

On Tue, Apr 23, 2024 at 04:10:37PM -0700, Paul M Stillwell Jr wrote:
> On 4/23/2024 2:26 PM, Bjorn Helgaas wrote:
> > On Mon, Apr 22, 2024 at 04:39:19PM -0700, Paul M Stillwell Jr wrote:
> > > On 4/22/2024 3:52 PM, Bjorn Helgaas wrote:
> > > > On Mon, Apr 22, 2024 at 02:39:16PM -0700, Paul M Stillwell Jr wrote:
> > > > > On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > > > _OSC negotiates ownership of features between platform firmware and
> > > > > > OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
> > > > > > device advertises the feature, the OS can use it."  We clear those
> > > > > > native_* bits if the platform retains ownership via _OSC.
> > > > > > 
> > > > > > If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
> > > > > > the domain below it, why would we assume that BIOS retains ownership
> > > > > > of the features negotiated by _OSC?  I think we have to assume the OS
> > > > > > owns them, which is what happened before 04b12ef163d1.
> > > > > 
> > > > > Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is disabled)
> > > > > then all the root ports and devices underneath VMD are visible to the BIOS
> > > > > and OS so ACPI would run on all of them and the _OSC bits should be set
> > > > > correctly.
> > > > 
> > > > Sorry, that was confusing.  I think there are two pieces to enabling
> > > > VMD:
> > > > 
> > > >     1) There's the BIOS "VMD enable" switch.  If set, the VMD device
> > > >     appears as an RCiEP and the devices behind it are invisible to the
> > > >     BIOS.  If cleared, VMD doesn't exist; the VMD RCiEP is hidden and
> > > >     the devices behind it appear as normal Root Ports with devices below
> > > >     them.
> > > > 
> > > >     2) When the BIOS "VMD enable" is set, the OS vmd driver configures
> > > >     the VMD RCiEP and enumerates things below the VMD host bridge.
> > > > 
> > > >     In this case, BIOS enables the VMD RCiEP, but it doesn't have a
> > > >     driver for it and it doesn't know how to enumerate the VMD Root
> > > >     Ports, so I don't think it makes sense for BIOS to own features for
> > > >     devices it doesn't know about.
> > > 
> > > That makes sense to me. It sounds like VMD should own all the features, I
> > > just don't know how the vmd driver would set the bits other than hotplug
> > > correctly... We know leaving them on is problematic, but I'm not sure what
> > > method to use to decide which of the other bits should be set or not.
> > 
> > My starting assumption would be that we'd handle the VMD domain the
> > same as other PCI domains: if a device advertises a feature, the
> > kernel includes support for it, and the kernel owns it, we enable it.
> 
> I've been poking around and it seems like some things (I was looking for
> AER) are global to the platform. In my investigation (which is a small
> sample size of machines) it looks like there is a single entry in the BIOS
> to enable/disable AER so whatever is in one domain should be the same in all
> the domains. I couldn't find settings for LTR or the other bits, but I'm not
> sure what to look for in the BIOS for those.
> 
> So it seems that there are 2 categories: platform global and device
> specific. AER and probably some of the others are global and can be copied
> from one domain to another, but things like hotplug are device specific and
> should be handled that way.

_OSC is the only mechanism for negotiating ownership of these
features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that _OSC
only applies to the hierarchy originated by the PNP0A03/PNP0A08 host
bridge that contains the _OSC method.  AFAICT, there's no
global/device-specific thing here.

The BIOS may have a single user-visible setting, and it may apply that
setting to all host bridge _OSC methods, but that's just part of the
BIOS UI, not part of the firmware/OS interface.

> > If a device advertises a feature but there's a hardware problem with
> > it, the usual approach is to add a quirk to work around the problem.
> > The Correctable Error issue addressed by 04b12ef163d1 ("PCI: vmd:
> > Honor ACPI _OSC on PCIe features"), looks like it might be in this
> > category.
> 
> I don't think we had a hardware problem with these Samsung (IIRC) devices;
> the issue was that the vmd driver were incorrectly enabling AER because
> those native_* bits get set automatically. 

Where do all the Correctable Errors come from?  IMO they're either
caused by some hardware issue or by a software error in programming
AER.  It's possible we forget to clear the errors and we just see the
same error reported over and over.  But I don't think the answer is
to copy the AER ownership from a different domain.

Bjorn

