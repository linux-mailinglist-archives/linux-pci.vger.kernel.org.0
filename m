Return-Path: <linux-pci+bounces-24556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CCAA6E22B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5515D169F82
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311E264A75;
	Mon, 24 Mar 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk1k606k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC63264A74
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840445; cv=none; b=BEBtI8czUy6tZrO+KsNJWh2cRUfQUsjdmYlHUdLcAlDgBGeUgl6DyrS5x5okW8s9b9lMnclkVm/3B8zq/mdMzTbsuUsgKCER56tQWRzWZzfOdYRP2dSjcYs/b7QkGX3ljNBGlbpkb54sjTEEissjmE9gsOVPVnY+eAvSDxloqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840445; c=relaxed/simple;
	bh=zOgC9n2mKC62+AJUBHm6Ducn9s7XaQQZqTthWRA9drY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwcBEJjboiI2O3QYnPaGIZrJKj9xeljIJGGzceJhrhSxDyCoEddVX8Pq7WNOBR12LhaB1PYI0HY+W6bExokHN3jH99FJ4n7o8asr93OU9LagZjL2Rxwxd3J5tXMeOQYay/AmtGq8qSKGi5IhdY6EDpc+mLv/gk4VL6O1RIJVpP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk1k606k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D4AC4CEED;
	Mon, 24 Mar 2025 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742840444;
	bh=zOgC9n2mKC62+AJUBHm6Ducn9s7XaQQZqTthWRA9drY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fk1k606kcjezOHEH46tOYoGUB8tH5gpFWJ8ym+PTYt/+H2ELnN38I41gtp8qGNddt
	 AbICAMHq3+M8qNdbC5ZFbhuPTY5CuflgMOLq86HaanAu/eIU81x7XiSCQ2LJHwyMjL
	 yhJEd4s4orpyojczI3liWKf+AkAxhq49WrAf+eMwiPXLPdxGOqXyNbZAHlZPbEi5y3
	 pRifCfd69E5tqjp09+O0ilhzxFS4GGoQ5/GP+eiKjHcGgDZsh6cc4Lz4ZqKMgm0BaO
	 spCFlm67GB7591Gu/irasXMCDB+SewKwZQNj5EYzI+IT2VOpWUgKgPxwpVrWn9JFhE
	 WC85+OK50nNqw==
Date: Mon, 24 Mar 2025 19:20:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <Z+Giej6/jpSHSV3H@x1-carbon>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad>
 <Z91pRhf50ErRt5jD@x1-carbon>
 <20250322022450.jn2ea4dastonv36v@thinkpad>
 <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
 <20250323113449.GB1902347@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250323113449.GB1902347@rocinante>

Hello Krzysztof,

On Sun, Mar 23, 2025 at 08:34:49PM +0900, Krzysztof Wilczyński wrote:
> [...]
> > I still need to send a patch that fixes the kdoc.
> 
> Feel free to let me know what kernel-doc you want added there.  I will, in
> the mean time, go ahead and add something.

We already have:

 * @msi_capable: indicate if the endpoint function has MSI capability          
 * @msix_capable: indicate if the endpoint function has MSI-X capability

How about:

intx_capable: indicate if the endpoint can raise INTx interrupts


Kind regards,
Niklas

