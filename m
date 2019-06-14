Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D995D45AD0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 12:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfFNKoP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 06:44:15 -0400
Received: from foss.arm.com ([217.140.110.172]:59374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfFNKoP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 06:44:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A7262B;
        Fri, 14 Jun 2019 03:44:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D936F3F246;
        Fri, 14 Jun 2019 03:45:55 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:43:59 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
Message-ID: <20190614104351.GA29955@e121166-lin.cambridge.arm.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
 <20190612150819.GD15747@redmoon>
 <CAKnKUHFMH6=ox=qdaUR1kNEhETDCVyu3jQZEj+taEbbMRBRuYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKnKUHFMH6=ox=qdaUR1kNEhETDCVyu3jQZEj+taEbbMRBRuYA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 12:38:51PM +0530, Karthikeyan Mitran wrote:
> Hi Lorenzo and Hou Zhiqiang
>  PAB_INTP_AMBA_MISC_STAT does have other status in the higher bits, it
> should have been masked before checking for the status

You are the maintainer for this driver, so if there is something to be
changed you must post a patch to that extent, I do not understand what
the above means, write the code to fix it, I won't do it.

I am getting a bit annoyed with this Mobiveil driver so either you guys
sort this out or I will have to remove it from the kernel.

> Acked-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>

Ok I assume this means you tested it but according to what you
say above, are there still issues with this code path ? Should
we update the patch ?

Moreover:

https://kernelnewbies.org/PatchCulture

Please read it and never top-post.

Thanks,
Lorenzo

> On Wed, Jun 12, 2019 at 8:38 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Fri, Apr 12, 2019 at 08:36:12AM +0000, Z.q. Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > In the loop block, there is not code to update the loop key,
> > > this patch updates the loop key by re-read the INTx status
> > > register.
> > >
> > > This patch also add the clearing of the handled INTx status.
> > >
> > > Note: Need MV to test this fix.
> >
> > This means INTX were never tested and current code handling them is,
> > AFAICS, an infinite loop which is very very bad.
> >
> > This is a gross bug and must be fixed as soon as possible.
> >
> > I want Karthikeyan ACK and Tested-by on this patch.
> >
> > Lorenzo
> >
> > > Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > > Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > > ---
> > > V5:
> > >  - Corrected and retouched the subject and changelog.
> > >
> > >  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> > > index 4ba458474e42..78e575e71f4d 100644
> > > --- a/drivers/pci/controller/pcie-mobiveil.c
> > > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > > @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> > >       /* Handle INTx */
> > >       if (intr_status & PAB_INTP_INTX_MASK) {
> > >               shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> > > +             shifted_status &= PAB_INTP_INTX_MASK;
> > >               shifted_status >>= PAB_INTX_START;
> > >               do {
> > >                       for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> > > @@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> > >                                       dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
> > >                                                           bit);
> > >
> > > -                             /* clear interrupt */
> > > -                             csr_writel(pcie,
> > > -                                        shifted_status << PAB_INTX_START,
> > > +                             /* clear interrupt handled */
> > > +                             csr_writel(pcie, 1 << (PAB_INTX_START + bit),
> > >                                          PAB_INTP_AMBA_MISC_STAT);
> > >                       }
> > > -             } while ((shifted_status >> PAB_INTX_START) != 0);
> > > +
> > > +                     shifted_status = csr_readl(pcie,
> > > +                                                PAB_INTP_AMBA_MISC_STAT);
> > > +                     shifted_status &= PAB_INTP_INTX_MASK;
> > > +                     shifted_status >>= PAB_INTX_START;
> > > +             } while (shifted_status != 0);
> > >       }
> > >
> > >       /* read extra MSI status register */
> > > --
> > > 2.17.1
> > >
> 
> 
> 
> -- 
> Thanks,
> Regards,
> Karthikeyan Mitran
> 
> -- 
> Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
> attachments, is for the sole use of the intended recipient(s) and may 
> contain proprietary confidential or privileged information or otherwise be 
> protected by law. Any unauthorized review, use, disclosure or distribution 
> is prohibited. If you are not the intended recipient, please notify the 
> sender and destroy all copies and the original message.
