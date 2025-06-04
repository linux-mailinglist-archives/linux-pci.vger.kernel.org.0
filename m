Return-Path: <linux-pci+bounces-28960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CF4ACDCD0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 13:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF61175B25
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50F28D8D4;
	Wed,  4 Jun 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCGwShIJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6628C030
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037259; cv=none; b=pj1Eujy+l/QOzzYho477ZNtatRjwCq50y3c/FdU09WqUTZe1e0K7vBVTkhx4/ifKh6xbs4AubbL4LRn1CFeKgq453ysnfJM/NLlSxmBc5BeWaLaVRBxxOrQ40rDlq0y9Rqj5gv21SE7R5+SP/upiHDMM2ZExfE54Cjq2x+y21tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037259; c=relaxed/simple;
	bh=na+e7iAyIdNEOxA/Fo3/lMjI298SPFA0QzS+xSDF0Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNpO1npl00/5wxJyeuK3i84bO3VMLFfZSRD3D7n00G109ikLuRNcT4lx27dA6c0T6bY3c4PLjCk2LjjCJNS7v7d3uf+k2syIceOtYq4Ip+IxHvciRlGJy6as92lERNRJHV3+gk+MxrMGPw4Yx6ZIiRikNIzZH0FR9JtpfFbJIGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCGwShIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844CEC4CEEF;
	Wed,  4 Jun 2025 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749037258;
	bh=na+e7iAyIdNEOxA/Fo3/lMjI298SPFA0QzS+xSDF0Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCGwShIJtYiAjjl7xwa4EpbS0L6ohuJBWlnfXSAmmC1FMtZYotGyitscDbYVcRxYV
	 ynLCuyn2fuaSVssZAmNVKe/M67ECh6gQK3n9/kbHgo2cydL1gZMnxO/01nbd3IuOca
	 dGhbgEwisZyg0PvqjkiyLrHvPeM7tOZzvINjYZEbISW6bvuqu2dRPDzd7b2Kej8Dar
	 jpAZSD2kPPfJFtwDNCaLuTzAPGmXLbw+FvDbBu8cIGTeOBeJvcrpnWNPnB561F7zrw
	 /ykTtbx2u+vOHOb6T/krUbRg4fNruJYeOTYP8PUtu1dLEGayEwWmNplfM2Bd+qZa4C
	 TJYXhYCpyp/SQ==
Date: Wed, 4 Jun 2025 13:40:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <aEAwxFysCgdJCD54@ryzen>
References: <aD8Bz4CkdnAd8Col@ryzen>
 <20250603181250.GA473171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603181250.GA473171@bhelgaas>

On Tue, Jun 03, 2025 at 01:12:50PM -0500, Bjorn Helgaas wrote:
> 
> Hmmm, sorry, I misinterpreted both 1/4 and 2/4.  I read them as "add
> this delay so the PLEXTOR device works", but in fact, I think in both
> cases, the delay is actually to enforce the PCIe r6.0, sec 6.6.1,
> requirement for software to wait 100ms before issuing a config
> request, and the fact that it makes PLEXTOR work is a side effect of
> that.

Well, the Plextor NVMe drive used to work with previous kernels,
but regressed.

But yes, the delay was added to enforce "PCIe r6.0, sec 6.6.1"
requirement for software to wait 100ms, which once again makes
the Plextor NVMe drive work.


> 
> The beginning of that 100ms delay is "exit from Conventional Reset"
> (ports that support <= 5.0 GT/s) or "link training completes" (ports
> that support > 5.0 GT/s).
> 
> I think we lack that 100ms delay in dwc drivers in general.  The only
> generic dwc delay is in dw_pcie_host_init() via the LINK_WAIT_SLEEP_MS
> in dw_pcie_wait_for_link(), but that doesn't count because it's
> *before* the link comes up.  We have to wait 100ms *after* exiting
> Conventional Reset or completing link training.

In dw_pcie_wait_for_link(), in the first iteration of the loop, the link
will never be up (because the link was just started),
dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS (90 ms),
before trying again.

Most likely the link training took way less than 100 ms, so most of those
90 ms will probably be after link training has completed.

That is most likely why Plextor worked on older kernels (which does not
use the link up IRQ).

If we add a 100 ms sleep after wait_for_link(), then I suggest that we
also reduce LINK_WAIT_SLEEP_MS to something shorter.


> 
> We don't know when the exit from Conventional Reset was, but it was
> certainly before the link came up.  In the absence of a timestamp for
> exit from reset, starting the wait after link-up is probably the best
> we can do.  This could be either after dw_pcie_wait_for_link() finds
> the link up or when we handle the link-up interrupt.
> 
> Patches 1 and 2 would fix the link-up interrupt case.  I think we need
> another patch for the dwc core for dw_pcie_wait_for_link().

I agree, sounds like a plan.


> 
> I wish I'd had time to spend on this and include patches 1 and 2, but
> we're up against the merge window wire and I'll be out the end of this
> week, so I think they'll have to wait.  It seems like something we can
> still justify for v6.16 though.

I think it sounds good to target this as fixes for v6.16.

Do you plan to send out something after -rc1, or do you prefer me to do it?


Kind regards,
Niklas

