Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2C140FA5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgAQRL3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 12:11:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56953 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQRL2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 12:11:28 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isV9Y-0004lB-CS; Fri, 17 Jan 2020 18:11:24 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A2C70100C19; Fri, 17 Jan 2020 18:11:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
In-Reply-To: <CAGi-RUJkr0gPbynYe+Gkk-JoeyCHdSvd9zdgCv4Hij5vfGVMEA@mail.gmail.com>
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com> <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com> <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com> <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com> <87v9pcw55q.fsf@nanos.tec.linutronix.de> <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com> <87pnfjwxtx.fsf@nanos.tec.linutronix.de> <CAGi-RUJtqdLtFBVMxL8TOQ3LGRqqrV4Ge7Fu9mTyDoQVYxtA5g@mail.gmail.com> <87zhem172r.fsf@nanos.tec.linutronix.de> <CAGi-RUJkr0gPbynYe+Gkk-JoeyCHdSvd9zdgCv4Hij5vfGVMEA@mail.gmail.com>
Date:   Fri, 17 Jan 2020 18:11:23 +0100
Message-ID: <87sgke1004.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ramon,

Ramon Fried <rfried.dev@gmail.com> writes:
> On Fri, Jan 17, 2020 at 4:38 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> This is wrong. MSI is edge type, not level and you are really mixing up
>> the concepts here.
>>
>> The fact that the MSI block raises a level interrupt on the output side
>> has absolutely nothing to do with the type of the MSI interrupt itself.
>>
>> MSI is edge type by definition and this does not change just because
>> there is a translation unit between the MSI interrupt and the CPU
>> controller.
>>
>> The actual MSI interrupts do not even know about the existance of that
>> MSI block at all. They do not care, as all they need to know is a
>> message and an address. When an interrupt is raised in the device the
>> MSI chip associated to the device (PCI or something else) writes this
>> message to the address exactly ONCE. And this exactly ONCE defines the
>> edge nature of MSI.
>
> OK, now I understand my mistake. thanks.

:)

>> A proper designed MSI device should not send another message before the
>> interrupt handler which is associated to the device has handled the
>> interrupt at the device level.
>
> By "MSI device" you mean the MSI controller in the SOC or the endpoint
> that sends the MSI ?

The device which incorporates the MSI endpoint. 

Thanks,

        tglx
