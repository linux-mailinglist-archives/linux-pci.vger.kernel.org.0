Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6795E3B0F0F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 22:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFVU5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 16:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhFVU5l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 16:57:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11D4660FE5;
        Tue, 22 Jun 2021 20:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624395325;
        bh=QYq03R8TgP3/BrQjbw8IXBjmbBYZVysDeLtDsr7q1rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaN63uXLNlBBC7e0UmKDG9W0tFV7/dDbXObST08es+cYQaovrSuhjTZ5pvtZ3z5WV
         Sted6xY8GUYLPfk6di7iPX2ADghyWQW+BifQO8XmsHEYxluBnVAGs9JOCrrbkXLd5R
         Op+3WyiJtVS78ZgabY2e72Q6tOQ9oNC/I4chVIAcI0dfEGlj5CJQkFqC5GBSZSGEVf
         kGJ0dzdYWXWYv8ZuquC4bR7HYFw6pHCMzvpuXafJ/ydNJ+vjqnTgBitlRq3cj//1WZ
         G0ZEaC51Q7OmUFYTx95yP7D3qooC4xbIF70rfJ/aZZY+Oq5X1WuPcRjTwJ8u9XxB/0
         ECbzrwdryOnBw==
Received: by pali.im (Postfix)
        id 62CBB889; Tue, 22 Jun 2021 22:55:22 +0200 (CEST)
Date:   Tue, 22 Jun 2021 22:55:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linus.walleij@linaro.org, kishon@ti.com,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210622205522.v2kdqkdu7obylhne@pali>
References: <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
 <20210622110627.aqzxxtf2j3uxfeyl@pali>
 <20210622115604.GA25503@lpieralisi>
 <20210622121649.ouiaecdvwutgdyy5@pali>
 <20210622142325.GA27099@lpieralisi>
 <20210622204846.s5z2brzhgkrsxs4f@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210622204846.s5z2brzhgkrsxs4f@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 22 June 2021 22:48:46 Pali Rohár wrote:
