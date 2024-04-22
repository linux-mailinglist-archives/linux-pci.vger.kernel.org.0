Return-Path: <linux-pci+bounces-6514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA28AC8E7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 11:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8FC1F21901
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A654FB8;
	Mon, 22 Apr 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJzhJEIE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B35029A;
	Mon, 22 Apr 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778217; cv=none; b=mr+PARSRvO02FRc4iE+3rzVBRMf2iO5QnETFRouGeXnQhmhOT+TL/TYq6Y6ZpfcDEOO8arjCXrlGwR60v5UU2x7YhREbT7Aknf+rk4o56k67bvl2Su0quGuDN4h1eXwqjyodQK0jDgIuVlxlFEuituKIwZ4Gt+JwXWzwchfTfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778217; c=relaxed/simple;
	bh=EESYxXe371fcWRXjGI9bPSFEjgmbWU9a8XVa2tbzFQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCzuRWycpLn+yDlxfZ8UeXiyTPtKEHutfqIIlLNXR3FLcMEUpDgfNgCMIsSZ/kNZVe16gAGUIfjEq1GkvN3E7Bg65idbfSfkxE0hTp2lSFZ2uCRvX4OQUhCOfH8v8UNIcCRndIhCXoGGM/GL/xQNHuc82FxEIEsi1x2SKFMJGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJzhJEIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F17BC113CC;
	Mon, 22 Apr 2024 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713778216;
	bh=EESYxXe371fcWRXjGI9bPSFEjgmbWU9a8XVa2tbzFQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJzhJEIEdrVn3UR5wDwmgtXyJ3D1hYmqDK9ZCaV5oHq0LHAWy77vYsB5zGSsc24Ti
	 BUEtAfqwYUlUffVIrbiGfyCWudcRomRqBKmg5sSoIL4lCpPH9a/1WVLDSZUzi2oCoo
	 CcZjP+LCBcwW2t7PhVhXRj7ote5xbSuEN9JyQggWdxgB0LWQnggJ7tlIbQ9rvg5LPc
	 M8lULz/DFG+nHfCzuBHecDLJ5AWL9mZ29tmDG8rE/oUOzRIy/jyime52EqZjgetPBf
	 0iSDy5zZmctguF+py2v5ixATr2R404SpElNFrls7KAaGaoLc+Pmaix5wOHQMbYNXIJ
	 xxZ6gFl/6iVbw==
Date: Mon, 22 Apr 2024 11:30:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
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
Message-ID: <ZiYuIaX7ZV0exKMt@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>
 <Zf2tXgKo-gc3qy1D@ryzen>
 <20240326082636.GG9565@thinkpad>
 <ZgKsBoTvPWWhPO9e@ryzen>
 <20240327055457.GA2742@thinkpad>
 <ZgQFXsgqpeLbXMTb@ryzen>
 <ZgW6KB73Wh1X6911@matsya>
 <Zg5oeDzq5u3jmKIu@ryzen>
 <20240422075521.GB9775@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422075521.GB9775@thinkpad>

On Mon, Apr 22, 2024 at 01:25:21PM +0530, Manivannan Sadhasivam wrote:
> > 
> > What I would like is more consistency between the EPF drivers.
> > 
> > I guess an if-statement that skips the pci_epc_map_addr() in pci-epf-test
> > if using eDMA would make pci-epf-mhi and pci-epf-test most consistent.
> > 
> 
> Agree.


> > 1) Do we want to rely on the fact that hopefully none of the iATUs in the DWC
> > controller has configured a mapping that might mess things up for us?
> > I don't see why the PCI/DMA address of the remote buffer, supplied to
> > pci-epf-test via test_reg BAR, might not fall within the physical iATU window
> > on the local EP system. (As long as the PCI EPF driver has mapped any address
> > using pci_epc_map_addr().)
> > 
> > This is a big argument that EPF drivers running on a DWC-based EPC should
> > definitely NOT call pci_epc_map_addr() needlessly when using eDMA, as it
> > can be catastrophic. (pci-epf-test needs to be patched.)
> > 
> 
> Right. There is no need to do iATU translation for DMA. I avoid that in MHI
> driver.

There is no need for pci_epc_map_addr() when using DMA_SLAVE *for DWC-based
controllers*.

Are we certain that this will not break pci-epf-test for non DWC-based
controllers?


> > 2) Can we really assume that both pci-epf-test and pci-epf-mhi does not need
> > to call pci_epc_map_addr() when using a DMA_SLAVE DMA controller?
> > This seems to be designed only with DWC in mind. Other PCIe endpoint
> > controllers might require this.
> > (Yes, for DWC-based controllers, this definitely should be skipped, but EPF
> > drivers are supposed to be independent from a specific EPC.)
> > 
> 
> For TEST yes, but for MHI, no. In MHI, I kind of mix both iATU and DMA to ripe
> most of the performance (small vs big transactions). But for the TEST driver, it
> is fair to not call pci_epc_map_addr() when DMA_SLAVE is supported.

I agree that we should definitely skip pci_epc_map_addr() in pci-epf-test when
using DMA_SLAVE on DWC-based controllers, but I don't feel comfortable in
submitting a patch that does this unconditionally for pci-epf-test.c,
as I don't know how the DMA hardware in:
drivers/pci/controller/cadence/pcie-cadence-ep.c
drivers/pci/controller/pcie-rcar-ep.c
drivers/pci/controller/pcie-rockchip-ep.c

works, and I do not want to regress them.

I did suggest that DWC-based drivers could set a DMA_SLAVE_SKIP_MEM_MAP flag
or similar when registering the eDMA, which pci-epf-test then could check,
but I got no response if anoyone else thought that this was a good idea.


Kind regards,
Niklas

