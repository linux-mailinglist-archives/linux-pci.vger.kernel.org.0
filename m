Return-Path: <linux-pci+bounces-1601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E04821FA9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 17:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1351C21641
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3268814F8E;
	Tue,  2 Jan 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSeUq0uE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5814F8A
	for <linux-pci@vger.kernel.org>; Tue,  2 Jan 2024 16:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5DAC433C8;
	Tue,  2 Jan 2024 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704214135;
	bh=iFQOSFjxGDEm1W9n/FfZO+61hvlGvh1w0Q0xKFdjxpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSeUq0uEndw7eHiI4RM5oAM24pPq/lV0lutZbfQhFbg1gTWjvY2b5jdb4/zmRmPji
	 EdYUCp3+BQMmhYAgcAWR3/jeN+xB6rRsa6TM9dJWgEdyzbbsqQlSOOD6wZAOM0gs3K
	 YmDVKqXJEPcJzFzNTPJIB/PG6oCcIWAU88lI4njgFkGcQtFfrIP2MInEV7IWgVNV07
	 CgBMRhBNywCU9I6pT8tKAAy1/15+8E0emv2umpo/DTXe4oMMiui6s+9d5IU7INFuSI
	 rF7/1lqpwmiR80odeqE/nrgKOMQM7TqhDiTEM6hq53nqNJNEu8tvfYQENMZ4Eh7jT/
	 KTkDC0k3Jc80g==
Date: Tue, 2 Jan 2024 22:18:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <nks@flawful.org>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Message-ID: <20240102164840.GB4917@thinkpad>
References: <ZYwRK2Vh5PLRcrQo@x1-carbon>
 <20231227130341.GA1498687@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227130341.GA1498687@bhelgaas>

On Wed, Dec 27, 2023 at 07:03:41AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 27, 2023 at 12:57:31PM +0100, Niklas Cassel wrote:
> > On Tue, Dec 26, 2023 at 04:17:14PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 28, 2023 at 02:22:30PM +0100, Niklas Cassel wrote:
> > > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > > 
> > > > Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> > > > correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
> > > > support iATUs which require a specific alignment.
> > > > 
> > > > However, this support cannot have been properly tested.
> > > > 
> > > > The whole point is for the iATU to map an address that is aligned,
> > > > using dw_pcie_ep_map_addr(), and then let the writel() write to
> > > > ep->msi_mem + aligned_offset.
> > > > 
> > > > Thus, modify the address that is mapped such that it is aligned.
> > > > With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
> > > > dw_pcie_ep_raise_msi_irq().
> > 
> > For the record, this patch is already queued up:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc
> 
> Yes, of course.  I was writing the merge commit log for merging that
> branch into the PCI "next" branch.
> 
> > ...
> > > > @@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > >  	}
> > > >  
> > > >  	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > > > +	msg_addr &= ~aligned_offset;
> > > >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > > >  				  epc->mem->window.page_size);
> > > 
> > > Total tangent and I don't know enough to suggest any changes, but
> > > it's a little strange as a reader that we want to write to
> > > ep->msi_mem, and the ATU setup with dw_pcie_ep_map_addr() doesn't
> > > involve ep->msi_mem at all.
> > > 
> > > I see that ep->msi_mem is allocated and ioremapped far away in
> > > dw_pcie_ep_init().  It's just a little weird that there's no
> > > connection *here* with ep->msi_mem.
> > 
> > There is a connection. dw_pcie_ep_raise_msix_irq() uses
> > ep->msi_mem_phys, which is the physical address of ep->msi_mem:
> > 
> > ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> >                                   epc->mem->window.page_size);  
> 
> Right, that's the connection I mentioned as "far away in
> dw_pcie_ep_init()".  It's not the usual pattern of "map X, write X".
> Here we have "map X, write Y", and it's up to the reader to do the
> research to figure out whether and how X and Y are related.
> 
> > > I assume dw_pcie_ep_map_addr(), writel(), dw_pcie_ep_unmap_addr()
> > > have to happen atomically so nobody else uses that piece of the
> > > ATU while we're doing this?  There's no mutex here, so I guess we
> > > must know this is atomic already because of something else?
> > 
> > Most devices have multiple iATUs (so multiple iATU indexes).
> > 
> > pcie-designware-ep.c:dw_pcie_ep_outbound_atu() uses
> > find_first_zero_bit() to make sure that a specific iATU (index) is
> > not reused for something else:
> > https://github.com/torvalds/linux/blob/v6.7-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L208
> > 
> > A specific iATU (index) is then freed by dw_pcie_ep_unmap_addr(),
> > which does a clear_bit() for that iATU (index).
> > 
> > It is a bit scary that there is no mutex or anything, since
> > find_first_zero_bit() is _not_ atomic, so if we have concurrent
> > calls to dw_pcie_ep_map_addr(), things might break, but that is a
> > separate issue.
> > 
> > I assume that this patch series will improve the concurrency issue,
> > if it gets accepted:
> > https://lore.kernel.org/linux-pci/20231212022749.625238-1-yury.norov@gmail.com/
> 
> This totally seems non-obvious and scary, regardless of Yury's patch.
> If we're relying on the mem->bitmap to permanently assign an iATU
> index for ep->msi_mem, it's not obvious why we need to use
> dw_pcie_ep_map_addr() to enable that address each time we need it.
> 

Agree. I'm planning to switch to genpoll/genalloc instead of using a custom
memory allocation scheme in pci-epc-mem.c. Will try to address this issue also.\
Thanks for spotting!

- Mani

> But all this is completely unrelated to your patch, which is fine and
> now in -next (well, it *will* be the next time there is a linux-next
> release, which looks like Jan 2 or so).
> 
> Bjorn

-- 
மணிவண்ணன் சதாசிவம்

