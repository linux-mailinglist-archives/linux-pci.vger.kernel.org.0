Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572204B166
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 07:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfFSF3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 01:29:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34323 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbfFSF3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 01:29:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so1958137ljg.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2019 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCUAPV+QexPTMtFpELNiq1RlIWLicRq4oH7TLWUppok=;
        b=06W/Y3cSZGK9qGdIkrRKae6GS83CtZgvcpLyiEYX/CH8oiz2QMNEnRHq9tkOe8Vhlv
         AaYmyZRoz+2JGbAkSTfAL+lYDZe+EKPXLD87Ug+rDiga9JVBb1lAfYm/OHzqIe7QQ4sg
         GNFRhx6EP/7BdHkzpUDQfWkORZMvcOicpDZ60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCUAPV+QexPTMtFpELNiq1RlIWLicRq4oH7TLWUppok=;
        b=DyukwAe8YPedYkZK4RL76zZ+O7OlOOuYGKdpOps7jPo+VuPL1Z4TScPdJ/dnc0GyrR
         oaIWK5NjemeairhbmkSwlXWRd1ab6ePhPr5OJQE+VNZXs3PqD0NvVJ9JGYYZeNxa6nig
         H7gz4mzeyZFxCQrPYSzjJN9yho2pHmRTtS0eiSF59NHBTvfN6WZBQ3XkuymQ27+MKMyS
         PHyomcjTTkBsFvoSmYfkDaC21GShq7RUm05VHGvaEMlJG1JY4UxX9EsbshtNiKoDhJWy
         s93Ogd3wyIUlVsZ2KpOZGsh9/mKp27QNBq/ZKF4EuMtOuVboCQni/YFzHiVzh7JZMaMS
         xhyw==
X-Gm-Message-State: APjAAAXp6s33kQXSlM3nq0ziBJd6voiapB/ZtNY7q7dAWwOwt01ltROS
        ck8e7E3FMiAUvTva3xDihglXQ3+eyyzQew5OFmGxFLYK2Spiuv3EsgLXEsM5KVkNNgE3j8cgxsE
        h7wvayU/FE3IrCHfWufHDj2PHFFopbQ==
X-Google-Smtp-Source: APXvYqzKCWyYVYljVoUu5JGomTGSMvq1652NRLfxnluH9rE+ab0jIubi+Ogd2Mw26Jaq0Y4Uxj/yFkRHTtCXrWX8zDQ=
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr22630705ljj.156.1560922141583;
 Tue, 18 Jun 2019 22:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com> <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
 <20190612150819.GD15747@redmoon> <CAKnKUHFMH6=ox=qdaUR1kNEhETDCVyu3jQZEj+taEbbMRBRuYA@mail.gmail.com>
 <20190614104351.GA29955@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190614104351.GA29955@e121166-lin.cambridge.arm.com>
From:   Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Date:   Wed, 19 Jun 2019 10:58:49 +0530
Message-ID: <CAKnKUHHTAsjMoMkqaWq5z6r30JUGCpxSaYwyp8AuE3H5R0vBig@mail.gmail.com>
Subject: Re: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 4:14 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Jun 14, 2019 at 12:38:51PM +0530, Karthikeyan Mitran wrote:
> > Hi Lorenzo and Hou Zhiqiang
> >  PAB_INTP_AMBA_MISC_STAT does have other status in the higher bits, it
> > should have been masked before checking for the status
>
> You are the maintainer for this driver, so if there is something to be
> changed you must post a patch to that extent, I do not understand what
> the above means, write the code to fix it, I won't do it.
>
> I am getting a bit annoyed with this Mobiveil driver so either you guys
> sort this out or I will have to remove it from the kernel.
>
> > Acked-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
>
> Ok I assume this means you tested it but according to what you
> say above, are there still issues with this code path ? Should
> we update the patch ?
Tested-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
This patch fixes the INTx status extraction and handling,
I don't see any need to update this patch.
>
> Moreover:
>
> https://kernelnewbies.org/PatchCulture
>
> Please read it and never top-post.
Thank you very much, for the information.

>
> Thanks,
> Lorenzo
>
> > On Wed, Jun 12, 2019 at 8:38 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Fri, Apr 12, 2019 at 08:36:12AM +0000, Z.q. Hou wrote:
> > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > >
> > > > In the loop block, there is not code to update the loop key,
> > > > this patch updates the loop key by re-read the INTx status
> > > > register.
> > > >
> > > > This patch also add the clearing of the handled INTx status.
> > > >
> > > > Note: Need MV to test this fix.
> > >
> > > This means INTX were never tested and current code handling them is,
> > > AFAICS, an infinite loop which is very very bad.
> > >
> > > This is a gross bug and must be fixed as soon as possible.
> > >
> > > I want Karthikeyan ACK and Tested-by on this patch.
> > >
> > > Lorenzo
> > >
> > > > Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> > > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > > > Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > > > ---
> > > > V5:
> > > >  - Corrected and retouched the subject and changelog.
> > > >
> > > >  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
> > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> > > > index 4ba458474e42..78e575e71f4d 100644
> > > > --- a/drivers/pci/controller/pcie-mobiveil.c
> > > > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > > > @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> > > >       /* Handle INTx */
> > > >       if (intr_status & PAB_INTP_INTX_MASK) {
> > > >               shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> > > > +             shifted_status &= PAB_INTP_INTX_MASK;
> > > >               shifted_status >>= PAB_INTX_START;
> > > >               do {
> > > >                       for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> > > > @@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> > > >                                       dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
> > > >                                                           bit);
> > > >
> > > > -                             /* clear interrupt */
> > > > -                             csr_writel(pcie,
> > > > -                                        shifted_status << PAB_INTX_START,
> > > > +                             /* clear interrupt handled */
> > > > +                             csr_writel(pcie, 1 << (PAB_INTX_START + bit),
> > > >                                          PAB_INTP_AMBA_MISC_STAT);
> > > >                       }
> > > > -             } while ((shifted_status >> PAB_INTX_START) != 0);
> > > > +
> > > > +                     shifted_status = csr_readl(pcie,
> > > > +                                                PAB_INTP_AMBA_MISC_STAT);
> > > > +                     shifted_status &= PAB_INTP_INTX_MASK;
> > > > +                     shifted_status >>= PAB_INTX_START;
> > > > +             } while (shifted_status != 0);
> > > >       }
> > > >
> > > >       /* read extra MSI status register */
> > > > --
> > > > 2.17.1
> > > >
> >
> >
> >
> >

-- 
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
attachments, is for the sole use of the intended recipient(s) and may 
contain proprietary confidential or privileged information or otherwise be 
protected by law. Any unauthorized review, use, disclosure or distribution 
is prohibited. If you are not the intended recipient, please notify the 
sender and destroy all copies and the original message.
