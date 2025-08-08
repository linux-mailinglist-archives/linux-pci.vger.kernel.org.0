Return-Path: <linux-pci+bounces-33601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE95CB1E151
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 06:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BD7AE39F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 04:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84317A2E3;
	Fri,  8 Aug 2025 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OA0n+LYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8B2E36F9;
	Fri,  8 Aug 2025 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754628345; cv=none; b=NOqNpSPNVS2jTykgkFeId7wFUFCnFnso/gZoivX35bIZM7btMAjmqbM8XF4qmKuBDu9bIwenHPB3dggvQ8G8m6b7XNxHNifapGC49bdXf67buVo3QycOiQM+TJizSbULVFGdAa2X9dvPgaUPqedNcYn37398lmKAHr3zwkK7qiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754628345; c=relaxed/simple;
	bh=AKgO4pIbB2nTfSdHB55+IqU+L1/HE1Bb84XBePTX3zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWlou5xk9n7vrnQtwGMw4rY79j8Zqmj3XzrTIvxJGygfXKbV4Q4f+9nRD5ih+rMLtCXMK81/0tKSr6DqdnbgIRjtG8sVx7Y9aOKEwJvXj6S0dEs4a4Q6TWNVxlPpt8BQGgUrTF8CMe87VoTPHGqTflFgrfiYZxuJQlEkeaUV0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OA0n+LYB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754628343; x=1786164343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKgO4pIbB2nTfSdHB55+IqU+L1/HE1Bb84XBePTX3zE=;
  b=OA0n+LYB0SbmxnRz/PZdmo4EcAy2TfPnZr/mFcJTUCAYtg2WEd1mUOgY
   wAb9cgoUa81Z67WeAXaWxUg70AIS/rhBB+HDpeQCcYiQumNdQlx1n52yt
   4N+GCIKQcCn5tyrD6h+ixsByM4EFjs1ixaQHYWFHEF+v9G3VtG2SmJlaH
   YhCmHkd/Lxw5XrvEamFlfp4Orx+AUroVruNNCc8di3njcs6BeJa7J8Kf7
   8Lu6tlpFOvUieCvj5Jwsh7tZieJmgJYfQyrCmsznAH2r6Te102FZW8Bri
   SGyaS10yIXlfdJuiCj/XgBB24zHlg7qgfor70HM6bL3rCz8PVy/ttfM+v
   g==;
X-CSE-ConnectionGUID: C2Y6TNOTThSxdX0xPa+zfw==
X-CSE-MsgGUID: UsVOTFS2SiSgn7y8uohKKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56177246"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56177246"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 21:45:42 -0700
X-CSE-ConnectionGUID: hakPw1ijRKSQEA58VFqNXg==
X-CSE-MsgGUID: vdMLLlniSkiBpyBMEkxglQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="166030300"
Received: from unknown (HELO black.igk.intel.com) ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 07 Aug 2025 21:45:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D394D93; Fri, 08 Aug 2025 06:45:38 +0200 (CEST)
Date: Fri, 8 Aug 2025 06:45:38 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"Rangoju, Raju" <raju.rangoju@amd.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	westeri@kernel.org, YehezkelShB@gmail.com, bhelgaas@google.com,
	Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <20250808044538.GK476609@black.igk.intel.com>
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
 <20250728064743.GS2824380@black.fi.intel.com>
 <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
 <20250806085118.GE476609@black.igk.intel.com>
 <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
 <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
 <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>

On Thu, Aug 07, 2025 at 11:07:39AM -0500, Mario Limonciello wrote:
> On 8/7/25 11:02 AM, Greg KH wrote:
> > On Thu, Aug 07, 2025 at 07:15:33AM +0200, Mika Westerberg wrote:
> > > On Wed, Aug 06, 2025 at 05:58:26PM +0100, Greg KH wrote:
> > > > On Wed, Aug 06, 2025 at 05:00:24PM +0200, Mika Westerberg wrote:
> > > > > On Wed, Aug 06, 2025 at 09:06:30AM -0500, Mario Limonciello wrote:
> > > > > > On 8/6/2025 3:51 AM, Mika Westerberg wrote:
> > > > > > > On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 7/28/2025 12:17 PM, Mika Westerberg wrote:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
> > > > > > > > > > This patch series aims to update vendor properties for XDomain
> > > > > > > > > > dynamically for vendors like AMD, Intel and ASMedia.
> > > > > > > > > 
> > > > > > > > > The XDomain properties pretty much describe "software" not the underlying
> > > > > > > > > hardware so I don't understand why this is needed? We could have some USB
> > > > > > > > > IF registered Linux specific ID there but I don't see why this matters at
> > > > > > > > > all.
> > > > > > > > 
> > > > > > > > Currently, it is showing up as "Intel" on AMD host controllers during
> > > > > > > > inter-domain connection. I suppose an alternative is to just call it "Linux"
> > > > > > > > or "Linux Connection Manager" to ensure we accurately represent the
> > > > > > > > connections across different systems.
> > > > > > > > 
> > > > > > > > I appreciate your guidance on this and suggestions you might have.
> > > > > > > 
> > > > > > > Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
> > > > > > > though but I don't think that matters. AFAIK we have other "donated" IDs in
> > > > > > > use in Linux. Let me check on our side if that's okay.
> > > > > > 
> > > > > > Having looked through this discussion I personally like "Linux" for this
> > > > > > string too.
> > > > > > 
> > > > > > As for the vendor ID doesn't the LF have an ID assigned already of 0x1d6b?
> > > > > > Would it make sense to use that?
> > > > > 
> > > > > AFAIK that's PCI ID, right? It should be USB IF assigned ID and LF is not
> > > > > here at least:
> > > > > 
> > > > >    https://www.usb.org/members
> > > > > 
> > > > > If it really matters we can sure register one.
> > > > 
> > > > Linux has an official USB vendor id, we use it for when Linux is used as
> > > > a USB gadget device and in a few other places.  If you want to reserve a
> > > > product id from it, just let me know and I can dole it out (the list is
> > > > around here somewhere...)
> > > 
> > > Yes please :) I think this is the right thing to do.
> > 
> > Great, please let me know why you need it and what it will be for and
> > why.  I totally can not figure that out from this thread...
> > 
> > thanks,
> > 
> > greg k-h
> 
> Actually it's a very similar reason for the gadget drivers.  When connected
> to other machines and using the USB4 networking feature (like a host to host
> communication) the Linux kernel will identify itself and the other side will
> show that to a user.
> 
> So right now it's got some hardcoded values.  This thread was prompting to
> change the strings, but it's brought about the realization that we should
> also be using a Linux specific vendor (the one uses in gadget devices) and
> then a Linux specific "device id" which you will allocate.
> 
> Hope that helps!

Thanks Mario, yes exactly that :)

"Linux USB4 Inter-domain discovery properties" in a nutshell.

