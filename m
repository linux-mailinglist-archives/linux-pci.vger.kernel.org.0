Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40476520832
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 01:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiEIXQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 19:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiEIXQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 19:16:23 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B92A3773;
        Mon,  9 May 2022 16:12:28 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so16432631fac.7;
        Mon, 09 May 2022 16:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EmgXIp6wMnmBy4zjwHY36GV+5Al3/f1oiVUfAfxCvxk=;
        b=k5jxUUGjw3xPc9EL8QU3bBdnolB6+FtcBPTVtvBjchZYxk2EGWi08QdyfKmITvU3mD
         +OoTsNjuJXGcIl1/zR9XT7Z3J5fFePpJ3oxFxsgCwX/aoIMdtriGYcp0tctO+VJIP6bL
         XRv47Mv/GyUyomS9jBHx1DX9SFFrhbvr5ZE62Yo+OERyZKEbEdoRBWBNa3NDVRlcyJCd
         PR1gl89jts91sadW81hmuuTC28Av+wEf9ugXSRXp5naG6A7PudcwBcMuTTHUU/XMY4j/
         F0CPTHbsoSPD0JfnH8Q+S8UTE9JVNpNm1wwDNiwj3tyHG4+IJeqEArLEwAwCfbXXcjdX
         iJvw==
X-Gm-Message-State: AOAM532U2XUYrn1g5roxAPFTvXKl97SHwqxbSuDKzHdLiK5jrXkQHpuZ
        KYWYMmGfMXLRCV3uagUb3w==
X-Google-Smtp-Source: ABdhPJyQXGVgIQQnFpuDFb8C5WA0aJ+WbyZnIgmYjGPoDZXRH0oKqv26w/MqI6+h2SBJC994xOLNZA==
X-Received: by 2002:a05:6870:c698:b0:de:8a16:c37 with SMTP id cv24-20020a056870c69800b000de8a160c37mr11542610oab.191.1652137947285;
        Mon, 09 May 2022 16:12:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x7-20020a056870a78700b000e686d13897sm4746599oao.49.2022.05.09.16.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 16:12:26 -0700 (PDT)
Received: (nullmailer pid 393081 invoked by uid 1000);
        Mon, 09 May 2022 23:12:25 -0000
Date:   Mon, 9 May 2022 18:12:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] irqchip/armada-370-xp: Implement SoC Error interrupts
Message-ID: <Ynmf2SHN90yvsOmP@robh.at.kernel.org>
References: <20220506134029.21470-1-pali@kernel.org>
 <20220506134029.21470-3-pali@kernel.org>
 <87mtfu7ccd.wl-maz@kernel.org>
 <20220506183051.wimo7p4nuqfnl2aj@pali>
 <8735hmijlu.wl-maz@kernel.org>
 <20220506185546.n5rl3chyyauy4bjt@pali>
 <87levd7m2n.wl-maz@kernel.org>
 <20220507092054.b7yu23nj667l6xhy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220507092054.b7yu23nj667l6xhy@pali>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 07, 2022 at 11:20:54AM +0200, Pali Rohár wrote:
> On Saturday 07 May 2022 10:01:52 Marc Zyngier wrote:
> > On Fri, 06 May 2022 19:55:46 +0100,
> > Pali Rohár <pali@kernel.org> wrote:
> > > 
> > > On Friday 06 May 2022 19:47:25 Marc Zyngier wrote:
> > > > On Fri, 06 May 2022 19:30:51 +0100,
> > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > 
> > > > > On Friday 06 May 2022 19:19:46 Marc Zyngier wrote:
> > > > > > On Fri, 06 May 2022 14:40:25 +0100,
> > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > 
> > > > > > > +static void armada_370_xp_soc_err_irq_unmask(struct irq_data *d);
> > > > > > > +
> > > > > > >  static inline bool is_percpu_irq(irq_hw_number_t irq)
> > > > > > >  {
> > > > > > >  	if (irq <= ARMADA_370_XP_MAX_PER_CPU_IRQS)
> > > > > > > @@ -509,6 +517,27 @@ static void armada_xp_mpic_reenable_percpu(void)
> > > > > > >  		armada_370_xp_irq_unmask(data);
> > > > > > >  	}
> > > > > > >  
> > > > > > > +	/* Re-enable per-CPU SoC Error interrupts that were enabled before suspend */
> > > > > > > +	for (irq = 0; irq < soc_err_irq_num_regs * 32; irq++) {
> > > > > > > +		struct irq_data *data;
> > > > > > > +		int virq;
> > > > > > > +
> > > > > > > +		virq = irq_linear_revmap(armada_370_xp_soc_err_domain, irq);
> > > > > > > +		if (virq == 0)
> > > > > > > +			continue;
> > > > > > > +
> > > > > > > +		data = irq_get_irq_data(virq);
> > > > > > > +
> > > > > > > +		if (!irq_percpu_is_enabled(virq))
> > > > > > > +			continue;
> > > > > > > +
> > > > > > > +		armada_370_xp_soc_err_irq_unmask(data);
> > > > > > > +	}
> > > > > > 
> > > > > > So you do this loop and all these lookups, both here and in the resume
> > > > > > function (duplicated code!) just to be able to call the unmask
> > > > > > function?  This would be better served by two straight writes of the
> > > > > > mask register, which you'd conveniently save on suspend.
> > > > > > 
> > > > > > Yes, you have only duplicated the existing logic. But surely there is
> > > > > > something better to do.
> > > > > 
> > > > > Yes, I just used existing logic.
> > > > > 
> > > > > I'm not rewriting driver or doing big refactor of it, as this is not in
> > > > > the scope of the PCIe AER interrupt support.
> > > > 
> > > > Fair enough. By the same logic, I'm not taking any change to the
> > > > driver until it is put in a better shape. Your call.
> > > 
> > > If you are maintainer of this code then it is expected from _you_ to
> > > move the current code into _better shape_ as you wrote and expect. And
> > > then show us exactly, how new changes in this driver should look like,
> > > in examples.
> > 
> > Sorry, but that's not how this works. You are the one willing to
> > change a sub-par piece of code, you get to make it better. You
> > obviously have the means (the HW) and the incentive (these patches).
> > But you don't get to make something even more unmaintainable because
> > you're unwilling to do some extra work.
> > 
> > If you're unhappy with my position, that's fine. I suggest you take it
> > with Thomas, and maybe even Linus. As I suggested before, you can also
> > post a patch removing me as the irqchip maintainer. I'm sure that will
> > spark an interesting discussion.
> 
> You have already suggested it in email [1] but apparently you are _not_
> maintainer of mvebu pci controller. get_maintainer.pl for part about
> which you have talked in [1] says:
> 
> $ ./scripts/get_maintainer.pl -f drivers/pci/controller/pci-aardvark.c
> Thomas Petazzoni <thomas.petazzoni@bootlin.com> (maintainer:PCI DRIVER FOR AARDVARK (Marvell Armada 3700))
> "Pali Rohár" <pali@kernel.org> (maintainer:PCI DRIVER FOR AARDVARK (Marvell Armada 3700))
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> (supporter:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
> Rob Herring <robh@kernel.org> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)

Please just refactor the code in question. You've wasted more time 
arguing about it than it would take to do. Having done a bit of PCI 
refactoring, I can tell you hardly anyone else does. I can barely even 
get comments/acks on refactoring until I break platforms (which happens 
a lot). Maintainers have no other leverage other than what Marc pointed 
out.

In any case, I think there's no way the PCI maintainers will take this 
as-is at this point.

Rob
