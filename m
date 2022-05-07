Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2185651E5FD
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 11:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383920AbiEGJYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 May 2022 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiEGJYq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 May 2022 05:24:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379703A5C0;
        Sat,  7 May 2022 02:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C34DDB82A25;
        Sat,  7 May 2022 09:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FE1C385A9;
        Sat,  7 May 2022 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651915257;
        bh=r8f1G85CwWBXhZRvyRIEzk2UJ38tU9254k0pQ4QCqV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEvVqi5VyHya5cqMihERtNcpG0SZ4OLmqDFv+T4BdyPyUlc+B7/EuzwP0xrZqo/nd
         CA0/Lv/jQ9sfZiSf2IipXTg/w2xVuDQi65A9dyyWcRnDRns2Tczw7MlRfqOY6QkRH+
         RTaK/omywVK+PYvH21xH8nyZNOERkWGVfFeTW1SvyeCdCwOBBHAOdPBBXhWkjhpjQv
         BktH9fVXs7/ItVAWISU5UksNCZQYpsRDBCYbGptSAj4mcGz/HtdP+Ir99/Z2N4Ktqr
         IbS4Yrl1jVpYSPM2dthu+1hsbauwnwScGl+vlSnRLHP/k1Vp1RvjCYJppn36bpucBJ
         kaIVJlQj5InJA==
Received: by pali.im (Postfix)
        id 21F06947; Sat,  7 May 2022 11:20:54 +0200 (CEST)
Date:   Sat, 7 May 2022 11:20:54 +0200
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
Message-ID: <20220507092054.b7yu23nj667l6xhy@pali>
References: <20220506134029.21470-1-pali@kernel.org>
 <20220506134029.21470-3-pali@kernel.org>
 <87mtfu7ccd.wl-maz@kernel.org>
 <20220506183051.wimo7p4nuqfnl2aj@pali>
 <8735hmijlu.wl-maz@kernel.org>
 <20220506185546.n5rl3chyyauy4bjt@pali>
 <87levd7m2n.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87levd7m2n.wl-maz@kernel.org>
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

On Saturday 07 May 2022 10:01:52 Marc Zyngier wrote:
> On Fri, 06 May 2022 19:55:46 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > On Friday 06 May 2022 19:47:25 Marc Zyngier wrote:
> > > On Fri, 06 May 2022 19:30:51 +0100,
> > > Pali Rohár <pali@kernel.org> wrote:
> > > > 
> > > > On Friday 06 May 2022 19:19:46 Marc Zyngier wrote:
> > > > > On Fri, 06 May 2022 14:40:25 +0100,
> > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > 
> > > > > > +static void armada_370_xp_soc_err_irq_unmask(struct irq_data *d);
> > > > > > +
> > > > > >  static inline bool is_percpu_irq(irq_hw_number_t irq)
> > > > > >  {
> > > > > >  	if (irq <= ARMADA_370_XP_MAX_PER_CPU_IRQS)
> > > > > > @@ -509,6 +517,27 @@ static void armada_xp_mpic_reenable_percpu(void)
> > > > > >  		armada_370_xp_irq_unmask(data);
> > > > > >  	}
> > > > > >  
> > > > > > +	/* Re-enable per-CPU SoC Error interrupts that were enabled before suspend */
> > > > > > +	for (irq = 0; irq < soc_err_irq_num_regs * 32; irq++) {
> > > > > > +		struct irq_data *data;
> > > > > > +		int virq;
> > > > > > +
> > > > > > +		virq = irq_linear_revmap(armada_370_xp_soc_err_domain, irq);
> > > > > > +		if (virq == 0)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		data = irq_get_irq_data(virq);
> > > > > > +
> > > > > > +		if (!irq_percpu_is_enabled(virq))
> > > > > > +			continue;
> > > > > > +
> > > > > > +		armada_370_xp_soc_err_irq_unmask(data);
> > > > > > +	}
> > > > > 
> > > > > So you do this loop and all these lookups, both here and in the resume
> > > > > function (duplicated code!) just to be able to call the unmask
> > > > > function?  This would be better served by two straight writes of the
> > > > > mask register, which you'd conveniently save on suspend.
> > > > > 
> > > > > Yes, you have only duplicated the existing logic. But surely there is
> > > > > something better to do.
> > > > 
> > > > Yes, I just used existing logic.
> > > > 
> > > > I'm not rewriting driver or doing big refactor of it, as this is not in
> > > > the scope of the PCIe AER interrupt support.
> > > 
> > > Fair enough. By the same logic, I'm not taking any change to the
> > > driver until it is put in a better shape. Your call.
> > 
> > If you are maintainer of this code then it is expected from _you_ to
> > move the current code into _better shape_ as you wrote and expect. And
> > then show us exactly, how new changes in this driver should look like,
> > in examples.
> 
> Sorry, but that's not how this works. You are the one willing to
> change a sub-par piece of code, you get to make it better. You
> obviously have the means (the HW) and the incentive (these patches).
> But you don't get to make something even more unmaintainable because
> you're unwilling to do some extra work.
> 
> If you're unhappy with my position, that's fine. I suggest you take it
> with Thomas, and maybe even Linus. As I suggested before, you can also
> post a patch removing me as the irqchip maintainer. I'm sure that will
> spark an interesting discussion.

