Return-Path: <linux-pci+bounces-33620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2233B1E56B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D69C3A28FD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157426B742;
	Fri,  8 Aug 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1KPXvWK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04922356C0;
	Fri,  8 Aug 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644399; cv=none; b=jCWvqMWY6eoGMPY2zYGmS+QPHXPi/OARfSnHmLW8suRArkpzG8n0kLQxqZ3L/BHHw2lthH08tBBmYccKaWBa74zmlwZbD1nitil/aei5IWsdHe8ZRm9ZPBLfBj+HmfjGfLlzKRK4Aj0c11x9LUdqLIxyqiWxr8wO2zusEQ+PlO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644399; c=relaxed/simple;
	bh=jak3MZp79DWMyM3LRf+gkKinlpgNgSN9X5uunOJiQc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4qbN4VbBhj0k/dyjyKnOi7MpkOSkZKIz6yssF4RCBcl1PeN4qxf9JY34vQhK98ohMKrZCl+wgUPLeKwUjYnrGvzWRgq5Pmf3SIdfPrCUIFXi3vrOu1pdDqI/RH6pjkoJg8cmXc/Z20gLAe0T9qCBxSJVvAc9LFZG7KPmbs7ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1KPXvWK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754644398; x=1786180398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jak3MZp79DWMyM3LRf+gkKinlpgNgSN9X5uunOJiQc8=;
  b=b1KPXvWKWLHMK4nfZVqbK0HeBXq8D0x2YyW3XvbqmZJLHfZLoPsCk53O
   TU0l7cIWuiEJTldYZ42T2/EWbACGqbIWSAf2+5F7NT+87PsBbBfyRORCe
   uMScHgm69o+BqaEYaBI4jClUDKUpCgOC1cpLzBRPGaFIPOliyt20ui3F9
   IANe7xnSynq3WhpduC2qV/Qfre09fWFxcjNXfmkseppeOLwEGnZEFyoRt
   IojjF/NgqKiu3hxtY0ruiDHAeJJ0cK6YCpDgpEufhNUTR5ITozulH8K1Y
   0tWxCeXzrfBA3xv5VEI/g2bBpx6vG/aG2j5Bzn15OnWHrFodaTS32ne1G
   g==;
X-CSE-ConnectionGUID: lVZt+DeMSuW8EvjCdNA9EQ==
X-CSE-MsgGUID: z84Hts8oReGUOzL14CaoKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74443780"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="74443780"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 02:13:17 -0700
X-CSE-ConnectionGUID: 0m8LeReFSzieTb2Y6stPaQ==
X-CSE-MsgGUID: CD1CwIOYQmGVCDGP9ZgWOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196109753"
Received: from unknown (HELO black.igk.intel.com) ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 08 Aug 2025 02:13:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 5D8C793; Fri, 08 Aug 2025 11:13:13 +0200 (CEST)
Date: Fri, 8 Aug 2025 11:13:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	"Rangoju, Raju" <raju.rangoju@amd.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	westeri@kernel.org, YehezkelShB@gmail.com, bhelgaas@google.com,
	Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <20250808091313.GN476609@black.igk.intel.com>
References: <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
 <20250806085118.GE476609@black.igk.intel.com>
 <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
 <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
 <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
 <20250808044538.GK476609@black.igk.intel.com>
 <2025080822-cardboard-aloha-3c5d@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025080822-cardboard-aloha-3c5d@gregkh>

