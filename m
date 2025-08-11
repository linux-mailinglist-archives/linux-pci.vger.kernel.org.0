Return-Path: <linux-pci+bounces-33689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE9B1FE8C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 07:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A7A189919D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 05:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380B263C9F;
	Mon, 11 Aug 2025 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wOc5kP3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E221922FB;
	Mon, 11 Aug 2025 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890105; cv=none; b=toEW7MOY+EHvZrSi478saakexssXXMXfsi5Otv2G374D9u8Usr89TmPD/5cNU77vmP/eya9QHs2yHubxU17Y3u3oH2IRvDQljkpHg1fA2QkhRczfyk2bv/8yEuAI4QC2ZM46pGIzmLqJHvxl3RadHj1/N3x3OviE4Ni9GsrVfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890105; c=relaxed/simple;
	bh=cpaSvl6SsSfs7gOlt6S9ri9UH97CzFJnhSJf+CPOD2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzoqkTWXQoO8f4haYVt5gUO0nZYyOrLb1q8aJadf9lX+SwPJV2E9m4hfVXogtqKdL5tJi/zj+DxvcwyKTGvQO3GUGGuLL1Ye95n6XkVIH7nncD3+7LQRMI0Y+TuMflllpToROavT6TMdm7xaf9J57cKGe9rCGtI7G3iBOqaBJtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wOc5kP3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86B7C4CEED;
	Mon, 11 Aug 2025 05:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754890104;
	bh=cpaSvl6SsSfs7gOlt6S9ri9UH97CzFJnhSJf+CPOD2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wOc5kP3nhg4yFQ4BSsI0N73wpKDhxKPsla46GlOZlDL9HCb3ZbgupbGDxlyKZc4u7
	 tXweOq/HTKdMP0YeohRqtqQD7rslTrc2bB3OWrphE+xgRI6h6YGzhTMKzIuCCqRPKu
	 R1ZNcbQvsDB9aRiV55o5qUnXNOGP2E5E3kRqqAEk=
Date: Mon, 11 Aug 2025 07:28:21 +0200
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
Message-ID: <2025081128-cartwheel-grandly-a9be@gregkh>
References: <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
 <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
 <20250808044538.GK476609@black.igk.intel.com>
 <2025080822-cardboard-aloha-3c5d@gregkh>
 <20250808091313.GN476609@black.igk.intel.com>
 <2025080832-poker-rectal-0895@gregkh>
 <20250811045307.GP476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811045307.GP476609@black.igk.intel.com>

On Mon, Aug 11, 2025 at 06:53:07AM +0200, Mika Westerberg wrote:
> On Fri, Aug 08, 2025 at 04:13:28PM +0100, Greg KH wrote:
> > > 0004 USB4
> > > 
> > > sounds good to me. In USB4 there is no "root hub". It's called host router
> > > (but we do have device routers that are called USB4 hubs for added
> > > confusion ;-).
> > > 
> > > But I'm fine with other numbers too, does not matter if you want to save it
> > > for some future USB variant.
> > 
> > Ok, use 0004 for this.  But what should I use for the text string here
> > in the usb.ids file?
> 
> Thanks! I'll cook up a patch changing these.
> 
> I don't think it should be in usb.ids because it is not visible anywhere
> except over USB4 link (between hosts). You don't see this through USB 2.x
> or 3.x.

It goes in usb.ids as that is what I use to keep track of all of the
assigned product ids for this vendor :)

So, should I use "USB 4.0 host link" or something else?

thanks,

greg k-h

