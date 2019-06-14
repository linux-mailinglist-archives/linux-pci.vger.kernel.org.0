Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF52A45538
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfFNHJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 03:09:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37500 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNHJG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 03:09:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so1278980ljf.4
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2019 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxfyM6IErwzUuZQc4rX6nb5MYVBMEiaUIJAOhGRqMq4=;
        b=BFQ7n7ZxnDJCfw3InVQV8Lykl7mTzTO/uKjfT68koQImu8DCSUAFvWIamSHmM+uW7E
         GZVxCsJcMdhXyWOdvsBS8286msfvR4ZWO78pNH0mqpSacM6BftYDWL1xMkdIh7w9MiX3
         3tb2/ogsbdl7Lw2YtiCBHiD3UaatAaBTKNvM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxfyM6IErwzUuZQc4rX6nb5MYVBMEiaUIJAOhGRqMq4=;
        b=W7kbYvFIHv6oc/dO2DZ8RsjDMFtZx5mX2PKCwiqw0eJo+x/k/TyXG4CZRRLOXF4v/F
         2RN/nCFAqmyIaMY7u03q94OK+DnUiKyYoY8o6ifapxpn9yPFH1KJkVHNYuFMr3C3oTyT
         uWkMohdeO2BHCPzXpi/dvoDohF8Y60JqzDHv9n7bY8SIWla8IY4R+dmYS+HehVKH6cN4
         kzVIBEhIdSyu04X/+ca+Yf45/FBYzHA6OGGyIjo+HGaFNZ7t+ORNYSIdM9PqTq/fFKt0
         ldyD7MIQ0BWiM5kUeLWYP+yvoJw92LzEkLCKKd52hNPfuEP3COdYO0wSS/ChdLEcFonY
         /ZBQ==
X-Gm-Message-State: APjAAAUp4BxujB3EDZDfqDXBn/UPX+HSN5roR41ZvWlmQ4MF5OxKvTOh
        7eh0zs3s+fDDHNTUm3Z+dVwCUTftFThUokQrYAmk4GaIXT980Em2tyvpDrlplNAOhYSXRaNyEBm
        MAKudLHCctV9+lc9UrDyy6glunh2GRQ==
X-Google-Smtp-Source: APXvYqygzgKoulB56EW6IgCZUnp+so8s8umG4AYyfJaRVIp1tDhleNADbz8MqdlwR5Bohv/3k4ORVDx+UFQFAkoJJWU=
X-Received: by 2002:a2e:760f:: with SMTP id r15mr34139345ljc.18.1560496143737;
 Fri, 14 Jun 2019 00:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com> <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
 <20190612150819.GD15747@redmoon>
In-Reply-To: <20190612150819.GD15747@redmoon>
From:   Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Date:   Fri, 14 Jun 2019 12:38:51 +0530
Message-ID: <CAKnKUHFMH6=ox=qdaUR1kNEhETDCVyu3jQZEj+taEbbMRBRuYA@mail.gmail.com>
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

Hi Lorenzo and Hou Zhiqiang
 PAB_INTP_AMBA_MISC_STAT does have other status in the higher bits, it
should have been masked before checking for the status

Acked-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>

On Wed, Jun 12, 2019 at 8:38 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Apr 12, 2019 at 08:36:12AM +0000, Z.q. Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > In the loop block, there is not code to update the loop key,
> > this patch updates the loop key by re-read the INTx status
> > register.
> >
> > This patch also add the clearing of the handled INTx status.
> >
> > Note: Need MV to test this fix.
>
> This means INTX were never tested and current code handling them is,
> AFAICS, an infinite loop which is very very bad.
>
> This is a gross bug and must be fixed as soon as possible.
>
> I want Karthikeyan ACK and Tested-by on this patch.
>
> Lorenzo
>
> > Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > ---
> > V5:
> >  - Corrected and retouched the subject and changelog.
> >
> >  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> > index 4ba458474e42..78e575e71f4d 100644
> > --- a/drivers/pci/controller/pcie-mobiveil.c
> > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> >       /* Handle INTx */
> >       if (intr_status & PAB_INTP_INTX_MASK) {
> >               shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> > +             shifted_status &= PAB_INTP_INTX_MASK;
> >               shifted_status >>= PAB_INTX_START;
> >               do {
> >                       for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> > @@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> >                                       dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
> >                                                           bit);
> >
> > -                             /* clear interrupt */
> > -                             csr_writel(pcie,
> > -                                        shifted_status << PAB_INTX_START,
> > +                             /* clear interrupt handled */
> > +                             csr_writel(pcie, 1 << (PAB_INTX_START + bit),
> >                                          PAB_INTP_AMBA_MISC_STAT);
> >                       }
> > -             } while ((shifted_status >> PAB_INTX_START) != 0);
> > +
> > +                     shifted_status = csr_readl(pcie,
> > +                                                PAB_INTP_AMBA_MISC_STAT);
> > +                     shifted_status &= PAB_INTP_INTX_MASK;
> > +                     shifted_status >>= PAB_INTX_START;
> > +             } while (shifted_status != 0);
> >       }
> >
> >       /* read extra MSI status register */
> > --
> > 2.17.1
> >



-- 
Thanks,
Regards,
Karthikeyan Mitran

-- 
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
attachments, is for the sole use of the intended recipient(s) and may 
contain proprietary confidential or privileged information or otherwise be 
protected by law. Any unauthorized review, use, disclosure or distribution 
is prohibited. If you are not the intended recipient, please notify the 
sender and destroy all copies and the original message.