On Fri, Aug 08, 2025 at 10:02:08AM +0100, Greg KH wrote:
> On Fri, Aug 08, 2025 at 06:45:38AM +0200, Mika Westerberg wrote:
> > On Thu, Aug 07, 2025 at 11:07:39AM -0500, Mario Limonciello wrote:
> > > On 8/7/25 11:02 AM, Greg KH wrote:
> > > > On Thu, Aug 07, 2025 at 07:15:33AM +0200, Mika Westerberg wrote:
> > > > > On Wed, Aug 06, 2025 at 05:58:26PM +0100, Greg KH wrote:
> > > > > > On Wed, Aug 06, 2025 at 05:00:24PM +0200, Mika Westerberg wrote:
> > > > > > > On Wed, Aug 06, 2025 at 09:06:30AM -0500, Mario Limonciello wrote:
> > > > > > > > On 8/6/2025 3:51 AM, Mika Westerberg wrote:
> > > > > > > > > On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > On 7/28/2025 12:17 PM, Mika Westerberg wrote:
> > > > > > > > > > > Hi,
> > > > > > > > > > > 
> > > > > > > > > > > On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
> > > > > > > > > > > > This patch series aims to update vendor properties for XDomain
> > > > > > > > > > > > dynamically for vendors like AMD, Intel and ASMedia.
> > > > > > > > > > > 
> > > > > > > > > > > The XDomain properties pretty much describe "software" not the underlying
> > > > > > > > > > > hardware so I don't understand why this is needed? We could have some USB
> > > > > > > > > > > IF registered Linux specific ID there but I don't see why this matters at
> > > > > > > > > > > all.
> > > > > > > > > > 
> > > > > > > > > > Currently, it is showing up as "Intel" on AMD host controllers during
> > > > > > > > > > inter-domain connection. I suppose an alternative is to just call it "Linux"
> > > > > > > > > > or "Linux Connection Manager" to ensure we accurately represent the
> > > > > > > > > > connections across different systems.
> > > > > > > > > > 
> > > > > > > > > > I appreciate your guidance on this and suggestions you might have.
> > > > > > > > > 
> > > > > > > > > Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
> > > > > > > > > though but I don't think that matters. AFAIK we have other "donated" IDs in
> > > > > > > > > use in Linux. Let me check on our side if that's okay.
> > > > > > > > 
> > > > > > > > Having looked through this discussion I personally like "Linux" for this
> > > > > > > > string too.
> > > > > > > > 
> > > > > > > > As for the vendor ID doesn't the LF have an ID assigned already of 0x1d6b?
> > > > > > > > Would it make sense to use that?
> > > > > > > 
> > > > > > > AFAIK that's PCI ID, right? It should be USB IF assigned ID and LF is not
> > > > > > > here at least:
> > > > > > > 
> > > > > > >    https://www.usb.org/members
> > > > > > > 
> > > > > > > If it really matters we can sure register one.
> > > > > > 
> > > > > > Linux has an official USB vendor id, we use it for when Linux is used as
> > > > > > a USB gadget device and in a few other places.  If you want to reserve a
> > > > > > product id from it, just let me know and I can dole it out (the list is
> > > > > > around here somewhere...)
> > > > > 
> > > > > Yes please :) I think this is the right thing to do.
> > > > 
> > > > Great, please let me know why you need it and what it will be for and
> > > > why.  I totally can not figure that out from this thread...
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Actually it's a very similar reason for the gadget drivers.  When connected
> > > to other machines and using the USB4 networking feature (like a host to host
> > > communication) the Linux kernel will identify itself and the other side will
> > > show that to a user.
> > > 
> > > So right now it's got some hardcoded values.  This thread was prompting to
> > > change the strings, but it's brought about the realization that we should
> > > also be using a Linux specific vendor (the one uses in gadget devices) and
> > > then a Linux specific "device id" which you will allocate.
> > > 
> > > Hope that helps!
> > 
> > Thanks Mario, yes exactly that :)
> > 
> > "Linux USB4 Inter-domain discovery properties" in a nutshell.
> 
> Ok, sounds good.  Here's the currently assigned ids that we have so far:
> 
> # Linux Foundation USB id list.
> 1d6b  Linux Foundation
>         0001  1.1 root hub
>         0002  2.0 root hub
>         0003  3.0 root hub
>         0010  USB Debug Target
>         0011  USB GDB Target
>         0100  PTP Gadget
>         0101  Audio Gadget
>         0102  EEM Gadget
>         0103  NCM (Ethernet) Gadget
>         0104  Multifunction Composite Gadget
>         0105  FunctionFS Gadget
>         0106  Composite Gadget: ACM + Mass Storage
>         0107  Embedded Hub Gadgetg
>         0200  Qemu Audio Device
>         0246  BlueZ Host Stack
>         0247  BlueZ for Android
> 
> Any specific number feel drawn toward using?  Would 0004 make sense as this is
> "USB 4" or should we save that if we ever get a USB 4.0 root hub?

0004 USB4

sounds good to me. In USB4 there is no "root hub". It's called host router
(but we do have device routers that are called USB4 hubs for added
confusion ;-).

But I'm fine with other numbers too, does not matter if you want to save it
for some future USB variant.

