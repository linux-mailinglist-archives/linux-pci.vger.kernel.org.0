Return-Path: <linux-pci+bounces-15111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C879AC68B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 11:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7094D1C222E5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57EE43AB9;
	Wed, 23 Oct 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi5aVIEh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E6145323
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675789; cv=none; b=OP79ut0zZPqoGjOw0JRXQMdZ+tntMs0TYhGn/HTl0ibuyRKtVfd+VLyzGHq1+oBmmozj+dsWsqMIAd1DVYRA2IcUq4bHz/BxmrYJGRETbT6mvats23ttcPCvtLslLeP/oPeUqi2uNu7F9ZgoDDK30Vuzjeqz8VuPMNSfaOfGlrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675789; c=relaxed/simple;
	bh=SdhOwZKI/gsrk8AGaPPuiCICEt3+t7RgqCjHGfRoBJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/7W/T5uhAFly9t2LKNBZ2cpjtgiwrWIl12yJ49SgJMMTVQpvfWJnr1EypQxHT2pPPY3jPodDSnNPoWvrvs1zdv0ij8ze8tbT9/pnY9svEGVf0vw+dpLAMztvmJY7pe4JWFzGTYfgQ04IpWMJV4gav38gsXwJBjNhlOQCd3iI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi5aVIEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16C2C4CEC6;
	Wed, 23 Oct 2024 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729675789;
	bh=SdhOwZKI/gsrk8AGaPPuiCICEt3+t7RgqCjHGfRoBJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mi5aVIEh2V70eev05hlS3P4Fo3Jy34jgIiMt1fiWIM3Q5q9BM4GX1U8hj6emPQ9U9
	 xfAjdqVBADDDL6VbqgYydtmgQhnWPGbpwd1bY9JVBRL0cKgMK+Kn3X+A9Hjd1dZ3MN
	 2nRWMTZcHjXc/2lm78heV3zxbAxUq4/5I/5FwU1I0DCNdJN2xxAc3s9dGdcSp3wzXM
	 70rHtzsMfUNPLeIZEmzAKFUeFSdlnas375mMPp/OAqZ9w5RNxulvAE5d5/nrSwLrvz
	 FHohMsyNRr/6hXCTR8UchETb8WKKPJtzIsQR+0dLuB0PtWKuRmKhUoQ5EajojphLe1
	 w/VD5xy1O63VQ==
Date: Wed, 23 Oct 2024 11:29:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <ZxjCB6cSTm2NukZP@ryzen>
References: <20241022234926.GA893145@bhelgaas>
 <fced0bf9-dcd3-4c04-af19-505b943c6440@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fced0bf9-dcd3-4c04-af19-505b943c6440@kernel.org>

On Wed, Oct 23, 2024 at 11:51:41AM +0900, Damien Le Moal wrote:

(snip)

> For an endpoint initiated transfer, typically, the PCI address is obtained from
> some "command" received through a BAR or through DMA. The command has the PCI
> addresses to use for transfering data to/from the host (e.g. an nvme rw command
> uses PRPs or SGLs to specify the PCI address segments for the data buffer of a
> command). For this case, the EPF driver calls calls pci_epc_mem_map() for the
> command buffer, does the transfer (memcpy_toio/fromio()) and unmaps with
> pci_epc_mem_unmap(). Note though that here, if an eDMA channel is used for the
> transfer, the DMA engine will do the mapping automatically and the epf does not
> need to call pci_epc_mem_map()/pci_epc_mem_unmap(). There is still an issue in
> this area which is that it is *not* clear if the DMA channel used can actually
> do the mapping automatically or not. E.g. the generic DMA channel (mem copy
> offload engine) will not. So there is still some API improvement needed to
> abstract more HW dependent things here.

FWIW, in my final reply here:
https://lore.kernel.org/lkml/ZiYuIaX7ZV0exKMt@ryzen/

"
I did suggest that DWC-based drivers could set a DMA_SLAVE_SKIP_MEM_MAP flag
or similar when registering the eDMA, which pci-epf-test then could check,
but I got no response if anyone else thought that this was a good idea.
"


For DMA_SLAVE (private tx/rx DMA channels):
For DWC-based controllers, we can definitely set DMA_SLAVE_SKIP_MEM_MAP when
registering the eDMA (e.g. in dw_pcie_edma_detect()).

However, I don't know how the DMA hardware (if any) in:
drivers/pci/controller/cadence/pcie-cadence-ep.c
drivers/pci/controller/pcie-rcar-ep.c
drivers/pci/controller/pcie-rockchip-ep.c
works, so I'm not sure if those drivers can set DMA_SLAVE_SKIP_MEM_MAP
(the safest thing is to not set that flag, until we know how they work).


For DMA_MEMCPY:
We know that we need to perform pci_epc_mem_map() when using
DMA API + "dummy" memcpy dma-channel (DMA_MEMCPY).
I could imagine that some embedded DMA controllers also provide
DMA_MEMCPY capabilities (in addition to DMA_SLAVE).


So I guess the safest thing is to call the flag something like:
PCI_EPC_DMA_SKIP_MEM_MAP
(rather than PCI_EPC_DMA_SLAVE_SKIP_MEM_MAP).
(since the embedded DMA controller might provide both DMA_SLAVE and DMA_MEMCPY).

And let the EPC driver (e.g. dw_pcie_edma_detect()), or possibly the DMA
driver itself to provide/set this flag.


Kind regards,
Niklas

