Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7114EDB00E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 16:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfJQO2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 10:28:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52469 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbfJQO2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 10:28:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so2804784wmh.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2019 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2aBeWNRxDtTRHfUI9htMJzW/AtuitZvg8GIzAAl28Q=;
        b=dBe6YjaxoHZnJhbTRjkiiW25KskKFuyEEzNZwJ3xB0fHdrmMgZNiXJ0YOJz+a9Edna
         SxqTulViehkQ8MxhZ1JzcAs/0ag5fwwYrZZag4c9ffQFKCW1lCuRXqmzkWQwOGWg0d6V
         ISljxqOj7xejKJGlCLKqFiRnbm9LJcvM4v4nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2aBeWNRxDtTRHfUI9htMJzW/AtuitZvg8GIzAAl28Q=;
        b=RNuqORwBtwyKWCDru8Zkrbystq2j05mQTdfgHpb0Hh8DZBmZ1TD+6xXhUGLsvR6pgH
         pDkG2Q+ZgPmQCGDavIIj7rfqnH3N+SivK5wvtQtL2U4bPUK+sZoE9eKAxymUHx/RYMwK
         1HsPtp7oQ6qe41nT1h2G0qkAvbXSjO4nJwj08BCTADYU4wxyUCTsycR7yrvILMXFDoss
         BxCMYpM8l03gS9hxGXP5BP5ZAtOEktlGqlGIP/MS17+hoVzTN4NflZklsyYUwd6oy6c4
         YYKHD3giNG4ngITH5zWZGlkMLW8dYbSf9ZBDSeJciN2XCrr0whI4icf5aMKmCFa8xj/1
         n3ow==
X-Gm-Message-State: APjAAAVa2PjayrrauXnCVQjvKtaub9zuFBOJLI1QcCmJpywl8rbPIKf7
        HOR40HFTL6lRkSRdtgqxrWIHwjQNwgubNdP77kHfqw==
X-Google-Smtp-Source: APXvYqw1AUbLjfiWzfHvCBnmIR1upVknDfmaHDyI/L5HIOSueUVlPr33+tGstbzFvY6ybaVHvFP6LjdMT4TIIKsBc+g=
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr3107079wmc.108.1571322488120;
 Thu, 17 Oct 2019 07:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190906035813.24046-1-abhishek.shah@broadcom.com> <20191015164303.GC25674@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191015164303.GC25674@e121166-lin.cambridge.arm.com>
From:   Abhishek Shah <abhishek.shah@broadcom.com>
Date:   Thu, 17 Oct 2019 19:57:56 +0530
Message-ID: <CAKUFe6bQPMirQ01s-ezaQcUU85J+moFKMO8sLZgvtG2EPowrGA@mail.gmail.com>
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

Hi Lorenzo,

Please see my comments inline:

On Tue, Oct 15, 2019 at 10:13 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Sep 06, 2019 at 09:28:13AM +0530, Abhishek Shah wrote:
> > Invalidate PAXB inbound/outbound address mapping each time before
> > programming it. This is helpful for the cases where we need to
> > reprogram inbound/outbound address mapping without resetting PAXB.
> > kexec kernel is one such example.
>
> This looks like a hack, explain to us please what it actually solves and
> why a full reset is not necessary.
>
The PAXB IP performs address translation(PCI<->AXI address) for both inbound and
outbound addresses (amongst other things) based on version of IP being used.
It does so using the IMAP/IARR/OMAP/OARR registers.

These registers get programmed as per mappings specified in device tree during
PCI driver probe for each RC and do not get reset when kexec/kdump kernel boots.
This results in driver assuming valid mappings in place for some mapping windows
during kexec/kdump kernel boot, consequently it skips those windows and
we run out of available mapping windows, leading to mapping failure.

Normally, we take care of resetting PAXB block in firmware, but in
primary kernel
to kexec/kdump kernel handover, no firmware is executed in between.
So, we just, by default, invalidate the mapping registers each time before
programming them to solve the issue described above..
We do not need full reset for handling this.

> > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
>
> Patches are reviewed on public mailing lists, remove tags given
> on internal reviews - they are not relevant.
>
Ok, will remove.

> > ---
> >  drivers/pci/controller/pcie-iproc.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index e3ca46497470..99a9521ba7ab 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -1245,6 +1245,32 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> >       return ret;
> >  }
> >
> > +static void iproc_pcie_invalidate_mapping(struct iproc_pcie *pcie)
> > +{
> > +     struct iproc_pcie_ib *ib = &pcie->ib;
> > +     struct iproc_pcie_ob *ob = &pcie->ob;
> > +     int idx;
> > +
> > +     if (pcie->ep_is_internal)
>
> What's this check for and why leaving mappings in place is safe for
> this category of IPs ?
For this category of IP(PAXC), no mappings need to be programmed in
the first place.

>
> > +             return;
> > +
> > +     if (pcie->need_ob_cfg) {
> > +             /* iterate through all OARR mapping regions */
> > +             for (idx = ob->nr_windows - 1; idx >= 0; idx--) {
> > +                     iproc_pcie_write_reg(pcie,
> > +                                          MAP_REG(IPROC_PCIE_OARR0, idx), 0);
> > +             }
> > +     }
> > +
> > +     if (pcie->need_ib_cfg) {
> > +             /* iterate through all IARR mapping regions */
> > +             for (idx = 0; idx < ib->nr_regions; idx++) {
> > +                     iproc_pcie_write_reg(pcie,
> > +                                          MAP_REG(IPROC_PCIE_IARR0, idx), 0);
> > +             }
> > +     }
> > +}
> > +
> >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
> >                              struct device_node *msi_node,
> >                              u64 *msi_addr)
> > @@ -1517,6 +1543,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> >       iproc_pcie_perst_ctrl(pcie, true);
> >       iproc_pcie_perst_ctrl(pcie, false);
> >
> > +     iproc_pcie_invalidate_mapping(pcie);
>
> It makes more sense to call this in the .shutdown() method if I
> understand what it does.
>
It would work for kexec kernel, but not for kdump kernel as only for
kexec'ed kernel,
"device_shutdown" callback is present. We are here taking care of both the cases
with this patch.


Regards,
Abhishek

> Lorenzo
>
> >       if (pcie->need_ob_cfg) {
> >               ret = iproc_pcie_map_ranges(pcie, res);
> >               if (ret) {
> > --
> > 2.17.1
> >
