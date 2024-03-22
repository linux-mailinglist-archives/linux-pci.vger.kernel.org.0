Return-Path: <linux-pci+bounces-5027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF98875C5
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 00:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60521F236B6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 23:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA58174C;
	Fri, 22 Mar 2024 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDqmhlmM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4B1CD00
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150600; cv=none; b=M+NfveGrrHENi3tIwGTxuDyYU6wpW6tvn0UFnAncxLhXL5zsGJdQPtigBm+dtvvV0fgqm2+yqa4PXUOI2IK+7K/bZIDfSpQ1rmuTeiSxpXp4CfmbDrymT5gvSVvo/xQTceG5yN3ulCq0hyev2X2oWh7kXU0Lm3TEdmaS8QTkgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150600; c=relaxed/simple;
	bh=3KzZ9NSHLQRGLfpN2DRmzP8CaiKc+OZKysevAVDAUxc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iLowed9rCTz/ZV3+ZL4/N+qSfcY+ztRkQqZyS1NqSZ7j5+fLs4PxWYvLrenqEuh1CMHClOTzyxyvLqOh0CX754UiAHtYam5ezCsOcRHqMYOiRs7tkF0qATJuGHUmafRpFQHer09L36VC7NiIOk1e1xtIDgwx8+QLcgT87zGMaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDqmhlmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AE2C433C7;
	Fri, 22 Mar 2024 23:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711150599;
	bh=3KzZ9NSHLQRGLfpN2DRmzP8CaiKc+OZKysevAVDAUxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nDqmhlmMtuARcDdBLFB5gbYLxFyinlOeyiFANRsc5MQQV90B1T3Jmyr9pqhcIs1cw
	 G7ZnNcdr1KWhIOK9eU+Gh9RcWvooeJTw2bKft+9A9Z898GRzt/egEh7qtb58UxakyN
	 Dtbg7g4v4zlmrfX762EZCMoapleWRwI1PnyQBTUoa28d+JN+gxHIYLFje+n5r34rRi
	 xexZ5KoYUR+pRFq8LNbBDLGt9JwFYD49UDmTZ5+bEsLMosaY5IAYTimzTbWpDfNvb2
	 bRMDZ8mVrveVeFnaw7bSHW29/lipvXCtS0ls6qaQNe3ArtxpFuuNKuMkInJrkz4MWN
	 GFYvt5cpH1Mag==
Date: Fri, 22 Mar 2024 18:36:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240322233637.GA1385969@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f37506e-4849-4c7d-b76c-27b02b7453af@intel.com>

On Fri, Mar 22, 2024 at 03:43:27PM -0700, Paul M Stillwell Jr wrote:
> On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:
> > On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel wrote:
> > > On Fri, 15 Mar 2024 09:29:32 +0800
> > > Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > ...
> > 
> > > > If there's an official document on intel.com, it can make many things
> > > > clearer and easier.
> > > > States what VMD does and what VMD expect OS to do can be really
> > > > helpful. Basically put what you wrote in an official document.
> > > 
> > > Thanks for the suggestion. I can certainly find official VMD
> > > architecture document and add that required information to
> > > Documentation/PCI/controller/vmd.rst. Will that be okay?
> > 
> > I'd definitely be interested in whatever you can add to illuminate
> > these issues.
> > 
> > > I also need your some help/suggestion on following alternate solution.
> > > We have been looking at VMD HW registers to find some empty registers.
> > > Cache Line Size register offset OCh is not being used by VMD. This is
> > > the explanation in PCI spec 5.0 section 7.5.1.1.7:
> > > "This read-write register is implemented for legacy compatibility
> > > purposes but has no effect on any PCI Express device behavior."
> > > Can these registers be used for passing _OSC settings from BIOS to VMD
> > > OS driver?
> > > 
> > > These 8 bits are more than enough for UEFI VMD driver to store all _OSC
> > > flags and VMD OS driver can read it during OS boot up. This will solve
> > > all of our issues.
> > 
> > Interesting idea.  I think you'd have to do some work to separate out
> > the conventional PCI devices, where PCI_CACHE_LINE_SIZE is still
> > relevant, to make sure nothing breaks.  But I think we overwrite it in
> > some cases even for PCIe devices where it's pointless, and it would be
> > nice to clean that up.
> 
> I think the suggestion here is to use the VMD devices Cache Line Size
> register, not the other PCI devices. In that case we don't have to worry
> about conventional PCI devices because we aren't touching them.

Yes, but there is generic code that writes PCI_CACHE_LINE_SIZE for
every device in some cases.  If we wrote the VMD PCI_CACHE_LINE_SIZE,
it would obliterate whatever you want to pass there.

Bjorn

