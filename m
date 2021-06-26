Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C83B4F45
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFZPvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 11:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhFZPvH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Jun 2021 11:51:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 437E961C44;
        Sat, 26 Jun 2021 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624722524;
        bh=fkicDn38aCz1Lyv32ngMjCNf6vU1u47PjWoCcHXaraE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kb+ig6l9TICVFh8pZZsuwjVAF17DEFqlec5kdtlAsMRVQdm8SWfmYX9eBMiYb+0mJ
         suTgvLFeyr/nNOSEGCGdVAqUYLTsySZeOiyVjLnuQZlAuMIP5F8MBmbsF16svi9+VG
         iUBNBv/2U+fYHeKa4LI5Jc0tULUhSOKCWycssy3DiMzQwmPXL/2EDixdwYP4X5Wwbc
         P/+f4wx5ueZx+imMFK2Qqei/c1axxc6UUsUoy6hHEguVhbZ7bzrg652sREwH92fTeW
         6BxN1iPfiyrRL64mJTV4YQI5koA7DdaJzem/kJL//+flINwcK0N18+JrrsW9AzOti8
         7nRnCN2JYEw1Q==
Date:   Sat, 26 Jun 2021 10:48:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3 3/4] PCI: Improve the MRRS quirk for LS7A
Message-ID: <20210626154837.GA3738258@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625222204.GA3657225@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 05:22:04PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 25, 2021 at 05:30:29PM +0800, Huacai Chen wrote:
> > In new revision of LS7A, some PCIe ports support larger value than 256,
> > but their maximum supported MRRS values are not detectable. Moreover,
> > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > will actually set a big value in its driver. So the only possible way is
> > configure MRRS of all devices in BIOS, and add a PCI device flag (i.e.,
> > PCI_DEV_FLAGS_NO_INCREASE_MRRS) to stop the increasing MRRS operations.
> > 
> > However, according to PCIe Spec, it is legal for an OS to program any
> > value for MRRS, and it is also legal for an endpoint to generate a Read
> > Request with any size up to its MRRS. As the hardware engineers says,
> > the root cause here is LS7A doesn't break up large read requests (Yes,
> > that is a problem in the LS7A design).
> 
> "LS7A doesn't break up large read requests" claims to be a root cause,
> but you haven't yet said what the actual *problem* is.
> 
> Is the problem that an endpoint reports a malformed TLP because it
> received a completion bigger than it can handle?  Is it that the LS7A
> root port reports some kind of error if it receives a Memory Read
> request with a size that's "too big"?  Maybe the LS7A doesn't know
> what to do when it receives a Memory Read request with MRRS > MPS?
> What exactly happens when the problem occurs?
> 
> MRRS applies only to the read request.  It is not directly related to
> the size of the completions that carry the data back to the device
> (except that obviously you shouldn't get a completion larger than the
> read you requested).
> 
> The setting that directly controls the size of completions is MPS
> (Max_Payload_Size).  One reason to break up read requests is because
> the endpoint's buffers can't accommodate big TLPs.  One way to deal
> with that is to set MPS in the hierarchy to a smaller value.  Then the
> root port must ensure that no TLP exceeds the MPS size, regardless of
> what the MRRS in the read request was.
> 
> For example, if the endpoint's MRRS=4096 and the hierarchy's MPS=128,
> it's up to the root port to break up completions into 128-byte chunks.
> 
> It's also possible to set the endpoint's MRRS=128, which means reads
> to main memory will never receive completions larger than 128 bytes.
> But it does NOT guarantee that a peer-to-peer DMA from another device
> will be limited to 128 bytes.  The other device is allowed to generate
> Memory Write TLPs with payloads up to its MPS size, and MRRS is not
> involved at all.
> 
> It's not clear yet whether the LS7A problem is with MRRS, with MPS, or
> with some combination.  It's important to understand exactly what is
> broken here so the quirk doesn't get in the way of future changes to
> the generic MRRS and MPS configuration.
> 
> Here's a good overview:
> 
>   https://www.xilinx.com/support/documentation/white_papers/wp350.pdf
> 
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pci.c    | 5 +++++
> >  drivers/pci/quirks.c | 8 +++++++-
> >  include/linux/pci.h  | 2 ++
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b717680377a9..6f0d2f5b6f30 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5802,6 +5802,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >  
> >  	v = (ffs(rq) - 8) << 12;
> >  
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_INCREASE_MRRS) {
> > +		if (rq > pcie_get_readrq(dev))
> > +			return -EINVAL;
> > +	}
> > +
> >  	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> >  						  PCI_EXP_DEVCTL_READRQ, v);
> >  
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index dee4798a49fc..8284480dc7e4 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -263,7 +263,13 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
> >  		 * anything larger than this. So force this limit on
> >  		 * any devices attached under these ports.
> >  		 */
> > -		if (pci_match_id(bridge_devids, bridge)) {
> > +		if (bridge && pci_match_id(bridge_devids, bridge)) {
> > +			dev->dev_flags |= PCI_DEV_FLAGS_NO_INCREASE_MRRS;
> > +
> > +			if (pcie_bus_config == PCIE_BUS_DEFAULT ||
> > +			    pcie_bus_config == PCIE_BUS_TUNE_OFF)
> > +				break;

Another approach might be to make a quirk that prevents Linux from
touching MPS and MRRS at all under any circumstances.

You'd have to do this without reference to pcie_bus_config so future
MPS/MRRS algorithm changes wouldn't be affected.  And the quirk bit
would have to be in struct pci_host_bridge, similar to no_ext_tags.

> >  			if (pcie_get_readrq(dev) > 256) {
> >  				pci_info(dev, "limiting MRRS to 256\n");
> >  				pcie_set_readrq(dev, 256);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 24306504226a..5e0ec3e4318b 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> >  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> >  	/* Don't use Relaxed Ordering for TLPs directed at this device */
> >  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> > +	/* Don't increase BIOS's MRRS configuration */
> > +	PCI_DEV_FLAGS_NO_INCREASE_MRRS = (__force pci_dev_flags_t) (1 << 12),
> >  };
> >  
> >  enum pci_irq_reroute_variant {
> > -- 
> > 2.27.0
> > 
