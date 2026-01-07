Return-Path: <linux-pci+bounces-44194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59582CFE4B3
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D54C3061DCF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C087B34CFDA;
	Wed,  7 Jan 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mys3KVGI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1A34BA56;
	Wed,  7 Jan 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796053; cv=none; b=XpPyO9MVX8XIWQbY44f66UjYCJ9afXjYd94W9hUbtiCRrnzdk/k6H90CHCOhsa/4R//rVXcgMejYhRJF7PFXCMqbmTrAh62iRrf1J8mdk5HPDvDHzPcHU5YZG2/HLPI03CeNKq5CAFp3QVgGUTZvW16sHlKvzoM7/NhCeohxqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796053; c=relaxed/simple;
	bh=+zcMnnFQz/qwQcPp7U3zI2tQM5Aa6IWvgwzccZIsIUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJkR406qCZYTfeww4CRFNSYv9ygEiUkUHEq10CybVUAYP/2vE1vWYM9m1k33ShDyMYkqkmaMcHOx4LmIGVP4OyD1WEjcrplq/2UXAzP47La4905v8mPs2CQNP9EO/KJ+RwdHLjP9ym0r9nyk+Zd8+gpA2qr4t5F0PK/7JFV4HM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mys3KVGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89D1C4CEF7;
	Wed,  7 Jan 2026 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767796053;
	bh=+zcMnnFQz/qwQcPp7U3zI2tQM5Aa6IWvgwzccZIsIUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mys3KVGIl789vox/XjjcpJUROipOG/uPP8aMGLC5bnOH494aVKa5zsxSt4IbJrWgJ
	 W869k/CGiYx1CViMXOor2WxFXAixxTcMddu4HqLHNsdWRhHkLnXd7+5ILXqSOEAgdK
	 umfI/ScFvKEp5qyWEy++Y09LPJrd26/HPJeQ9g3MZuHIVay71yO3XKT7CbxTivDvJ7
	 W7bC0fbSKOKieFCNTKyJbDlVLiKD9/LcyUVoqEIm+76rXghhUaJ+Li1c3pq4tjo1Pj
	 g+n5Et8wZXcVCij8Acu/1f5vLJuq26nMAiPJnymqYlwlVsDh5vqL0zKvzJI87pZwdf
	 Bt/DAR0bRkREA==
Date: Wed, 7 Jan 2026 15:27:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: ep: Support BAR subrange inbound
 mapping via address-match iATU
Message-ID: <aV5tUE02ipda-R76@ryzen>
References: <20260107041358.1986701-1-den@valinux.co.jp>
 <20260107041358.1986701-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107041358.1986701-3-den@valinux.co.jp>

Hello Koichiro,


I like this design way more, where you have a one-shot (all-or-nothing)
submap programming to avoid leaving half-programmed BAR state.


On Wed, Jan 07, 2026 at 01:13:58PM +0900, Koichiro Den wrote:
> +/* Address Match Mode IB iATU mapping */
> +static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
> +				  const struct pci_epf_bar *epf_bar)
> +{
> +	struct pci_epf_bar_submap *submap = epf_bar->submap;
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	struct device *dev = pci->dev;
> +	u64 pci_addr, parent_bus_addr;
> +	struct dw_pcie_ib_map *new;
> +	u64 size, off, base;
> +	unsigned long flags;
> +	int free_win, ret;
> +	unsigned int i;
> +
> +	if (!epf_bar->num_submap || !submap || !epf_bar->size)
> +		return -EINVAL;
> +
> +	/* Work on a sorted copy */
> +	struct pci_epf_bar_submap *smap __free(kfree) = kcalloc(
> +				epf_bar->num_submap, sizeof(*smap), GFP_KERNEL);
> +	if (!smap)
> +		return -ENOMEM;
> +
> +	memcpy(smap, submap, epf_bar->num_submap * sizeof(*smap));
> +	sort(smap, epf_bar->num_submap, sizeof(*smap),
> +	     dw_pcie_ep_submap_offset_cmp, NULL);

My only comment is that:

Why not simply let dw_pcie_ep_validate_submap() return an error if the
caller of dw_pcie_ep_set_bar() did not provide a submap with offsets in
ascending order (i.e. sorted).

Performing an unconditional sort of the submap here looks a bit out of
place, IMO.


> +
> +	ret = dw_pcie_ep_validate_submap(ep, smap, epf_bar->num_submap, epf_bar->size);
> +	if (ret)
> +		return ret;


Kind regards,
Niklas

