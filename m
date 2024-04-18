Return-Path: <linux-pci+bounces-6465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DDD8AA5E1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 01:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43650285A39
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 23:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D075FEED;
	Thu, 18 Apr 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHE1t07U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7654776
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483278; cv=none; b=DG1VTCTuy5QmixE78NAkG/Y3hIVTAi4rIuJyU8YslXp2eLrvy05D9ji6nbmHGph0UNEUujpjDEzTLHynOg/SmQv2/AHBS1femty+3i9AuH7KAUZJd2e6bQ2uChWt2AUPe+y0D594TITrX3FdEg+PVBqL0uD5ZNM/5rmqiDT9Pyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483278; c=relaxed/simple;
	bh=fQGL3ccyjVBbLbqAcSzJjzXmacbIhYft2pLHKIaWaOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR2Aw/ar+je7xuEKAUAdAw4wRtaW2GgvKRzDfSVcHHc6B398+MGGBLp01QyWdBhJ9H80qEbqaAdhSt7qogKSiBdiahEn4kpOvh1N0UyEzl8+m/PJznIw5BXHg4HUlMPVBOSr2oa05gpno/17hAIk9OnkipAWIDvr8DZMGmkT2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHE1t07U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970AEC113CC;
	Thu, 18 Apr 2024 23:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713483277;
	bh=fQGL3ccyjVBbLbqAcSzJjzXmacbIhYft2pLHKIaWaOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHE1t07URmfGOhp1SWWGWKbS1MToZqTiEiIj9UD6N7hSTL3ev5aTdjXNJHlJ3YaQx
	 wbvlXUteMvGj4cLVGW00LwrE3T8pUexxZFsFql2VmdUfkKXe3psngFTcGprv7oJeI7
	 piaGn5LyP/iKSevCCB14Hu0PTn70+38NHWz5NvpGC8zv0gzmcMO4rzgevABNNc86CJ
	 pdzpU3ZYRe56SsWulauW+UtlewExHhQea0ptInwbJ2t9Gb5pgDMgprsrK2oNz2qzA+
	 gFencqKAfzguUP30zSrjQpzIPOwF6mYStcQgxXasQASvvCB84z0aivG9xNPeOVn7vi
	 iy8Zx7qbPqt8w==
Date: Thu, 18 Apr 2024 17:34:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <ZiGuC7VDCx2t740S@kbusch-mbp>
References: <20240417201542.102-1-paul.m.stillwell.jr@intel.com>
 <ZiBgeYVQRLWPs_ZO@kbusch-mbp>
 <f2f050c0-178b-4841-bd2c-3a7026481c89@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f050c0-178b-4841-bd2c-3a7026481c89@intel.com>

On Thu, Apr 18, 2024 at 08:07:26AM -0700, Paul M Stillwell Jr wrote:
> On 4/17/2024 4:51 PM, Keith Busch wrote:
> > On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
> > > +=================================================================
> > > +Linux Base Driver for the Intel(R) Volume Management Device (VMD)
> > > +=================================================================
> > > +
> > > +Intel vmd Linux driver.
> > > +
> > > +Contents
> > > +========
> > > +
> > > +- Overview
> > > +- Features
> > > +- Limitations
> > > +
> > > +The Intel VMD provides the means to provide volume management across separate
> > > +PCI Express HBAs and SSDs without requiring operating system support or
> > > +communication between drivers. It does this by obscuring each storage
> > > +controller from the OS, but allowing a single driver to be loaded that would
> > > +control each storage controller. A Volume Management Device (VMD) provides a
> > > +single device for a single storage driver. The VMD resides in the IIO root
> > > +complex and it appears to the OS as a root bus integrated endpoint. In the IIO,
> > > +the VMD is in a central location to manipulate access to storage devices which
> > > +may be attached directly to the IIO or indirectly through the PCH. Instead of
> > > +allowing individual storage devices to be detected by the OS and allow it to
> > > +load a separate driver instance for each, the VMD provides configuration
> > > +settings to allow specific devices and root ports on the root bus to be
> > > +invisible to the OS.
> > 
> > This doesn't really capture how the vmd driver works here, though. The
> > linux driver doesn't control or hide any devices connected to it; it
> > just creates a host bridge to its PCI domain, then exposes everything to
> > the rest of the OS for other drivers to bind to individual device
> > instances that the pci bus driver finds. Everything functions much the
> > same as if VMD was disabled.
> 
> I was trying more to provide an overview of how the VMD device itself works
> here and not the driver. The driver is fairly simple; it's how the device
> works that seems to confuse people :).

Right, I know that's how the marketing docs described VMD, but your new
doc is called "Linux Base Driver for ... VMD", so I thought your goal
was to describe the *driver* rather than the device.

> Do you have a suggestion on what you would like to see here?

I think we did okay with the description in the initial commit log. It
is here if you want to reference that, though it may need some updates
for more current hardware.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=185a383ada2e7794b0e82e040223e741b24d2bf8

