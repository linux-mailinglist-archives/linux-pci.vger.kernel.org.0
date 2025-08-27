Return-Path: <linux-pci+bounces-34942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC13B38E86
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 00:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD3B160EF1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A124304BB2;
	Wed, 27 Aug 2025 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUpxeAZt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3704438B;
	Wed, 27 Aug 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334169; cv=none; b=QDggZiLqi8kJNimMoCLdNCDFT6jgIhCcST7tCPT4a+i9cYs1Pks/oT3Fd+qt4aThe93oOGE663bV1ezvbt3RPLD0SxeejvlxyWXXXFH2/1ULrsnYoW1wE1rx2Iaxm982WortLHTmebSaKPY7lEGMsfJINZz4VbgaG8zw8fnL2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334169; c=relaxed/simple;
	bh=SuvtG9zPU1paS6zdtAQLH1EmQzS92Y488uepGCslfWI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FANBEHsYc+JZAcAgVqyNA+ReDGEuKt0Ah7/hf+bqGxWM7BpFfzRTvZgQr14mz6fAfvRX08wUyjgEmxB5Vy0+nsxhxKjn+LAS/m8WxQ3Y4gR11WV0iaGWqhAUFDNEGTm3Sw486jybZDpMsHrwDRcueNuKi/3FfmjgNXF24HbV2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUpxeAZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3EBC4CEEB;
	Wed, 27 Aug 2025 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756334168;
	bh=SuvtG9zPU1paS6zdtAQLH1EmQzS92Y488uepGCslfWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DUpxeAZt3sd2SF+CHF9cOy/FaqwBpkfO3QmQLN4WtjqYJww1JgdN330EJgtOo7awf
	 xyWVC65Ik9s82mLjd16u/fsvSuu23dv4M1YBxCe8bO6CXWEgzoRLhpV3WDHPmP25aY
	 MN84rM34MoHWDkORX0/iiQ1n3JoUADeR5wXKbBAovlj1sAMI5uZeJDeOfTYi0lz+zn
	 V5/DUusNTXr35xQCbizoSyjKjZgXsropAj0Da/2jC4EKIm5VEVn251opw5aNwUVvou
	 RRsuPYOe7vPF9M/TvmOxlhhB1X2T3hVX9lRk7L3x0iNPNnhqbMmQokcb4oci+E0njx
	 QPfbX1CvuOzSQ==
Date: Wed, 27 Aug 2025 17:36:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/24] PCI: Bridge window selection improvements
Message-ID: <20250827223606.GA915856@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>

On Fri, Aug 22, 2025 at 05:55:41PM +0300, Ilpo Järvinen wrote:
> This series is based on top of the three resource fitting and
> assignment algorithm fixes (v3).
> 
> PCI resource fitting and assignment code needs to find the bridge
> window a resource belongs to in multiple places, yet, no common
> function for that exists. Thus, each site has its own version of
> the decision, each with their own corner cases, misbehaviors, and
> some resulting in complex interfaces between internal functions.
> ...

> I've tried to look out for any trouble that code under arch/ could
> cause after the flags start to behave differently and therefore ended
> up consolidating arch/ code to use pci_enable_resources(). My
> impression is that strictly speaking only the MIPS code would break
> similar to PCI core's copy of pci_enable_resources(), the others were
> much more lax in checking so they'd likely keep working but
> consolidation seemed still the best approach there as the enable checks
> seemed diverging for no apparent reason.
> ...

>   m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
>   sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
>   MIPS: PCI: Use pci_enable_resources()
> ...

>  arch/m68k/kernel/pcibios.c   |  39 +-
>  arch/mips/pci/pci-legacy.c   |  38 +-
>  arch/sparc/kernel/leon_pci.c |  27 --
>  arch/sparc/kernel/pci.c      |  27 --
>  arch/sparc/kernel/pcic.c     |  27 --
> ...

I love the fact that you're doing so much cleanup.  Thanks for all the
work in this!

Obviously all this code is quite sensitive, so I put it on
pci/resource to get more exposure in -next.  If it turns out that we
trip over things or just don't feel comfortable yet for v6.18, we can
always defer this part until the next cycle.

I will also watch for acks from the m68k, mips, and sparc maintainers
for those pieces.

Bjorn

