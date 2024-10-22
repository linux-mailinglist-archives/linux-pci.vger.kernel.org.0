Return-Path: <linux-pci+bounces-15044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52919AB7F5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6151F23BBF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE79126C05;
	Tue, 22 Oct 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyhN8rhA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F73EA83
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630075; cv=none; b=rJ5wG+Bt7FshehKhM+Z56uRiIGapCgN9ohJS8EBU0iPrEJxzuhiCXN5qCFx/Jrc/cg0uFJpQ9qfkKY486atPVZiQZGh4vw5+2rtAJzWKV8iNKb2K9dQiO+rnfEfmi71CntPIkWfBq+paENcyukjlZS/1DRzRQzmUjhPgm5Wte10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630075; c=relaxed/simple;
	bh=25jEaqkmcp7P2oj+8D3mUiopqQOf9stbYwFX4tVsg8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EtcOshA/hlRalzSo4zkT8QuzatoKC7XxzSW13cc6GTO9WzK5llWIix0x6j+nrgmdCH0YpivqDry7mtKlX+BmJmSWdbPchFj21h53Tw2jEFHj/yD2EXGILhMpPN+qFObvLlGaBiez/jHaK8p6QSc3L62C137qwQhl09hncHLrVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyhN8rhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC234C4CEC7;
	Tue, 22 Oct 2024 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729630074;
	bh=25jEaqkmcp7P2oj+8D3mUiopqQOf9stbYwFX4tVsg8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pyhN8rhACbsrB26+65v0BJwBhFOH/LemKpyYJizJ5c3Mvpu/TWaqP8tNomjxfp3xe
	 ieFAdJTyXsCmqNxk0wISWGeociURG65UIyGl+idE8F+REVJ+KEuUXoDDpm4jNyCNIL
	 jbUxNQ64zQ+4yUg0wsrZka8Ug5fNw5egZBQbQP+rjf2GwK+zjWxfTxh/O1zyPhcX99
	 8E/7WY3uSAv1I1qGtL37WQW95PJdmAaG3Mj+eT/H7cY88bUeg6Ga4Yrd14PS++S0T2
	 D9GaTaFt0VrcGPxn2bp7+skD436FJfrJ+PfodzRd+c5pWdHZvaLBDHwz850ire2+s4
	 pR3x2ShxPrZHA==
Date: Tue, 22 Oct 2024 15:47:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <20241022204752.GA881656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848f676b-afce-472e-872d-53a32af094c1@kernel.org>

On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
> On 10/22/24 07:19, Bjorn Helgaas wrote:
> > On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
> >> This series introduces the new functions pci_epc_mem_map() and
> >> pci_epc_mem_unmap() to improve handling of the PCI address mapping
> >> alignment constraints of endpoint controllers in a controller
> >> independent manner.
> > 
> > Hi Damien, I know this is obvious to everybody except me, but who
> > uses this mapping?  A driver running on the endpoint that does
> > MMIO?  DMA (Memory Reads or Writes that target an endpoint BAR)?
> > I'm still trying to wrap my head around the whole endpoint driver
> > model.
> 
> The mapping API is for mmio or DMA using endpoint controller memory
> mapped to a host PCI address range. It is not for BARs. BARs setup
> does not use the same API and has not changed with these patches.
> 
> BARs can still be accessed on the endpoint (within the EPF driver)
> with regular READ_ONCE()/WRITE_ONCE() once they are set. But any
> data transfer between the PCI RC host and the EPF driver on the EP
> host that use mmio or DMA generic channel (memory copy offload
> channel) needs the new mapping API. DMA transfers that can be done
> using dedicated DMA rx/tx channels associated with the endpoint
> controller do not need to use this API as the mapping to the host
> PCI address space is automatically handled by the DMA driver.

Sorry I'm dense.  I'm really not used to thinking in the endpoint
point of view.  Correct me where I go off the rails:

  - This code (pci_epc_mem_map()) runs on an endpoint, basically as
    part of some endpoint firmware, right?

  - On the endpoint's PCIe side, it receives memory read/write TLPs?

  - These TLPs would be generated elsewhere in the PCIe fabric, e.g.,
    by a driver on the host doing MMIO to the endpoint, or possibly
    another endpoint doing peer-to-peer DMA.

  - Mem read/write TLPs are routed by address, and the endpoint
    accepts them if the address matches one of its BARs.

  - This is a little different from a Root Complex, which would
    basically treat reads/writes to anything outside the Root Port
    windows as incoming DMA headed to physical memory.

  - A Root Complex would use the TLP address (the PCI bus address)
    directly as a CPU physical memory address unless the TLP address
    is translated by an IOMMU.

  - For the endpoint, you want the BAR to be an aperture to physical
    memory in the address space of the SoC driving the endpoint.

  - The SoC physical memory address may be different from the PCI but
    address in the TLP, and pci_epc_mem_map() is the way to account
    for this?

  - IOMMU translations from PCI to CPU physical address space are
    pretty arbitrary and needn't be contiguous on the CPU side.

  - pci_epc_mem_map() sets up a conceptually similar PCI to CPU
    address space translation, but it's much simpler because it
    basically applies just a constant offset?

