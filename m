Return-Path: <linux-pci+bounces-14316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61A99A3CD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB6E2884C3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942C213EEB;
	Fri, 11 Oct 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp2yaXP4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D24212F13
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649379; cv=none; b=q+mXWzG2pOpb8WyYW3b1K+clNnnmeDHmZAGrtKZa90rCESESOWZ3bScFLfN1R5ITDp8kc/MmhxEzU6d9V1qME9zEfUoFMHMMq35g0vURdCmScRUyPyof1oSnCrIlr+BeqQwkKOGuqM5puiuYerTZpb6mkF2NCfjRiJfuM+Y8TXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649379; c=relaxed/simple;
	bh=5Q5NcrThLnv4jZVvFygS/AmXCz9yO9z3rCvhnBG0SZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixpwor5+UsC8NIwyELkHjP2UQaiVHaSi8PPk6Xk40BNYfHNfxIDFLbsbWYt0ZZItsrKQRvWwTZKAFHd89TurZwuw5qxUypjFrcCavCTkoppWWBpTG3oA/ZpoAo608SfoU19wO5k9aoC3WE00TeQNCaA20do4tYuy8DvDAjGGFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp2yaXP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A481C4CEC3;
	Fri, 11 Oct 2024 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649379;
	bh=5Q5NcrThLnv4jZVvFygS/AmXCz9yO9z3rCvhnBG0SZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cp2yaXP48wRe429pELvHiOHjOyNiWox6jjjD5EODyvbjAjkBjbEuACecEp7B+SCQV
	 Ly7MMcRrADvKZroSMT6Fbo1Bdg5Cd9jPyMzGfAcaEFc5gx3sQT0W/cjVMd/FgPu0n2
	 YJFElQAygiX7Rwm7kecv/I+ukROzCmy/sk65u0wBELBFym0hX9yd6wLL45o2Msw/sb
	 zGlULAVC+aSI3WW7okhgsqYBy3xfIxZPPcN7edvB7R0O+GrbZ8T9uWg+ltI/MpMPOq
	 UC0ivUp/io37aT+6F0nJavJYeFw0FbQyDUnqHbzDaLxRipsJXNf7EiWS9B6FvOGBaF
	 qLV/jyGtWYvXg==
Date: Fri, 11 Oct 2024 14:22:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v5 3/6] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Message-ID: <ZwkYnr4VdxSNuUq1@ryzen.lan>
References: <20241011120115.89756-1-dlemoal@kernel.org>
 <20241011120115.89756-4-dlemoal@kernel.org>
 <ZwkU68LjTkahz_RZ@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkU68LjTkahz_RZ@ryzen.lan>

On Fri, Oct 11, 2024 at 02:07:07PM +0200, Niklas Cassel wrote:
> On Fri, Oct 11, 2024 at 09:01:12PM +0900, Damien Le Moal wrote:

(snip)

> > +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
> > +{
> > +	int ret;
> > +
> > +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> > +		return -EINVAL;
> > +
> > +	if (!pci_size || !map)
> > +		return -EINVAL;
> > +
> > +	ret = pci_epc_get_mem_map(epc, func_no, vfunc_no,
> > +				  pci_addr, pci_size, map);
> > +	if (ret)
> > +		return ret;
> > +
> > +	map->virt_base = pci_epc_mem_alloc_addr(epc, &map->phys_base,
> > +						map->map_size);
> > +	if (!map->virt_base)
> > +		return -ENOMEM;
> > +
> > +	map->phys_addr = map->phys_base + map->map_ofst;
> > +	map->virt_addr = map->virt_base + map->map_ofst;
> > +
> > +	ret = pci_epc_map_addr(epc, func_no, vfunc_no, map->phys_base,
> > +			       map->map_pci_addr, map->map_size);
> > +	if (ret) {
> > +		pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
> > +				      map->map_size);
> > +		map->virt_base = 0;
> 
> As reported by the kernel test robot on both v3 and v4, this should be:
> map->virt_base = NULL;
> otherwise you introduce a new sparse warning.

With that nit fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

