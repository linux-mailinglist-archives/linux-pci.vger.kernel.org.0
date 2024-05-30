Return-Path: <linux-pci+bounces-8080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C38D4E1A
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41E61C209D0
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202D0186E5F;
	Thu, 30 May 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8beDHN2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072A186E57
	for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079771; cv=none; b=cpSt1pWbuoMVn4kZ3KfjnReTWAdNKfOm6pTECPPixY3lBtydj2nILHOCuvy2HngQns9EGA2Bnj5/DSKWWPeU9lwhbGd/yQrqRdqjnFWiIUZG1H+i8dg32wA8m7R2OGSlkIHSjjvZ3zbCbDDaDnFGmF+/oO86dgOQSdXeqba1Cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079771; c=relaxed/simple;
	bh=lPoPj2GhX9Na4IPC0TIM0L/bhl/DgFWSIZqyMO59Tq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa8iGCRJBVrHkM1oRUFoWPd+5z/gg0pWQZ0AzQCvXOSN/W0ArLG9VBx3fPhNn3q8/BzORAd9YikbaRTJaDhg8GEh2ZNjsCkFaoPx1D1Q9EUdi3lAeZEidYDeF9bhFwX+nFajhPskG+ZRZSTQgKhxwJb34xX89M2dHlh8xlicJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8beDHN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5167C2BBFC;
	Thu, 30 May 2024 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079769;
	bh=lPoPj2GhX9Na4IPC0TIM0L/bhl/DgFWSIZqyMO59Tq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8beDHN2AzqAJesyt47JFSJ3w/NTfuTJHLCzB/Mdc1Damty3z5U0Iy5R9VCrn4224
	 hi9u9U8zHtNSHUQjqaT3tAw8V+6gphDyfryCKGW6aybz8jIIObYVE/pHJ8AtlZgiCt
	 bFjJwmehuYHtAhrTkyYSJ3qR9IEOuoUrWLM5Smd9QPZ9i2wHgN+qwjcz2lscGgKhq9
	 7K4vvOxTIREmuiDrIgq+4yvk97sSg8IH/wBT+nXcfIIkzMhvmMPsDghNnRe5mCKAQ5
	 uKogjqQCpPqcLeNqr8SjcBf/vKzVWEaKzDt575xGBOU+3FGyP+WrO10rwsE/lND1UP
	 NitB43XDz+aOw==
Date: Thu, 30 May 2024 20:06:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Enforce DWC specific 64-bit BAR limitiation
Message-ID: <20240530143603.GF2770@thinkpad>
References: <20240528134839.8817-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528134839.8817-2-cassel@kernel.org>

On Tue, May 28, 2024 at 03:48:40PM +0200, Niklas Cassel wrote:
> From the DWC EP databook 5.96a, section "3.5.7.1.4 General Rules for BAR
> Setup (Fixed Mask or Programmable Mask Schemes Only)":
> 
> "Any pair (for example BARs 0 and 1) can be configured as one 64-bit BAR,
> two 32-bit BARs, or one 32-bit BAR."
> 
> "BAR pairs cannot overlap to form a 64-bit BAR. For example, you cannot
> combine BARs 1 and 2 to form a 64-bit BAR."
> 
> While this limitation does exist in some other PCI endpoint controllers,
> e.g. cdns_pcie_ep_set_bar(), the limitation does not appear to be defined
> in the PCIe specification itself, thus add an explicit check for this in
> dw_pcie_ep_set_bar() (rather than pci_epc_set_bar()).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f22252699548..42db3c3bbe96 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -227,6 +227,13 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	int ret, type;
>  	u32 reg;
>  
> +	/*
> +	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
> +	 * 1 and 2 to form a 64-bit BAR.
> +	 */
> +	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
> +		return -EINVAL;
> +
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