> On Tuesday 22 June 2021 15:23:25 Lorenzo Pieralisi wrote:
> > On Tue, Jun 22, 2021 at 02:16:49PM +0200, Pali Rohár wrote:
> > > On Tuesday 22 June 2021 12:56:04 Lorenzo Pieralisi wrote:
> > > > [Adding Linus for GPIO discussion, thread:
> > > > https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net]
> > > > 
> > > > On Tue, Jun 22, 2021 at 01:06:27PM +0200, Pali Rohár wrote:
> > > > > Hello!
> > > > > 
> > > > > On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
> > > > > > Nothing happened after a few weeks... I understand that knowing the
> > > > > > correct reset timings is relevant, but unfortunately I cannot help much
> > > > > > in finding out the correct values.
> > > > > > 
> > > > > > However I'm wondering what should happen to this patch. It *does* fix a
> > > > > > real bug, but potentially with an incorrect or non-optimal usleep range.
> > > > > > Do we really want to ignore a bugfix because we are not sure about how
> > > > > > long this delay should be?
> > > > > 
> > > > > As there is no better solution right now, I'm fine with your patch. But
> > > > > patch needs to be approved by Lorenzo, so please wait for his final
> > > > > answer.
> > > > 
> > > > I am not a GPIO expert and I have a feeling this is platform specific
> > > > beyond what the PCI specification can actually define architecturally.
> > > 
> > > In my opinion timeout is not platform specific as I wrote in email:
> > > https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> > > 
> > > My experiments already proved that some PCIe cards needs to be in reset
> > > state for some minimal time otherwise they cannot be enumerated. And it
> > > does not matter to which platform you connect those (endpoint) cards.
> > > 
> > > I do not think that timeout itself is platform specific. GPIO controls
> > > PERST# pin and therefore specified sleep value directly drives how long
> > > is card on the other end of PCIe slot in Warm Reset state. PCIe CEM spec
> > > directly says that PERST# signal controls PCIe Warm Reset.
> > 
> > Point taken but regardless this deviates from the PCI electromechanical
> > specifications (ie T-PERST-CLK), does not it ?
> 
> Well, I was not able to understand and decode PCIe base and PCIe CEM
> specs to figure out which timeout value should be used. You wrote about
> T-PERST-CLK but I'm really not sure if it is this one... Therefore I
> cannot say if something deviates from spec or not.
> 
> > I misused "platform" to
> > define something that apparently is not contemplated by the PCI
> > specifications (and I would like to understand why).
> >  
> > I guess on ACPI systems (ie where the PERST# handling is implemented in
> > FW) this is handled in BIOS/UEFI
> 
> PCIe base spec does not define any standard interface for controlling
> PCIe Warm Reset and PCIe CEM spec does not define any SW interface for
> PERST# pin. So every board / computer with PCIe slot may connect PERST#
> pin in different way to CPU. Some ARM boards connect all PERST# pins to
> just one GPIO, and so via SW you can reset all PCIe cards at the same
> time. No granularity to reset just one card. Some other connects all
> PERST# pin to CPU reset output pin, so when CPU / board resets it cause
> also reset of all PCIe cards.
> 
> I read that some server machines have some dedicated device connected to
> CPU via i2c/smbus, which controls PERST# pins for each PCIe slot
> individually. And on these machines people use userspace i2cset
> application to control PERST# and therefore can reset cards manually.
> 
> If ACPI / BIOS / UEFI system has some kind of PCIe support && PERST# is
> controller by software then for sure it needs to reset PCIe card (at
> least putting it from reset state to normal) prior trying to read PCI
> device/vendor ID from config space.
> 
> > need to peruse the code to check how
> > PERST# is handled and whether the delay is per host controller driver.
> 
> Are there any open source implementations? Or we are just limited to
> dump ACPI bytecode or BIOS / UEFI firmware and start reverse engineering
> it? Because this would not be simple.
> 
> And major problems with PCIe Warm Reset / PERST# signal I saw only on
> boards where there is no BIOS / UEFI / ACPI; just native PCIe controller
> drivers which talks directly to HW.
> 
> I was not able to find any way how to control PERST# on any my x86
> laptop (standard setup with UEFI and ACPI). So I'm even not sure if on
> x86 laptops is PERST# controllable by SW. I can imagine that this PIN
> may be connected to some reset circuit from Embedded Controller which
> may take full control of resetting card when it is needed at correct
> time.
> 
> So it is possible that code which controls PERST# on x86 does not have
> to run on CPU and may be "burned" as part of other hardware...
> 
> > > 
> > > What is here platform specific thing is that PERST# signal is controlled
> > > by GPIO. But value of signal (high / low) and how long is in signal in
> > > which state for me sounds like not an platform specific thing, but as
> > > PCIe / CEM related.
> > 
> > There are two different things to agree on this patch
> > 1) how GPIO drives PERST#
> 
> I'm not sure what do you mean by this 1). GPIO is set to output
> direction and can be either in low or high state. One of this states
> represents RESET state on PERST# pin and which it is (low or high) is
> defined by DTS (reset-gpio).
> 
> So setting GPIO with output direction to value 1 (active) always puts
> card into reset state and setting GPIO to value 0 (inactive) puts card
> into normal state.

Now I see what you mean. Some boards define in DTS that reset-gpio in
inactive state puts card into reset state. Which contradicts my lines...

> > 2) the PERST# de-assertion delay.
> 
> This is open question.
> 
> > I appreciate they are related and that Luca had to handle them together
> > but logically they are separated "issues", it'd be great if we manage
> > to nail down how they should be handled before we merge this code.
> > 
> > Lorenzo
> > 
> > > 
> > > > There are two things I'd like to see:
> > > > 
> > > > 1) If Linus can have a look at the GPIO bits in this thread that would
> > > >    definitely help clarify any pending controversy
> > > > 2) Kishon to test on *existing* platforms and confirm there are no
> > > >    regressions triggered
> > > > 
> > > > > I would suggest to add a comment for call "usleep_range(1000, 2000);"
> > > > > that you have chosen some "random" values which worked fine on your
> > > > > setup and that they fix mentioned bug. Comment just to mark this sleep
> > > > > code that is suboptimal / not-so-correct and to prevent other people to
> > > > > copy+paste this code into other (new) drivers...
> > > > 
> > > > Yes a comment would help but as I say above I am afraid this is
> > > > a platform specific set-up, ie that delay is somewhat tied to
> > > > a platform, not sure there is anything we can do.
> > > > 
> > > > If Linus and Kishon are happy with the approach we can merge this
> > > > patch.
> > > > 
> > > > Lorenzo
