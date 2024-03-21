Return-Path: <linux-pci+bounces-4968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697188558E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 09:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0842B281C5D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2F77828F;
	Thu, 21 Mar 2024 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5fMpg58"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4167828E;
	Thu, 21 Mar 2024 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009022; cv=none; b=sZELHzswReUNPPZkVJVMDMqNSjTPV00uxVDUGPYQWniUWgfdBz2fSO6/vgDXF9KI+Gbt4ubFPptl1WJhab4W4Niq0Ff0SH0bbpgyqC+aOB+E9IX3yfcXOkrkXpy0GueucOYKP4ywzZz42jPEyiBXQ3oBQGL0GOdveEljeC3Fh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009022; c=relaxed/simple;
	bh=r2RHfmTbLsPpzlNVzT0ZkM0H54j0pEjMtGKDo+gCUyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OELpbBDB515AYPD2nJP1C/+RFAvPyrjVo+8RrWCaDvX1lr9D/QdHVsJze/TNoFlynRdTTd8IoidHhUbnAbmbCIXAMQbe8IIlaUWnSJppXrFUGt4ZyUO5lEAWNHDoTiBYGV4ZQ3YQaVxVxJhvFgO8w26xouBiXWSafcDS495z0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5fMpg58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45234C43390;
	Thu, 21 Mar 2024 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711009022;
	bh=r2RHfmTbLsPpzlNVzT0ZkM0H54j0pEjMtGKDo+gCUyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5fMpg5882WSDUeIpySO5LC8lfYNHNnZLE4DR81NT70whYVhEuoys1M9w5F/nhX/w
	 7d7m2Wwgk2BXTqoyHD2ljzoVQj939S53AwdhhKsEy7u9xmn6T3XtQtK6SZVyWL2CDU
	 uwqj3BPnTXgIsSDyYVPrNlZ7KD+3VWHuvL7brc6BKQEPUzSBZBnpsoqqDdFkHhzjtX
	 avhkE5lU/D88T6PsdKvfAjka+SCs+ghEJs5DAUv7+BuDIds76Go5GcDtZVGPpDy9n0
	 XOyLtCmBFrAVsvxYpF6gVnU3RAr8CGZJJi62X/osuhgfg7dlU99kxAse2LFOORBgk4
	 bkwGIma+N+KgQ==
Date: Thu, 21 Mar 2024 09:16:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: mani@kernel.org, kw@linux.com, niklas.cassel@wdc.com,
	bhelgaas@google.com, gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <Zfvs-AHcuH2k9x7w@ryzen>
References: <20240304224616.1238966-1-Frank.Li@nxp.com>
 <ZfGJUDoGnFXKBoG0@ryzen>
 <Zfqj-mvpG442eyt2@ryzen>
 <Zfry1kaYgg2OBvQL@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfry1kaYgg2OBvQL@lizhi-Precision-Tower-5810>

On Wed, Mar 20, 2024 at 10:29:42AM -0400, Frank Li wrote:
> On Wed, Mar 20, 2024 at 09:53:14AM +0100, Niklas Cassel wrote:
> > On Wed, Mar 13, 2024 at 12:09:04PM +0100, Niklas Cassel wrote:
> > > On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > > > dw_pcie_ep_inbound_atu()
> > > > {
> > > > 	...
> > > > 	if (!ep->bar_to_atu[bar])
> > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > 	else
> > > > 		free_win = ep->bar_to_atu[bar];
> > > > 	...
> > > > }
> > > > 
> > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > 
> > > > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > > > it have not allocate atu to the bar.
> > > > 
> > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > 
> > > Any chance of this fix being picked up?
> > 
> > Gentle ping.
> 
> Now it is v6.9 merge windows. You'd better ping two weeks after linus
> create v6.9-rc1 tag.

I don't follow this logic.
Two weeks after v6.9-rc1 is v6.9-rc3.
Why wait that long to merge a fix?

The PCI pull request for v6.9-rc1 has already been merged.

Merging new features (to a submaintainer tree) might temporarily be put
on hold in relation to the merge window, but for fixes, it is quite
possible to both queue things (in a submaintainer tree), and to send
accumulated fixes to Linus during the merge window.

I did it myself just a few days ago, and Linus pulled it already:
https://lore.kernel.org/linux-ide/171087658094.21820.15365015832308818327.pr-tracker-bot@kernel.org/T/#t


Kind regards,
Niklas

