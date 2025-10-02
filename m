Return-Path: <linux-pci+bounces-37392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15BBB297D
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 08:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2856942030B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267F2C08D9;
	Thu,  2 Oct 2025 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bu/Uw0L6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C22C0323;
	Thu,  2 Oct 2025 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385354; cv=none; b=KA5K4u8RYaclpwfoZH5lQQuaWmkMkCSsdVcmkB6W0uf0Xp70iC3RWR6ipxI1MN6KPfJb4QblcHQwqjjA9GDDal4LBDcOn+HMhrGZn2/uYyudIuM29yt1Clh7Ah6Ie3fgvL420sy3MS8uoG6z6nRBlbv4Jknc7WptGDfc/bNww6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385354; c=relaxed/simple;
	bh=fNkw/IQQtNnzuv9dQTG2ARg+cQEkgDNqlGWH06R6VpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwdjvnvGG2pLaam1NZohA6v59uYHYwPLWmtOornZv6qcfGdpPdUExHbHAICeFDFVgu0z2MOjR1ncZHpFhvVAq6plQNvxcUjztqUnzto4A+NpJoaXvTHRZfbQQpPg5nCVABhRr3GcpCVqd/uCzNVIna/fjSQsjhI4Yoljayun9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bu/Uw0L6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736A8C4CEF4;
	Thu,  2 Oct 2025 06:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759385354;
	bh=fNkw/IQQtNnzuv9dQTG2ARg+cQEkgDNqlGWH06R6VpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bu/Uw0L6HTODWONKgI99TPB447N8TC/wYAKWwERrY+yr6pfT+dHDIHlyN55nVsQSO
	 oiqZhrHIkLUUAldiSPwrLifSG+8qa8JKRHnFQDEFkZ3PVsw0MoTY9okHLVjbiunn2S
	 baFBHjwlrlJAIeOwsC9I9fUF+JAStfqKBP9wL7UM=
Date: Thu, 2 Oct 2025 08:09:11 +0200
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
Message-ID: <2025100225-abridge-shifty-3d50@gregkh>
References: <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh>
 <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
 <2025093052-resupply-unmixable-e9bb@gregkh>
 <CA+CK2bCBFZDsaEywbfCzDJrH3oXyMmSffV-x7bOs8qC7NT7nAg@mail.gmail.com>
 <2025100147-scrubbed-untold-fc55@gregkh>
 <CA+CK2bA0acjg-CEKufERu_ov4up3E4XTkJ6kbEDCny0iASrFVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bA0acjg-CEKufERu_ov4up3E4XTkJ6kbEDCny0iASrFVQ@mail.gmail.com>

On Wed, Oct 01, 2025 at 05:03:19PM -0400, Pasha Tatashin wrote:
> On Wed, Oct 1, 2025 at 1:06 AM Greg Kroah-Hartman
> > On Tue, Sep 30, 2025 at 11:56:58AM -0400, Pasha Tatashin wrote:
> > > > > A driver that preserves state across a reboot already has an implicit
> > > > > contract with its future self about that data's format. The GUID
> > > > > simply makes that contract explicit and machine-checkable. It does not
> > > > > have to be GUID, but nevertheless there has to be a specific contract.
> > > >
> > > > So how are you going to "version" these GUID?  I see you use "schema Vx"
> > >
> > > Driver developer who changes a driver to support live-update.
> >
> > I do not understand this response, sorry.
> 
> Sorry for the confusion, I misunderstood your question. I thought you
> were asking who would add a new field to a driver. My answer was that
> it would be the developer who is adding support for the Live Update
> feature to that specific driver.
> I now realize you were asking about how the GUID would be versioned.
> Using a GUID was just one of several ideas. My main point is that we
> need some form of versioned compatibility identifier, whether it's a
> string or a number. This would allow the system to verify that the new
> driver can understand the preserved data for this device from the
> previous kernel before it binds to the device.

Again, "versioned" identifiers will not work over time as you can never
drop old versions, AND a driver author does not know if the underlying
structures that are outside of the driver have changed or not, nor if
the compiler settings have changed, or anything else that could affect
it like that have changed.

