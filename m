Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDCBAB533
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfIFKBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 06:01:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732160AbfIFKBR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 06:01:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B67721570;
        Fri,  6 Sep 2019 03:01:16 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8F23F59C;
        Fri,  6 Sep 2019 03:01:16 -0700 (PDT)
Date:   Fri, 6 Sep 2019 11:01:14 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Abhishek Shah <abhishek.shah@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 1/1] PCI: iproc: Invalidate PAXB address mapping before
 programming it
Message-ID: <20190906100114.GE9720@e119886-lin.cambridge.arm.com>
References: <20190906035813.24046-1-abhishek.shah@broadcom.com>
 <20190906083816.GD9720@e119886-lin.cambridge.arm.com>
 <CAKUFe6ZuRGJSmLdXqTWJzX-nE_Vh4yEQF_-rf+BWFrD_r4BRaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUFe6ZuRGJSmLdXqTWJzX-nE_Vh4yEQF_-rf+BWFrD_r4BRaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 02:55:19PM +0530, Abhishek Shah wrote:
> Hi Andrew,
> 
> Thanks for the review. Please see my response inline:
> 
> On Fri, Sep 6, 2019 at 2:08 PM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Fri, Sep 06, 2019 at 09:28:13AM +0530, Abhishek Shah wrote:
> > > Invalidate PAXB inbound/outbound address mapping each time before
> > > programming it. This is helpful for the cases where we need to
> > > reprogram inbound/outbound address mapping without resetting PAXB.
> > > kexec kernel is one such example.
> >
> > Why is this approach better than resetting the PAXB (I assume that's
> > the PCI controller IP)? Wouldn't resetting the PAXB address this issue,
> > and ensure that no other configuration is left behind?
> >
> We normally reset PAXB in the firmware(ATF). But for cases like kexec
> kernel boot,
> we do not execute any firmware code and directly boot into kernel.
> 
> We could have done PAXB reset in the driver itself as you have suggested here.
> But note that this detail could vary for each SoC, because these
> registers are not part
> of PAXB register space itself, rather exists in a register space responsible for
> controlling power to various wrappers in PCIe IP. Normally, this kind
> of SoC specific
> details are handled in firmware itself, we don't bring them to driver level.

OK understood.

> 
> > Or is this related to earlier boot stages loading firmware for the emulated
> > downstream endpoints (ep_is_internal)?
> >
> > Finally, in the case where ep_is_internal do you need to disable anything
> > prior to invalidating the mappings?
> >
> No, ep_is_internal  is indicator for PAXC IP. It does not have
> mappings as in PAXB.

I think I meant !ep_is_internal. I.e. is there possibility of inbound traffic
prior to invalidating the mappings. I'd assume not, but that's an assumption.

Either way:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 
> 
> Regards,
> Abhishek
> > >
> > > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
> > > ---
> > >  drivers/pci/controller/pcie-iproc.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > index e3ca46497470..99a9521ba7ab 100644
> > > --- a/drivers/pci/controller/pcie-iproc.c
> > > +++ b/drivers/pci/controller/pcie-iproc.c
> > > @@ -1245,6 +1245,32 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> > >       return ret;
> > >  }
> > >
> > > +static void iproc_pcie_invalidate_mapping(struct iproc_pcie *pcie)
> > > +{
> > > +     struct iproc_pcie_ib *ib = &pcie->ib;
> > > +     struct iproc_pcie_ob *ob = &pcie->ob;
> > > +     int idx;
> > > +
> > > +     if (pcie->ep_is_internal)
> > > +             return;
> > > +
> > > +     if (pcie->need_ob_cfg) {
> > > +             /* iterate through all OARR mapping regions */
> > > +             for (idx = ob->nr_windows - 1; idx >= 0; idx--) {
> > > +                     iproc_pcie_write_reg(pcie,
> > > +                                          MAP_REG(IPROC_PCIE_OARR0, idx), 0);
> > > +             }
> > > +     }
> > > +
> > > +     if (pcie->need_ib_cfg) {
> > > +             /* iterate through all IARR mapping regions */
> > > +             for (idx = 0; idx < ib->nr_regions; idx++) {
> > > +                     iproc_pcie_write_reg(pcie,
> > > +                                          MAP_REG(IPROC_PCIE_IARR0, idx), 0);
> > > +             }
> > > +     }
> > > +}
> > > +
> > >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
> > >                              struct device_node *msi_node,
> > >                              u64 *msi_addr)
> > > @@ -1517,6 +1543,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> > >       iproc_pcie_perst_ctrl(pcie, true);
> > >       iproc_pcie_perst_ctrl(pcie, false);
> > >
> > > +     iproc_pcie_invalidate_mapping(pcie);
> > > +
> > >       if (pcie->need_ob_cfg) {
> > >               ret = iproc_pcie_map_ranges(pcie, res);
> > >               if (ret) {
> >
> > The code changes look good to me.
> >
> > Thanks,
> >
> > Andrew Murray
> >
> > > --
> > > 2.17.1
> > >
