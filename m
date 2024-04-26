Return-Path: <linux-pci+bounces-6702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3A8B414A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 23:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DA7282E59
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 21:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426E2C85F;
	Fri, 26 Apr 2024 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDfxjmy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F7376E6
	for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167394; cv=none; b=sqIhDKDxjudSpz/Z1TFRg0WhBKjnDTGCiSSuhfBEKR+ZUQ8xJuz1nunGclDjhnHYiNH7Vx+bEZnVCUrOq+SjD4xwGaaKDrKSKI4Afbo+ScEqS6s6lvn3wf2+NFi0KFY7dwsGEmc+pP+GL2Wwvl+ZcMfhsdlvVR9whFpA23ScEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167394; c=relaxed/simple;
	bh=TGlsc33Shhmp/lT2WcH/NokOXpLoGLNQosg2WnC2FkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=afDz+jSIwi1KNRvGeJ3OCI3y+qXBzvXKSj3Z/IwEqYcpKbTkn7L9QB+3XwkZD40cuVZaxhj5rAG+Xu9K9SNbAot1KXjd6c8VzCW7hOdpq5765zPJ4pTWB/FPdxeVGrwD2AA+k4iErpcUoWoPyrExmgcP8oj7evDrdthTj0BBu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDfxjmy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3E2C2BD11;
	Fri, 26 Apr 2024 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714167394;
	bh=TGlsc33Shhmp/lT2WcH/NokOXpLoGLNQosg2WnC2FkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aDfxjmy+RRW9eLNr2v1adPmd5YT0OBgkjYWhWsejOaV6gwgcpCkSq6Ygf5QuvKopi
	 eNEHDsMwkQENGY3XxrLW/+Z5bwvvi0+CkfW8pHwtLPSsWo8MLSd+sfHxchTUpMDC5a
	 ScRX67F6nB1bSzXIqdis4IYawUIkKxPDfvL30XUOurcVghGy5cqsBLt6wnsun0w6WS
	 1qnupxnZZgyMLejYt1gd1kqIDNa871fOsjf/T5H6gU6Oo/YPNbr6gmC8fV/0Ao/NEZ
	 wjAMnMVVCLuWSqwO6c3W8TkW9Dhwl5rRMUyBJGSmW1mT7e/BKVul+/k6VfPaCgW5O0
	 7xJGUZY/vM/gw==
Date: Fri, 26 Apr 2024 16:36:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240426213631.GA594688@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c5f46e-5649-4ab4-9828-5711dd06ee5d@intel.com>

