Return-Path: <linux-pci+bounces-6510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E28AC618
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B68B1F215DB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB884DA0C;
	Mon, 22 Apr 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCbjH1yy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE94CE1F;
	Mon, 22 Apr 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772533; cv=none; b=drwYbwnGRYv0EwskYluVxqmmJiJiLK8KeZ66rF0BvTCe6JtRMzTHSCM3qJ0YEKVtZwYk8d3IxNwv4WfePAkSGYxY1OekVdyzKV9ArjqNVhyXyb1fzUiccA1EraCBgPtucU2IYKzU/QBzqpaivKyIVLC3lQnkh2liHAIbybXlz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772533; c=relaxed/simple;
	bh=EzRjNCSbKtQiwQ0eT1S66pyOa6ClYC4xUHa8zMfB0Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trn4w3RGC8pl3guK2ha+Lw+5daTz0zaMV26mSmQAcseQrFDyHn7bffjhv4uL0eVSoj3cxXBMLeHjEZgV+hXqPr39U2KoLuQ4cnoQ6Ngro6qztd/lWrzfBSQahGgMok7attd1lI0k7uQ4bpJZqJWsLlKSJA2wV///7fHWEUGJeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCbjH1yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A25BC113CC;
	Mon, 22 Apr 2024 07:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713772532;
	bh=EzRjNCSbKtQiwQ0eT1S66pyOa6ClYC4xUHa8zMfB0Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCbjH1yyvhAAC80zHQuNReQp/rrz/BGPMuAGGM/ammvFcPPjak7uc/6WVl6aN27Np
	 pI7SHZa8uYH4bVlWlOGhJCaf9TF5Bm6hKs5f/gOUy2yHjwgSvE0QzCYO6oy8Bu4EpX
	 QlRuOfIA2kVBhXGS1Win0JCN5tjkcYVbtWYhJoFTzb03F5qmeDjDaHovMcIfjlfwjE
	 RW655maF2+Kfipl8t95EI8UwQXCnHY+xWc0gEgOD5MHZ4vW9KjescbzLZTSIUVzXUb
	 ta0hpcY5GpaS7JDPeUR59YbKNwvi3Bmsv0hH6JfwvGcd4XFj0GLkBRg68vFhh0edDE
	 VianSv1g9oOiw==
Date: Mon, 22 Apr 2024 13:25:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 05/11] PCI: epf-{mhi/test}: Move DMA initialization to
 EPC init callback
Message-ID: <20240422075521.GB9775@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>
 <Zf2tXgKo-gc3qy1D@ryzen>
 <20240326082636.GG9565@thinkpad>
 <ZgKsBoTvPWWhPO9e@ryzen>
 <20240327055457.GA2742@thinkpad>
 <ZgQFXsgqpeLbXMTb@ryzen>
 <ZgW6KB73Wh1X6911@matsya>
 <Zg5oeDzq5u3jmKIu@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zg5oeDzq5u3jmKIu@ryzen>

On Thu, Apr 04, 2024 at 10:44:40AM +0200, Niklas Cassel wrote:
> On Fri, Mar 29, 2024 at 12:12:48AM +0530, Vinod Koul wrote:
> > On 27-03-24, 12:39, Niklas Cassel wrote:
> > > 
> > > So my question is:
> > > Is the "dummy memcpy" DMA channel always available?
> > 
> > That depends on the system, you may or maynot have such a system where
> > you have a generic memcpy dma controller which can provide you with
> > these channels
> 
> I misunderstood DMA_MEMCPY then, I assumed that it was a "software emulated"
> DMA channel, which allowed the a driver to always use dmaengine + DMA API.
> 
> It actually uses a real DMA controller. I don't have any DMA controller in
> the PCIe EP device tree node, but perhaps it can use any DMA controller that
> has been registered with dmaengine?
> 

AFAIK, most of the dma controllers support both memcpy and separate tx/rx
channels except a few like dw-edma where memcpy is not supported.

But for just memcpy, clients can use any registered DMA controller in the
system. For slave channels, it is best to pass them in DT since the client may
not know how the channels are laid out in the DMA controller.

