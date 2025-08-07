Return-Path: <linux-pci+bounces-33514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4198B1D1E3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A9D18C0B30
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 05:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B51E3DDE;
	Thu,  7 Aug 2025 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ni8aT9GD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0641C5F27;
	Thu,  7 Aug 2025 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543739; cv=none; b=XFqUxLJ3XD+t9MkPHzqM1ant7H6Eoa+WQIr+dZyUXvA4AJbVTqQ7ltQck6kdxJQNgvNb8Pf7wmiLSkJzzGdqgfP9vEJUKGHKVT4Xbblq8OWKxsluCCaHqjyWsbesKSYQamuea1TqTDIPwrrfV57eFeiG01dj4XrfxxTK3Cb913o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543739; c=relaxed/simple;
	bh=OABG8QK27oVphx3KmqQS2k4HAfAU3yskGkRAX0znjrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1rOphzRomV1Yqe+HU7BLMyd/4aArL++UjcV/x4n7a/qVHgR3cHvkLcs+/P0RA1mWzXgGed1jR3yt+LlutSzzZKa6mwv0Rr5TVKyfSKdrsyQBR80q1ccSWb1D/lTay3dKqLJ1SWeDihMZAmT+WBY9e4raQPKI0arj8PzKJWKWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ni8aT9GD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754543738; x=1786079738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OABG8QK27oVphx3KmqQS2k4HAfAU3yskGkRAX0znjrU=;
  b=ni8aT9GDVeagtkfiZZYn4LUHWggDwVURr2EHEfHgH/P3i9FxsrFO/pEF
   zCXe0FuIzjmFgaCjY/iRrCdkYOVo9kGLm21c+fNiwe7ekV54n3V/2Ghxx
   702nws8vOb+hag2HjFasfcshWjX6cX8jhpius487nOSIaTP6jvvac1JUv
   ay8DJxsW1mMYoswRx6oHX7fb36Q4EEv2R28bQSNPrWnkX/bukD8LifeFx
   kj1Tt7sIIjD0nKj/5isL2Swch8kzeao07dJf0uIpx0hBKh7fkIOUegZDl
   kHJAx1KlXnBrGQm3JM9DSL/AL5IB6z7623J2FDqf/FLUIAtpeNnKcNJ6P
   Q==;
X-CSE-ConnectionGUID: i5G4oNfHQxiNhivXFNHirw==
X-CSE-MsgGUID: J/8IHxFcQ2+KYXH+4OeVpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74329375"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="74329375"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 22:15:37 -0700
X-CSE-ConnectionGUID: A+BIQ4/nTU2iPkTP4V9FmA==
X-CSE-MsgGUID: 6nXx22+eRF2/SLMSaTn02Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165327763"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2025 22:15:34 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B8DF793; Thu, 07 Aug 2025 07:15:33 +0200 (CEST)
Date: Thu, 7 Aug 2025 07:15:33 +0200
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
Message-ID: <20250807051533.GG476609@black.igk.intel.com>
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
 <20250728064743.GS2824380@black.fi.intel.com>
 <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
 <20250806085118.GE476609@black.igk.intel.com>
 <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
 <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025080628-viral-untruth-4811@gregkh>

On Wed, Aug 06, 2025 at 05:58:26PM +0100, Greg KH wrote:
> On Wed, Aug 06, 2025 at 05:00:24PM +0200, Mika Westerberg wrote:
> > On Wed, Aug 06, 2025 at 09:06:30AM -0500, Mario Limonciello wrote:
> > > On 8/6/2025 3:51 AM, Mika Westerberg wrote:
> > > > On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
> > > > > 
> > > > > 
> > > > > On 7/28/2025 12:17 PM, Mika Westerberg wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
> > > > > > > This patch series aims to update vendor properties for XDomain
> > > > > > > dynamically for vendors like AMD, Intel and ASMedia.
> > > > > > 
> > > > > > The XDomain properties pretty much describe "software" not the underlying
> > > > > > hardware so I don't understand why this is needed? We could have some USB
> > > > > > IF registered Linux specific ID there but I don't see why this matters at
> > > > > > all.
> > > > > 
> > > > > Currently, it is showing up as "Intel" on AMD host controllers during
> > > > > inter-domain connection. I suppose an alternative is to just call it "Linux"
> > > > > or "Linux Connection Manager" to ensure we accurately represent the
> > > > > connections across different systems.
> > > > > 
> > > > > I appreciate your guidance on this and suggestions you might have.
> > > > 
> > > > Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
> > > > though but I don't think that matters. AFAIK we have other "donated" IDs in
> > > > use in Linux. Let me check on our side if that's okay.
> > > 
> > > Having looked through this discussion I personally like "Linux" for this
> > > string too.
> > > 
> > > As for the vendor ID doesn't the LF have an ID assigned already of 0x1d6b?
> > > Would it make sense to use that?
> > 
> > AFAIK that's PCI ID, right? It should be USB IF assigned ID and LF is not
> > here at least:
> > 
> >   https://www.usb.org/members
> > 
> > If it really matters we can sure register one.
> 
> Linux has an official USB vendor id, we use it for when Linux is used as
> a USB gadget device and in a few other places.  If you want to reserve a
> product id from it, just let me know and I can dole it out (the list is
> around here somewhere...)

Yes please :) I think this is the right thing to do.

> Note, the LF is NOT listed as a USB-IF member anymore, as the USB-IF
> kicked us out at the request of one of their founding members many years
> ago.  But we still got to keep the product id, they can't take that away
> from us :)

Hehe, understood.

