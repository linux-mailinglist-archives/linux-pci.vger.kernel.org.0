Return-Path: <linux-pci+bounces-2443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE78373A4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4046828A466
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9492040BE8;
	Mon, 22 Jan 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sdgx1A6s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAC3D0B0;
	Mon, 22 Jan 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955064; cv=none; b=sZFeWugY4anf5LtSw++a+LxnNe33sOdh3HC4GMHF6mxS61ODwoKIZcjSt0cgy++ec5bqXtB6yU13Hon0knCP4irHvebZ5IYx7oz+YRqzaQXvw5+oX59DADoIiMnd5Me7bGysGf9scnhKkjmcxH8m0bykzlaw9j9WrE15DlJHY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955064; c=relaxed/simple;
	bh=RvNdmqvRJZCnd4r0dBRX01wJXlS7Usb6Wy9TJZtMDwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTP4iRmWKIj4wMjz/LwyzJmH2xtNYpvQJbBiyT0iU6U2zk5qahExzqb8MufN8UrpihAphffN3d3b/7nZ8fM5q4Qr268OownXmgqdYMR2jG1oj452A7FscuZ20iY+PlnR4pf+X1zpcFheiXlM+3udYC73YNhRotW6a+5d1Kl6EyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sdgx1A6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B585C43390;
	Mon, 22 Jan 2024 20:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955062;
	bh=RvNdmqvRJZCnd4r0dBRX01wJXlS7Usb6Wy9TJZtMDwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sdgx1A6s0gA5VZ5U/sGYbXpefpvFAN8QyNoScEXqSXXFT8jk7sEkWlAgYEmhly6lU
	 r+l47eG0NNfKqyobS2G4lIzdilTd3Kw2tVNJLZWam9Qmu4dvsyjyzFwA8IWTMDOF7C
	 1u9cJBbqIm0de39pX0o16rWDOzmQJV9W0L7wus3A6znDxztsb85o7313qKFPEbWxL2
	 GXkgS0ENeWneoETPl7/cY1aoB8hK9Uapal0IBy2WlZwA/eZYAuw1Oxc4zllkJP+Jfc
	 se4zFSxtMI3ZEoIf84Xz0OKbMqURehjcCvXQbF1PI/1jxE3tPwDlBBJfXK4Ldq1Q2b
	 aQuJ1+NQwX+bA==
Date: Mon, 22 Jan 2024 21:24:14 +0100
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
Subject: Re: [PATCH v3 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
Message-ID: <Za7O7mfuQH7GxWVQ@x1-carbon>
References: <d0d5b689-9437-43cd-8c1f-daa72aeafb2e@moroto.mountain>
 <c5499db2-2c25-4765-b9e0-1fa26da1cc45@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5499db2-2c25-4765-b9e0-1fa26da1cc45@moroto.mountain>

On Mon, Jan 22, 2024 at 06:21:00PM +0300, Dan Carpenter wrote:
> I recently changed the code in dw_pcie_ep_raise_msix_irq() to use
> ALIGN_DOWN(). The code in dw_pcie_ep_raise_msi_irq() is similar so
> update it to match as well.  (No effect on runtime, just a cleanup).
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Add this patch
> v3: Use ALIGN_DOWN() as a style improvement
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 51679c6702cf..1c8d2e938851 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -483,8 +483,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	}
>  	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> -	msg_addr = ((u64)msg_addr_upper) << 32 |
> -			(msg_addr_lower & ~aligned_offset);
> +	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> +	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
> -- 
> 2.43.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>


Although, if I'm being super nitpicky
(sorry... and feel free to ignore),
I think this is slightly cleaner:

--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -482,9 +482,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
                reg = ep_func->msi_cap + PCI_MSI_DATA_32;
                msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
        }
-       aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
-       msg_addr = ((u64)msg_addr_upper) << 32 |
-                       (msg_addr_lower & ~aligned_offset);
+       msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
+
+       aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+       msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
        ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
                                  epc->mem->window.page_size);
        if (ret)

