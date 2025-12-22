Return-Path: <linux-pci+bounces-43513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7053ECD56B8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 10:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C94300A854
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A65E23D7FC;
	Mon, 22 Dec 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+qFMQ/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D9239570
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766397524; cv=none; b=slp/0XfixkV4oIjBy6iUEVWmd3X9PUMMl6C+a4HQeJTVGBGzbN7HupbbGW/QlUQDUUaYYNTx7clSalaKMF3e4sxEnBbWBN8atqNtu4Qa22aNvHpNQRfAaYFynwm++1AaL2CzwcExINeJ0WWvU+KPATTW95VXyVG0ykL+RC9xCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766397524; c=relaxed/simple;
	bh=VwWP/J6WhOnvMWuLZNUMjcc0kPO+6Ki0ccjVDSxSVMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9cOTzWeod3jVbimJEZXStCUmAPLdBufK8CC1XL9Yo8e6os9QR7P7AgldrITDMNp8UZA3OqnQY8I61S0hcyjuciaQ6wC54jZQWxGYgoE1WKyg+DQQ5C07yjvEDwnkNWfCklp4vWBSmFSydi7g4ZzTJudxzS+kv4ePlmlPH5KvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+qFMQ/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4848DC16AAE;
	Mon, 22 Dec 2025 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766397524;
	bh=VwWP/J6WhOnvMWuLZNUMjcc0kPO+6Ki0ccjVDSxSVMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+qFMQ/YPTJ2C3Xfg+9V3McHBmefE8cfRtN+Crr5oSeIF2YHoTGY0pLTCMl9x/wg5
	 ek8L0oqPd5hAgi8zsaoFA6aKNvhRj+eye04hn9ClDQNXnDBHmbeAmvSMV8rOo51O5d
	 k9a+UCqvpihdzi0sKlCUmw8kcNargLXHq2zh1tWI4E5ayu1q0Fr+cVbu+XSUMrvbY9
	 tYLdmz7NrMnID4DWT564VWY0swCa8bQoYaNYAKMEQbGWloaMPpFDiu8liawXuKQNoq
	 vyGBPTY0smXTT4266uPTMpLfejoQarHvP0L8JgCDBELAj3M3evVffFIO6ja+Emy07D
	 fjxR4uK60obFw==
Date: Mon, 22 Dec 2025 15:28:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-ID: <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>

On Mon, Dec 22, 2025 at 01:49:21PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/10/2025 12:43 PM, Niklas Cassel wrote:
> > From: Koichiro Den <den@valinux.co.jp>
> > 
> > dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> > for the MSI target address on every interrupt and tears it down again
> > via dw_pcie_ep_unmap_addr().
> > 
> > On systems that heavily use the AXI bridge interface (for example when
> > the integrated eDMA engine is active), this means the outbound iATU
> > registers are updated while traffic is in flight. The DesignWare
> > endpoint databook 5.40a - "3.10.6.1 iATU Outbound Programming Overview"
> > warns that updating iATU registers in this situation is not supported,
> > and the behavior is undefined.
> > 
> > Under high MSI and eDMA load this pattern results in occasional bogus
> > outbound transactions and IOMMU faults, on the RC side, such as:
> > 
> >    ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
> > 
> > followed by the system becoming unresponsive. This is the actual output
> > observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.
> > 
> > There is no need to reprogram the iATU region used for MSI on every
> > interrupt. The host-provided MSI address is stable while MSI is enabled,
> > and the endpoint driver already dedicates a scratch buffer for MSI
> > generation.
> > 
> > Cache the aligned MSI address and map size, program the outbound iATU
> > once, and keep the window enabled. Subsequent interrupts only perform a
> > write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
> > the hot path and fixing the lockups seen under load.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > [cassel: do same change for dw_pcie_ep_raise_msix_irq()]
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>

Thanks for splitting it up!

