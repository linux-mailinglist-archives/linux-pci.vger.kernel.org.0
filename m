Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B544DAB4DA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392897AbfIFJZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 05:25:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39846 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIFJZd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2019 05:25:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so5791071wra.6
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2019 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/hTF78iK4Cpd1QxROMccGOHzNHaxmbPis/cOP5u7Xg=;
        b=eKLzvu2MGA64vk98hhxrKNuyKWibjjWUbKiy08K4iRsX1Co7AIxiUbclqeXzsnCFIu
         IWvBUrh2iX8dSC1MP4TPJdmTs5Hh1NJEcr3hwmC88o+E9iYYFLSjyxH0ZOTOLFrt3f9l
         16xmIXG1pm8YAmLbpt11SbjP/akgC3ruX5yVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/hTF78iK4Cpd1QxROMccGOHzNHaxmbPis/cOP5u7Xg=;
        b=TTYzMQIAyqGEF/gAOTvxA/3NDhxHiggyVNJz4m+W0IxWF94WaVvGwY3YbtNP+VTuU6
         ce8t2zdAWoe7NNRKnZ1J62s/TxXxuBFrOd8ScBntkToQaQ4KXFADIlAqstUEImlqCquB
         af7tO7p69hCkMQTrZ2iruEsnMZX9QrtUlEmoKdFWt3EC/OI0zD8V2L0xatKLunlAsrwL
         SdCQLUSffI2L+rBp1nZGj4d/Yi1ndFMlLGGYDXqVnc/x3l3lJWE52zzRqAQuezklGsuL
         dBTw06d6ZWVIWorkaTCC4uRBt6RiWR+90JUEkToCwKRerD/oRdA8CICh8hwaHmmLTaMa
         I6Fg==
X-Gm-Message-State: APjAAAW2ur6phI9i0aOS4ssxZYr+hm0hNCWMloT7lRcionWsCESPSCgv
        ZRfpUAQKwwjZ3GHzsLBSY6GuMA8u1FlRy7LX4e/n4g==
X-Google-Smtp-Source: APXvYqwbU+XGTguORWihC8VnYu09/9mUmdttn0D/6NQhpn7lEMS/E0pN0mR6XPsaf0hc7khzR2EiaXrcqpuqhy9wNdY=
X-Received: by 2002:adf:dd04:: with SMTP id a4mr6298846wrm.340.1567761930632;
 Fri, 06 Sep 2019 02:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190906035813.24046-1-abhishek.shah@broadcom.com> <20190906083816.GD9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190906083816.GD9720@e119886-lin.cambridge.arm.com>
From:   Abhishek Shah <abhishek.shah@broadcom.com>
Date:   Fri, 6 Sep 2019 14:55:19 +0530
Message-ID: <CAKUFe6ZuRGJSmLdXqTWJzX-nE_Vh4yEQF_-rf+BWFrD_r4BRaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: iproc: Invalidate PAXB address mapping before
 programming it
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
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

Hi Andrew,

Thanks for the review. Please see my response inline:

On Fri, Sep 6, 2019 at 2:08 PM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Fri, Sep 06, 2019 at 09:28:13AM +0530, Abhishek Shah wrote:
> > Invalidate PAXB inbound/outbound address mapping each time before
> > programming it. This is helpful for the cases where we need to
> > reprogram inbound/outbound address mapping without resetting PAXB.
> > kexec kernel is one such example.
>
> Why is this approach better than resetting the PAXB (I assume that's
> the PCI controller IP)? Wouldn't resetting the PAXB address this issue,
> and ensure that no other configuration is left behind?
>
We normally reset PAXB in the firmware(ATF). But for cases like kexec
kernel boot,
we do not execute any firmware code and directly boot into kernel.

We could have done PAXB reset in the driver itself as you have suggested here.
But note that this detail could vary for each SoC, because these
registers are not part
of PAXB register space itself, rather exists in a register space responsible for
controlling power to various wrappers in PCIe IP. Normally, this kind
of SoC specific
details are handled in firmware itself, we don't bring them to driver level.

> Or is this related to earlier boot stages loading firmware for the emulated
> downstream endpoints (ep_is_internal)?
>
> Finally, in the case where ep_is_internal do you need to disable anything
> prior to invalidating the mappings?
>
No, ep_is_internal  is indicator for PAXC IP. It does not have
mappings as in PAXB.


Regards,
Abhishek
> >
> > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
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
> > +
> >       if (pcie->need_ob_cfg) {
> >               ret = iproc_pcie_map_ranges(pcie, res);
> >               if (ret) {
>
> The code changes look good to me.
>
> Thanks,
>
> Andrew Murray
>
> > --
> > 2.17.1
> >
