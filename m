Return-Path: <linux-pci+bounces-37324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D2BAF1E8
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 07:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35433BDD7A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 05:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C6A2D7801;
	Wed,  1 Oct 2025 05:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U35xNHLC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90290190473;
	Wed,  1 Oct 2025 05:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759295185; cv=none; b=laG4dZmJJluAPT8xCLjTqGVBFeybTwTLOKXClK4lSuXmS10bCe9xdOxr6E1oXD1gz1ZOwa5BNJYS3X4Q8C+Y/NjxmWZuUe0ivDUzIi6n5OAF/McV2npqCnZ9FEBbY0n2VG64yjdmeHsZHFM7d9jagrFLxTl+jXNHY6CZaAdCDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759295185; c=relaxed/simple;
	bh=fe5zbu+Rv705yv+eJxMSGbgl5QCGMDlR+ZondE8FEjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYDYV+0igcd4pXdtcLQ6AGtj/D98hCy5IU0BGEJHNrIUmaUzOnFt0AXmskadJRSi+0Vj4MpuQ5upqFtv4IXgL4rzew6qyiKoLU7nNlsB2vCJNMBh0Fu0g9Dxsajj/nJWdmrOHGAgn3mEgzNAccdiMzKrxK09cX7YQU7E0i/jBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U35xNHLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D37FC4CEF4;
	Wed,  1 Oct 2025 05:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759295185;
	bh=fe5zbu+Rv705yv+eJxMSGbgl5QCGMDlR+ZondE8FEjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U35xNHLC+tKaPk5HDfdwT40OWyNWDEWmAjhAV1+nCfwUDkz2FmGfKDXzHdEGTPZ+b
	 xJGU/yjZdxsHlboJNEpt8AJABMw591U6sqGgRyHbZbX8p4FPrmlY2BNk5pSEd8F5RB
	 b4bObzMAj19tL4CXide5rmXmf8b6walU2n2sTFBw=
Date: Wed, 1 Oct 2025 07:06:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Chris Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <2025100147-scrubbed-untold-fc55@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh>
 <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
 <2025093052-resupply-unmixable-e9bb@gregkh>
 <CA+CK2bCBFZDsaEywbfCzDJrH3oXyMmSffV-x7bOs8qC7NT7nAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCBFZDsaEywbfCzDJrH3oXyMmSffV-x7bOs8qC7NT7nAg@mail.gmail.com>

On Tue, Sep 30, 2025 at 11:56:58AM -0400, Pasha Tatashin wrote:
> > > A driver that preserves state across a reboot already has an implicit
> > > contract with its future self about that data's format. The GUID
> > > simply makes that contract explicit and machine-checkable. It does not
> > > have to be GUID, but nevertheless there has to be a specific contract.
> >
> > So how are you going to "version" these GUID?  I see you use "schema Vx"
> 
> Driver developer who changes a driver to support live-update.

I do not understand this response, sorry.

> > above, but how is that really going to work in the end?  Lots of data
> > structures change underneath the base driver that it knows nothing
> > about, not to mention basic things like compiler flags and the like
> > (think about how we have changed things for spectre issues over the
> > years...)
> 
> We are working on versioning protocol, the GUID I am suggesting is not
> to protect "struct" coherency, but just to identify which driver to
> bind to which device compatability.

So you have a new way of matching drivers to devices?  That's odd.

> > And when can you delete an old "schema"?  This feels like you are
> > forcing future developers to maintain things "for forever"...
> 
> This won't be an issue because of how live update support is planned.
> The support model will be phased and limited:
> 
> Initially, and for a while there will be no stability guarantees
> between different kernel versions.
> Eventually, we will support specific, narrow upgrade paths (e.g.,
> minor-to-minor, or stable-A to stable-A+1).
> Downgrades and arbitrary version jumps ("any-to-any") will not be
> supported upstream. Since we only ever need to handle a well-defined
> forward path, the code for old, irrelevant schemas can always be
> removed. There is no "forever".

This is kernel code, it is always "forever", sorry.

If you want "minor to minor" update, how is that going to work given
that you do not add changes only to "minor" releases (that being the
6.12.y the "y" number).

Remember, Linux does not use "semantic versioning" as its release
numbering is older than that scheme.  It just does "this version is
newer than that version" and that's it.  You can't really take anything
else from the number.

And if this isn't for "upstream" at all, then why have it?  We can't add
new features and support it if we can't actually use it and it's only
for out-of-tree vendor kernels.

And how will you document properly a "well defined forward path"?  That
should be done first, before you have any code here that we are
reviewing.

Please do that, get people to agree on the idea and how it will work
before asking us to review code.

thanks,

greg k-h