> > ---
> > Notes: Without this patch, I also see IOMMU errors on the host side,
> > when running drivers/nvme/target/pci-epf.c with a large queue depth.
> > 
> > pci_epc_raise_irq() does take a mutex, so the calls to these functions
> > are serialized, so it really appears that the DWC controller does not
> > handle iATU reprogramming while there are outstanding transactions.
> > 
> > Just like Koichiro describes here:
> > https://lore.kernel.org/linux-pci/ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6/
> > 
> > I also see the iova faulting on the RC side to be the start of "addr_space"
> > on the EP, so it appears that a transaction has gone through untranslated.
> > (Most likely because the DWC controller does handle the iATU table being
> > modified while there are outstanding transactions.)
> > 
> > This patch has been tested using pci-epf-test and nvmet-pci-epf on rock5b.
> > 
> > pci-epf-test does change between MSI and MSI-X without calling
> > dw_pcie_ep_stop(), however, the msg_addr address written by the host
> > will be the same address, at least when using a Linux host using a DWC
> > based controller. If another host ends up using different msg_addr for
> > MSI and MSI-X, then I think that we will need to modify pci-epf-test to
> > call a function when changing IRQ type, such that pcie-designware-ep.c
> > can tear down the MSI/MSI-X mapping.
> > 
> >   .../pci/controller/dwc/pcie-designware-ep.c   | 82 ++++++++++++++++---
> >   drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
> >   2 files changed, 75 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 7f2112c2fb21..2bbeddaa73d4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -601,6 +601,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
> >   	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	/*
> > +	 * Tear down the dedicated outbound window used for MSI
> > +	 * generation. This avoids leaking an iATU window across
> > +	 * endpoint stop/start cycles.
> > +	 */
> > +	if (ep->msi_iatu_mapped) {
> > +		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
> > +		ep->msi_iatu_mapped = false;
> > +	}
> > +
> >   	dw_pcie_stop_link(pci);
> >   }
> > @@ -702,14 +712,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >   	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> >   	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> > -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  map_size);
> > -	if (ret)
> > -		return ret;
> > -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> > +	/*
> > +	 * Program the outbound iATU once and keep it enabled.
> > +	 *
> > +	 * The spec warns that updating iATU registers while there are
> > +	 * operations in flight on the AXI bridge interface is not
> > +	 * supported, so we avoid reprogramming the region on every MSI,
> > +	 * specifically unmapping immediately after writel().
> > +	 */
> > +	if (!ep->msi_iatu_mapped) {
> > +		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> > +					  ep->msi_mem_phys, msg_addr,
> > +					  map_size);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ep->msi_iatu_mapped = true;
> > +		ep->msi_msg_addr = msg_addr;
> > +		ep->msi_map_size = map_size;
> > +	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> > +				ep->msi_map_size != map_size)) {
> > +		/*
> > +		 * The host changed the MSI target address or the required
> > +		 * mapping size changed. Reprogramming the iATU at runtime is
> > +		 * unsafe on this controller, so bail out instead of trying to
> > +		 * update the existing region.
> > +		 */
> > +		return -EINVAL;
> > +	}
> > -	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> > +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> >   	return 0;
> >   }
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
> 
> And also we see in MSIX the address are getting updated at runtime with x86
> windows host machines.
> 

The spec allows changing the MSI-X address/data pair when the corresponding
vector is *masked*, and classifies the behavior as undefined if address/data
pair gets changed while the vector is *unmasked*.

If we were to enable caching, then we need to take note of the above point. But
the EP implementation doesn't get any notification when the vector gets
masked/unmasked dynamically, which makes it trickier to implement the caching in
SW.

> Use the MSIX doorbell method which will not use iATU at all,
> dw_pcie_ep_raise_msix_irq_doorbell().
> 

I think this is the safe bet since this feature doesn't seem like an optional
one.

Niklas, if you can just fix MSI in this patch and leave out MSI-X for the vendor
drivers to transition to doorbell, I'm OK to merge it. Otherwise, I don't know
how you can reliably fix MSI-X generation with AXI slave interface.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

