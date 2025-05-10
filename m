Return-Path: <linux-pci+bounces-27541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF45AB23A4
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 13:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CCF1BC04DA
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392F158218;
	Sat, 10 May 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJVWhm/B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F157154BE2
	for <linux-pci@vger.kernel.org>; Sat, 10 May 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746877425; cv=none; b=YYZZ6GsAttXhGeCpZGwrMGTowSNBlLT+3OTCBY4sKmc0hNag1+bkDhXVKFqMsJ5LTdyEWGgZV2H2jD1O4de+SP7qq8cBK4W581YHyJiz7xj/Zh4Z32zJTeiMGkq7k9+a5CfisrGj6ZRWgUjaLmDKvvGmU0vLAmOWBDxNe5WXZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746877425; c=relaxed/simple;
	bh=we1V9c8stSslgF8UCLTv30KHJbMzrgZSYGajfNKd+As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsqMJ2Pw16pV+lGilNK3rTCH+K5umj+tOoiD+KRSMnPftgXN9p0nqvGrq5ioK7tQXFSBJnBJXnoPu7aAAm1GsHQBaYSzkBizM5HSOjVvaicmK6nFBea82ZZVMWzO3mbo3PdqPDtGLzV5erGgkog7dlw5JWY69CMm9WE+yX+A8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJVWhm/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B25FC4CEE2;
	Sat, 10 May 2025 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746877424;
	bh=we1V9c8stSslgF8UCLTv30KHJbMzrgZSYGajfNKd+As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJVWhm/BIbf2U9m52mELMJ4OhhTtHl9A/4LfrRJW4PpnGQ3Qmwmhncz8gtX8AYiJB
	 ChI443p2PFvAxn1mvV0F8xjMKNUdWS22AMNwoaBsM8fK+nCV/Lpw01+L8Ra+4pd5Af
	 yxWuRaWHO5LFXKvykPp3YlyqmWSglobAW1mrAIDQBWsU+QVJKTa1AEDniX1RR2j/vG
	 kvgAotlkhyUDtKTi1Sz0DfFTnmpxyAxNL8Df75U15uXlyUD4jeRLH1XvhIBIt4i9Ki
	 SsSapWvYOsaif5WjW94tl+d6reqWE82rWOmfnE6hBrkXAuqtALq15cDIgVrObKf390
	 u/+rZHJE/ktgw==
Date: Sat, 10 May 2025 13:43:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>, dlemoal@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
Message-ID: <aB8762GD_iI5G5LY@ryzen>
References: <20250430123158.40535-3-cassel@kernel.org>
 <tmtm4od4paptgbiodq5cezltsy6njoyeet7mcsq7rq3m7zcz5z@thpqdtzpskgx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tmtm4od4paptgbiodq5cezltsy6njoyeet7mcsq7rq3m7zcz5z@thpqdtzpskgx>

On Sat, May 10, 2025 at 11:27:55AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 30, 2025 at 02:31:59PM +0200, Niklas Cassel wrote:
> > While the parameter 'interrupts' to the functions pci_epc_set_msi() and
> > pci_epc_set_msix() represent the actual number of interrupts, and
> > pci_epc_get_msi() and pci_epc_get_msix() return the actual number of
> > interrupts.
> > 
> > These endpoint library functions just mentioned will however supply
> > "interrupts - 1" to the EPC callback functions pci_epc_ops->set_msi() and
> > pci_epc_ops->set_msix(), and likewise add 1 to return value from
> > pci_epc_ops->get_msi() and pci_epc_ops->get_msix(),
> 
> Only {get/set}_msix() callbacks were having this behavior, right?

pci_epc_get_msix() adds 1 to the return of epc->ops->get_msix().
pci_epc_set_msix() subtracts 1 to the parameter sent to epc->ops->set_msix().

pci_epc_get_msi() does 1 << interrupt from the return of epc->ops->get_msi().
So a return of 0 from epc->ops->get_msi() will result in pci_epc_get_msi()
returning 1. A return of 1 from epc->ops->get_msi() will result in
pci_epc_get_msi() returning 2.

Similar for pci_epc_set_msi(). It will call order_base_2() on the parameter
before sending it to epc->ops->set_msi().

So pci_epc_get_msi() / pci_epc_set_msi() takes a interrupts parameter
that actually represents the number of interrupts.

epc->ops->set_msi() / epc->ops->get_msi() takes an interrupts parameter,
but that value does NOT represent the actual number of interrupts.
It is instead the value encoded per the Multiple Message Enable (MME)
field in the "7.7.1.2 Message Control Register for MSI". So it is quite
confusing that these the parameter for epc->ops->set_msi() /
epc->ops->get_msi() is also called interrupts. A better parameter name
would have been "mme".

It is however called 'interrupts' in the pci-epc.h header:
https://github.com/torvalds/linux/blob/v6.15-rc5/include/linux/pci-epc.h#L102-L103

and in the DWC driver and RCar driver:
static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 interrupts)

However, some drivers have seen this weirdness and actually named the parameter
differently:
static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 multi_msg_cap)

TL;DR: all of these callbacks are a mess IMO, not only {get/set}_msix().

I did the smallest fix possible, because doing a cleanup of this will
require changing all drivers that implement these callbacks, which seems
different from a fix.


> 
> > even though the
> > parameter name for the callback function is also named 'interrupts'.
> > 
> > While the set_msix() callback function in pcie-designware-ep writes the
> > Table Size field correctly (N-1), the calculation of the PBA offset
> > is wrong because it calculates space for (N-1) entries instead of N.
> > 
> > This results in e.g. the following error when using QEMU with PCI
> > passthrough on a device which relies on the PCI endpoint subsystem:
> > failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align
> > 
> > Fix the calculation of PBA offset in the MSI-X capability.
> > 
> 
> Thanks for the fix! We should also fix the API discrepancy w.r.t interrupts as
> it is causing much of a headache. One more example is the interrupt vector. API
> expects the vectors to be 1-based, but in reality, vectors start from 0. So the
> callers of raise_irq() has to increment the vector and the implementation has to
> decrement it.
> 
> If you want to fix it up too, let me know. Otherwise, I may do it at some point.

As you know, I'm working on adding SRNS/SRIS support for dw-rockchip,
I might send a cleanup for the Tegra driver too.

I do not intend to clean up all the drivers.
I am a bit worried about patches after the cleanup getting backported, which
will need to be different before and after this cleanup. Perhaps renaming the
callbacks at the same as the cleanup might be a good idea?

It should be a simple cleanup though, just do the order_base_2() etc in the
driver callbacks themselves.

We really should rename the parameter of .set_msi() though, as it is totally
misleading as of now.


> 
> > Fixes: 83153d9f36e2 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
> 
> This doesn't seem like the correct fixes commit.

It is correct.

Commit 83153d9f36e2 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
added the PBA offset to dw_pcie_ep_set_msix().

dw_pcie_ep_set_msix() already wrote the interrupts value (zeroes based) to the
QSIZE register. Commit 83153d9f36e2 added this code:
+       val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;

So it used a zeroes based value to calculate the size,
which is obviously wrong.


Kind regards,
Niklas

