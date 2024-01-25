Return-Path: <linux-pci+bounces-2540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F5B83BB0E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 08:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B88B24CBC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2113AD9;
	Thu, 25 Jan 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thOYhABM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6F13AC4;
	Thu, 25 Jan 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169370; cv=none; b=DHiRmaVSXxbA3ywH7G0tTlD7ir46o/LDUkYDKwgz3Z9lY9sVX1CPG6NNUayAseAYmvN+8rfLcJoKTbR4XJqasAk4k+c/QpKUiEg3bszouR9uyEBPJZuQFwBA6nvcQZrR6o37d0QjFESdD53sxK0xI/vrUiO/Ey8UhvVwqosFEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169370; c=relaxed/simple;
	bh=oGEnZLNs2ln1J2d3RRX097XSFJtdFzD/XrDgWH8hjdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvkUL8J/zJwUToOSP8Ra9SPG0UVgR6SUKZNlDg3POb8ogopRG9mRf3CPQvifTO01zldOv0jppfWCyyQI4bh4E0MRf9T9IPNawtcsnDNbHUqbSllqKzHXHOAQ7Yx9cOW4hPMpzEJv4SyuH2ZivsA1MGt3eX515LTmloBX8MnoLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thOYhABM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ABEC433F1;
	Thu, 25 Jan 2024 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706169370;
	bh=oGEnZLNs2ln1J2d3RRX097XSFJtdFzD/XrDgWH8hjdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thOYhABMOeY+9IP7f2oUSgkMLUYNSAl+xPZqTZtkEiMlDnqabS/2mNNZKNzSpr3i4
	 akQpx8sDx2/gkp2Fayhc0KNISBf0voNvqAy71rpYfxTYzekkPyL9yb3uyUn5e4/HwR
	 V4LNNzDK+FxSXaejQIc5CSJTM4T9Q+Vwg/J+MpuQsKP+AOh86SE5FPAU4dtbxdsG6b
	 bjwzxqOT/jvKofSgqp0OEHr4qMU2UAPz1HkSQPKJVtZQ/fehZfGQXoDC1YESZ4c/+p
	 k1qOJ61RXzTMegtvSNNl3QtJ28zPkxe7kscJmBOmXfztNlVIDW1RInYCa7nk2JCbqj
	 us+TfKVlu9ekQ==
Date: Thu, 25 Jan 2024 08:56:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
Message-ID: <ZbIUEaqrpH6jAMiO@x1-carbon>
References: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
 <64ef42f0-5618-40fd-b715-0d412121045c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ef42f0-5618-40fd-b715-0d412121045c@moroto.mountain>

On Wed, Jan 24, 2024 at 06:03:51PM +0300, Dan Carpenter wrote:
> I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().
> The code in dw_pcie_ep_raise_msi_irq() is similar so update it to match
> as well, just for consistency.  (No effect on runtime, just a cleanup).
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v4: style improvements
> v3: use ALIGN_DOWN()
> v2: new patch
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 51679c6702cf..d2de41f02a77 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -482,9 +482,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
>  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	}
> -	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> -	msg_addr = ((u64)msg_addr_upper) << 32 |
> -			(msg_addr_lower & ~aligned_offset);
> +	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> +
> +	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> +	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
> -- 
> 2.43.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

(Feel free to keep my R-b tags even if you send out a new version with the
#include requested by Ilpo.)