You have already suggested it in email [1] but apparently you are _not_
maintainer of mvebu pci controller. get_maintainer.pl for part about
which you have talked in [1] says:

$ ./scripts/get_maintainer.pl -f drivers/pci/controller/pci-aardvark.c
Thomas Petazzoni <thomas.petazzoni@bootlin.com> (maintainer:PCI DRIVER FOR AARDVARK (Marvell Armada 3700))
"Pali Rohár" <pali@kernel.org> (maintainer:PCI DRIVER FOR AARDVARK (Marvell Armada 3700))
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> (supporter:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Rob Herring <robh@kernel.org> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
"Krzysztof Wilczyński" <kw@linux.com> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM)
linux-pci@vger.kernel.org (open list:PCI DRIVER FOR AARDVARK (Marvell Armada 3700))
linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR AARDVARK (Marvell Armada 3700))
linux-kernel@vger.kernel.org (open list)

So I do not have to remove anything, you are _not_ on that list.
On the other hand, Thomas Petazzoni is on this list...

> > > > > > +static int armada_xp_soc_err_irq_set_affinity(struct irq_data *d,
> > > > > > +					      const struct cpumask *mask,
> > > > > > +					      bool force)
> > > > > > +{
> > > > > > +	unsigned int cpu;
> > > > > > +
> > > > > > +	cpus_read_lock();
> > > > > > +
> > > > > > +	/* First disable IRQ on all cores */
> > > > > > +	for_each_online_cpu(cpu)
> > > > > > +		smp_call_on_cpu(cpu, armada_370_xp_soc_err_irq_mask_on_cpu, d, true);
> > > > > > +
> > > > > > +	/* Select a single core from the affinity mask which is online */
> > > > > > +	cpu = cpumask_any_and(mask, cpu_online_mask);
> > > > > > +	smp_call_on_cpu(cpu, armada_370_xp_soc_err_irq_unmask_on_cpu, d, true);
> > > > > > +
> > > > > > +	cpus_read_unlock();
> > > > > > +
> > > > > > +	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > > > > > +
> > > > > > +	return IRQ_SET_MASK_OK;
> > > > > > +}
> > > > > 
> > > > > Aren't these per-CPU interrupts anyway? What does it mean to set their
> > > > > affinity? /me rolls eyes...
> > > > 
> > > > Yes, they are per-CPU interrupts. But to mask or unmask particular
> > > > interrupt for specific CPU is possible only from that CPU. CPU 0 just
> > > > cannot move interrupt from CPU 0 to CPU 1. CPU 0 can only mask that
> > > > interrupt and CPU 1 has to unmask it.
> > > 
> > > And that's no different form other per-CPU interrupts that have the
> > > exact same requirements. NAK to this sort of hacks.
> > 
> > You forgot to mention in your previous email how to do it, right? So we
> > are waiting...
> 
> I didn't forget. I explained that it should be handled just like any
> other per-CPU interrupt. There is plenty of example of how to do that
> in the tree (timers, for example), and if you had even looked at it,
> you'd have seen that your approach most probably results in an
> arbitrary pointer dereference on anything but CPU0 because the
> requesting driver knows nothing about per-CPU interrupts.
> 
> But you're obviously trying to make a very different point here. I'll
> let you play that game for as long as you want, no skin off my nose.
> Maybe in the future, you'll be more interested in actively
> collaborating on the kernel code instead of throwing your toys out of
> the pram.
> 
> Thanks,

The only _toy_ here is your broken mvebu board which your ego was unable
to fix, and you have put it into recycling pile [2] and since than for
months you are trying to reject every change or improvement in mvebu
drivers and trying to find out a way how to remove all mvebu code, like
if you were not able to fix your toy, then broke it also to all other
people. You have already expressed this, but I'm not going to search
emails more and find these your statements.

Sorry, I'm stopping here. This is just a prove that you are not
qualified in reviewing mvebu code.

[1] - https://lore.kernel.org/linux-pci/87mtk3tzum.wl-maz@kernel.org/
[2] - https://lore.kernel.org/linux-pci/87pmx1zjjt.wl-maz@kernel.org/
