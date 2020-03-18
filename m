Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790E8189D35
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 14:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCRNnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 09:43:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgCRNnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2020 09:43:03 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEYyA-00051t-4D; Wed, 18 Mar 2020 14:42:50 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7E66A1040C5; Wed, 18 Mar 2020 14:42:48 +0100 (CET)
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
In-Reply-To: <20200317220334.GA230141@google.com>
References: <20200317220334.GA230141@google.com>
Date:   Wed, 18 Mar 2020 14:42:48 +0100
Message-ID: <874kulbwyv.fsf@nanos.tec.linutronix.de>
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
> On Fri, Mar 13, 2020 at 04:56:42PM -0500, Bjorn Helgaas wrote:
>> On Fri, Mar 13, 2020 at 10:05:58PM +0100, Thomas Gleixner wrote:
>> > >   I think the best pattern is:
>> > >
>> > >     irq = platform_get_irq(pdev, i);
>> > >     if (irq < 0)
>> > >       return irq;
>> > 
>> > Careful. 0 is not a valid interrupt.
>> 
>> Should callers of platform_get_irq() check for a 0 return value?
>> About 900 of them do not.

I don't know what I was looking at.

platform_get_irq() does the right thing already, so checking for irq < 0
is sufficient.

Sorry for the confusion!

Thanks,

        tglx
