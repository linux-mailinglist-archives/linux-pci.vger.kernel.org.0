Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A970C0D5
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjEVOTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjEVOTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 10:19:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAE5A3;
        Mon, 22 May 2023 07:19:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684765179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEFrgqz+gYLalhKQzChWX9y13gBECThZx9rK3oKXttA=;
        b=cnxOpR90o7b9DdKZbimSkvnr6JHqdXf3oOrsG7QcyoV1Ac/DwCRI9RFkgWd5l6vSJdDUk7
        QH/p5gkBaJyHXeV+852Ii+nXe9WRHtdyUzbOlrVfKOxGHby46cx/h49HYyCs0GetKzD9im
        RkI3ASIiJGTYXWJ9iPSrGXHLl+7eaorVZdIIlTZomc0ukCC7M9J3RwI6Nu4JluhNCfWmO7
        KpU9eCs+zB9b205s3ptRyp1JwGsg1+arE+KtcPp/d3dHs1S4jjoWHGlfML9ROMtTFdvE30
        rVsx2WYi0+Gf4iNo+Omb98a3p6dXimbGks+lHQmepIoxUd2oGwPQarrqrE1yDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684765179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEFrgqz+gYLalhKQzChWX9y13gBECThZx9rK3oKXttA=;
        b=BFafzFgxgWxPaKO3wZOg+17eqARUJiZ13GDJnVawb4dyxmDJRqxJB6hjPwQB0txXX1fh8h
        6J/LXx4rHUjl4hDQ==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>
Subject: Re: [patch V2 06/40] PCI/MSI: Provide static key for parent
 mask/unmask
In-Reply-To: <87v8n3c2qy.ffs@tglx>
References: <20221121135653.208611233@linutronix.de>
 <20221121140048.659849460@linutronix.de> <8635a8o65q.wl-maz@kernel.org>
 <87bkowcx0z.ffs@tglx> <86zgcgmpzl.wl-maz@kernel.org> <87v8n3c2qy.ffs@tglx>
Date:   Mon, 22 May 2023 16:19:39 +0200
Message-ID: <87ttw4wiro.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 25 2022 at 01:11, Thomas Gleixner wrote:
> On Thu, Nov 24 2022 at 13:38, Marc Zyngier wrote:
>> On Thu, 24 Nov 2022 13:17:00 +0000,
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>> > I find this a bit odd. If anything, I'd rather drop the masking at the
>>> > PCI level and keep it local to the interrupt controller, because this
>>> > is likely to be more universal than the equivalent PCI operation
>>> > (think multi-MSI, for example, which cannot masks individual MSIs).
>>> >
>>> > Another thing is that the static key is a global state. Nothing says
>>> > that masking one way or the other is a universal thing, specially when
>>> > you have multiple interrupt controllers dealing with MSIs in different
>>> > ways. For example, GICv3 can use both the ITS and the GICv3-MBI frame
>>> > at the same time for different PCI RC. OK, they happen to deal with
>>> > MSIs in the same way, but you hopefully get my point.
>>> 
>>> I'm fine with dropping that. I did this because basically all of the
>>> various ARM PCI/MSI domain implementation have a copy of the same
>>> functions. Some of them have pointlessly the wrong order because copy &
>>> pasta is so wonderful....
>>> 
>>> So the alternative solution is to provide _ONE_ set of correct callbacks
>>> and let the domain initialization code override the irq chip callbacks
>>> of the default PCI/MSI template.
>>
>> If the various irqchips can tell the core code whether they want
>> things to be masked at the PCI level or at the irqchip level, this
>> would be a move in the right direction. For the GIC, I'd definitely
>> want things masked locally.
>>
>> What I'd like to get rid off is the double masking, as I agree it is
>> on the "pretty dumb" side of things.
>
> Not necessarily. It mitigates the problem of MSI interrupts which can't
> be masked because the implementers decided to spare the gates. MSI
> allows that as masking is opt-in...
>
> Let me think about it.

That really took a while to think about it :)

We have the following cases on the PCI/MSI side:

 1) The MSI[X] entry can be masked

 2) The MSI[X] entry cannot be masked because hardware did not implement
    it, masking is globally disabled due to XEN, masking does not exist
    for this horrible virtual MSI hackery

Now you said:

 "For the GIC, I'd definitely want things masked locally."

I decoded this, that you want to have these interrupts masked at the GIC
level too independent of #1 or #2 above. And then:

 "What I'd like to get rid off is the double masking."

But relying on the GIC alone is not really a good thing IMO. There is no
point to let some confused device send unwanted MSI messages around
without a way to shut it up from the generic code via the regular
mask/unmask callbacks.

On the other hand for PCI/MSI[x] the mask/unmask operations are not in
the hot path as PCI/MSI[x] are strictly edge. Mask/unmask is only
happening on startup, shutdown and when an interrupt arrives after
disable_irq() incremented the lazy disable counter.

For regular interrupt handling mask/unmask is not involved.

So to avoid that global key we can let the parent domain set a new flag,
e.g. MSI_FLAG_PCI_MSI_MASK_PARENT, in msi_parent_ops::supported_flags
and let the PCI/MSI core code query that information when the per device
domain is created and select the appropriate template or fixup the
callbacks after the domain is created.

Does that address your concerns?

Thanks,

        tglx





