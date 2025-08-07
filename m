Return-Path: <linux-pci+bounces-33564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A9B1DB34
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983FA1884C2B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6926CE03;
	Thu,  7 Aug 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhDZexlD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A77146A72;
	Thu,  7 Aug 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582561; cv=none; b=jBaxWyCb3sj9n9A+Wgp7AG0NuOtjMw/ccHc1YCaJVb8A5YNMv8rF01fPhITC46Jv+HVKAkyHFf9bUU0JzxakFk/rnbJgHSiTMgaXwy/HHL/tyLW0vnyv9ydJ2zxG4mQ72NDXfFlsHd6hUNv6keF4LZbbv5YQMkX34N8NXw8RkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582561; c=relaxed/simple;
	bh=LvMMT8HRPwXsYdGloXGLjWypaXvPrcgc3WZiewkGmFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9uICxtx61WBHVqWo7VYHUr6r/cx7l0EtLexXaVPTDal5avIri17x7xrc4oLN1HI2NFMzS2obq6H8XME78yRViWEGdAE1sv2da4ajovIQthwhJSyEUdtPOCKua3AjF01F2BL0v1WzgdI4RXATUp117+CKVaYYrKUanGzMaXateo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhDZexlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13669C4CEEB;
	Thu,  7 Aug 2025 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754582560;
	bh=LvMMT8HRPwXsYdGloXGLjWypaXvPrcgc3WZiewkGmFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhDZexlD4Ga0vzaZ0CyZ4wbKtaaaciAgaNGee60dFUyzle6d5Y4CsAarZqeurLWWq
	 g3Vmc0CXy6nE3/jt5wdGEvJbTtQkgqWCtiG/QWlMD/44RZsneiG1awlZf3lue0s95d
	 xdehdMalTGE/KwjGM9v3kuezKENTRkVQAwmcSs8g=
Date: Thu, 7 Aug 2025 17:02:35 +0100
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
Message-ID: <2025080758-supervise-craftily-9b7f@gregkh>
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
 <20250728064743.GS2824380@black.fi.intel.com>
 <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
 <20250806085118.GE476609@black.igk.intel.com>
 <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
 <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807051533.GG476609@black.igk.intel.com>

On Thu, Aug 07, 2025 at 07:15:33AM +0200, Mika Westerberg wrote:
> On Wed, Aug 06, 2025 at 05:58:26PM +0100, Greg KH wrote:
> > On Wed, Aug 06, 2025 at 05:00:24PM +0200, Mika Westerberg wrote:
> > > On Wed, Aug 06, 2025 at 09:06:30AM -0500, Mario Limonciello wrote:
> > > > On 8/6/2025 3:51 AM, Mika Westerberg wrote:
> > > > > On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
> > > > > > 
> > > > > > 
> > > > > > On 7/28/2025 12:17 PM, Mika Westerberg wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
> > > > > > > > This patch series aims to update vendor properties for XDomain
> > > > > > > > dynamically for vendors like AMD, Intel and ASMedia.
> > > > > > > 
> > > > > > > The XDomain properties pretty much describe "software" not the underlying
> > > > > > > hardware so I don't understand why this is needed? We could have some USB
> > > > > > > IF registered Linux specific ID there but I don't see why this matters at
> > > > > > > all.
> > > > > > 
> > > > > > Currently, it is showing up as "Intel" on AMD host controllers during
> > > > > > inter-domain connection. I suppose an alternative is to just call it "Linux"
> > > > > > or "Linux Connection Manager" to ensure we accurately represent the
> > > > > > connections across different systems.
> > > > > > 
> > > > > > I appreciate your guidance on this and suggestions you might have.
> > > > > 
> > > > > Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
> > > > > though but I don't think that matters. AFAIK we have other "donated" IDs in
> > > > > use in Linux. Let me check on our side if that's okay.
> > > > 
> > > > Having looked through this discussion I personally like "Linux" for this
> > > > string too.
> > > > 
> > > > As for the vendor ID doesn't the LF have an ID assigned already of 0x1d6b?
> > > > Would it make sense to use that?
> > > 
> > > AFAIK that's PCI ID, right? It should be USB IF assigned ID and LF is not
> > > here at least:
> > > 
> > >   https://www.usb.org/members
> > > 
> > > If it really matters we can sure register one.
> > 
> > Linux has an official USB vendor id, we use it for when Linux is used as
> > a USB gadget device and in a few other places.  If you want to reserve a
> > product id from it, just let me know and I can dole it out (the list is
> > around here somewhere...)
> 
> Yes please :) I think this is the right thing to do.

Great, please let me know why you need it and what it will be for and
why.  I totally can not figure that out from this thread...

thanks,

greg k-h

