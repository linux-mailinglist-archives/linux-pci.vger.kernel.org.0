Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567E1E28C0
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392909AbfJXDW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 23:22:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45893 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392896AbfJXDWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2019 23:22:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so19278722wrs.12
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2019 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxgWmQM7qtnhNLoqpfev4EbCbpYsYSC4gKmtA8VlS7s=;
        b=f3+EkB1SkTxtFa2qO8z9TpGkjdUu2bpOoeZixAvg5AvMLs1euNJB2LCIjuIU+VuWSY
         /eQ6HtO6E5bSED1EJovtj6M35hInbZqufaXyst1OMfjXE30u7L8vENRqCXPVt3M8l3jY
         lizvm2R12l/SJ2GFoXx5LeXNv4+9XrfxW7qoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxgWmQM7qtnhNLoqpfev4EbCbpYsYSC4gKmtA8VlS7s=;
        b=CL1un1kHOPo9lIovhtH9QsPyUyKQralCGSx08PxlBqCSrrlX+RU1pxXTDDizRtzpGT
         4btxLGBjo4RQh/JdctElEAMgOeuUBJXbfgjCNLju1vypvyvIozcsM7Co68ze/OxxAFTu
         xmraDt0W1MKaq7+/ZiFyoi+73LkdsV5jyKBbJAKyFx9j4bdtZLdjXw2kCu2mGcDILndr
         o1lk9eiThHg54c5vYT7m9wIfVbNQnDZSmxloi1x8LfkPHU87KIBUsogW5bb2eZnCNadw
         1Js9p4xX97+ojulaU3yweNDA09ujEhFAXgDch2TIwkUQDuxJFxd3/tHR44IOiDC28cv3
         H5cw==
X-Gm-Message-State: APjAAAWZ/YT0AX9++U1Z9XbNdg8uifc/RChxuQWL4/Om5x8iMBvRRMje
        TPGVu10T/boZiBiU/6Ld8MQSkWicXFrUdKC7c3tuNQ==
X-Google-Smtp-Source: APXvYqyG9MzlQubrRgYExs+l/UMdE69TF938LH25z81UsvSyDHsfm4yK4JD+INrJnrkrCy1n5uL+O2aESo4czMbI4u4=
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr1603850wrn.57.1571887372518;
 Wed, 23 Oct 2019 20:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190906035813.24046-1-abhishek.shah@broadcom.com>
 <20191015164303.GC25674@e121166-lin.cambridge.arm.com> <CAKUFe6bQPMirQ01s-ezaQcUU85J+moFKMO8sLZgvtG2EPowrGA@mail.gmail.com>
 <20191021103808.GA29528@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191021103808.GA29528@e121166-lin.cambridge.arm.com>
From:   Abhishek Shah <abhishek.shah@broadcom.com>
Date:   Thu, 24 Oct 2019 08:52:41 +0530
Message-ID: <CAKUFe6Yg4ZiDfTZyAcerHa7q9TGqsUikGNOqv4eDOhkPjh5rJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: iproc: Invalidate PAXB address mapping before
 programming it
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 4:08 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Oct 17, 2019 at 07:57:56PM +0530, Abhishek Shah wrote:
> > Hi Lorenzo,
> >
> > Please see my comments inline:
> >
> > On Tue, Oct 15, 2019 at 10:13 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Fri, Sep 06, 2019 at 09:28:13AM +0530, Abhishek Shah wrote:
> > > > Invalidate PAXB inbound/outbound address mapping each time before
> > > > programming it. This is helpful for the cases where we need to
> > > > reprogram inbound/outbound address mapping without resetting PAXB.
> > > > kexec kernel is one such example.
> > >
> > > This looks like a hack, explain to us please what it actually solves and
> > > why a full reset is not necessary.
> > >
> > The PAXB IP performs address translation(PCI<->AXI address) for both inbound and
> > outbound addresses (amongst other things) based on version of IP being used.
> > It does so using the IMAP/IARR/OMAP/OARR registers.
> >
> > These registers get programmed as per mappings specified in device tree during
> > PCI driver probe for each RC and do not get reset when kexec/kdump kernel boots.
> > This results in driver assuming valid mappings in place for some mapping windows
> > during kexec/kdump kernel boot, consequently it skips those windows and
> > we run out of available mapping windows, leading to mapping failure.
> >
> > Normally, we take care of resetting PAXB block in firmware, but in
> > primary kernel to kexec/kdump kernel handover, no firmware is executed
> > in between.  So, we just, by default, invalidate the mapping registers
> > each time before
> > programming them to solve the issue described above..
> > We do not need full reset for handling this.
>
> I see. A simple bitmap to detect which windows are *actually*
> programmed by the current kernel (that can be used by
>
> iproc_pcie_ob_is_valid()
>
> to carry out a valid check) would do as well instead of having to
> invalidate all the OB registers.
>
Okay, so you are suggesting to use variable/bitmap to hold status of
ib/ob windows (mapped/unmapped)
instead of using registers to check it. Please note that we would
still be programming corresponding
window register to mark it valid (HW requirement).

