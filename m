Return-Path: <linux-pci+bounces-12857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E196E2F2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 21:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D303285A26
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132B17C9B5;
	Thu,  5 Sep 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIu2kEiA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6E13211C;
	Thu,  5 Sep 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563799; cv=none; b=KhrdLpU3v5fRHJbtUEDplddvZIT469KK33KnGNEKQoXusRnqHJw2rXD5Aiiw/pTySou+8uKZXBe7S4NwH8ajDixmHDe61Mk7l2LF7PzM49npsj1+JqWVQMLfmlvLnXRztXHIvw5c/Sa2/o/dyVagxoZsiP4TL6Sw9GwJdICdX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563799; c=relaxed/simple;
	bh=9aJfL5uL8bd3t0e3HtAXpLc2f4fAdbCybcOsaulLVvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OKki99VDo5HT8dveeYglfzeLv5hqnY/4hYdrvnfek7X2sJbXASz1HT1el3VpmvbUkT2z4Ex5bUDiSp4tBObZfZqY7N0dJo/H7EF1zXcetmhHqPuKLRVABSP89VsLicaFUvMboruwXDHpMMz9U6rHeC9AmY4jEdIY6ksV1MfMiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIu2kEiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECA6C4CEC3;
	Thu,  5 Sep 2024 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563798;
	bh=9aJfL5uL8bd3t0e3HtAXpLc2f4fAdbCybcOsaulLVvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eIu2kEiAZBqDaT7yHN6eG+IDuaPCPDqCMMCTivKgx4KBGiK1W6iCjULtgbp/1EsRK
	 i9u1E+SCe35Cetssk7Oj4XzhXUZujCQD+ij33X/pN7AMVtU337D31+dFFjzUBuhsZg
	 X7R3efIF5cWEhzhkKre+MoM9CuDTPyo+oHeZKWbdVDReEhqdxF+C9mZXrSdg6h+D4S
	 mYv5S2fFApkEos/3C4F/IxawXbYsRg7KTb0quLzS62h4yKjvGKFtqRsEuEgtqBpLa0
	 tdNYw6xddpyYDLB1xVqKqduxtln8ISOtNbGrBTHY9AbUzpaDcifg68D4U0mLOvG1kq
	 FNomTfczVE/Ww==
Date: Thu, 5 Sep 2024 14:16:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH v4 4/7] PCI: keystone: Add supported for PVU-based DMA
 isolation on AM654
Message-ID: <20240905191635.GA395079@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b5f0ff-50e7-42f9-8b66-b967476dd6c5@siemens.com>

On Thu, Sep 05, 2024 at 09:07:36PM +0200, Jan Kiszka wrote:
> On 05.09.24 18:33, Bjorn Helgaas wrote:
> > [+cc Kishon, just in case you have time/interest ;)]
> > 
> > On Wed, Sep 04, 2024 at 12:00:13PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
> >> from untrusted PCI devices to selected memory regions this way. Use
> >> static PVU-based protection instead.
> >>
> >> For this, we use the availability of restricted-dma-pool memory regions
> >> as trigger and register those as valid DMA targets with the PVU.
> > 
> > I guess the implication is that DMA *outside* the restricted-dma-pool
> > just gets dropped, and the Requester would see Completion Timeouts or
> > something for reads?
> 
> I cannot tell what happens on the PCI bus in that case, maybe someone 
> from TI can help out.
> 
> On the host side, the PVU will record an error and raise an interrupt 
> which will make the driver report that to the kernel log. That's quite 
> similar to what IOMMU drivers do on translation faults.

The main thing is that the DMA doesn't complete, as you mentioned
below.

> > Since there's no explicit use of "restricted-dma-pool" elsewhere in
> > this patch, I assume the setup above causes the controller to drop any
> > DMA accesses outside that pool?  I think a comment about how the
> > controller behavior is being changed would be useful.  Basically the
> > same comment as for the commit log.
> 
> Right, this is what will happen. Will add some comment.
> 
> > Would there be any value in a dmesg note about a restriction being
> > enforced?  Seems like it's dependent on both CONFIG_TI_PVU and some DT
> > properties, and since those are invisible in the log, maybe a note
> > would help understand/debug any issues?
> 
> This is what you will see when there are reserved region and PVU in 
> play:
> 
> keystone-pcie 5600000.pcie: assigned reserved memory node restricted-dma@c0000000
> ti-pvu 30f80000.iommu: created TLB entry 0.2: 0xc0000000, psize 4 (0x02000000)
> ti-pvu 30f80000.iommu: created TLB entry 0.3: 0xc2000000, psize 4 (0x02000000)
> ...
> ath9k 0000:01:00.0: assigned reserved memory node restricted-dma@c0000000

Looks reasonable and solves my concern.

> >> +	of_for_each_phandle(&it, err, pdev->dev.of_node, "memory-region",
> >> +			    NULL, 0) {
> >> +		if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
> >> +		    of_address_to_resource(it.node, 0, &phys) == 0)
> >> +			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);
> > 
> > I guess it's not important to undo the PCIE_VMAP_xP_CTRL_EN and
> > related setup that was done by ks_init_restricted_dma()?
> > 
> 
> Right, I didn't find a reason to do that.

OK, as long as you considered it :)

Bjorn

