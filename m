Return-Path: <linux-pci+bounces-33618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BBB1E544
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6963B9019
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C726B74D;
	Fri,  8 Aug 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K7PXVo3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090226B09A;
	Fri,  8 Aug 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643735; cv=none; b=IITHjmCn351pup3WEqsRuZYCEgzd7OahwAc4XXV9ojJNc0QbjDTNrreE0Sdm8U2rxW/E+FTwEUZm1e0QvC8dpAnY/3M18zCO77EHv7uqwfm3fhrw5lFW2O9bEZGXApj90Xy4hXWzFgMzxhFWihT2swQjnM7uwWSCGlOgEpJm7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643735; c=relaxed/simple;
	bh=OLfHMf+/p5SF+EgDcTpMTi6RNHClRtVhsBq/E2moFuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyvdndVHXH1YsS8Wx2/xGp4+FFKsRIjJt9Ql3mxEgaA8uQFX3Vc9bdzqQGDNDIvxq4PEDOdAC2C890j/3LEaJQv/mTHPjb40n3B+nx31N4G1L4pJxVqj1qkwGbg4vCzSLQFyqq5Ake43saglAKjWxJsukEWhAXg8hs3KH165wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K7PXVo3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AE9C4CEED;
	Fri,  8 Aug 2025 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754643734;
	bh=OLfHMf+/p5SF+EgDcTpMTi6RNHClRtVhsBq/E2moFuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7PXVo3A2EFL2INqJV9HHk0NNcIRGJMPIept3H1KH7UHzyXgC+FvtKTQ4iCeBoWdt
	 HBfb+NlTANFo13jOZw+YPhjuftGmJPceBRyNnlgnhNvPuEQO3JF6ntKawBIPEd2/wl
	 5AIyYvNeB1WrXQ9HMhCO7u0epwGAc6U9NMJj6+Pc=
Date: Fri, 8 Aug 2025 10:02:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	"Rangoju, Raju" <raju.rangoju@amd.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	westeri@kernel.org, YehezkelShB@gmail.com, bhelgaas@google.com,
	Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <2025080822-cardboard-aloha-3c5d@gregkh>
References: <20250728064743.GS2824380@black.fi.intel.com>
 <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
 <20250806085118.GE476609@black.igk.intel.com>
 <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
 <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
 <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
 <20250808044538.GK476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808044538.GK476609@black.igk.intel.com>

On Fri, Aug 08, 2025 at 06:45:38AM +0200, Mika Westerberg wrote:
> On Thu, Aug 07, 2025 at 11:07:39AM -0500, Mario Limonciello wrote:
> > On 8/7/25 11:02 AM, Greg KH wrote:
> > > On Thu, Aug 07, 2025 at 07:15:33AM +0200, Mika Westerberg wrote:
> > > > On Wed, Aug 06, 2025 at 05:58:26PM +0100, Greg KH wrote:
> > > > > On Wed, Aug 06, 2025 at 05:00:24PM +0200, Mika Westerberg wrote:
> > > > > > On Wed, Aug 06, 2025 at 09:06:30AM -0500, Mario Limonciello wrote:
> > > > > > > On 8/6/2025 3:51 AM, Mika Westerberg wrote:
> > > > > > > > On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > On 7/28/2025 12:17 PM, Mika Westerberg wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > 
> > > > > > > > > > On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
> > > > > > > > > > > This patch series aims to update vendor properties for XDomain
> > > > > > > > > > > dynamically for vendors like AMD, Intel and ASMedia.
> > > > > > > > > > 
> > > > > > > > > > The XDomain properties pretty much describe "software" not the underlying
> > > > > > > > > > hardware so I don't understand why this is needed? We could have some USB
> > > > > > > > > > IF registered Linux specific ID there but I don't see why this matters at
> > > > > > > > > > all.
> > > > > > > > > 
> > > > > > > > > Currently, it is showing up as "Intel" on AMD host controllers during
> > > > > > > > > inter-domain connection. I suppose an alternative is to just call it "Linux"
> > > > > > > > > or "Linux Connection Manager" to ensure we accurately represent the
> > > > > > > > > connections across different systems.
> > > > > > > > > 
> > > > > > > > > I appreciate your guidance on this and suggestions you might have.
> > > > > > > > 
> > > > > > > > Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
> > > > > > > > though but I don't think that matters. AFAIK we have other "donated" IDs in
> > > > > > > > use in Linux. Let me check on our side if that's okay.
> > > > > > > 
> > > > > > > Having looked through this discussion I personally like "Linux" for this
> > > > > > > string too.
> > > > > > > 
> > > > > > > As for the vendor ID doesn't the LF have an ID assigned already of 0x1d6b?
> > > > > > > Would it make sense to use that?
> > > > > > 
> > > > > > AFAIK that's PCI ID, right? It should be USB IF assigned ID and LF is not
> > > > > > here at least:
> > > > > > 
> > > > > >    https://www.usb.org/members
> > > > > > 
> > > > > > If it really matters we can sure register one.
> > > > > 
> > > > > Linux has an official USB vendor id, we use it for when Linux is used as
> > > > > a USB gadget device and in a few other places.  If you want to reserve a
> > > > > product id from it, just let me know and I can dole it out (the list is
> > > > > around here somewhere...)
> > > > 
> > > > Yes please :) I think this is the right thing to do.
> > > 
> > > Great, please let me know why you need it and what it will be for and
> > > why.  I totally can not figure that out from this thread...
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Actually it's a very similar reason for the gadget drivers.  When connected
> > to other machines and using the USB4 networking feature (like a host to host
> > communication) the Linux kernel will identify itself and the other side will
> > show that to a user.
> > 
> > So right now it's got some hardcoded values.  This thread was prompting to
> > change the strings, but it's brought about the realization that we should
> > also be using a Linux specific vendor (the one uses in gadget devices) and
> > then a Linux specific "device id" which you will allocate.
> > 
> > Hope that helps!
> 
> Thanks Mario, yes exactly that :)
> 
> "Linux USB4 Inter-domain discovery properties" in a nutshell.

Ok, sounds good.  Here's the currently assigned ids that we have so far:

# Linux Foundation USB id list.
1d6b  Linux Foundation
        0001  1.1 root hub
        0002  2.0 root hub
        0003  3.0 root hub
        0010  USB Debug Target
        0011  USB GDB Target
        0100  PTP Gadget
        0101  Audio Gadget
        0102  EEM Gadget
        0103  NCM (Ethernet) Gadget
        0104  Multifunction Composite Gadget
        0105  FunctionFS Gadget
        0106  Composite Gadget: ACM + Mass Storage
        0107  Embedded Hub Gadgetg
        0200  Qemu Audio Device
        0246  BlueZ Host Stack
        0247  BlueZ for Android

Any specific number feel drawn toward using?  Would 0004 make sense as this is
"USB 4" or should we save that if we ever get a USB 4.0 root hub?

thanks,

greg k-h

