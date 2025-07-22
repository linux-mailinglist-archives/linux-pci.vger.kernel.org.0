Return-Path: <linux-pci+bounces-32737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EAB0DE9F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36993AC83E1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835DD2ED873;
	Tue, 22 Jul 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ei5JrRZT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFF2ECE9D;
	Tue, 22 Jul 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193783; cv=none; b=AmwJsljSeXGz776vrM/WNbC9b3ExERVN5wbz6icxkc1gaU/ISEhwtehR+GJXWDk+x9xafLbobajNgd9SeI3qOtWQFD1RvjVCDhBQJ24bogHAmpbkcrgxAbMVPv+fTloCmjyXVy8NIkunMmrx0R1NIetuKGCyV7j+RxGZfjn2Vt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193783; c=relaxed/simple;
	bh=lvlIsTL0552lQuywV3G4MsYNUlFAfmcSfSeYBIIh/yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9Jra0yhnYPvg42YUGwLAUwjRVqgZOPGb0IzhAVvhdgzdTo/pbt2tZvQXK7nW14HfRI1Dly5Ib8X6PvFYoUaUmr8H6pl1Z3bOYLN9NfeGKrILHop8pTcacYWbVIieGBkVbNPHUDJYQFlCBA9qFxmheO1S0X4wH92I8r7jPVyJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ei5JrRZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B386DC4CEEB;
	Tue, 22 Jul 2025 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193783;
	bh=lvlIsTL0552lQuywV3G4MsYNUlFAfmcSfSeYBIIh/yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ei5JrRZTyN4C5B/4kFm4mwRhz+yqyweq7Xu0VMe2JC6B36JyEJjvIhc0YpT2ob8/3
	 uIgaSeOb/sndGFzmsiBkJyC+aljVAtzdyWS/X4+aylan5gA6gM89fmmOlI1Hv+6l5T
	 FMUDpu5MUXtgb06TpotvnTRYwnOAeo49xyDNAkks=
Date: Tue, 22 Jul 2025 16:08:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
Message-ID: <2025072218-decipher-spree-327d@gregkh>
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
 <2025071716-phoney-object-1648@gregkh>
 <rzbzah5iigz25jtxyqadnitkzkazxsaxntajhlfrfdslyioevk@pylcjkfh5n42>
 <2025071919-patience-cattishly-cf7c@gregkh>
 <l54i36uk33je744w4f47tehdopk5dsjotvozfv5b2hehmxrwpq@eins7awyq4dy>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l54i36uk33je744w4f47tehdopk5dsjotvozfv5b2hehmxrwpq@eins7awyq4dy>

On Tue, Jul 22, 2025 at 03:56:40PM +0200, Thierry Reding wrote:
> On Sat, Jul 19, 2025 at 08:52:41AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 18, 2025 at 03:49:37PM +0200, Thierry Reding wrote:
> > > On Thu, Jul 17, 2025 at 02:11:41PM +0200, Greg Kroah-Hartman wrote:
> > > > On Thu, Jul 17, 2025 at 12:32:34PM +0200, Thierry Reding wrote:
> [...]
> > > 	struct syscore;
> > > 
> > > 	struct syscore_ops {
> > > 		int (*suspend)(struct syscore *syscore);
> > > 		void (*resume)(struct syscore *syscore);
> > > 		void (*shutdown)(struct syscore *syscore);
> > > 	};
> > > 
> > > 	struct syscore {
> > > 		const struct syscore_ops *ops;
> > > 		struct list_head node;
> > > 	};
> > > 
> > > Is that what you had in mind?
> > 
> > I missed the list_head, so yes, this would be better, but don't pass
> > back the syscore structure, how about just a void * instead, making the
> > whole container_of() stuff go away?
> 
> Yeah, that's a possibility. I personally don't like passing the void *
> around because it's easier to make mistakes that way. I also find it
> unintuitive because it doesn't immediately show you what the functions
> expect.
> 
> My understanding is that the container_of() should get optimized away
> most of the time, so there aren't any obvious downsides that I can see.

container_of() is just pointer math, but a cast is even faster :)

> But I don't feel very strongly, so if you have a strong preference for
> void pointers, I can do that.

That's what you really want to have here, it's a syscore data type
thing, that the callback wants to reference.  Just like a irqrequest_t
function passes back a void * that the handler "knows" how to deal with
properly.

thanks,

greg k-h

