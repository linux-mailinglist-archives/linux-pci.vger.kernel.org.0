Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8106C3B0367
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFVL60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 07:58:26 -0400
Received: from foss.arm.com ([217.140.110.172]:47912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhFVL60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 07:58:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CCFF11D4;
        Tue, 22 Jun 2021 04:56:10 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 186C93F694;
        Tue, 22 Jun 2021 04:56:08 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:56:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linus.walleij@linaro.org, kishon@ti.com
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210622115604.GA25503@lpieralisi>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
 <20210622110627.aqzxxtf2j3uxfeyl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210622110627.aqzxxtf2j3uxfeyl@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Adding Linus for GPIO discussion, thread:
https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net]

On Tue, Jun 22, 2021 at 01:06:27PM +0200, Pali Rohár wrote:
> Hello!
> 
> On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
> > Nothing happened after a few weeks... I understand that knowing the
> > correct reset timings is relevant, but unfortunately I cannot help much
> > in finding out the correct values.
> > 
> > However I'm wondering what should happen to this patch. It *does* fix a
> > real bug, but potentially with an incorrect or non-optimal usleep range.
> > Do we really want to ignore a bugfix because we are not sure about how
> > long this delay should be?
> 
> As there is no better solution right now, I'm fine with your patch. But
> patch needs to be approved by Lorenzo, so please wait for his final
> answer.

I am not a GPIO expert and I have a feeling this is platform specific
beyond what the PCI specification can actually define architecturally.

There are two things I'd like to see:

1) If Linus can have a look at the GPIO bits in this thread that would
   definitely help clarify any pending controversy
2) Kishon to test on *existing* platforms and confirm there are no
   regressions triggered

> I would suggest to add a comment for call "usleep_range(1000, 2000);"
> that you have chosen some "random" values which worked fine on your
> setup and that they fix mentioned bug. Comment just to mark this sleep
> code that is suboptimal / not-so-correct and to prevent other people to
> copy+paste this code into other (new) drivers...

Yes a comment would help but as I say above I am afraid this is
a platform specific set-up, ie that delay is somewhat tied to
a platform, not sure there is anything we can do.

If Linus and Kishon are happy with the approach we can merge this
patch.

Lorenzo
