Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C57457D66
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 12:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhKTLfo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 06:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhKTLfo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Nov 2021 06:35:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E30DE60EB9;
        Sat, 20 Nov 2021 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637407961;
        bh=j3b8aNE9prTnXmGO7AUa+s42Q3s+fxuXLzmPQEQG9GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rptj9VzpkG641RQMnHDy5WXM4nRa6Ed8beRpvyTJytO5FkS6WsjBln5Vo75hulJME
         zUSaqU5HomZA7NAWNx2320TaIoZPcx/oJupPrwNc6dV7jgJBbRt8F0u+F4ddglzHUK
         xx62jsDPg2rJ0RaZtgzYcfqfXFjU0yeW8yDv15IBxqIqTM2Gl5JG/j6VcrnzI3LRUf
         Z9si+wRNucO/r+AXzdB9SSgHHBCH8xfCCbm/sC5MgIl1ZuVGt2vz3a+Q+IHaGebvBD
         j2t0RTi2QhQCqyjIYxOsJxE7EoeAYWV6m7r3rTxVU6RyL7VViVzyjtyMpTtJi/F0Xc
         I9Q1JH5iZ00/Q==
Received: by pali.im (Postfix)
        id 44922A3A; Sat, 20 Nov 2021 12:32:38 +0100 (CET)
Date:   Sat, 20 Nov 2021 12:32:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel-team@android.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: apple: Reset the port for 100ms on probe
Message-ID: <20211120113238.at5pfzs2xeu4gdze@pali>
References: <20211117160053.232158-1-maz@kernel.org>
 <20211117201245.GA1768803@bhelgaas>
 <20211117202859.2m5sqwz6xsjgldji@pali>
 <87o86h7pex.wl-maz@kernel.org>
 <20211118103156.r66aso2bklm7jnns@pali>
 <87k0h57h9x.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0h57h9x.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 November 2021 12:57:46 Marc Zyngier wrote:
> On Thu, 18 Nov 2021 10:31:56 +0000,
> Pali Rohár <pali@kernel.org> wrote:
> > For power-on it is probably overkill, but I think that delay between
> > flipping PERST# should be there. IIRC Compex WLE1216 wifi card needs to
> > be at least 10-11ms in reset. Last year, during testing of this card I
> > saw that if PERST#-based reset was shorter then card was completely
> > undetected.
> 
> The only delay we really need is Tperst-clk. Random bugs on random
> devices don't apply here, as the system is completely closed (there is
> no slot to add anything). Once we have TB running one of these days,
> we will see whether this still holds.

Ok!

> > > In practice, I can completely remove the initial Tpvperl delay (we
> > > have been powered-on for a long time already, and the clock is stable
> > > when we come back from setting it up), and cut the second one by half
> > > without observing any ill effect (though I feel safer keeping it to
> > > its nominal value).
> > 
> > My opinion is that this patch does not power on/off card in PCIe slot.
> > And because card is powered-on for a long time (as you wrote), it means
> > that Tpvperl delay does not apply here. That is why I think that
> > different delay (How long should be PCIe card in Warm Reset state)
> > should be used _between_ flipping PERST# signal.
> 
> My reading of the spec is that the only thing we need while #PERST is
> asserted is Tperst-clk. The value you keep arguing about doesn't seem
> to exist as such in the spec, because it appears to be endpoint
> specific.

Well, I was not able to find it in the spec too, that is why I do not
know...

> > And of course after the releasing PERST# that 100ms post-PERST# delay is
> > required.
> 
> That we agree on.
> 
> > I have an idea to move PERST# handling (with all delays) from controller
> > drivers to pci core functions. Because basically every driver
> > re-implements these delays in its probe function. I wrote this idea with
> > some details in email. If you have a time, could you look at it? I
> > summarized here also details about delays (like Tpvperl, Tperstclk, ..):
> > https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/
> 
> That's a laudable goal. What isn't clear to me is whether you intend
> to move the whole state machine into core code, or just have a set of
> helpers that the driver calls into. IMO, the former is what we really
> need, while the latter only rids us of the simple stuff.

Now I'm just collecting comments and feedbacks for this idea. I think
that state machine in core code is what we need.