> > > > And when can you delete an old "schema"?  This feels like you are
> > > > forcing future developers to maintain things "for forever"...
> > >
> > > This won't be an issue because of how live update support is planned.
> > > The support model will be phased and limited:
> > >
> > > Initially, and for a while there will be no stability guarantees
> > > between different kernel versions.
> > > Eventually, we will support specific, narrow upgrade paths (e.g.,
> > > minor-to-minor, or stable-A to stable-A+1).
> > > Downgrades and arbitrary version jumps ("any-to-any") will not be
> > > supported upstream. Since we only ever need to handle a well-defined
> > > forward path, the code for old, irrelevant schemas can always be
> > > removed. There is no "forever".
> >
> > This is kernel code, it is always "forever", sorry.
> 
> I'm sorry, but I don't quite understand what you mean. There is no
> stable internal kernel API; the upstream tree is constantly evolving
> with features being added, improved, and removed.

Yes, that is very true, but you can not remove user-visible
functionality, which is what you are saying you are going to do here.

> > If you want "minor to minor" update, how is that going to work given
> > that you do not add changes only to "minor" releases (that being the
> > 6.12.y the "y" number).
> 
> You are correct. Initially, our plan is to allow live updates to break
> between any kernel version.

Then there is no such thing as live updates :)

> However, it is my hope that we will
> eventually stabilize this process and only allow breakages between,
> for example, versions 6.n and 6.n+2, and eventually from one stable
> release to stable+2. This would create a well-defined window for
> safely removing deprecated data formats and the code that handles them
> from the kernel.

How are you going to define this?  We can not break old users when they
upgrade, and so you are going to have to support this "upgrade path" for
forever.

> > Remember, Linux does not use "semantic versioning" as its release
> > numbering is older than that scheme.  It just does "this version is
> > newer than that version" and that's it.  You can't really take anything
> > else from the number.
> 
> Understood. If that's the case, we could use stable releases as the
> basis for defining when a live update can break.

So every single release?

> It would take longer
> to achieve, but it is a possibility. These are the kinds of questions
> that will be discussed at the LPC Liveupdate MC. If you are attending
> LPC, I encourage you to join the discussion, as your thoughts on how
> we can frame long-term live update support would be very valuable.

I will be at LPC, but can't guarantee I can make it to that MC, it all
depends on scheduling.

> > And if this isn't for "upstream" at all, then why have it?  We can't add
> > new features and support it if we can't actually use it and it's only
> > for out-of-tree vendor kernels.
> 
> Our goal is to have full support in the upstream kernel. Downstream
> users will then need to adapt live updates to their specific needs.
> For example, if a live update from version A to version C is broken, a
> downstream user would either have to update incrementally from A to B
> and then to C, or they would have to internally fix whatever is
> causing the breakage before performing the live update.

What does "internally fix" mean exactly here?

> > And how will you document properly a "well defined forward path"?  That
> > should be done first, before you have any code here that we are
> > reviewing.
> 
> Currently, and for the near future, live updates will only be
> supported within the same kernel version.

Ok, then no need for any GUID at all.  Just update and pray! :)

> > Please do that, get people to agree on the idea and how it will work
> > before asking us to review code.
> 
> This is an industry-wide effort. We have engineers from Amazon,
> Google, Microsoft, Nvidia, and other companies meeting bi-weekly to
> discuss Live Update support, and sending and landing patches upstream.
> We are also organizing an LPC Live Update Micro Conference where the
> versioning strategy will be a topic.
> 
> For now, we have agreed that the live update can break between and
> kernel versions or with any commit while the feature is under active
> development. This approach allows us the flexibility to build the core
> functionality while we collaboratively define the long-term versioning
> and stability model.

Just keeping a device "alive" while rebooting into the same exact kernel
image seems odd to me given that this is almost never what people
actually do.  They update their kernel with the weekly stable release to
get the new bugfixes (remember we fix 13 CVEs a day), and away you go.
You are saying that this workload would not actually be supported, so
why do you want live update at all?  Who needs this?

thanks,

greg k-h

