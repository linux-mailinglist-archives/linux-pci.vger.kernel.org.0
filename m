Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7507351E69A
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382070AbiEGLTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 May 2022 07:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiEGLS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 May 2022 07:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD838DB2;
        Sat,  7 May 2022 04:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59226115F;
        Sat,  7 May 2022 11:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB30C385A9;
        Sat,  7 May 2022 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651922112;
        bh=/LOtxvTggIO6icaWFdhUM6BPOHRmcG034NQXFaL7UfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vyp24Y7Yvi4m4vGqgXthnnoLjM2VFzlYC8FeIDkRH8MPFWeLRXMQZfvV6oH9bvxEL
         XvduPF6jfOZpCyi8wkn5hvCqtqKVIJXQIPBS3gOJ54UoZ8zU+ieP0dhJ1hgKORmWy4
         G6buMYACQKPxLOWQEXY6Stct3ESdccQ6yzH87PxBxgsGgeL+bbrcdOIzi9hz8dlDan
         yqGy44pmiXBLlHfHECrM66QpAT1ebAssdMmPeR3pnrtBXghnon0vTmdDpqqFgGm1Ni
         ob/cKeL68VLicy7n8emtc2RFhKrtTU/LCFW0lGgH7iDQoKqqjEyfgpf3ZqgmTzXcdg
         Y4+qQgAO9YsVQ==
Received: by pali.im (Postfix)
        id 6ED077F6; Sat,  7 May 2022 13:15:08 +0200 (CEST)
Date:   Sat, 7 May 2022 13:15:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] irqchip/armada-370-xp: Implement SoC Error interrupts
Message-ID: <20220507111508.dk4ztsg7esspoupb@pali>
References: <20220506134029.21470-1-pali@kernel.org>
 <20220506134029.21470-3-pali@kernel.org>
 <87mtfu7ccd.wl-maz@kernel.org>
 <20220506183051.wimo7p4nuqfnl2aj@pali>
 <8735hmijlu.wl-maz@kernel.org>
 <20220506185546.n5rl3chyyauy4bjt@pali>
 <87levd7m2n.wl-maz@kernel.org>
 <20220507092054.b7yu23nj667l6xhy@pali>
 <871qx5ispy.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871qx5ispy.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 07 May 2022 10:42:49 Marc Zyngier wrote:
