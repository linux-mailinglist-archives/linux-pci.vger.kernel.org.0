Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727993B040F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 14:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhFVMTN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 08:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231464AbhFVMTJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 08:19:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27BD2611CE;
        Tue, 22 Jun 2021 12:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624364213;
        bh=+DSoQii3QA6TNarjz5jdOxe8E+65XqNOB0H4z1VVg/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUosdjs1ssfAL/o0RkE2+ODxWK+fo636fpSl89g0ENmRCX5LIIq+VfQwpAwn09spb
         Njb6ysVBXcl8LyNzd8UDYlf+VP2qbSkBGh0rzi4n4DWYfKwXK0B+SUMvf8UCkBhN41
         M9ZznVnwo9BAxhNkMNnHxO564RJBnhCeopkCJkQ6JQ1E9p9UwrMzvC4VBVIyz4Widr
         ZqL5mJpAaGsj8YPUWtCyvA0MMbC6O++jVt0n2s8mQQdjG35+UGym/N9imsiyW2i8Y0
         gmGQprIsJ3ecWqdcekUnet809cl1EWH88cqqUks0ln1t6VWrxSrez+uQGFMZO/RzZu
         e0qYDySCGZWzw==
Received: by pali.im (Postfix)
        id D9595889; Tue, 22 Jun 2021 14:16:49 +0200 (CEST)
Date:   Tue, 22 Jun 2021 14:16:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linus.walleij@linaro.org, kishon@ti.com,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210622121649.ouiaecdvwutgdyy5@pali>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
 <20210622110627.aqzxxtf2j3uxfeyl@pali>
 <20210622115604.GA25503@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210622115604.GA25503@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 22 June 2021 12:56:04 Lorenzo Pieralisi wrote:
> [Adding Linus for GPIO discussion, thread:
> https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net]
> 
> On Tue, Jun 22, 2021 at 01:06:27PM +0200, Pali Rohár wrote:
> > Hello!
> > 
> > On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
> > > Nothing happened after a few weeks... I understand that knowing the
> > > correct reset timings is relevant, but unfortunately I cannot help much
> > > in finding out the correct values.
> > > 
> > > However I'm wondering what should happen to this patch. It *does* fix a
> > > real bug, but potentially with an incorrect or non-optimal usleep range.
> > > Do we really want to ignore a bugfix because we are not sure about how
> > > long this delay should be?
> > 
> > As there is no better solution right now, I'm fine with your patch. But
> > patch needs to be approved by Lorenzo, so please wait for his final
> > answer.
> 
> I am not a GPIO expert and I have a feeling this is platform specific
> beyond what the PCI specification can actually define architecturally.

In my opinion timeout is not platform specific as I wrote in email:
https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/

My experiments already proved that some PCIe cards needs to be in reset
state for some minimal time otherwise they cannot be enumerated. And it
does not matter to which platform you connect those (endpoint) cards.

I do not think that timeout itself is platform specific. GPIO controls
PERST# pin and therefore specified sleep value directly drives how long
is card on the other end of PCIe slot in Warm Reset state. PCIe CEM spec
directly says that PERST# signal controls PCIe Warm Reset.

What is here platform specific thing is that PERST# signal is controlled
by GPIO. But value of signal (high / low) and how long is in signal in
which state for me sounds like not an platform specific thing, but as
PCIe / CEM related.

> There are two things I'd like to see:
> 
> 1) If Linus can have a look at the GPIO bits in this thread that would
>    definitely help clarify any pending controversy
> 2) Kishon to test on *existing* platforms and confirm there are no
>    regressions triggered
> 
> > I would suggest to add a comment for call "usleep_range(1000, 2000);"
> > that you have chosen some "random" values which worked fine on your
> > setup and that they fix mentioned bug. Comment just to mark this sleep
> > code that is suboptimal / not-so-correct and to prevent other people to
> > copy+paste this code into other (new) drivers...
> 
> Yes a comment would help but as I say above I am afraid this is
> a platform specific set-up, ie that delay is somewhat tied to
> a platform, not sure there is anything we can do.
> 
> If Linus and Kishon are happy with the approach we can merge this
> patch.
> 
> Lorenzo
