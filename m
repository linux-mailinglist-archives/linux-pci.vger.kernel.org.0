Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3053B0755
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFVOZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 10:25:50 -0400
Received: from foss.arm.com ([217.140.110.172]:50244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhFVOZt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 10:25:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A0CC31B;
        Tue, 22 Jun 2021 07:23:33 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C1923F694;
        Tue, 22 Jun 2021 07:23:32 -0700 (PDT)
Date:   Tue, 22 Jun 2021 15:23:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linus.walleij@linaro.org, kishon@ti.com,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210622142325.GA27099@lpieralisi>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
 <20210622110627.aqzxxtf2j3uxfeyl@pali>
 <20210622115604.GA25503@lpieralisi>
 <20210622121649.ouiaecdvwutgdyy5@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210622121649.ouiaecdvwutgdyy5@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22, 2021 at 02:16:49PM +0200, Pali Rohár wrote:
> On Tuesday 22 June 2021 12:56:04 Lorenzo Pieralisi wrote:
> > [Adding Linus for GPIO discussion, thread:
> > https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net]
> > 
> > On Tue, Jun 22, 2021 at 01:06:27PM +0200, Pali Rohár wrote:
> > > Hello!
> > > 
> > > On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
> > > > Nothing happened after a few weeks... I understand that knowing the
> > > > correct reset timings is relevant, but unfortunately I cannot help much
> > > > in finding out the correct values.
> > > > 
> > > > However I'm wondering what should happen to this patch. It *does* fix a
> > > > real bug, but potentially with an incorrect or non-optimal usleep range.
> > > > Do we really want to ignore a bugfix because we are not sure about how
> > > > long this delay should be?
> > > 
> > > As there is no better solution right now, I'm fine with your patch. But
> > > patch needs to be approved by Lorenzo, so please wait for his final
> > > answer.
> > 
> > I am not a GPIO expert and I have a feeling this is platform specific
> > beyond what the PCI specification can actually define architecturally.
> 
> In my opinion timeout is not platform specific as I wrote in email:
> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> 
> My experiments already proved that some PCIe cards needs to be in reset
> state for some minimal time otherwise they cannot be enumerated. And it
> does not matter to which platform you connect those (endpoint) cards.
> 
> I do not think that timeout itself is platform specific. GPIO controls
> PERST# pin and therefore specified sleep value directly drives how long
> is card on the other end of PCIe slot in Warm Reset state. PCIe CEM spec
> directly says that PERST# signal controls PCIe Warm Reset.

Point taken but regardless this deviates from the PCI electromechanical
specifications (ie T-PERST-CLK), does not it ? I misused "platform" to
define something that apparently is not contemplated by the PCI
specifications (and I would like to understand why).
 
I guess on ACPI systems (ie where the PERST# handling is implemented in
FW) this is handled in BIOS/UEFI - need to peruse the code to check how
PERST# is handled and whether the delay is per host controller driver.

> 
> What is here platform specific thing is that PERST# signal is controlled
> by GPIO. But value of signal (high / low) and how long is in signal in
> which state for me sounds like not an platform specific thing, but as
> PCIe / CEM related.

There are two different things to agree on this patch 1) how GPIO drives
PERST# 2) the PERST# de-assertion delay.

I appreciate they are related and that Luca had to handle them together
but logically they are separated "issues", it'd be great if we manage
to nail down how they should be handled before we merge this code.

Lorenzo

> 
> > There are two things I'd like to see:
> > 
> > 1) If Linus can have a look at the GPIO bits in this thread that would
> >    definitely help clarify any pending controversy
> > 2) Kishon to test on *existing* platforms and confirm there are no
> >    regressions triggered
> > 
> > > I would suggest to add a comment for call "usleep_range(1000, 2000);"
> > > that you have chosen some "random" values which worked fine on your
> > > setup and that they fix mentioned bug. Comment just to mark this sleep
> > > code that is suboptimal / not-so-correct and to prevent other people to
> > > copy+paste this code into other (new) drivers...
> > 
> > Yes a comment would help but as I say above I am afraid this is
> > a platform specific set-up, ie that delay is somewhat tied to
> > a platform, not sure there is anything we can do.
> > 
> > If Linus and Kishon are happy with the approach we can merge this
> > patch.
> > 
> > Lorenzo