@Ray, could you please provide feedback on this? I think existing way
is proper for given driver design.

Also, as internal review tags are irrelevant as suggested by Lorenzo earlier,
could you please put sign again once reviewed?


Regards,
Abhishek

> It is up to you, let me know and I will merge code accordingly.
>
> Lorenzo
>
> > > > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > > Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
> > >
> > > Patches are reviewed on public mailing lists, remove tags given
> > > on internal reviews - they are not relevant.
> > >
> > Ok, will remove.
> >
> > > > ---
> > > >  drivers/pci/controller/pcie-iproc.c | 28 ++++++++++++++++++++++++++++
> > > >  1 file changed, 28 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > > index e3ca46497470..99a9521ba7ab 100644
> > > > --- a/drivers/pci/controller/pcie-iproc.c
> > > > +++ b/drivers/pci/controller/pcie-iproc.c
> > > > @@ -1245,6 +1245,32 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> > > >       return ret;
> > > >  }
> > > >
> > > > +static void iproc_pcie_invalidate_mapping(struct iproc_pcie *pcie)
> > > > +{
> > > > +     struct iproc_pcie_ib *ib = &pcie->ib;
> > > > +     struct iproc_pcie_ob *ob = &pcie->ob;
> > > > +     int idx;
> > > > +
> > > > +     if (pcie->ep_is_internal)
> > >
> > > What's this check for and why leaving mappings in place is safe for
> > > this category of IPs ?
> > For this category of IP(PAXC), no mappings need to be programmed in
> > the first place.
> >
> > >
> > > > +             return;
> > > > +
> > > > +     if (pcie->need_ob_cfg) {
> > > > +             /* iterate through all OARR mapping regions */
> > > > +             for (idx = ob->nr_windows - 1; idx >= 0; idx--) {
> > > > +                     iproc_pcie_write_reg(pcie,
> > > > +                                          MAP_REG(IPROC_PCIE_OARR0, idx), 0);
> > > > +             }
> > > > +     }
> > > > +
> > > > +     if (pcie->need_ib_cfg) {
> > > > +             /* iterate through all IARR mapping regions */
> > > > +             for (idx = 0; idx < ib->nr_regions; idx++) {
> > > > +                     iproc_pcie_write_reg(pcie,
> > > > +                                          MAP_REG(IPROC_PCIE_IARR0, idx), 0);
> > > > +             }
> > > > +     }
> > > > +}
> > > > +
> > > >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
> > > >                              struct device_node *msi_node,
> > > >                              u64 *msi_addr)
> > > > @@ -1517,6 +1543,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> > > >       iproc_pcie_perst_ctrl(pcie, true);
> > > >       iproc_pcie_perst_ctrl(pcie, false);
> > > >
> > > > +     iproc_pcie_invalidate_mapping(pcie);
> > >
> > > It makes more sense to call this in the .shutdown() method if I
> > > understand what it does.
> > >
> > It would work for kexec kernel, but not for kdump kernel as only for
> > kexec'ed kernel,
> > "device_shutdown" callback is present. We are here taking care of both the cases
> > with this patch.
> >
> >
> > Regards,
> > Abhishek
> >
> > > Lorenzo
> > >
> > > >       if (pcie->need_ob_cfg) {
> > > >               ret = iproc_pcie_map_ranges(pcie, res);
> > > >               if (ret) {
> > > > --
> > > > 2.17.1
> > > >
