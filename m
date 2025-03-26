Return-Path: <linux-pci+bounces-24790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991DA71F08
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 20:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1533AFC0F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA2B2505D4;
	Wed, 26 Mar 2025 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kELVlrOb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A015990C
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016931; cv=none; b=lh/2wjiOe+OJ1rbL6O01cYAd5+RGGtBemZXE7BltS4sAY2Hv0os9+/wRVuHWmVrDPQBbtzG1oebl8gMEuGw3YCx7P2hM3pGy3pQEs6vVgVMCE5MINP/7eiiSQCLQ986UptrBtFbvjiQOmjlCcZ3aM5ITLydVjNgA0D867w5ZMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016931; c=relaxed/simple;
	bh=xQbUaVqFmSlQNiSKlzvwaOqbK38pBb7T2zUyaxNmQdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoAgtPUKwtSdspBJxQxb7BpJMu/2eh5CmXZUHo+9jwOYXDv3nDMS0lQv/gvuTFiVm1odD1uer5RDGDtoTl06/mXTh9duM9GVP3ZgJ1ShnOrCjlNvoPxkvcAPGp2gOaW+T6PNR0Eqevl1olo4Jf2j7Ta+i4FLBnpalcZUQP9mrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kELVlrOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FCFC4CEE2;
	Wed, 26 Mar 2025 19:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743016931;
	bh=xQbUaVqFmSlQNiSKlzvwaOqbK38pBb7T2zUyaxNmQdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kELVlrOba4rMsJWbhStPu5l4H7AVfoU2M/EJYPpJco49JX74M1FUAaeqI8fIp2AVo
	 7Tu7yN51l34xRsEBrnv0ZteEmdKLp83SnbpLX9kc3Xz/sJpSMCMJg3WkDMgJsihk/k
	 /Cc5dhqnFwAy0MujyUHYMTzJtR8u5dP/J6HFFGzQEBWZQdAHcF79TSgkrNmP2ul4WF
	 ZWC2f+WamV1UdHoqm+oTwlLwCjg/inC2U8HHO1SKVC+Y0KEG51p95fFOmjNPn74LId
	 BaeK3o+FAzbLfKgAHFUYxxmVad25KVW16FjaM1BA3ahbYNXmp5hJngZsKUB/jlDOka
	 JQ3GS0kQCrmTA==
Date: Wed, 26 Mar 2025 20:22:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <Z+RT4BxBzK68Crac@x1-carbon>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad>
 <Z91pRhf50ErRt5jD@x1-carbon>
 <20250322022450.jn2ea4dastonv36v@thinkpad>
 <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
 <01676177-4757-41D3-BEC2-F61C0C7C3F69@kernel.org>
 <bbgwy44nxf4h4hiycyue56uzfktfqzzwvw73bovtz42uklhuri@ejqrp5kjqbqh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbgwy44nxf4h4hiycyue56uzfktfqzzwvw73bovtz42uklhuri@ejqrp5kjqbqh>

On Wed, Mar 26, 2025 at 09:47:18PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 26, 2025 at 10:39:50AM -0400, Niklas Cassel wrote:
> > 
> > Can all Qcom platforms raise INTx in EP mode?
> > 
> 
> Yes, all Qcom platforms support INTx. But if we start setting the flag to true,
> there is no need to set it to false as that would be the default value. So let's
> just set 'true' for INTx capable platforms and assume others as not supported. I
> know that you had added justification in the commit message, but I think we'd
> have to drop the below commit:
> 
> PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts

Well, with that logic, we should also remove the following:

$ git grep "msi_capable = false"
drivers/pci/controller/dwc/pcie-tegra194.c:     .msi_capable = false,

$ git grep "msix_capable = false"
drivers/pci/controller/dwc/pci-dra7xx.c:        .msix_capable = false,
drivers/pci/controller/dwc/pci-imx6.c:  .msix_capable = false,
drivers/pci/controller/dwc/pci-imx6.c:  .msix_capable = false,
drivers/pci/controller/dwc/pcie-artpec6.c:      .msix_capable = false,
drivers/pci/controller/dwc/pcie-qcom-ep.c:      .msix_capable = false,
drivers/pci/controller/dwc/pcie-rcar-gen4.c:    .msix_capable = false,
drivers/pci/controller/dwc/pcie-tegra194.c:     .msix_capable = false,
drivers/pci/controller/dwc/pcie-uniphier-ep.c:          .msix_capable = false,
drivers/pci/controller/dwc/pcie-uniphier-ep.c:          .msix_capable = false,
drivers/pci/controller/pcie-rcar-ep.c:  .msix_capable = false,
drivers/pci/controller/pcie-rockchip-ep.c:      .msix_capable = false,

Feel free to send patches that removes all:
{msi_capable,msix_capable,intx_capable}=false;

I will be happy to help out with reviews.

However, I'm slightly leaning towards thinking that there actually is some
value in _explicitly_ seeing that something is not supported.


Kind regards,
Niklas