On Thu, Apr 25, 2024 at 04:32:21PM -0700, Paul M Stillwell Jr wrote:
> On 4/25/2024 3:32 PM, Bjorn Helgaas wrote:
> > On Thu, Apr 25, 2024 at 02:43:07PM -0700, Paul M Stillwell Jr wrote:
> > > On 4/25/2024 10:24 AM, Bjorn Helgaas wrote:
> > > > On Wed, Apr 24, 2024 at 02:29:16PM -0700, Paul M Stillwell Jr wrote:
> > > > > On 4/23/2024 5:47 PM, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > > > _OSC is the only mechanism for negotiating ownership of these
> > > > > > features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that _OSC
> > > > > > only applies to the hierarchy originated by the PNP0A03/PNP0A08 host
> > > > > > bridge that contains the _OSC method.  AFAICT, there's no
> > > > > > global/device-specific thing here.
> > > > > > 
> > > > > > The BIOS may have a single user-visible setting, and it may apply that
> > > > > > setting to all host bridge _OSC methods, but that's just part of the
> > > > > > BIOS UI, not part of the firmware/OS interface.
> > > > > 
> > > > > Fair, but we are still left with the question of how to set the _OSC bits
> > > > > for the VMD bridge. This would normally happen using ACPI AFAICT and we
> > > > > don't have that for the devices behind VMD.
> > > > 
> > > > In the absence of a mechanism for negotiating ownership, e.g., an ACPI
> > > > host bridge device for the hierarchy, the OS owns all the PCIe
> > > > features.
> > > 
> > > I'm new to this space so I don't know what it means for the OS to
> > > own the features. In other words, how would the vmd driver figure
> > > out what features are supported?
> > 
> > There are three things that go into this:
> > 
> >    - Does the OS support the feature, e.g., is CONFIG_PCIEAER enabled?
> > 
> >    - Has the platform granted permission to the OS to use the feature,
> >      either explicitly via _OSC or implicitly because there's no
> >      mechanism to negotiate ownership?
> > 
> >    - Does the device advertise the feature, e.g., does it have an AER
> >      Capability?
> > 
> > If all three are true, Linux enables the feature.
> > 
> > I think vmd has implicit ownership of all features because there is no
> > ACPI host bridge device for the VMD domain, and (IMO) that means there
> > is no way to negotiate ownership in that domain.
> > 
> > So the VMD domain starts with all the native_* bits set, meaning Linux
> > owns the features.  If the vmd driver doesn't want some feature to be
> > used, it could clear the native_* bit for it.
> > 
> > I don't think vmd should unilaterally claim ownership of features by
> > *setting* native_* bits because that will lead to conflicts with
> > firmware.
> 
> This is the crux of the problem IMO. I'm happy to set the native_* bits
> using some knowledge about what the firmware wants, but we don't have a
> mechanism to do it AFAICT. I think that's what commit 04b12ef163d1 ("PCI:
> vmd: Honor ACPI _OSC on PCIe features") was trying to do: use a domain that
> ACPI had run on and negotiated features and apply them to the vmd domain.

Yes, this is the problem.  We have no information about what firmware
wants for the VMD domain because there is no ACPI host bridge device.

We have information about what firmware wants for *other* domains.
04b12ef163d1 assumes that also applies to the VMD domain, but I don't
think that's a good idea.

> Using the 3 criteria you described above, could we do this for the hotplug
> feature for VMD:
> 
> 1. Use IS_ENABLED(CONFIG_<whatever hotplug setting we need>) to check to see
> if the hotplug feature is enabled

That's already there.

> 2. We know that for VMD we want hotplug enabled so that is the implicit
> permission

The VMD domain starts with all native_* bits set.  All you have to do
is avoid *clearing* them.

The problem (IMO) is that 04b12ef163d1 clears bits based on the _OSC
for some other domain.

> 3. Look at the root ports below VMD and see if hotplug capability is set

This is already there, too.

> If 1 & 3 are true, then we set the native_* bits for hotplug (we can look
> for surprise hotplug as well in the capability to set the
> native_shpc_hotplug bit corrrectly) to 1. This feels like it would solve the
> problem of "what if there is a hotplug issue on the platform" because the
> user would have disabled hotplug for VMD and the root ports below it would
> have the capability turned off.
> 
> In theory we could do this same thing for all the features, but we don't
> know what the firmware wants for features other than hotplug (because we
> implicitly know that vmd wants hotplug). I feel like 04b12ef163d1 is a good
> compromise for the other features, but I hear your issues with it.
> 
> I'm happy to "do the right thing" for the other features, I just can't
> figure out what that thing is :)

04b12ef163d1 was motivated by a flood of Correctable Errors.

Kai-Heng says the errors occur even when booting with
"pcie_ports=native" and VMD turned off, i.e., when the VMD RCiEP is
disabled and the NVMe devices appear under plain Root Ports in domain
0000.  That suggests that they aren't related to VMD at all.

I think there's a significant chance that those errors are caused by a
software defect, e.g., ASPM configuration.  There are many similar
reports of Correctable Errors where "pcie_aspm=off" is a workaround.

If we can nail down the root cause of those Correctable Errors, we may
be able to fix it and just revert 04b12ef163d1.  That would leave all
the PCIe features owned and enabled by Linux in the VMD domain.  AER
would be enabled and not a problem, hotplug would be enabled as you
need, etc.

There are a zillion reports of these errors and I added comments to
some to see if anybody can help us get to a root cause.

Bjorn

