Return-Path: <linux-pci+bounces-5246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FF588DCAF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 12:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52811F28DDD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466886648;
	Wed, 27 Mar 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IthzmOWE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9283E86637;
	Wed, 27 Mar 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539556; cv=none; b=jLUuWqwF00nZ7+xmWNua4VsnmLDCv+51Vhkbw6ecR/QGgjoyeJ3ZXe9ips3j01ECZWftOstGWlTp9r/4kKhkXHMOEvV5CaLNegykfSoQsEb80STPFxmutzgropcvdBjCd9bpnFwS9Ci8VRuU4aATOG40RKxyPG4R2MO3oFzSVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539556; c=relaxed/simple;
	bh=0aSLD8v9FhdgjLmAm4FFNYvpmf51+GglcayqfEF6akk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7RSQL8XAaQH3Y/25amUOzpfC9PkCMps5QW58P6H+itaqyU1i8auYm95f9XKQ9+YzoWhP8ZyNlQeHtXti6QCqmfqZc9z+FuHb49bxuP0qbVYiElIHRS0qFkqdKr0/hMEfWVYEtBEn/WI237WFxqxpyM2DwA6kJWVeHjqi7Ux28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IthzmOWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182F0C433F1;
	Wed, 27 Mar 2024 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711539556;
	bh=0aSLD8v9FhdgjLmAm4FFNYvpmf51+GglcayqfEF6akk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IthzmOWEN3mIomGFkzEB7rdFo+sVY9NJoykWW/JaltxLd6FaeS7t/4TOEz67p3nBA
	 I2PXY+Edpozu3HFBTHNyT4zD/Azr4mbYlQRfgb6n9+XFE5/gwjk+qBrtCirGC2MBXy
	 40Vm1apsToyMQazDpvK1j/JQECLhCY+uKKtTb8Rk+zmaVwPutLbZMgVN7Ay9795nig
	 7CxFS0O+CM3rImV6sFyLghl93bs/Xd++nzFgCZ+/2Lml/PgqNJdLN32kTDTUuCh8+z
	 hY7WnKKpYAPsim7YtilIQtXPf0BXRhDH01VvkLB+AVUADNreC4+pK58Czcd49svPpX
	 lt8nvzqZXMZuA==
Date: Wed, 27 Mar 2024 12:39:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 05/11] PCI: epf-{mhi/test}: Move DMA initialization to
 EPC init callback
Message-ID: <ZgQFXsgqpeLbXMTb@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>
 <Zf2tXgKo-gc3qy1D@ryzen>
 <20240326082636.GG9565@thinkpad>
 <ZgKsBoTvPWWhPO9e@ryzen>
 <20240327055457.GA2742@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327055457.GA2742@thinkpad>

+CC Vinod

Hello Vinod,

I didn't know the answer, so I chose the "call a friend option" ;)
I hope that you can help me out :)


If you take a look at drivers/pci/endpoint/functions/pci-epf-test.c
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/endpoint/functions/pci-epf-test.c#L448-L471

You can see that the driver always does pci_epc_map_addr(),
then it will either use:
DMA API, e.g. dma_map_single() etc.
or
memcpy_fromio()/memcpy_toio()

based on flag FLAG_USE_DMA.

This flag is set via ioctl, so if we run:
/usr/bin/pcitest -d
the flag will be set, without the -d parameter the flag won't be set.


If you look at how the DMA channel is requested:
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/endpoint/functions/pci-epf-test.c#L224-L258

If will try to get a private DMA channel, if that fails,
it will use the "dummy memcpy" DMA channel.

If the FLAG_USE_DMA is set, the transfers itself will use:
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/endpoint/functions/pci-epf-test.c#L139-L155
either dmaengine_prep_slave_single() or dmaengine_prep_dma_memcpy(),
depending on if we are using "dummy memcpy" or not.



If you take e.g. the DWC PCIe EP controller, it can have an embedded DMA
controller on the PCIe controller, and we will try to detect it when
initializing the PCIe EP controller using dw_pcie_edma_detect():
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/controller/dwc/pcie-designware-ep.c#L759

For the PCIe EP controller that I am using, which have eDMA built-in,
I noticed that if I do not enable the eDMA driver (# CONFIG_DW_EDMA is not
set), I noticed that I can still run:
/usr/bin/pcitest -d

Which will use the "dummy memcpy" DMA channel.
Yes, the performance is poor, but it still works, so it appears that the
fallback code is working properly.


If I enable the eDMA driver (CONFIG_DW_EDMA=y),
I can run:
/usr/bin/pcitest -d

And the performance is good.


So my question is:
Is the "dummy memcpy" DMA channel always available?

Because if it is, I think we could drop the path in the pci-epf-test.c
driver which uses memcpy_fromio()/memcpy_toio() instead of DMA API.
(Since just having a single path to do I/O in the driver would simplify
the driver IMO.)

I assume that the "dummy memcpy" DMA channel just uses memcpy_fromio() and
memcpy_toio() under the hood, so I assume that using the memcpy_fromio()/
memcpy_toio/() is equivalent to using DMA API + dmaengine_prep_dma_memcpy().

Although it would be nice if we didn't need to have the two separate paths
in pci_epf_test_data_transfer() (dmaengine_prep_slave_single() vs
dmaengine_prep_dma_memcpy()) to support the "dummy memcpy" channel.
But I guess that is not possible...


