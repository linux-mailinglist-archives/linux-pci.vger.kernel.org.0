Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFE6381E0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 01:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKYALJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 19:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKYALH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 19:11:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1226F0C2;
        Thu, 24 Nov 2022 16:11:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669335062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxSVflZ18PlqJMx8oWzcA732KZVFL71UoUUiiLTILXQ=;
        b=yurYLRMCRLJGDk8CJFNPQWjf/jy4ahKrCP1f1c71Jp3BX5h41lcuiBIsTbfS3KfGe2xH2Q
        gmzEyDMq45hG4l7QUTUiBHBKYyy/lk18jGYdG7LRFMvWoaGSdodK/MnKVpIF0Whrl0pjcS
        F4TzwrsX8FKusvObbj326QZ5/a2ez0P4uokzAKnEjiv672BwZA/AkCK8LL1xTuhUWpCYcS
        OwJDX8PqSw/nLZQLBGR4YA4ntf7wlI27jXmnnYkSSIzuzO8oubsDLnlDUaxxZwm0J0fuX+
        B07IqVxTn/PuqnFUV3eBQkuttdlQmtYRr1zxL0xOFQu5P0bXthbC9H/eJ+Wt9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669335062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxSVflZ18PlqJMx8oWzcA732KZVFL71UoUUiiLTILXQ=;
        b=uDlLaBXfkmTGZACcqFghOT2Vd+CefArCf3vqfkNV8sj5GMejeu7zKbsyQqtUPMvW6q3wxI
        4RgNCI64sJ130vCQ==
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
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [patch V2 06/40] PCI/MSI: Provide static key for parent
 mask/unmask
In-Reply-To: <86zgcgmpzl.wl-maz@kernel.org>
References: <20221121135653.208611233@linutronix.de>
 <20221121140048.659849460@linutronix.de> <8635a8o65q.wl-maz@kernel.org>
 <87bkowcx0z.ffs@tglx> <86zgcgmpzl.wl-maz@kernel.org>
Date:   Fri, 25 Nov 2022 01:11:01 +0100
Message-ID: <87v8n3c2qy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 24 2022 at 13:38, Marc Zyngier wrote:
> On Thu, 24 Nov 2022 13:17:00 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> > I find this a bit odd. If anything, I'd rather drop the masking at the
>> > PCI level and keep it local to the interrupt controller, because this
>> > is likely to be more universal than the equivalent PCI operation
>> > (think multi-MSI, for example, which cannot masks individual MSIs).
>> >
>> > Another thing is that the static key is a global state. Nothing says
>> > that masking one way or the other is a universal thing, specially when
>> > you have multiple interrupt controllers dealing with MSIs in different
>> > ways. For example, GICv3 can use both the ITS and the GICv3-MBI frame
>> > at the same time for different PCI RC. OK, they happen to deal with
>> > MSIs in the same way, but you hopefully get my point.
>> 
>> I'm fine with dropping that. I did this because basically all of the
>> various ARM PCI/MSI domain implementation have a copy of the same
>> functions. Some of them have pointlessly the wrong order because copy &
>> pasta is so wonderful....
>> 
>> So the alternative solution is to provide _ONE_ set of correct callbacks
>> and let the domain initialization code override the irq chip callbacks
>> of the default PCI/MSI template.
>
> If the various irqchips can tell the core code whether they want
> things to be masked at the PCI level or at the irqchip level, this
> would be a move in the right direction. For the GIC, I'd definitely
> want things masked locally.
>
> What I'd like to get rid off is the double masking, as I agree it is
> on the "pretty dumb" side of things.

Not necessarily. It mitigates the problem of MSI interrupts which can't
be masked because the implementers decided to spare the gates. MSI
allows that as masking is opt-in...

Let me think about it.

Thanks,

        tglx
