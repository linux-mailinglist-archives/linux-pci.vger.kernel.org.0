Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87A5EAA09
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiIZPQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiIZPP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 11:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE4B2A963
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 07:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B6860DCB
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 14:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02FDC433C1;
        Mon, 26 Sep 2022 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664200820;
        bh=xQH4FsyT+Dv/FkIwMdXsyg+Yph7LcdP5Gv0oJ1Qxs0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crRE+EBu+h5LCZnCIkijcvAUhnwHc76d6SkoxoaORJHoOD3yDO1OY/3ma/YF14U9w
         i4vQCoW/0zZzYgmBd/0be6DjcYVkurnVBEmy+FwP8p5g5VDwFAu7H3ZhqwtavWEvsk
         FYNiM9w+ZSBtCjCxgiKWeJNtl6MhgYOEHSiN74qEuEKxm/63v3UWZUytpWeiRim9Ac
         TuYE2JIAQS0bTd7TgaBf2m0aq67argsHOIua4unZ2uL/TEgRzG+jcyXmlhTPD1hcFY
         DVEAZJedaLl/lPNkZUWs4ZUd+djWC6+1xNSe24/fNHu8PYE/YlCGfXPBqyYYhzHaN5
         3IAvTgqmIYnrw==
Date:   Mon, 26 Sep 2022 16:00:13 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de
Subject: Re: [PATCH 03/11] PCI: aardvark: Add support for DLLSC and hotplug
 interrupt
Message-ID: <YzGwbWoFIpADgbXz@lpieralisi>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-4-kabel@kernel.org>
 <YxtUR0+dBZut8QZH@lpieralisi>
 <87r10al6a0.wl-maz@kernel.org>
 <YzGR40/kmQX4ZNaS@lpieralisi>
 <868rm68g9k.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <868rm68g9k.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 08:35:51AM -0400, Marc Zyngier wrote:
> On Mon, 26 Sep 2022 07:49:55 -0400,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > On Sat, Sep 17, 2022 at 10:05:59AM +0100, Marc Zyngier wrote:
> > > Hi Lorenzo,
> > > 
> > > On Fri, 09 Sep 2022 15:57:11 +0100,
> > > Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > > > 
> > > > [+Marc, Thomas - I can't merge this code without them reviewing it,
> > > > I am not sure at all you can mix the timer/IRQ code the way you do]
> > > > 
> > > > On Thu, Aug 18, 2022 at 03:51:32PM +0200, Marek Behún wrote:
> > > > > From: Pali Rohár <pali@kernel.org>
> > > > > 
> > > > > Add support for Data Link Layer State Change in the emulated slot
> > > > > registers and hotplug interrupt via the emulated root bridge.
> > > > > 
> > > > > This is mainly useful for when an error causes link down event. With
> > > > > this change, drivers can try recovery.
> > > > > 
> > > > > Link down state change can be implemented because Aardvark supports Link
> > > > > Down event interrupt. Use it for signaling that Data Link Layer Link is
> > > > > not active anymore via Hot-Plug Interrupt on emulated root bridge.
> > > > > 
> > > > > Link up interrupt is not available on Aardvark, but we check for whether
> > > > > link is up in the advk_pcie_link_up() function. By triggering Hot-Plug
> > > > > Interrupt from this function we achieve Link up event, so long as the
> > > > > function is called (which it is after probe and when rescanning).
> > > > > Although it is not ideal, it is better than nothing.
> > > > 
> > > > So before even coming to the code review: this patch does two things.
> > > > 
> > > > 1) It adds support for handling the Link down state
> > > > 2) It adds some code to emulate a Link-up event
> > > > 
> > > > Now, for (2). IIUC you are adding code to make sure that an HP
> > > > event is triggered if advk_pcie_link_up() is called and it
> > > > detects a Link-down->Link-up transition, that has to be notified
> > > > through an HP event.
> > > > 
> > > > If that's correct, you have to explain to me please what this is
> > > > actually achieving and a specific scenario where we want this to be
> > > > implemented, in fine details; then we add it to the commit log.
> > > > 
> > > > That aside, the interaction of the timer and the IRQ domain code
> > > > must be reviewed by Marc and Thomas to make sure this is not
> > > > a gross violation of the respective subsystems usage.
> > > 
> > > I don't see anything being a "gross violation" here, at least from an
> > > interrupt subsystem perspective. In a way, this is synthesising an
> > > interrupt on the back of some other event, and as long as the context
> > > is somehow appropriate (something that looks like an interrupt when
> > > pretending there is one), this should be OK. Other subsystems such as
> > > i2c GPIO expanders do similar things.
> > 
> > Right, thanks.
> > 
> > > The one thing I'm dubious about is the frequency of the timer. Asking
> > > for a poll of the link every jiffy is bound to be expensive, and it
> > > would be good to relax this as much as possible, specially on low-end
> > > HW such as this, where every cycle counts. It is always going to be a
> > > "best effort" thing, and the commit message doesn't say what's the
> > > actual grace period to handle this (the spec probably has one).
> > 
> > AFAICS, the code does not poll the link. It sets a timer only if
> > the link is checked (eg upon PCI bus forced rescan or config access)
> > the link is up and it was down, to emulate a HP IRQ.
> 
> I still find the timer frequency pretty high, but surely the authors
> of the code have worked out that this wasn't a problem.

Please correct me if I am wrong but with mod_timer() all they want to do
is emulating/firing an (hotplug) IRQ as soon as possible - a one-off.

It is not a periodic timer - at least that's what I understand from the
code and that's the reason why such a short interval was chosen but
it should not be me who comment on that :)

Again - that's just my understanding of this patch (the link-up
portion).

Lorenzo
