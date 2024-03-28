Return-Path: <linux-pci+bounces-5359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19903890C2E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 22:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276F01C222D4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A13782870;
	Thu, 28 Mar 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbKPKWA8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204EA2C6B1;
	Thu, 28 Mar 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660009; cv=none; b=YBrSvtxcTnkHa6p3mokI+0TjUQHX7cDdbvJ2qrXHCTLNFVmwQVtr8keaztyx8/+m7AIN3hCvwcYci4TpCkSTdN4ab06CffFsJS7jsdk+bQgDoykT2osGj2R0r27SsX/KlkFKE3dctA8F7VCG1rsniFLHBdG8K2mRTY8qGeLafxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660009; c=relaxed/simple;
	bh=uEta2BrWAKz194xIrnBwKypqhcaPd50jFm3BWsmHjQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CJhLgoZZ0UvzXRYUu1lI3Mgeoh9xp2HdklNhBtW5sc5Yiv0SNJ6My80W+ULZdil+2suvW0c906X3CvUoE/AGHwPalyuRA7/V1gkFxxcP5a6ZuDZiZNWtbyGqbZe6ehj+gZRcwyqLlAIkPIGVD0ty8vnu7J6keDLm4ARyNBvSiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbKPKWA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8BAC433F1;
	Thu, 28 Mar 2024 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711660008;
	bh=uEta2BrWAKz194xIrnBwKypqhcaPd50jFm3BWsmHjQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pbKPKWA80fpWni2qqH6zOJXCN+mhBMjc1x7SXcZ3XBlogWvtHnhcwmNKbulZ/n//J
	 hC4b0c5leZrF2UUHApujsE1XI9HTQNtM1bvWDViVvq/K+wIcl8cq7J/q1b8ACzdYjF
	 75hlUtmiF2LWfQyWrZ4hSqdgkmdpN2QOcjhTlvyz+IfZf2J8XrYfP1VSbzTBFGOqEO
	 nTVl883ZEIawOcTaisRdPPvbu3lr/p5tf7GHbnv1W6FxA417YXnIzhA15QYHtsJie7
	 8qS0/qZ+mL1G/MayQakQbt6AuAULzAYVIxILr91B3E+P7YUFCh3Zg7cj35b+VsJE8F
	 C+sn6vefotD4A==
Date: Thu, 28 Mar 2024 16:06:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240328210646.GA1581782@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328144201.510f6d5e.alex.williamson@redhat.com>

On Thu, Mar 28, 2024 at 02:42:01PM -0600, Alex Williamson wrote:
> On Wed, 27 Mar 2024 10:01:19 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Tue, Mar 26, 2024 at 10:18:58PM +0900, Takashi Sakamoto wrote:
> > > On Mon, Mar 25, 2024 at 09:41:49AM -0500, Bjorn Helgaas wrote:  
> > > > So even without this patch, you are able to pass the FW643 to a VM
> > > > with VFIO, and you don't see any issues caused by VFIO resetting the
> > > > device?  
> > >  
> > > Absolutely yes, at least in my VM, for recent years to maintain Linux
> > > FireWire subsystem and ALSA firewire stack.  
> > 
> > So there must be something different between your system and Edmund's.
> > Maybe we can refine the quirk so it avoids the SBR on Edmund's system
> > but not yours.
> > 
> > Can you both collect the output of "sudo lspci -vvv" so we can try to
> > figure out the difference?  Also a complete dmesg log would be helpful
> > and would contain DMI information that we might need if this is
> > firmware dependent.
> 
> The original patch proposed for this gave me the impression that this
> was a device used on various old Mac systems, not likely applicable to
> a general purpose plug-in card.  Given the expanded use case, I'd
> suggest reverting the patch.

Makes sense, I'll queue up a revert for v6.9 so we can take some time
to figure this out.

> I think we need significantly more exhaustive testing on the afflicted
> system to understand whether this is an issue with the endpoint, the
> root port, the BIOS, etc.
> 
> In the meantime, or maybe as a permanent solution, Edmund can make use
> of the reset_method interface in pci-syfs to restrict the available
> reset methods for the device rather than risk removing a reset
> mechanism identified as working by other users.  My 2 cents.  Thanks,
> 
> Alex
> 

