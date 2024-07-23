Return-Path: <linux-pci+bounces-10657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9402A93A24B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB5D284E1D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE0153BF8;
	Tue, 23 Jul 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn05/Yz9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E25153BF6;
	Tue, 23 Jul 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743543; cv=none; b=sQIpaKSKMJ4euJvcDLt9uPBu4lveP6+mDlfojtuqOfQ+w2sLsCPbKmJlbCKl9/4AGEkNgc3BZAiux7RYfJPI6WLssWY2Xman/onhqevgJdXFfxqym97I6QzmxlrKZ8lYFFMJXcF4fmZVfXaHFRb4P0/mN4CCk95hl2/YgRToi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743543; c=relaxed/simple;
	bh=rjtW1y2WGr38Vg1HMk17S2csjHOfKrRlV1/oyXILjDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoA28khKnw7iuu929mqTMYbCy9BwhBM1HCfGZfsRs6A5msc+NoC3FJjhvITVQMHd83zh3GWTEByJGLLUoUzbOQyMJ1QWQj1hu3xjqVZaWblII7KKtXI0+QSqI+M8NyxAI8gjxIenuBUh78/sQd1NUofoI37tlPDabjCZDD461kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn05/Yz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CF4C4AF09;
	Tue, 23 Jul 2024 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721743542;
	bh=rjtW1y2WGr38Vg1HMk17S2csjHOfKrRlV1/oyXILjDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cn05/Yz9p8b5OVCGE7RNDHYQVykxYphCvQ8IHIKMczMDfOG3wW2ApUC8tsDEPwTD0
	 tJy0PB6N597mC6WmAVD3AtI1eb/DyITIPzt3HNYjE9KYzmLPXb04tAJEV8gsnqCLm+
	 uVvVeA+kxxJW0UyCPKt2KyhL/HdnYqtgp39IhsYcUrsjSD+Evx1t4Ic3AyJ39135cU
	 44aRmXBG0GI/ykA6uiUywmZlHpOBksE372AzAh5SDG/DjKzcjawGpUzGlCukbNBFQV
	 QvPSId9lPQ0LeUvvzzT0sD4O20uOpdk+fHiu94ldEGmuhb7obUM+ENZHyVc/GVujM9
	 gRzj3WQ7xIhag==
Date: Tue, 23 Jul 2024 16:05:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, rick.wertenbroek@heig-vd.ch,
	alberto.dassatti@heig-vd.ch,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <Zp+4sDfopSiAdWt/@x1-carbon.lan>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <b4256f7c-350b-4fba-ba49-a91ee463b8d7@kernel.org>
 <CAAEEuhqCM08NLTkM+WFh88S45OP-mjbJUd+KPtu2tBA+fbJvpw@mail.gmail.com>
 <b75de7a9-09fe-4c53-8e73-a3dbfd6efa4d@kernel.org>
 <CAAEEuhq1JLo+Lyhah6EGSTPZRbeEUFmbUehYXY1dA1f0KUwvrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAEEuhq1JLo+Lyhah6EGSTPZRbeEUFmbUehYXY1dA1f0KUwvrQ@mail.gmail.com>

On Tue, Jul 23, 2024 at 09:41:14AM +0200, Rick Wertenbroek wrote:
> 
> Interesting. I like this approach, this would also make it possible to
> combine the current 'pci_epf_alloc_space' and 'pci_epc_set_bar' into a
> single function which would simplify the endpoint functions.
> 
> The reason why it is separate now is so that 'pci_epf_alloc_space' can
> be called before the endpoint function is bound to a controller, and
> therefore the BAR memory can be filled and prepared before bind() is
> called. Merging 'pci_epf_alloc_bar' with 'pci_epc_set_bar' into a
> 'pci_epc_alloc_bar' (epc because it is dependent on the endpoint
> controller and prior to be bound to a specific controller we don't
> know if we need to allocate locally or remap) would make it impossible
> to access the BAR prior to be bound to a controller (because the
> function 'pci_epc_alloc_bar' would fail without a specific
> controller). I don't think this is a problem as an unbound endpoint
> function is kind of useless on its own, but this means the BAR memory
> could only be allocated/remapped/accessed once the endpoint is bound
> to a controller.

Back when I was looking it to this, I came to the conclusion:
"The proper place is to allocate them when receiving PERST,
but not all drivers have a PERST handler."

However, since:
https://github.com/torvalds/linux/commit/a01e7214bef904723d26d293eb17586078610379

All EPF drivers should get a epc_init event, either directly when the EPC
driver is loaded, or when PERST# is asserted.

So I definitely agree that it makes sense for all EPF function drivers to do
both alloc_space() + set_bar() is a single call, now when that is possible.

This will simplify a lot of PCIe endpoint code considerably.


Kind regards,
Niklas

