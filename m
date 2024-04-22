Return-Path: <linux-pci+bounces-6539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB31B8AD5CC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B318B20A51
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E721553AE;
	Mon, 22 Apr 2024 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4QTs0/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3F154BF9
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817663; cv=none; b=d8Txjh/XZ7PVy2cjpEYtP+XlXQWvItWW/PC8RHCvQCAV4hgTkmkm7h0W662U6Oja2jWNsIaXCX2OqU/TMAZa9w7tFavzAAv33pusppi6q1SElLZe/LGnw3GUqb1TilFSFM9IVomhgxUMJJAy7Nbsy7aVbHamDZ7nUFyaL7UWZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817663; c=relaxed/simple;
	bh=5FDdLmmjeSUErrscrt1zXOy6DdRqMBi6CWzjyamwLQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M6eA3ntLduqlJI2JUelUBH9eLMx94ucf+mABuBCuu1b6HEzTzn0e2s6RANgB1IXc3JW4bI0p70fw7TjsWrvOZBH14dzQve9wReGHRtWvr2QBCpWda7DLu19At08KdoxAYQCa2mhrddJXlMzuwEKicFmF2z8n7g4s2QETeyxJSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4QTs0/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB52C113CC;
	Mon, 22 Apr 2024 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713817662;
	bh=5FDdLmmjeSUErrscrt1zXOy6DdRqMBi6CWzjyamwLQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z4QTs0/YacYHRCjnJFSeA2IWOowLzIaPKP8/4nWJYD29dfO8vL4Fda95JUDMFKFxo
	 LRFL8qQLah0cSY6y39Xvb9MfER22kxP2zXLjF3YKNmDI5uiXciXIXKac/OSPIG+iLO
	 8IaHwMijHLNO08h2kCrVyKiopVqZjZQ2yKuEwncvrYUryDKvafjQ6cXZ//ezYqh63n
	 3DNfg1fLiU8RUE5buaUmdC2t61ycibzpjXINb+TkEeV+0nkNdArdwv8Hn9H554JhKo
	 g+OMxl+cL8kciql5LNHlr6iojdHTWjXgZ2E62rEpLnhTZxx/IV3l9payHqkWjLYV9K
	 eDXvgCnLl+RHw==
Date: Mon, 22 Apr 2024 15:27:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240422202740.GA415030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54e79c3-7a73-4ae8-b773-ae7c96559a31@intel.com>

On Fri, Apr 19, 2024 at 03:18:19PM -0700, Paul M Stillwell Jr wrote:
> On 4/19/2024 2:14 PM, Bjorn Helgaas wrote:
> > On Thu, Apr 18, 2024 at 02:51:19PM -0700, Paul M Stillwell Jr wrote:
> > > On 4/18/2024 11:26 AM, Bjorn Helgaas wrote:
> > > > On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
> > > > > Adding documentation for the Intel VMD driver and updating the index
> > > > > file to include it.

> > > >     - Which devices are passed through to a virtual guest and enumerated
> > > >       there?
> > > 
> > > All devices under VMD are passed to a virtual guest
> > 
> > So the guest will see the VMD Root Ports, but not the VMD RCiEP
> > itself?
> 
> The guest will see the VMD device and then the vmd driver in the guest will
> enumerate the devices behind it is my understanding
> 
> > > >     - Where does the vmd driver run (host or guest or both)?
> > > 
> > > I believe the answer is both.
> > 
> > If the VMD RCiEP isn't passed through to the guest, how can the vmd
> > driver do anything in the guest?
> 
> The VMD device is passed through to the guest. It works just like bare metal
> in that the guest OS detects the VMD device and loads the vmd driver which
> then enumerates the devices into the guest

I guess it's obvious that the VMD RCiEP must be passed through to the
guest because the whole point of
https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
is to do something in the guest.

It does puzzle me that we have two copies of the vmd driver (one in
the host OS and another in the guest OS) that think they own the same
physical device.  I'm not a virtualization guru but that sounds
potentially problematic.

> > IIUC, the current situation is "regardless of what firmware said, in
> > the VMD domain we want AER disabled and hotplug enabled."
> 
> We aren't saying we want AER disabled, we are just saying we want hotplug
> enabled. The observation is that in a hypervisor scenario AER is going to be
> disabled because the _OSC bits are all 0.

04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") is saying
we want AER disabled for the VMD domain, isn't it?

> > It seems like the only clear option is to say "the vmd driver owns all
> > PCIe services in the VMD domain, the platform does not supply _OSC for
> > the VMD domain, the platform can't do anything with PCIe services in
> > the VMD domain, and the vmd driver needs to explicitly enable/disable
> > services as it needs."
> 
> I actually looked at this as well :) I had an idea to set the _OSC bits to 0
> when the vmd driver created the domain. The look at all the root ports
> underneath it and see if AER and PM were set. If any root port underneath
> VMD set AER or PM then I would set the _OSC bit for the bridge to 1. That
> way if any root port underneath VMD had enabled AER (as an example) then
> that feature would still work. I didn't test this in a hypervisor scenario
> though so not sure what I would see.

_OSC negotiates ownership of features between platform firmware and
OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
device advertises the feature, the OS can use it."  We clear those
native_* bits if the platform retains ownership via _OSC.

If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
the domain below it, why would we assume that BIOS retains ownership
of the features negotiated by _OSC?  I think we have to assume the OS
owns them, which is what happened before 04b12ef163d1.

Bjorn