> On Sat, 07 May 2022 10:20:54 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > On Saturday 07 May 2022 10:01:52 Marc Zyngier wrote:
> > > On Fri, 06 May 2022 19:55:46 +0100,
> > > Pali Rohár <pali@kernel.org> wrote:
> > > > 
> > > > On Friday 06 May 2022 19:47:25 Marc Zyngier wrote:
> > > > > On Fri, 06 May 2022 19:30:51 +0100,
> > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > 
> > > > > > On Friday 06 May 2022 19:19:46 Marc Zyngier wrote:
> > > > > > > On Fri, 06 May 2022 14:40:25 +0100,
> > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > 
> > > > > > > > +static void armada_370_xp_soc_err_irq_unmask(struct irq_data *d);
> > > > > > > > +
> > > > > > > >  static inline bool is_percpu_irq(irq_hw_number_t irq)
> > > > > > > >  {
> > > > > > > >  	if (irq <= ARMADA_370_XP_MAX_PER_CPU_IRQS)
> > > > > > > > @@ -509,6 +517,27 @@ static void armada_xp_mpic_reenable_percpu(void)
> > > > > > > >  		armada_370_xp_irq_unmask(data);
> > > > > > > >  	}
> > > > > > > >  
> > > > > > > > +	/* Re-enable per-CPU SoC Error interrupts that were enabled before suspend */
> > > > > > > > +	for (irq = 0; irq < soc_err_irq_num_regs * 32; irq++) {
> > > > > > > > +		struct irq_data *data;
> > > > > > > > +		int virq;
> > > > > > > > +
> > > > > > > > +		virq = irq_linear_revmap(armada_370_xp_soc_err_domain, irq);
> > > > > > > > +		if (virq == 0)
> > > > > > > > +			continue;
> > > > > > > > +
> > > > > > > > +		data = irq_get_irq_data(virq);
> > > > > > > > +
> > > > > > > > +		if (!irq_percpu_is_enabled(virq))
> > > > > > > > +			continue;
> > > > > > > > +
> > > > > > > > +		armada_370_xp_soc_err_irq_unmask(data);
> > > > > > > > +	}
> > > > > > > 
> > > > > > > So you do this loop and all these lookups, both here and in the resume
> > > > > > > function (duplicated code!) just to be able to call the unmask
> > > > > > > function?  This would be better served by two straight writes of the
> > > > > > > mask register, which you'd conveniently save on suspend.
> > > > > > > 
> > > > > > > Yes, you have only duplicated the existing logic. But surely there is
> > > > > > > something better to do.
> > > > > > 
> > > > > > Yes, I just used existing logic.
> > > > > > 
> > > > > > I'm not rewriting driver or doing big refactor of it, as this is not in
> > > > > > the scope of the PCIe AER interrupt support.
> > > > > 
> > > > > Fair enough. By the same logic, I'm not taking any change to the
> > > > > driver until it is put in a better shape. Your call.
> > > > 
> > > > If you are maintainer of this code then it is expected from _you_ to
> > > > move the current code into _better shape_ as you wrote and expect. And
> > > > then show us exactly, how new changes in this driver should look like,
> > > > in examples.
> > > 
> > > Sorry, but that's not how this works. You are the one willing to
> > > change a sub-par piece of code, you get to make it better. You
> > > obviously have the means (the HW) and the incentive (these patches).
> > > But you don't get to make something even more unmaintainable because
> > > you're unwilling to do some extra work.
> > > 
> > > If you're unhappy with my position, that's fine. I suggest you take it
> > > with Thomas, and maybe even Linus. As I suggested before, you can also
> > > post a patch removing me as the irqchip maintainer. I'm sure that will
> > > spark an interesting discussion.
> > 
> > You have already suggested it in email [1] but apparently you are _not_
> > maintainer of mvebu pci controller. get_maintainer.pl for part about
> > which you have talked in [1] says:
> > 
> > $ ./scripts/get_maintainer.pl -f drivers/pci/controller/pci-aardvark.c
> 
> Remind me which file this patch is touching?

So read again what you have presented in the past, in the email to which
you have referenced. I sent link to that your email in previous email.

Or you absolutely incompetent and I should have remind also previous
email to which you wrote your reaction?

> > The only _toy_ here is your broken mvebu board which your ego was unable
> > to fix, and you have put it into recycling pile [2] and since than for
> > months you are trying to reject every change or improvement in mvebu
> > drivers and trying to find out a way how to remove all mvebu code, like
> > if you were not able to fix your toy, then broke it also to all other
> > people. You have already expressed this, but I'm not going to search
> > emails more and find these your statements.
> 
> At this stage, this is pure paranoia.

No, just pure reality of your behavior of what you are doing and what
you are saying.

> Do you think I am so emotionally
> attached to HW purity that I would plot the annihilation of some ugly
> platform?

I do not think. You personally, have presented this statement, and I'm
just reminding it to you like you have asked for it.

> > Sorry, I'm stopping here. This is just a prove that you are not
> > qualified in reviewing mvebu code.
> 
> Happy not to have to review this code.

You are doing it for more than one year. Are you happy with it? Seem
absolutely.

> Just stop Cc'ing me on your patches

As there no progress from your side, nor change of your behavior from
more than one year, I'm accepting this offer.

This is my last email to you and I'm stopping right now to read your
emails.

I'm not obligated to remind you everything what you are asking just
because you are lazy to find you what you have wrote in the past.

> and don't expect me to merge any IRQ related patches coming
> from you.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
