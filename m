Return-Path: <linux-pci+bounces-5206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7788CFAE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 22:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9C41F81B88
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D913DDA5;
	Tue, 26 Mar 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLCp4crw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0513D898
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487324; cv=none; b=uHXwzV1yEAGFYrwZmKcCuCTIn4iiAn75cYO01HmJzAQl0+O0K0tf7cAUMM7nZvSE+sYIqrrbzaNpAkordVSkZS+sCHHO38CtbFA4w000P2Pex6cj2w4v2pBxYtcYTMXD7/xhCb6Dy5I9ljOWVyxbP1N4MTY90i+sdYqH4qwdVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487324; c=relaxed/simple;
	bh=Tx5swbrUO3wgROoJxbX+s3hLvxPUcDwp70qRCrmoZK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oUqkDN0Yh3Ml83TCBQdHNtj/5HLxo9wGizOy4uGies3U3EKYE8Z1Clb1/rC6Ibu4EZ15H1Qs+h5nUvcU85APnnmEVTHzUWLBEgrdI0/42U4pLKgHXTkVHdZS6B2x0yAPRWAE8bEIeBXKDCuflXKCqROEjTB6LnuEVZJJYmbIpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLCp4crw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A50C43142;
	Tue, 26 Mar 2024 21:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487323;
	bh=Tx5swbrUO3wgROoJxbX+s3hLvxPUcDwp70qRCrmoZK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GLCp4crwxtmxueoiLfzJ6iAGmWm6A4QjbXjG+Ce1JTGNrA92dAlsLmdLz8lWAYg1Z
	 DFIB2l4Ha7PWRjZLz4Nx2GgwfSTnZi2hbAWCt9bYG8K/Ev8ke0RosrF9DktFABug0n
	 NjDnDHFx4QJdGXl1f00eULdi5+EqJakAejrb8u7rK6RPoS1OGbSHGbAMBxOeeco9T8
	 rBm4RcS9ITCdAZq/ah4TVBR2cHIBhaMIYaizUPFkCjfYUsAYeLyU+dNpe5rL9ODsVn
	 Sf43DpvtQPNPBLeg3cFBilTlG24+AOn/gks6hdWGNIHpwyjdIPOUd4kOYraHNHD91R
	 v08R/bZPF6qnQ==
Date: Tue, 26 Mar 2024 16:08:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240326210841.GA1497045@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef559fe9-f3cd-4edf-bee8-dbd2ae504288@intel.com>

On Tue, Mar 26, 2024 at 08:51:45AM -0700, Paul M Stillwell Jr wrote:
> On 3/25/2024 6:59 PM, Kai-Heng Feng wrote:
> > On Tue, Mar 26, 2024 at 8:17 AM Nirmal Patel
> > <nirmal.patel@linux.intel.com> wrote:
> > > 
> > > On Fri, 22 Mar 2024 18:36:37 -0500 Bjorn Helgaas
> > > <helgaas@kernel.org> wrote:
> > > 
> > > > On Fri, Mar 22, 2024 at 03:43:27PM -0700, Paul M Stillwell Jr
> > > > wrote:
> > > > > On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:
> > > > > > On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel
> > > > > > wrote:
> > > > > > > On Fri, 15 Mar 2024 09:29:32 +0800 Kai-Heng Feng
> > > > > > > <kai.heng.feng@canonical.com> wrote: ...
> > > > > > 
> > > > > > > > If there's an official document on intel.com, it can
> > > > > > > > make many things clearer and easier. States what VMD does
> > > > > > > > and what VMD expect OS to do can be really helpful.
> > > > > > > > Basically put what you wrote in an official document.
> > > > > > > 
> > > > > > > Thanks for the suggestion. I can certainly find official
> > > > > > > VMD architecture document and add that required information
> > > > > > > to Documentation/PCI/controller/vmd.rst. Will that be
> > > > > > > okay?
> > > > > > 
> > > > > > I'd definitely be interested in whatever you can add to
> > > > > > illuminate these issues.
> > > > > > 
> > > > > > > I also need your some help/suggestion on following
> > > > > > > alternate solution. We have been looking at VMD HW
> > > > > > > registers to find some empty registers. Cache Line Size
> > > > > > > register offset OCh is not being used by VMD. This is the
> > > > > > > explanation in PCI spec 5.0 section 7.5.1.1.7: "This
> > > > > > > read-write register is implemented for legacy compatibility
> > > > > > > purposes but has no effect on any PCI Express device
> > > > > > > behavior." Can these registers be used for passing _OSC
> > > > > > > settings from BIOS to VMD OS driver?
> > > > > > > 
> > > > > > > These 8 bits are more than enough for UEFI VMD driver to
> > > > > > > store all _OSC flags and VMD OS driver can read it during
> > > > > > > OS boot up. This will solve all of our issues.
> > > > > > 
> > > > > > Interesting idea.  I think you'd have to do some work to
> > > > > > separate out the conventional PCI devices, where
> > > > > > PCI_CACHE_LINE_SIZE is still relevant, to make sure nothing
> > > > > > breaks.  But I think we overwrite it in some cases even for
> > > > > > PCIe devices where it's pointless, and it would be nice to
> > > > > > clean that up.
> > > > > 
> > > > > I think the suggestion here is to use the VMD devices Cache
> > > > > Line Size register, not the other PCI devices. In that case we
> > > > > don't have to worry about conventional PCI devices because we
> > > > > aren't touching them.
> > > > 
> > > > Yes, but there is generic code that writes PCI_CACHE_LINE_SIZE
> > > > for every device in some cases.  If we wrote the VMD
> > > > PCI_CACHE_LINE_SIZE, it would obliterate whatever you want to
> > > > pass there.
> > > > 
> > > Our initial testing showed no change in value by overwrite from
> > > pci. The registers didn't change in Host as well as in Guest OS
> > > when some data was written from BIOS. I will perform more testing
> > > and also make sure to write every register just in case.
> > 
> > If the VMD hardware is designed in this way and there's an official
> > document states that "VMD ports should follow _OSC expect for
> > hotplugging" then IMO there's no need to find alternative.
> 
> There isn't any official documentation for this, it's just the way VMD
> is designed :). VMD assumes that everything behind it is hotpluggable so
> the bits don't *really* matter. In other words, VMD supports hotplug and
> you can't turn that off so hotplug is always on regardless of what the
> bits say.

This whole discussion is about who *owns* the feature, not whether the
hardware supports the feature.

The general rule is "if _OSC covers the feature, the platform owns the
feature and the OS shouldn't touch it unless the OS requests and is
granted control of it."

VMD wants special treatment, and we'd like a simple description of
what that treatment is.  Right now it sounds like you want the OS to
own *hotplug* below VMD regardless of what _OSC says.

But I still have no idea about other features like AER, etc., so we're
kind of in no man's land about how to handle them.

Bjorn