> 
> > Based on my reading you might have this mechanism:
> > - eDMA provides dmaengine_prep_slave_single() which transfers data from
> >   mem to pci ep device, so fasted
> > - dmaengine_prep_dma_memcpy: This will copy the data but treat it as
> >   memory. I dont pci internals to figure out how both can work... So
> >   cant really make out why it is slowed
> > - memcpy_xxx that is IO mem functions, so ofc they will be slowest
> > 
> > I think the code is decent from fallback pov... chooses fastest path if
> > available on a system
> 
> Indeed, it makes more sense to me now, thank you Vinod.
> 
> 
> > > I was wrong here, pci-epf-test always calls pci_epc_map_addr()
> > > regardless if FLAG_USE_DMA is set or not.
> > > 
> > > (Even though this should be unnecessary when using the eDMA.)
> > > 
> > > However, if we look at pci-epf-mhi.c we can see that it does
> > > NOT call pci_epc_map_addr() when using DMA API + dmaengine.
> > > 
> > > Is it really safe to avoid pci_epc_map_addr() in all EPC controllers?
> > > I assume that it should be safe for all "real" DMA channels.
> > > We can see that it is not safe when using DMA API + "dummy" memcpy
> > > dma-channel. (That is why I was asking if we need a NEEDS_MAP, or
> > > MAP_NOT_NEEDED flag.)
> 
> 
> > > pci-epf-test.c:
> > > -Always calls pci_epc_map_addr() when using DMA API.
> > > 
> > > pci-epf-mhi.c:
> > > -Never calls pci_epc_map_addr() when using DMA API.
> 
> Mani, I still think that this part is inconsistent between PCI EPF drivers.
> 
> Looking more at commit:
> 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
> 
> Adding Frank on CC, since he is the author of that commit.
> 
> When the commit added support for eDMA to pci-epf-test, it added an extra
> parameter to pci_epf_test_data_transfer(), to pass the PCI/DMA address of
> the remote buffer, in addition to the already provided local physical address
> that pci_epc_map_addr() has mapped the PCI/DMA address to.
> 
> So in the case of eDMA transfer, the pci_epc_map_addr() operation is still
> being performed, even though pci-epf-test never uses the result of the
> the mapping operation... This is just confusing and a waste of CPU cycles.
> 
> What I would like is more consistency between the EPF drivers.
> 
> I guess an if-statement that skips the pci_epc_map_addr() in pci-epf-test
> if using eDMA would make pci-epf-mhi and pci-epf-test most consistent.
> 

Agree.

> 
> However, when reading the DWC databook:
> -The eDMA and HDMA always goes via the iATU table.
> If you do not want this, then you need to set the the appropriate bypass bit.
> 
> 
> For eDMA:
> ""
> When you do not want the iATU to translate outbound requests that are generated by the
> internal DMA module, then you must implement one of the following approaches:
> - Ensure that the combination of DMA channel programming and iATU control register
> programming, causes no translation of DMA traffic to be done in the iATU.
> or
> - Activate the DMA bypass mode to allow request TLPs which are initiated by the DMA
> controller to pass through the iATU untranslated. You can activate DMA bypass mode by
> setting the DMA Bypass field of the iATU Control 2 Register (IATU_REGION_C-
> TRL_OFF_2_OUTBOUND_0).
> ""
> 
> For HDMA:
> ""
> When you do not want the iATU to translate outbound requests that are generated by the
> internal HDMA module, then you must implement one of the following approaches:
> - Ensure that the combination of HDMA channel programming and iATU control register
> programming, causes no translation of DMA traffic to be done in the iATU.
> or
> - Activate the HDMA bypass mode to allow request TLPs which are initiated by the HDMA
> controller to pass through the iATU untranslated. You can activate HDMA bypass mode by
> setting the HDMA Bypass field of the iATU Control 2 Register (IATU_REGION_C-
> TRL_OFF_2_OUTBOUND_0).
> ""
> 
> We also know that, if there is no match in the iATU table:
> ""
> The default behavior of the ATU when there is no address match in the outbound direction or no
> TLP attribute match in the inbound direction, is to pass the transaction through.
> ""
> 
> So even if we do not call pci_epc_map_addr(), the eDMA and HDMA will go via
> the iATU table, it will most likely not find a match, so it will go through
> untranslated.
> 
> So I think we need to answer these questions:
> 1) Do we want to rely on the fact that hopefully none of the iATUs in the DWC
> controller has configured a mapping that might mess things up for us?
> I don't see why the PCI/DMA address of the remote buffer, supplied to
> pci-epf-test via test_reg BAR, might not fall within the physical iATU window
> on the local EP system. (As long as the PCI EPF driver has mapped any address
> using pci_epc_map_addr().)
> 
> This is a big argument that EPF drivers running on a DWC-based EPC should
> definitely NOT call pci_epc_map_addr() needlessly when using eDMA, as it
> can be catastrophic. (pci-epf-test needs to be patched.)
> 

Right. There is no need to do iATU translation for DMA. I avoid that in MHI
driver.

> 
> 2) Can we really assume that both pci-epf-test and pci-epf-mhi does not need
> to call pci_epc_map_addr() when using a DMA_SLAVE DMA controller?
> This seems to be designed only with DWC in mind. Other PCIe endpoint
> controllers might require this.
> (Yes, for DWC-based controllers, this definitely should be skipped, but EPF
> drivers are supposed to be independent from a specific EPC.)
> 

For TEST yes, but for MHI, no. In MHI, I kind of mix both iATU and DMA to ripe
most of the performance (small vs big transactions). But for the TEST driver, it
is fair to not call pci_epc_map_addr() when DMA_SLAVE is supported.

I do feel that we need to maintain the similarity within the EPF drivers, but it
is OK to let the drivers diverge a little for optimization.

> I'm fine with just avoiding the pci_epc_map_addr() call when using DMA_SLAVE
> DMA in pci-epf-test for now, as that is the only DMA controller that I'm
> familiar with. This second question was more a question for how EPF drivers
> are should be designed now and in the future.
> 

Regarding the DMA_MEMCPY code in TEST driver. We need to keep it for backwards
compatibility since not all platforms are passing the slave channels in
devicetree.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

