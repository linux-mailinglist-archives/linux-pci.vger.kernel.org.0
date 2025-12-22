Return-Path: <linux-pci+bounces-43508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1ACD5138
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A000C3001C34
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFBF3128B5;
	Mon, 22 Dec 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs6D1Jch"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58346314D0B
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392577; cv=none; b=ZREaXLTlf6+2504gH54Mb/gSMYkcgcRO8swPH9DZjD6T5rbygEYvqMIHMEj3Fokz4oLr5I5TelTq7rYWgMBRmGciUNhMSDmqbpwFkmdU6Bdxv7JJ1mLtNnBqz37+eg8/2m1TNHXoUg0GetiC8E6FElyAxkCaKOZ8+QaYpur+e9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392577; c=relaxed/simple;
	bh=vWiT2l8+S7kOLmYJjWvcIDWAfmJLsUhKuXkQ7zSmt5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n10NoW6T0aLp2rj2gV6HSuyvZyf3GPx7+B0Pk0TfX/N5bqxHLbRW55JdQl6mJL2+X8WLF+lFiT7I35085JOd9y0nNitNzcce2NUiFkCQS4CvyxZCLB7WvOaSZypRtF/5AYZAXgvOvd6FmBwZoyqHnlmeU8xj/WKVzBW9QGU3n8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs6D1Jch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD16C4CEF1;
	Mon, 22 Dec 2025 08:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766392576;
	bh=vWiT2l8+S7kOLmYJjWvcIDWAfmJLsUhKuXkQ7zSmt5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xs6D1JchpBMdJQCslyV3r5jKYNzQsqMRHJXE1Z6bzeJfKfBo6WbKzetroOJDBBr4o
	 LsnyEUQECfkVwHz6ca6VZleoiG8lHrCEVj8Ga8erpOVXxBGJk2kIrp3keYVsKO6BxR
	 PGXrPHNUMYdGlnzlUJkhSb5041m+IF3G5rt1np1RrbjtiPxqj1hnz6mlulZXa8ifwn
	 asx1/nbApfFnCp9UvQqbhScKX92XxWZ6+NP0pjb815id+ZO1NwsnYYHsow3sh4nVtK
	 O3vC0BvoCMrq4YcAWiVG+ODi3JcFT5YUozMpuOgROwP/gjacetOAKcN/OYSLHDTI/O
	 7oxQ+NzwJXMvw==
Date: Mon, 22 Dec 2025 09:36:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-ID: <aUkC-_pko_cItpKP@ryzen>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>

On Mon, Dec 22, 2025 at 01:49:21PM +0530, Krishna Chaitanya Chundru wrote:
> On 12/10/2025 12:43 PM, Niklas Cassel wrote:
> > @@ -786,14 +819,36 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >   	}
> >   	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> > -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  map_size);
> > -	if (ret)
> > -		return ret;
> > -	writel(msg_data, ep->msi_mem + offset);
> > +	/*
> > +	 * Program the outbound iATU once and keep it enabled.
> > +	 *
> > +	 * The spec warns that updating iATU registers while there are
> > +	 * operations in flight on the AXI bridge interface is not
> > +	 * supported, so we avoid reprogramming the region on every MSI-X,
> > +	 * specifically unmapping immediately after writel().
> > +	 */
> > +	if (!ep->msi_iatu_mapped) {
> This is wrong, in MSIX each vector can give you different address, you can't
> expect same address for
> all the vectors in MSIX table. In ARM based system you might see only single
> address for X86 this will
> change.

Ok, thank you. I did not know.


> 
> And also we see in MSIX the address are getting updated at runtime with x86
> windows host machines.

My idea was to add a pci_epc_set_currently_enabled_irq_type() API, and then
let the EPF driver call that if it wants to change the IRQ type.

But... if the msg_addr can change at runtime, even when the IRQ type does
not change, then a pci_epc_set_currently_enabled_irq_type() API will not
help.

I guess we will need to come up with something else for the MSI-X case.


> 
> Use the MSIX doorbell method which will not use iATU at all,
> dw_pcie_ep_raise_msix_irq_doorbell().

AFAICT, right now, the only driver ever calling this function is:
drivers/pci/controller/dwc/pci-layerscape-ep.c

Are you suggesting that we somehow change all the other DWC based EPC
drivers' .raise_irq() callback to call dw_pcie_ep_raise_msix_irq_doorbell()
instead of dw_pcie_ep_raise_msix_irq() for case PCI_IRQ_MSIX ?

That sounds like a big change that would need to be tested and verified
for each DWC based EPC driver.


Kind regards,
Niklas

