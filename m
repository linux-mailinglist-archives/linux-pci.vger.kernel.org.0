Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ABE6379C4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 14:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiKXNRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 08:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXNRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 08:17:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6AFCDD0;
        Thu, 24 Nov 2022 05:17:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669295820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3t5mTJ+9oFfobjpYgyouD4WEP6J1TnkxH7WUrKI7neU=;
        b=r0ITR9n291YHgrcpgT7yxfWBidJlwshxk+RhFkqCt8z9X5UuofbLPhrEVm7DHSvAFh3ocE
        o/co3Buen7CWOH3URbPFP3aszYUG2FxcDQU2eEQFzqjLePyUTnVzHVh4PllmxfLnMnta1R
        +GwsN+xcyklyIvI0NkjZSnyMvpmap4k2nfB8XGRaGeUtexlMEmdGSmnUT5vjESDRp8BK+C
        LclDHFvy1EimsWQ9d7J3Axfn/u4WSynshR6pTJ3X74JuJk+0xKVwgqG62N78P51oII+Wej
        b+eQn4HsKtGOG87sbyCVKKLdK3os1x5sTdu3e7s8YYt0cc8buWWgQNa8FS9y+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669295820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3t5mTJ+9oFfobjpYgyouD4WEP6J1TnkxH7WUrKI7neU=;
        b=rQf0pQYAyyksuqVLLAylWKVzaRi5KPD4K5oquK0iInHKBuHiV0y45FTcVlTpUJT7w3PNGL
        7SXhum3QgfsvvTCQ==
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
In-Reply-To: <8635a8o65q.wl-maz@kernel.org>
References: <20221121135653.208611233@linutronix.de>
 <20221121140048.659849460@linutronix.de> <8635a8o65q.wl-maz@kernel.org>
Date:   Thu, 24 Nov 2022 14:17:00 +0100
Message-ID: <87bkowcx0z.ffs@tglx>
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

On Thu, Nov 24 2022 at 13:04, Marc Zyngier wrote:
> On Mon, 21 Nov 2022 14:39:36 +0000,
>>  static void pci_mask_msi(struct irq_data *data)
>>  {
>>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>>  
>>  	pci_msi_mask(desc, BIT(data->irq - desc->irq));
>> +	cond_mask_parent(data);
>
> I find this a bit odd. If anything, I'd rather drop the masking at the
> PCI level and keep it local to the interrupt controller, because this
> is likely to be more universal than the equivalent PCI operation
> (think multi-MSI, for example, which cannot masks individual MSIs).
>
> Another thing is that the static key is a global state. Nothing says
> that masking one way or the other is a universal thing, specially when
> you have multiple interrupt controllers dealing with MSIs in different
> ways. For example, GICv3 can use both the ITS and the GICv3-MBI frame
> at the same time for different PCI RC. OK, they happen to deal with
> MSIs in the same way, but you hopefully get my point.

I'm fine with dropping that. I did this because basically all of the
various ARM PCI/MSI domain implementation have a copy of the same
functions. Some of them have pointlessly the wrong order because copy &
pasta is so wonderful....

So the alternative solution is to provide _ONE_ set of correct callbacks
and let the domain initialization code override the irq chip callbacks
of the default PCI/MSI template.

Thanks,

        tglx
