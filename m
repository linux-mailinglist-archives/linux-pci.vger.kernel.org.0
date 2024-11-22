Return-Path: <linux-pci+bounces-17210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7D79D5E9F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 13:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2391B23C6E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472E1CB51A;
	Fri, 22 Nov 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBgWbMXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4781B0F0C
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277531; cv=none; b=QF4gzVm57Ce5YCTHLTaRF7IkB5+ISPUdMyev0sJVVO81rzZreTC8YwVkSoO7pW1/fdHYzqIiVNxOVlhGRpOWQEsIB/g9TPuHZ8XS3hE9Z5sQThOZa3FeYlO3jiFGRS/reoIbJujStuIqOFIk3Ins7iSJJeku3K+YhfVkxJ33qrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277531; c=relaxed/simple;
	bh=fRGgUz2o8umL4VoYiQxBq6p1oTumycQHMZTWl+fsAuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRH9E/5vKBAyMVD6e7pPAB01QDT3a4/NuN5zeVBy98mWTR3309A1dslI97DW8DqcJhivgGRMqpxBsNo4eEiMOuBS2a6Wv5mCDWeiueVUPQIFMBE6fiEM4ekR0UtZsxDjusfegOymOevPbzH9FzAzdK1liOJTj2MMEwJI1bbUWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBgWbMXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E22BC4CECE;
	Fri, 22 Nov 2024 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732277530;
	bh=fRGgUz2o8umL4VoYiQxBq6p1oTumycQHMZTWl+fsAuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBgWbMXVP9+Nz/+4L+1Y3cio49YALQkHKW65nhsQghJdHO1fqldK7Ykj7bCHITKeK
	 kR5uc6CmEzAExzan2dbTFTBRj3znDkKW2piuZMdUi/xDLsICHDqFt627sylglw9Mt7
	 Vrbx639G/REgaS1GE4y8q3Xjsw2vdhSlfA6I4PVOlMxeCFV3KVguTZv5Dx4HuHt3wa
	 6j8TaHT8778u2cAJmiqv01BBGizq3fzJhcsENQOOhDqaQxRMDe0DntswG/mCMYhYFY
	 38LOcBfj+PVA2uJROd2TX0b/6N0POvvQNEEZFBLX168Tx7gk6PF4qOWjFK9bzNN6z7
	 s9QjZucaUIEOg==
Date: Fri, 22 Nov 2024 13:12:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Jon Mason <jdmason@kudzu.us>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: DWC PCIe endpoint iATU vs BAR MASK ordering
Message-ID: <Z0B1FUU-KQDN-jG3@ryzen>
References: <ZzxeBrjYRvYgMFdv@ryzen>
 <Zz4eTVyh73SQo60q@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz4eTVyh73SQo60q@lizhi-Precision-Tower-5810>

Hello Frank,

On Wed, Nov 20, 2024 at 12:37:17PM -0500, Frank Li wrote:
> On Tue, Nov 19, 2024 at 10:44:38AM +0100, Niklas Cassel wrote:
> >
> > Frank, since you are the author of:
> > 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> >
> > Please advice on what to do here. The only thing that makes sense to me is
> > that dw_pcie_ep_set_bar() always writes the BAR MASK. If dw_pcie_ep_set_bar()
> > does NOT write the BAR MASK, we depend on whatever BAR MASK was there before
> > dw_pcie_ep_set_bar(), which no matter how I look at it, seems horribly wrong.
> 
> dw_pcie_ep_set_bar() don't change BAR MASK because host side also use it
> to allocate resource when probe. But it just change iATU map address, for
> example 1M BAR1, map to EP's side 0x1000_0000, it may change to another
> address 0x2000_0000.  In doorbell MSI case, you tested, it dynamtic change
> to ITS address, then change back when do normal bar test, which easiest
> way to understand the behavior.
> 
> I think the order write iATU and mask doesn't matter because hardware
> should just ignores some bits according to mask register.

Well, since LWR_TARGET_RW and LWR_TARGET_HW field sizes depends on the
value in BAR_MASK, of course the order matters.

BAR_MASK will always have some value, and if we write the iATU registers
before writing the BAR_MASK, then we will be at the mercy of the reset
value of the BAR_MASK register.

I sent a fix for this here:
https://lore.kernel.org/linux-pci/20241122115709.2949703-8-cassel@kernel.org/

I now understand why you did the early return.
I cleaned up the code, and added some comments explaining how the support
for dynamically changing the physical address of a BAR works.
It would be nice if you could test so that your vNTB use case still works.


Kind regards,
Niklas

