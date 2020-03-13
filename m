Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9113C18509E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 22:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCMVGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 17:06:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48041 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgCMVGO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 17:06:14 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jCrVH-0003IC-Bk; Fri, 13 Mar 2020 22:05:59 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7674A100C8D; Fri, 13 Mar 2020 22:05:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
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
Subject: Re: [PATCH 4/5] pci: handled return value of platform_get_irq correctly
In-Reply-To: <20200312141102.GA93224@google.com>
References: <20200312141102.GA93224@google.com>
Date:   Fri, 13 Mar 2020 22:05:58 +0100
Message-ID: <871rpwhsnd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Thu, Mar 12, 2020 at 10:53:06AM +0100, Marc Gonzalez wrote:
>> Last time around, my understanding was that, going forward,
>> the best solution was:
>> 
>> 	virq = platform_get_irq(...)
>> 	if (virq <= 0)
>> 		return virq ? : -ENODEV;
>> 
>> i.e. map 0 to -ENODEV, pass other errors as-is, remove the dev_err
>> 
>> @Bjorn/Lorenzo did you have a change of heart?
>
> Yes.  In 10006651 (Oct 20, 2017), I thought:
>
>   irq = platform_get_irq(pdev, 0);
>   if (irq <= 0)
>     return -ENODEV;
>
> was fine.  In 11066455 (Aug 7, 2019), I said I thought I was wrong and
> that:
>
>   platform_get_irq() is a generic interface and we have to be able to
>   interpret return values consistently.  The overwhelming consensus
>   among platform_get_irq() callers is to treat "irq < 0" as an error,
>   and I think we should follow suit.
>   ...
>   I think the best pattern is:
>
>     irq = platform_get_irq(pdev, i);
>     if (irq < 0)
>       return irq;

Careful. 0 is not a valid interrupt.

Thanks,

        tglx
