Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA1216137
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 11:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEGJlK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 05:41:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48498 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfEGJlK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 05:41:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5FBD374;
        Tue,  7 May 2019 02:41:09 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E478B3F5AF;
        Tue,  7 May 2019 02:41:07 -0700 (PDT)
Date:   Tue, 7 May 2019 10:41:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] PCI: iproc: Add sorted dma ranges resource
 entries to host bridge
Message-ID: <20190507094102.GA10964@e121166-lin.cambridge.arm.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
 <1556892334-16270-4-git-send-email-srinath.mannam@broadcom.com>
 <20190506211208.GA156478@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506211208.GA156478@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 06, 2019 at 04:12:08PM -0500, Bjorn Helgaas wrote:
> On Fri, May 03, 2019 at 07:35:34PM +0530, Srinath Mannam wrote:
> > The IPROC host controller allows only a subset of physical address space
> > as target of inbound PCI memory transactions addresses.
> > 
> > PCIe devices memory transactions targeting memory regions that
> > are not allowed for inbound transactions in the host controller
> > are rejected by the host controller and cannot reach the upstream
> > buses.
> > 
> > Firmware device tree description defines the DMA ranges that are
> > addressable by devices DMA transactions; parse the device tree
> > dma-ranges property and add its ranges to the PCI host bridge dma_ranges
> > list; the iova_reserve_pci_windows() call in the driver will reserve the
> > IOVA address ranges that are not addressable (ie memory holes in the
> > dma-ranges set) so that they are not allocated to PCI devices for DMA
> > transfers.
> > 
> > All allowed address ranges are listed in dma-ranges DT parameter.
> > 
> > Example:
> > 
> > dma-ranges = < \
> >   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
> >   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
> >   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> > 
> > In the above example of dma-ranges, memory address from
> > 
> > 0x0 - 0x80000000,
> > 0x100000000 - 0x800000000,
> > 0x1000000000 - 0x8000000000 and
> > 0x10000000000 - 0xffffffffffffffff.
> > 
> > are not allowed to be used as inbound addresses.
> > 
> > Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > [lorenzo.pieralisi@arm.com: updated commit log]
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index c20fd6b..94ba5c0 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
> >  	return ret;
> >  }
> >  
> > +static int
> > +iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
> > +			 struct of_pci_range *range)
> 
> Just FYI, I cherry-picked these commits from Lorenzo's branch to fix
> the formatting of this prototype to match the rest of the file, e.g.:

Thank you, I noticed too but I forgot to update it before merging
v6 from the list.

Thanks,
Lorenzo

> >  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> > ...
> >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
