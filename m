Return-Path: <linux-pci+bounces-6599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1E8AF8E6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 23:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734AD283008
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB391422CB;
	Tue, 23 Apr 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNRQlx+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79013CFA4
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907588; cv=none; b=sBBUko+CAaOrG35FGm7nqK7xDQcB3t1hBKXy/STp8krjoYRmDz/SM7Tx+kdP0X0RosZv8u6xa+2cxybpGTgwMUssNAUgBXpkUJ9DvkhxvCovmlDnWddnGTPIZdXn006Im99eU1BLAw9n2HW2hjg9NHYCN5H4bmKiZ+EYFlLmfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907588; c=relaxed/simple;
	bh=WaVdFUPAxuXzPATTznV3wyAlDPNxiivntGtfy0dSuA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EJt65e6dmWLTV2Xu8pRL0SSwb5vq2gzS9kuArlMrjJomcE1StMYpVEqNhZuRel8zkiEGfCT7Uep94Lv/EmdlD3haa7uVIH3keI1ieilkOXtjr27yYDLh9+lytuYUfQcl6qKIHH6bC8uTjH3tk5RmId7GAqQ5NKfRKGCEGmNXSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNRQlx+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E80EC116B1;
	Tue, 23 Apr 2024 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713907588;
	bh=WaVdFUPAxuXzPATTznV3wyAlDPNxiivntGtfy0dSuA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rNRQlx+ghErU2OLaIlErDmqGpzQzYu+agwBkfz/TmySZPxLv3YZoP0hcCMxutfDmh
	 H69OKvFZ4+9uX3bVNobxRca0cL8rj31W/kEec8TaHxIqbUbbhDayu3+tbLuTy56iBS
	 6hXGWd2bX+prvELm1J8UAPR4PCfmnPfOQH9XaXSzSG5z6DEPShcfrcMrAPv403Ok6k
	 KYsQ2bU3d0BH7+NCAM319SJ4myiAdpmLr/HwDQ0jyfBY2/nn5PE/rqLvmupdzcw2cW
	 EDOPbXGPwyA7PCkvekBg4HlFWLOg3kKMa057O77TBEons2g+Yb4OMe3qclzISzqPLS
	 UhyjET+YO6gDQ==
Date: Tue, 23 Apr 2024 16:26:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240423212626.GA458714@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6dafda7-c151-416c-a6f7-0c142b228b85@intel.com>

On Mon, Apr 22, 2024 at 04:39:19PM -0700, Paul M Stillwell Jr wrote:
> On 4/22/2024 3:52 PM, Bjorn Helgaas wrote:
> > On Mon, Apr 22, 2024 at 02:39:16PM -0700, Paul M Stillwell Jr wrote:
> > > On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
> ...

> > > > _OSC negotiates ownership of features between platform firmware and
> > > > OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
> > > > device advertises the feature, the OS can use it."  We clear those
> > > > native_* bits if the platform retains ownership via _OSC.
> > > > 
> > > > If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
> > > > the domain below it, why would we assume that BIOS retains ownership
> > > > of the features negotiated by _OSC?  I think we have to assume the OS
> > > > owns them, which is what happened before 04b12ef163d1.
> > > 
> > > Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is disabled)
> > > then all the root ports and devices underneath VMD are visible to the BIOS
> > > and OS so ACPI would run on all of them and the _OSC bits should be set
> > > correctly.
> > 
> > Sorry, that was confusing.  I think there are two pieces to enabling
> > VMD:
> > 
> >    1) There's the BIOS "VMD enable" switch.  If set, the VMD device
> >    appears as an RCiEP and the devices behind it are invisible to the
> >    BIOS.  If cleared, VMD doesn't exist; the VMD RCiEP is hidden and
> >    the devices behind it appear as normal Root Ports with devices below
> >    them.
> > 
> >    2) When the BIOS "VMD enable" is set, the OS vmd driver configures
> >    the VMD RCiEP and enumerates things below the VMD host bridge.
> > 
> >    In this case, BIOS enables the VMD RCiEP, but it doesn't have a
> >    driver for it and it doesn't know how to enumerate the VMD Root
> >    Ports, so I don't think it makes sense for BIOS to own features for
> >    devices it doesn't know about.
> 
> That makes sense to me. It sounds like VMD should own all the features, I
> just don't know how the vmd driver would set the bits other than hotplug
> correctly... We know leaving them on is problematic, but I'm not sure what
> method to use to decide which of the other bits should be set or not.

My starting assumption would be that we'd handle the VMD domain the
same as other PCI domains: if a device advertises a feature, the
kernel includes support for it, and the kernel owns it, we enable it.

If a device advertises a feature but there's a hardware problem with
it, the usual approach is to add a quirk to work around the problem.
The Correctable Error issue addressed by 04b12ef163d1 ("PCI: vmd:
Honor ACPI _OSC on PCIe features"), looks like it might be in this
category.

Bjorn

