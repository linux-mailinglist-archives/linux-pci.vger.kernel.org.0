Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3332D18391F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 20:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgCLTCF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 15:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgCLTCF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 15:02:05 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FA9206EB;
        Thu, 12 Mar 2020 19:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584039724;
        bh=SlkhTmsxIrlEojuXYKZBatDWX41BUd/qNHIhRRSgdNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HduS9YsRfFqHiD9D0BPFGNc9LGRdKIq7LV4bMwx9D9gKIHDZxIv/oUpKkgvfT0MgW
         2uLGu6gw8Wb7hWtlyDfCCyO6K8lu2T2oRjF49qzR2Nu9THEDcZBV03OO8o9hb2jBdo
         OB5TeC/AUJleYP6rcDcjWO1p43gbpGkMcyytIQB8=
Date:   Thu, 12 Mar 2020 14:02:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aman Sharma <amanharitsh123@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] pci: handled return value of platform_get_irq
 correctly
Message-ID: <20200312190202.GA110276@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYv0U0RmT7snp+UejEXecq4wLkhc11DUniUfGYAgyXC=A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc, Thomas]

Hi Linus,

On Thu, Mar 12, 2020 at 03:07:58PM +0100, Linus Walleij wrote:
> On Wed, Mar 11, 2020 at 8:19 PM Aman Sharma <amanharitsh123@gmail.com> wrote:
> > Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
> > ---
> >  drivers/pci/controller/pci-v3-semi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> > index bd05221f5a22..a5bf945d2eda 100644
> > --- a/drivers/pci/controller/pci-v3-semi.c
> > +++ b/drivers/pci/controller/pci-v3-semi.c
> > @@ -777,9 +777,9 @@ static int v3_pci_probe(struct platform_device *pdev)
> >
> >         /* Get and request error IRQ resource */
> >         irq = platform_get_irq(pdev, 0);
> > -       if (irq <= 0) {
> > +       if (irq < 0) {
> 
> Have you considered:
> https://lwn.net/Articles/470820/
> 
> TL;DR Linus (both of them) are not with you on this.
> 
> And that is why the code is written like this.

I'm not sure I understand you here, so please correct me when I go in
the weeds.  I guess you're saying that platform_get_irq() can return
0 here and we should treat that as an error?

This particular driver seems to be ARM-specific -- does that mean we
need to check for 0 on some arches but not others?  That would
definitely be suboptimal, and that's what I'd like to fix here.

IIUC, in the link you mentioned, Linus T says that "dev->irq == 0"
means we don't have a valid IRQ.  I think that makes sense, but I'm
not sure it follows that 0 must be a sensical return value for
platform_get_irq().  It seems to me that platform_get_irq() ought to
return either a valid IRQ or an error, and the convention for errors
is a negative errno.

In fact, the platform_get_irq() function comment says it returns "IRQ
number on success, negative error number on failure."  If we need to
interpret 0 as an error on some arches, it sounds like something is
wrong in the arch-specific bowels of platform_get_irq().

If platform_get_irq() returns an error, a driver might want to
continue in polled mode without IRQs, in which case it could set its
"dev->irq = 0" to indicate that it has no valid IRQ.  But I think we
might be able to separate that "stored IRQ" situation from the
platform_get_irq() interface.

Bjorn
