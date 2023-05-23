Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F60970DD28
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjEWNGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEWNGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 09:06:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D9DB;
        Tue, 23 May 2023 06:05:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684847157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBL3D+wogzuI8WLqpWBwi6Hq40B1ocjEWy9bOCL1HEU=;
        b=DvF0LG/QWQOQtNEw6TXLSXLTLB0Q++LzGot9sn3/DolyN3Rh9tKi9FQdTxxZ7BONT2Two+
        JLKQ3KRlGAP7dVpsNdEXGXszjV/fPRaa4Bl3om2Y1SisHI8vXrrtqc8p122wKUT1GF6nUQ
        7SJRXPdeeYDzkNhcPznU5xlTLhVa3BV+36CsQxObZK3qdPW5TtOqAT1dbXvFZvMZTk+noq
        ndStmIRUL9pCJTyd0EYit5BL/x0emtqybT9Zl0npZkRwpUJMpbR3uuuKiexQ29nAzpHNdt
        /hMeEIzpajCjRYXm2lv1dqbLw+I7cOW2hrjk7bI29soy/l+adM/r4YNbwkVWfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684847157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBL3D+wogzuI8WLqpWBwi6Hq40B1ocjEWy9bOCL1HEU=;
        b=/yLHLe0a0jCoLPVWFG7TWRFGNU4Ud9jp/+LNbF5xN68sSPBGXFDQWnUYdfrFKVjThgfM1l
        j9uy1vMw6Vntt4CA==
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
In-Reply-To: <86r0r7cpks.wl-maz@kernel.org>
References: <20221121135653.208611233@linutronix.de>
 <20221121140048.659849460@linutronix.de> <8635a8o65q.wl-maz@kernel.org>
 <87bkowcx0z.ffs@tglx> <86zgcgmpzl.wl-maz@kernel.org> <87v8n3c2qy.ffs@tglx>
 <87ttw4wiro.ffs@tglx> <86r0r7cpks.wl-maz@kernel.org>
Date:   Tue, 23 May 2023 15:05:56 +0200
Message-ID: <87lehfurij.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 23 2023 at 11:25, Marc Zyngier wrote:
> On Mon, 22 May 2023 15:19:39 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> On the other hand for PCI/MSI[x] the mask/unmask operations are not in
>> the hot path as PCI/MSI[x] are strictly edge. Mask/unmask is only
>> happening on startup, shutdown and when an interrupt arrives after
>> disable_irq() incremented the lazy disable counter.
>> 
>> For regular interrupt handling mask/unmask is not involved.
>> 
>> So to avoid that global key we can let the parent domain set a new flag,
>> e.g. MSI_FLAG_PCI_MSI_MASK_PARENT, in msi_parent_ops::supported_flags
>> and let the PCI/MSI core code query that information when the per device
>> domain is created and select the appropriate template or fixup the
>> callbacks after the domain is created.
>> 
>> Does that address your concerns?
>
> It does to a certain extent.
>
> But what I'd really like is that in the most common case where the
> interrupt controller is capable of masking MSIs, the PCI/MSI
> *enabling* becomes the responsibility of the PCI core code and not the
> IRQ code.
>
> The IRQ code should ideally only be concerned with the masking of the
> interrupt at the irqchip level, and not beyond that. And that'd solve
> the Xen problem by merely ignoring it.
>
> If we have HW out there that cannot mask MSIs at the interrupt
> controller level, then we'd have to fallback to device-side masking,
> which doesn't really work in general (MultiMSI being my favourite
> example). My gut feeling is that this is rare, but I'm pretty sure it
> exists.

Sure. There are 3 parts involved:

      [Device]--->[PCI/MSI]---->[GIC]
                   irqchip      irqchip

Controlling the interrupt machinery in the device happens at the device
driver level and is conceptually independent of the interrupt
manangement code. The device driver has no access to the PCI/MSI irqchip
and all it can do is to enable/disable the source of the interrupt in
the device.

For the interrupt management code the job is to ensure that an interrupt
can be prevented from disrupting the OS operation independent of the
device driver correctness.

As a matter of fact we know that PCI/MSI masking ranges from not
possible over flaky to properly working. So we can't reliably prevent
that a rougue device spams the PCIe bus with messages.

Which means that we should utilize the fact that the next interrupt chip
in the hierarchy can mask reliably. I wish I could disable individual
vectors at the local APIC level on x86...

Now the question is whether we want to make this conditional depending
on what the PCI/MSI[X] hardware advertises or just keep it simple and do
it unconditionally.

Thanks,

        tglx
