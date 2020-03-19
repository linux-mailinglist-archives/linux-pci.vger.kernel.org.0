Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA018AEB1
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCSIsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 04:48:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59784 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCSIsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 04:48:01 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEqqD-0002xp-G4; Thu, 19 Mar 2020 09:47:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AB625103088; Thu, 19 Mar 2020 09:47:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH 4/5] pci: handled return value of platform_get_irq correctly
In-Reply-To: <20200318222238.GA247500@google.com>
References: <20200318222238.GA247500@google.com>
Date:   Thu, 19 Mar 2020 09:47:47 +0100
Message-ID: <877dzgennw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Wed, Mar 18, 2020 at 02:42:48PM +0100, Thomas Gleixner wrote:
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>> > On Fri, Mar 13, 2020 at 04:56:42PM -0500, Bjorn Helgaas wrote:
>> >> On Fri, Mar 13, 2020 at 10:05:58PM +0100, Thomas Gleixner wrote:
>> >> > >   I think the best pattern is:
>> >> > >
>> >> > >     irq = platform_get_irq(pdev, i);
>> >> > >     if (irq < 0)
>> >> > >       return irq;
>> >> > 
>> >> > Careful. 0 is not a valid interrupt.
>> >> 
>> >> Should callers of platform_get_irq() check for a 0 return value?
>> >> About 900 of them do not.
>> 
>> I don't know what I was looking at.
>> 
>> platform_get_irq() does the right thing already, so checking for irq < 0
>> is sufficient.
>> 
>> Sorry for the confusion!
>
> Thanks, I was indeed confused!  Maybe we could reduce future confusion
> by strengthening the comments slightly, e.g.,
>
>   - * Return: IRQ number on success, negative error number on failure.
>   + * Return: non-zero IRQ number on success, negative error number on failure.
>
> I don't want to push my luck, but it's pretty hard to prove that
> platform_get_irq() never returns 0.  What would you think of something
> like the following?

No objections from my side.
