Return-Path: <linux-pci+bounces-7713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C373B8CAC18
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 12:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AED1B22E2E
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F278C70;
	Tue, 21 May 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1kAgxiu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0778C6B;
	Tue, 21 May 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286621; cv=none; b=XvsNktlwIh56ilJUPQV7miPsefnMsmWRlYlRjGOXlMrTPPDYLVBenVUDP69xYPYLIpECmJovj+QkSUz86v1sCBt2GumqHQ53WyHtQNbi7LAwGmc/ofqZKY6T5Uz4AgpTcPFMV3OCb6pwQLZLxAkRRvNMhM3XG3pHvHbvNpgN8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286621; c=relaxed/simple;
	bh=PNikNaHR6zU/zfXGkNmZ8iumO7c9iBa0+ICynQKy2Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISgpIW5XQsU/ja8m42+XFcEqymdLDc4eI6srhO+olh8pqK885Pi1qsO9o38Os9yx8zRC9zjih4oxp6BziY6pgLvBEnU3OGAxvdo4HG98SuEtKpRETPurwMa7vEitqZzp+6/NrSH25ReAR6H+sdKDz+TNB2vPIENa93YAklNUjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1kAgxiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21C5C32782;
	Tue, 21 May 2024 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716286621;
	bh=PNikNaHR6zU/zfXGkNmZ8iumO7c9iBa0+ICynQKy2Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1kAgxiuE9rA/Hvqgct3mNL21APMt0RhL2f9/WJ2DjnIvh+b5obh7vYvCpVkGp/sv
	 vkl6CSnH56jgHicS/YPmlipskcvM9TjM6lMZ1T3PvbznCzAkGkd1KjMisOIhh8nZyB
	 HKBb8iY4/PmKfQpdFNZKpwfHuneh2I5IibdZDpXy5WCNAKwbQGxUa2SLIrzJsn6sR+
	 C6u5ex1q0wx4YC9h42PDhx3Q5jkuiZPD/VsUxilW9LQCGwGPtPbGOgTE5lOilzZXYo
	 bTXFqg3XHr95K26mBd0gJ0xU8KvqLd2kF64SNS2hi8EWRwTjV0hAWRQ7Luc9teBZtG
	 /wQ/33ZvivwXw==
Date: Tue, 21 May 2024 12:16:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	bhelgaas@google.com, mani@kernel.org
Cc: Frank Li <Frank.Li@nxp.com>, helgaas@kernel.org, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v4 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <Zkx0lzP76bmp4K0r@ryzen.lan>
References: <20240412160841.925927-1-Frank.Li@nxp.com>
 <20240517170650.GC1947919@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517170650.GC1947919@rocinante>

On Sat, May 18, 2024 at 02:06:50AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > When PERST# assert and deassert happens on the PERST# supported platforms,
> > the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
> > to the area that was previously allocated (iATU0) for BAR0, instead of the
> > new area (iATU6) for BAR0.
> > 
> > Right now, we dodge the bullet because both iATU0 and iATU6 should
> > currently translate inbound accesses to BAR0 to the same allocated memory
> > area. However, having two separate inbound mappings for the same BAR is a
> > disaster waiting to happen.
> > 
> > The mapping between PCI BAR and iATU inbound window are maintained in the
> > dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
> > a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
> > of the existing mapping in the array and if it is not found (i.e., value in
> > the array indexed by the BAR is found to be 0), then it will allocate a new
> > map value using find_first_zero_bit().
> > 
> > The issue here is, the existing logic failed to consider the fact that the
> > map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
> > will return '0' as the map value for BAR0 (note that it returns the first
> > zero bit position).
> > 
> > Due to this, when PERST# assert + deassert happens on the PERST# supported
> > platforms, the inbound window allocation restarts from BAR0 and the
> > existing logic to find the BAR mapping will return '6' for BAR0 instead of
> > '0' due to the fact that it considers '0' as an invalid map value.
> > 
> > So fix this issue by always incrementing the map value before assigning to
> > bar_to_atu[] array and then decrementing it while fetching. This will make
> > sure that the map value '0' always represents the invalid mapping."
> 
> Applied to controller/dwc, thank you!
> 
> [1/1] PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot
>       https://git.kernel.org/pci/pci/c/cd3c2f0fff46
> 
> 	Krzysztof

Hello PCI maintainers,

There was a message sent out that this patch was applied, yet the patch does
not appear to be part of the pull request that was sent out yesterday:
https://lore.kernel.org/linux-pci/20240520222943.GA7973@bhelgaas/T/#u

In fact, there seems to be many PCI patches that have been reviewed and ready
to be included (some of them for months) that is not part of the pull request.

Looking at pci/next, these patches do not appear there either, so I assume
that these patches will also not be included in a follow-up pull request.

Some of these patches are actual fixes, like the patch in $subject, and do not
appear to depend on any other patches, so what is the reason for not including
them in the PCI pull request?


Kind regards,
Niklas

