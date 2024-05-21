Return-Path: <linux-pci+bounces-7718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60DE8CB027
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558611F25696
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C957F7C3;
	Tue, 21 May 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtLLmbNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A67F7C1;
	Tue, 21 May 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300874; cv=none; b=TxbmjBbuW/l2XH7/IjXy5QdWvqs5ylbHWAnsMwhBR62yx4VtJ4yWDn2C4P28yyTxyMA92ZCODjyu42C9EnD23mPXPC1F+EY5fklwp/bWw8s9AoManAnxNopb3ocwo5JWRqB6jmSn+UoDKPrC/SGHmNhqWgjRwb0lQWUwearGzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300874; c=relaxed/simple;
	bh=AY9z2jOOOiWR4ihFpXH0l9LYmrbHOhfxQ20WcMzm54U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BrHiCoKdTwlugHcka0qTDTYr3+VaWXwgC0hrVGh1OFgHBFW+iVoozExzXTH2/4ATYSTwh28xPXJ7Dn1i6ccO+ZFSZMNdtfeqqs+caBeMWVR/zTPzrDWsv0fH/wI7xgysaPI67PM1uLuuVOiW87zOLy+Iyc6poOd1d0+cggz27n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtLLmbNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA5C2BD11;
	Tue, 21 May 2024 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300874;
	bh=AY9z2jOOOiWR4ihFpXH0l9LYmrbHOhfxQ20WcMzm54U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UtLLmbNUJPJuLX2G+rdPKrRs7Ld64KuKOmLlxZ2dTcolrqBtoDWoaKqStL+aY95ve
	 WIkYNwO7nZeBFPRPVSQuyf6byue/iEs0+gIxT86alE5gxzb9BJewOmkgt0faX4Ht/A
	 d2Dc56JmsOUM1mDwqRDsuN40nf27LcmEKNLQHMr/NUS8Ay+te6wDx47kht6jMDdLr0
	 y9UpyW/ZwIeNxJ3nDTZ9cmSrlpWAp67K9fItN0K6vW0Rm/QEWkmPe7Oi9YcNoUFkL6
	 pcm5XQ2zyXLRQnZMLVX1p+XWn0NfMK1EuQCFwl6e4jX5quZjTuH7U1XZkZ/Cb5fmjp
	 H5k1enDRV9Q4A==
Date: Tue, 21 May 2024 09:14:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	bhelgaas@google.com, mani@kernel.org, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v4 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240521141431.GA25673@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zkx0lzP76bmp4K0r@ryzen.lan>

On Tue, May 21, 2024 at 12:16:55PM +0200, Niklas Cassel wrote:
> On Sat, May 18, 2024 at 02:06:50AM +0900, Krzysztof Wilczyński wrote:
> > Hello,
> > 
> > > When PERST# assert and deassert happens on the PERST# supported platforms,
> > > the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
> > > to the area that was previously allocated (iATU0) for BAR0, instead of the
> > > new area (iATU6) for BAR0.
> > > 
> > > Right now, we dodge the bullet because both iATU0 and iATU6 should
> > > currently translate inbound accesses to BAR0 to the same allocated memory
> > > area. However, having two separate inbound mappings for the same BAR is a
> > > disaster waiting to happen.
> > > 
> > > The mapping between PCI BAR and iATU inbound window are maintained in the
> > > dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
> > > a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
> > > of the existing mapping in the array and if it is not found (i.e., value in
> > > the array indexed by the BAR is found to be 0), then it will allocate a new
> > > map value using find_first_zero_bit().
> > > 
> > > The issue here is, the existing logic failed to consider the fact that the
> > > map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
> > > will return '0' as the map value for BAR0 (note that it returns the first
> > > zero bit position).
> > > 
> > > Due to this, when PERST# assert + deassert happens on the PERST# supported
> > > platforms, the inbound window allocation restarts from BAR0 and the
> > > existing logic to find the BAR mapping will return '6' for BAR0 instead of
> > > '0' due to the fact that it considers '0' as an invalid map value.
> > > 
> > > So fix this issue by always incrementing the map value before assigning to
> > > bar_to_atu[] array and then decrementing it while fetching. This will make
> > > sure that the map value '0' always represents the invalid mapping."
> > 
> > Applied to controller/dwc, thank you!
> > 
> > [1/1] PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot
> >       https://git.kernel.org/pci/pci/c/cd3c2f0fff46
> > 
> > 	Krzysztof
> 
> Hello PCI maintainers,
> 
> There was a message sent out that this patch was applied, yet the patch does
> not appear to be part of the pull request that was sent out yesterday:
> https://lore.kernel.org/linux-pci/20240520222943.GA7973@bhelgaas/T/#u
> 
> In fact, there seems to be many PCI patches that have been reviewed and ready
> to be included (some of them for months) that is not part of the pull request.
> 
> Looking at pci/next, these patches do not appear there either, so I assume
> that these patches will also not be included in a follow-up pull request.
> 
> Some of these patches are actual fixes, like the patch in $subject, and do not
> appear to depend on any other patches, so what is the reason for not including
> them in the PCI pull request?

The problem was that we didn't get these applied soon enough for them
to get any time in linux-next before the merge window opened.  I don't
like to add non-trivial things during the merge window, so I deferred
most of these.  I plan to get them in linux-next as soon as v6.10-rc1
is tagged.

If we can make a case for post-merge window fixes, e.g., to fix a
regression in the pull request or other serious issue, that's always a
possibility.

Bjorn

