Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734AE183280
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 15:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCLOLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 10:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCLOLF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 10:11:05 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10BBE206E7;
        Thu, 12 Mar 2020 14:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584022264;
        bh=R/lnE+ckVywNCWcx1gHvO2Mh70J2f5SW32TxuQf+zGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=arv7/+jvUj9iJWfWlYdgqEG39OScPnVN8+yN/RSHbmQJwGazVMLlVu+Tctn3gdPTX
         FNdntEiwli27ScYUOBN6gfOPY6ZhjBhMcMl/D3RquqPL+Y8s6k9qxCCbZiR8x3ervB
         d5gWiTZ8T/wMs4bdrTy0xx25QCxA3drilWiFDdc0=
Date:   Thu, 12 Mar 2020 09:11:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Aman Sharma <amanharitsh123@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 4/5] pci: handled return value of platform_get_irq
 correctly
Message-ID: <20200312141102.GA93224@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e413f63-06e3-9613-97dc-ff5968a4f759@free.fr>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc another Marc]

On Thu, Mar 12, 2020 at 10:53:06AM +0100, Marc Gonzalez wrote:
> On 11/03/2020 20:19, Aman Sharma wrote:
> 
> > diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
> > index 21a208da3f59..18c2c4313eb5 100644
> > --- a/drivers/pci/controller/pcie-tango.c
> > +++ b/drivers/pci/controller/pcie-tango.c
> > @@ -273,9 +273,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
> >  		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
> >  
> >  	virq = platform_get_irq(pdev, 1);
> > -	if (virq <= 0) {
> > +	if (virq < 0) {
> >  		dev_err(dev, "Failed to map IRQ\n");
> > -		return -ENXIO;
> > +		return virq;
> >  	}
> >  
> >  	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
> 
> Weee, here we go again :-)
> 
> https://patchwork.kernel.org/patch/11066455/
> https://patchwork.kernel.org/patch/10006651/
> 
> Last time around, my understanding was that, going forward,
> the best solution was:
> 
> 	virq = platform_get_irq(...)
> 	if (virq <= 0)
> 		return virq ? : -ENODEV;
> 
> i.e. map 0 to -ENODEV, pass other errors as-is, remove the dev_err
> 
> @Bjorn/Lorenzo did you have a change of heart?

Yes.  In 10006651 (Oct 20, 2017), I thought:

  irq = platform_get_irq(pdev, 0);
  if (irq <= 0)
    return -ENODEV;

was fine.  In 11066455 (Aug 7, 2019), I said I thought I was wrong and
that:

  platform_get_irq() is a generic interface and we have to be able to
  interpret return values consistently.  The overwhelming consensus
  among platform_get_irq() callers is to treat "irq < 0" as an error,
  and I think we should follow suit.
  ...
  I think the best pattern is:

    irq = platform_get_irq(pdev, i);
    if (irq < 0)
      return irq;

I still think what I said in 2019 is the right approach.  I do see
your comment in 10006651 about this pattern:

  if (virq <= 0)
    return virq ? : -ENODEV;

but IMHO it's too complicated for general use.  Admittedly, it's not
*very* complicated, but it's a relatively unusual C idiom and I
stumble over it every time I see it.  If 0 is a special case I think
it should be mapped to a negative error in arch-specific code, which I
think is what Linus T suggested in [1].

I think there's still a large consensus that "irq < 0" is the error
case.  In the tree today we have about 1400 callers of
platform_get_irq() and platform_get_irq_byname() [2].  Of those,
almost 900 check for "irq < 0" [3], while only about 150 check for
"irq <= 0" [4] and about 15 use some variant of a "irq ? : -ENODEV"
pattern.

The bottom line is that in drivers/pci, I'd like to see either a
single style or a compelling argument for why some checks should be
"irq < 0" and others should be "irq <= 0".

[1] https://yarchive.net/comp/linux/zero.html
[2] $ git grep "=.*platform_get_irq" | wc -l
    1422
[3] $ git grep -A4 "=.*platform_get_irq" | grep "<\s*0" | wc -l
    894
[4] $ git grep -A4 "=.*platform_get_irq" | grep "<=\s*0" | wc -l
    151
[5] $ git grep -A4 "=.*platform_get_irq" | grep "return.*?.*:.*;" | wc -l
    15
