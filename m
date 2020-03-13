Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A2318516C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 22:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCMV4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 17:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgCMV4p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 17:56:45 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D012074E;
        Fri, 13 Mar 2020 21:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584136604;
        bh=9O3iTubGfZzMntn4/LYM5c2/iBnmaQdlBrLdH9sNka0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cGwnI/g5mqZKrZocmKyebIRUAXd9e+X/FWCRYP5pMFRVDyg9jjtoGFmEaF7Zyj+Fa
         tH0B7K42/EpeIAb6FNX3DzbuRb9Zsi5ujH7RZ1yIstubErjjVFm+jYNh7Qr3VA2FLZ
         uVllTIs25LDNGiev2L2gK5nLkQrjFRrImlhC7NTM=
Date:   Fri, 13 Mar 2020 16:56:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Aman Sharma <amanharitsh123@gmail.com>,
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
Message-ID: <20200313215642.GA202015@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rpwhsnd.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 13, 2020 at 10:05:58PM +0100, Thomas Gleixner wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Thu, Mar 12, 2020 at 10:53:06AM +0100, Marc Gonzalez wrote:
> >> Last time around, my understanding was that, going forward,
> >> the best solution was:
> >> 
> >> 	virq = platform_get_irq(...)
> >> 	if (virq <= 0)
> >> 		return virq ? : -ENODEV;
> >> 
> >> i.e. map 0 to -ENODEV, pass other errors as-is, remove the dev_err
> >> 
> >> @Bjorn/Lorenzo did you have a change of heart?
> >
> > Yes.  In 10006651 (Oct 20, 2017), I thought:
> >
> >   irq = platform_get_irq(pdev, 0);
> >   if (irq <= 0)
> >     return -ENODEV;
> >
> > was fine.  In 11066455 (Aug 7, 2019), I said I thought I was wrong and
> > that:
> >
> >   platform_get_irq() is a generic interface and we have to be able to
> >   interpret return values consistently.  The overwhelming consensus
> >   among platform_get_irq() callers is to treat "irq < 0" as an error,
> >   and I think we should follow suit.
> >   ...
> >   I think the best pattern is:
> >
> >     irq = platform_get_irq(pdev, i);
> >     if (irq < 0)
> >       return irq;
> 
> Careful. 0 is not a valid interrupt.

Should callers of platform_get_irq() check for a 0 return value?
About 900 of them do not.

Or should platform_get_irq() return a negative error instead of 0?
If 0 is not a valid interrupt, I think it would be easier to use the
interface if we made it so platform_get_irq() could never return 0,
which I think would also fit the interface documentation better:

 * Return: IRQ number on success, negative error number on failure.

Bjorn
