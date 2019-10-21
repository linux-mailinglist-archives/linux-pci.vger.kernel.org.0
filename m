Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F492DE9D4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 12:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfJUKip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 06:38:45 -0400
Received: from [217.140.110.172] ([217.140.110.172]:48602 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfJUKio (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 06:38:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C95CEBD;
        Mon, 21 Oct 2019 03:38:15 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DE2B3F718;
        Mon, 21 Oct 2019 03:38:14 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:38:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Abhishek Shah <abhishek.shah@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 1/1] PCI: iproc: Invalidate PAXB address mapping before
 programming it
Message-ID: <20191021103808.GA29528@e121166-lin.cambridge.arm.com>
References: <20190906035813.24046-1-abhishek.shah@broadcom.com>
 <20191015164303.GC25674@e121166-lin.cambridge.arm.com>
 <CAKUFe6bQPMirQ01s-ezaQcUU85J+moFKMO8sLZgvtG2EPowrGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUFe6bQPMirQ01s-ezaQcUU85J+moFKMO8sLZgvtG2EPowrGA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 07:57:56PM +0530, Abhishek Shah wrote:
> Hi Lorenzo,
> 
> Please see my comments inline:
> 
> On Tue, Oct 15, 2019 at 10:13 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Fri, Sep 06, 2019 at 09:28:13AM +0530, Abhishek Shah wrote:
> > > Invalidate PAXB inbound/outbound address mapping each time before
> > > programming it. This is helpful for the cases where we need to
> > > reprogram inbound/outbound address mapping without resetting PAXB.
> > > kexec kernel is one such example.
> >
> > This looks like a hack, explain to us please what it actually solves and
> > why a full reset is not necessary.
> >
> The PAXB IP performs address translation(PCI<->AXI address) for both inbound and
> outbound addresses (amongst other things) based on version of IP being used.
> It does so using the IMAP/IARR/OMAP/OARR registers.
> 
> These registers get programmed as per mappings specified in device tree during
> PCI driver probe for each RC and do not get reset when kexec/kdump kernel boots.
> This results in driver assuming valid mappings in place for some mapping windows
> during kexec/kdump kernel boot, consequently it skips those windows and
> we run out of available mapping windows, leading to mapping failure.
> 
> Normally, we take care of resetting PAXB block in firmware, but in
> primary kernel to kexec/kdump kernel handover, no firmware is executed
> in between.  So, we just, by default, invalidate the mapping registers
> each time before
> programming them to solve the issue described above..
> We do not need full reset for handling this.

I see. A simple bitmap to detect which windows are *actually*
programmed by the current kernel (that can be used by

iproc_pcie_ob_is_valid()

to carry out a valid check) would do as well instead of having to
invalidate all the OB registers.

It is up to you, let me know and I will merge code accordingly.

Lorenzo

> > > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
> >
> > Patches are reviewed on public mailing lists, remove tags given
> > on internal reviews - they are not relevant.
> >
> Ok, will remove.
> 
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
> >
> > What's this check for and why leaving mappings in place is safe for
> > this category of IPs ?
> For this category of IP(PAXC), no mappings need to be programmed in
> the first place.
> 
> >
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
> >
> > It makes more sense to call this in the .shutdown() method if I
> > understand what it does.
> >
> It would work for kexec kernel, but not for kdump kernel as only for
> kexec'ed kernel,
> "device_shutdown" callback is present. We are here taking care of both the cases
> with this patch.
> 
> 
> Regards,
> Abhishek
> 
> > Lorenzo
> >
> > >       if (pcie->need_ob_cfg) {
> > >               ret = iproc_pcie_map_ranges(pcie, res);
> > >               if (ret) {
> > > --
> > > 2.17.1
> > >
