Return-Path: <linux-pci+bounces-35520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61892B451A0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 10:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEAD18892EF
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294791A9FB3;
	Fri,  5 Sep 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxtdLKbO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C827703A;
	Fri,  5 Sep 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061373; cv=none; b=TuNvYwBhXPwga2wO33qH4PfK2KegtMfFDdHmefDgsG2k7Eg4vTixWWikbnacN96dHLdY3xA+fMsyiICZsv538A1GfVs4TheD4iptd4cIrFpYhaP87ci1DGn9Scgd1oYxsVyulrISLnxeu8RcBNVtPgq9S2Fq/UhlZ4sAUJzDZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061373; c=relaxed/simple;
	bh=V7/EAn8jaMlmHdrA05TRUPE7bsaZ2a3gZv/phaAV6/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIXXlwZQL7bB/4vxI3obnEim4cYgB+mGi8NRAKBp4LEdcUt0bP7JREF7J8uIHChPQa1teCjs8+JvzI37t7NCAH5ht9YxiATzw6yx709qrioQVwVOprXDaTlPznmD01IFrLB7oeeYSoruX5z6GzhLnztS0hKNV3+ZjRJzMgNelgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxtdLKbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5515C4CEF1;
	Fri,  5 Sep 2025 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757061372;
	bh=V7/EAn8jaMlmHdrA05TRUPE7bsaZ2a3gZv/phaAV6/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxtdLKbOm6gQA5dxJLUkyMcvjH57/zuNzj3SwEsHIq1i8Ygga51zXTqw5xlAbABvz
	 E1LO9WlGA6fu1ez6XSdMhCpCxVT3nfL4b3Pfi2pXIjHPphyWf6IPj4ZvTX0P6xMWO3
	 dIRl8q1DSp3JBaBdmP7VIA+9hptrtMKTIlzBOLk8AYuPEaxBGGuAHhPuKhmXTUn2Gp
	 MVFPtURnqHIjvxVHBBig9frV9lQ6FFCMKaWkjrBWOwbHz0iaMpnqMn1z+x2OEQZX7/
	 QsF8dwY3gHyV5jFVDjivP7RCOa4ulSlHW4bHAmeRQ6J7Xz1u2lrsJkJubwNrwiqFdP
	 bOojNUre39uxA==
Date: Fri, 5 Sep 2025 10:36:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
Message-ID: <aLqg90KqEJ8wSEPi@ryzen>
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
 <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
 <aLmGBYOVevP5hH0X@ryzen>
 <1jplc54aoc.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jplc54aoc.fsf@starbuckisacylon.baylibre.com>

On Fri, Sep 05, 2025 at 09:32:03AM +0200, Jerome Brunet wrote:
> On Thu 04 Sep 2025 at 14:28, Niklas Cassel <cassel@kernel.org> wrote:
> >> 
> >> I think this can be simplified to:
> >> 
> >> 		if (epc_features->bar[bar].type == BAR_FIXED)
> >> 			test_bar_size = epc_features->bar[bar].fixed_size;
> >> 		else
> >> 			test_bar_size = bar_size[bar];
> >
> > +1
> 
> It's what pci_epf_alloc_space() does too. so it makes sense but it also
> means the side must stay aligned.

Not really, pci_epf_alloc_space() will give you 'fixed_size'
if you request size < fixed_size.

If you request more, it will give you an error.

> 
> If a rework is needed, maybe it would be better to get size from
> pci_epf_alloc_space() instead of recomputing it ?

The pci-epf-test driver is just a test driver and we can use whatever
BAR size we want for each BAR.

However, I don't think that pci_epf_alloc_space() can always give us
a BAR size. Sure, for fixed_size BARs, there is only a single size
that is possible. But for Programmable and Resizable BARs, there are
many possible sizes, so which size should pci_epf_alloc_space() then
return?

And not all EPF drivers might be happy with an aribitrary BAR size
(which is the case for pci-epf-test), some EPF drivers might have
strict minimum sizes for a BAR.

So, I still think this proposal is the best thing we can do.

At least it appears that we only need to patch pci-epf-test.



Kind regards,
Niklas

