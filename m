Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68C373BE6
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhEENDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 09:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233225AbhEENDk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 09:03:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EB3861132;
        Wed,  5 May 2021 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620219763;
        bh=vbcgKT/KBNDfTI6iejkJ6R6+jF1Xf/tOizxPW/ohYYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=no3gCAliPLiKh/UnfDJiOwoYRwECNLicXCB9PzRxlqCTSqJs75au75lstWDIgIii5
         aId0gwMpnROJ3Pwrxzxv9cQ8wcPegYhSjtyBP1m460OLAdcUpSuwi+D9I9kkoBybi3
         It0J9+A63cm99stlpZV+er9XzUCkZASlYcaO9wGRMn7eEZHt00isilsh6kTWcogueI
         +Ueh4VO1zAfu0A4qdhQznuw6qAYFEK5vvrxEZ9U4ERBmdAiDLtatxSaOtToU9YVPKf
         /E8AyVXGUuW1J6YgGwthMcrfU+FuKpKaf0ZxbcMBZcimqyHvUFJgUyHENCxZfcL0nz
         N0VlOIvTJoOcQ==
Received: by pali.im (Postfix)
        id E565379D; Wed,  5 May 2021 15:02:40 +0200 (CEST)
Date:   Wed, 5 May 2021 15:02:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: xhci_pci & PCIe hotplug crash
Message-ID: <20210505130240.lmryb26xffzkg4pl@pali>
References: <20210505120117.4wpmo6fhvzznf3wv@pali>
 <YJKK7SDIaeH1L/fC@kroah.com>
 <20210505123346.kxfpumww5i4qmhnk@pali>
 <20210505124402.GB29101@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505124402.GB29101@wunner.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 05 May 2021 14:44:02 Lukas Wunner wrote:
> On Wed, May 05, 2021 at 02:33:46PM +0200, Pali Rohár wrote:
> > I just spotted this crash during debugging PCIe controller driver
> > pci-aardvark.c with trying to expose its link down events via "hot plug"
> > interrupt and corresponding link layer state flags.
> > 
> > And because in whole call trace I see only generic PCIe and USB code
> > path without any driver specific parts, I suspect that this is not PCIe
> > controller-specific issue but rather something "wrong" in genetic PCIe
> > (or USB) code. That is why I sent this email, so maybe somebody else
> > find something suspicious here.
> > 
> > But still there is a chance that issue can be also in pci-aardvark.c
> > driver and somehow it masked its issue and propagated it into generic
> > PCIe hot plug code path.
> 
> If you hot-remove the XHCI controller, accesses to its MMIO space
> will fail.  xhci_irq() seems to perform such MMIO accesses.

That abort happens at offset 4d00, here is part of objdump:

        if (!arch_irqs_disabled_flags(flags))
    4ccc:       340014a0        cbz     w0, 4f60 <xhci_irq+0x2d0>
    4cd0:       d2800000        mov     x0, #0x0                        // #0
    4cd4:       910a7276        add     x22, x19, #0x29c
    4cd8:       52800022        mov     w2, #0x1                        // #1
    4cdc:       f98002d1        prfm    pstl1strm, [x22]
    4ce0:       885ffec1        ldaxr   w1, [x22]
    4ce4:       4a000023        eor     w3, w1, w0
    4ce8:       35000063        cbnz    w3, 4cf4 <xhci_irq+0x64>
    4cec:       88037ec2        stxr    w3, w2, [x22]
    4cf0:       35ffff83        cbnz    w3, 4ce0 <xhci_irq+0x50>
    4cf4:       35002741        cbnz    w1, 51dc <xhci_irq+0x54c>
        status = readl(&xhci->op_regs->status);
    4cf8:       f9400f41        ldr     x1, [x26, #24]
    4cfc:       91001021        add     x1, x1, #0x4
    4d00:       b9400021        ldr     w1, [x1]

So it looks like it is that MMIO access, right?

> Normally this should happen silently and MMIO accesses just return
> with a fabricated "all ones" response.  Chances are however that the
> Aardvark controller raises a synchronous external abort instead.

This makes sense. Good catch lso with fact that it is from threaded
context!

> Perhaps you can teach it not to do that.

No :-( I read all documentation which is available for this PCIe
controller, part of Marvell A3720 SoC and I have not found anything
which allows me to configure raising external aborts.

I already figured out that CPU receive external abort also when trying
to issue a new PIO transfer for accessing PCI config space while
previous transfer has not finished yet. And also there is no way (at
least in documentation) which allows to "mask" this external abort. But
this issue can be fixed in pci-aardvark.c driver to disallow access to
config space while previous transfer is still running (I will send patch
for this one).

So seems that PCIe controller HW triggers these external aborts when
device on PCIe bus is not accessible anymore.

If this issue is really caused by MMIO access from xhci driver when
device is not accessible on the bus anymore, can we do something to
prevent this kernel crash? Somehow mask that external abort in kernel
for a time during MMIO access?

> Thanks,
> 
> Lukas