I hope that you can bring some clarity Vinod.
(Please read my replies to Mani below before you compose your email,
as it does provide more insight to this mess.)

Mani, I tried to reply to you inline below, with my limited understanding
of how dmaengine works.


On Wed, Mar 27, 2024 at 11:48:19AM +0530, Manivannan Sadhasivam wrote:
> > So we still want to test:
> > -DMA API using the eDMA
> > -DMA API using the "dummy" memcpy dma-channel.
> > 
> 
> IMO, the test driver should just test one form of data transfer. Either CPU
> memcpy (using iATU or something similar) or DMA. But I think the motive behind
> using DMA memcpy is that to support platforms that do not pass DMA slave
> channels in devicetree.
> 
> It is applicable to test driver but not to MHI driver since all DMA supported
> MHI platforms will pass the DMA slave channels in devicetree.

I don't understand how device tree is relevant here, e.g. qcom-ep.c
specifies pcie_ep->pci.edma.nr_irqs = 1;
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/controller/dwc/pcie-qcom-ep.c#L818
which is sufficient for you to be able to probe/detect eDMA successfully,
no need for anything in device tree at all.


> 
> > However, it seems like both pci-epf-mhi.c and pci-epf-test.c
> > do either:
> > -Use DMA API
> > or
> > -Use memcpy_fromio()/memcpy_toio() instead of DMA API
> > 
> > 
> > To me, it seems like we should always be able to use
> > DMA API (using either a eDMA or "dummy" memcpy).
> > 
> 
> No, there are platforms that don't support DMA at all. Like Qcom SDX55, so we
> still need to do CPU memcpy.

I assume that you mean the the PCIe controller used in SDX55 does not
have the eDMA on the PCIe controller, so dw_pcie_edma_detect() will
fail to detect any eDMA. That is fine no?

I assume that this SoC will still able to use the "dummy" memcpy dma-channel?


> 
> > I don't really see the need to have the path that does:
> > memcpy_fromio()/memcpy_toio().
> > 
> > I know that for DWC, when using memcpy (and this also
> > memcpy via DMA API), we need to map the address using
> > iATU first.
> > 
> > But that could probably be done using another flag,
> > perhaps rename that flag FLAG_USE_DMA to NEEDS_MAP or
> > something.
> > (Such that we can change these drivers to only have a
> > code path that uses DMA API.)
> > (...and making sure that inheriting the DMA mask does
> > not affect the DMA mask for DMA_MEMCPY.)

I was wrong here, pci-epf-test always calls pci_epc_map_addr()
regardless if FLAG_USE_DMA is set or not.

(Even though this should be unnecessary when using the eDMA.)

However, if we look at pci-epf-mhi.c we can see that it does
NOT call pci_epc_map_addr() when using DMA API + dmaengine.

Is it really safe to avoid pci_epc_map_addr() in all EPC controllers?
I assume that it should be safe for all "real" DMA channels.
We can see that it is not safe when using DMA API + "dummy" memcpy
dma-channel. (That is why I was asking if we need a NEEDS_MAP, or
MAP_NOT_NEEDED flag.)


> > 
> > But perhaps I am missing something... and DMA_MEMCPY is
> > not always available?

Right now pci-epf-test driver has three ways:
-DMA API + dmaengine dmaengine_prep_slave_single()
-DMA API + dmaengine dmaengine_prep_dma_memcpy()
-memcpy_toio()/memcpy_fromio().

pci-epf-mhi.c driver has two ways:
-DMA API + dmaengine dmaengine_prep_slave_single()
-memcpy_toio()/memcpy_fromio().


pci-epf-test.c:
-Always calls pci_epc_map_addr() when using DMA API.

pci-epf-mhi.c:
-Never calls pci_epc_map_addr() when using DMA API.


I honestly don't see any point of having three paths
for pci-epf-test. Ideally I would want one, max two.

If you think that:
-DMA API + dmaengine dmaengine_prep_slave_single()
+
-memcpy_toio()/memcpy_fromio().

is more logical than:
-DMA API + dmaengine dmaengine_prep_slave_single()
+
-DMA API + dmaengine dmaengine_prep_dma_memcpy()

Then I think we should rip out the:
-DMA API + dmaengine dmaengine_prep_dma_memcpy()
it serves no purpose... if you don't have a "real" DMA channel,
just run without the -d flag.

Or, if you argue that the dmaengine_prep_dma_memcpy() is there
to test the DMA API code (which I can't say that it does, since
it doesn't use the exact same code path as a "real" DMA channel, see:
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/endpoint/functions/pci-epf-test.c#L139-L155
so this argument is questionable).

Put it under a --use_dummy_dma, and return failure by default
if no "real" DMA channel is found.


But even so, that would not address the pci-epf-test and
pci-mhi-test inconsistency WRT pci_epc_map_addr().

I think if we rip out:
-DMA API + dmaengine dmaengine_prep_dma_memcpy()
we could also move the pci_epc_map_addr() so that it is
only used for the memcpy_toio()/memcpy_fromio() path.

(Or if we add a --use_dummy_dma, we can move the pci_epc_map_addr() to
that path, and remove it from the dmaengine_prep_slave_single() path.)


Kind regards,
Niklas

