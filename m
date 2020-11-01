Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F332A1F5B
	for <lists+linux-pci@lfdr.de>; Sun,  1 Nov 2020 16:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgKAP7A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Nov 2020 10:59:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:46897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgKAP7A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Nov 2020 10:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604246306;
        bh=qb6DRVxYaxT7D4MmCdO0NYQmm6IC0TrMSMy8foIKKz0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Uc2TWbp6pOWSJGk3I47l6u4tZf8IVzf6v74UF3D3SpaLZ+bkcUPdCtcESIFs5bcB2
         CKTR6loty4pdA16Wb2uAhDEXisqK4tHsP2Px/oNB2qQToH/Z9oKf478YGzznJPvjkQ
         OvXeHCikZw2P2Btm7BElVTtJxSkHTtncCeqRrtxg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.204] ([217.61.144.204]) by web-mail.gmx.net
 (3c-app-gmx-bap08.server.lan [172.19.172.78]) (via HTTP); Sun, 1 Nov 2020
 16:58:26 +0100
MIME-Version: 1.0
Message-ID: <trinity-65ad7212-0f00-45e4-b6ba-2ebf0d6ce496-1604246306570@3c-app-gmx-bap08>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        chuanjia.liu@mediatek.com
Subject: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 1 Nov 2020 16:58:26 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <87lfflti8q.wl-maz@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:fbRV6bMiFGC9Eh/64YsgpkDbiklowxEALlWU9GGzW2SwZpZ8kneSa0Kl2hTJSv1SAQvXa
 FR4pnUQiPjlnGGbQB1tbYrWkap2Cqje5PN0OmAPG4gjW3odE8PlRx85wGk1QLpPCSu/j/7+3AbLG
 4hRfQgicKbwHEheG+Bu6lnrCjVbqc6RwfJBVY3PutnyOtdobHcbzQsPBggrZUoCF7oiEOZUbsAsR
 6Yp16ARMbyWVrQNoE63B+n494PzUhCHnLJ34R3tm77xDb1M5avjXApZvPwvnNfnUg9JPfOPc1Zkw
 +U=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wywrOI65TLA=:OFTVISoufMGo1LNb6XlInw
 ErkrM60zMQQXwQcdNqWqUQJp1Z3DgDZHs1AtV6g7Gv91akpmHUNJuib3RqOF4lMV4RYD81uY6
 yYL0Q854EqDT4z74JFxbDkx7/X6MWAuUNfsoPqFUGPRoc2DmV8uj5mmKCKD/vw+fev2tBHvKP
 8aOf9Y04uLTn23Az4RP112HtpqAtyRm74ViZd2w4fFYJ9EGT4ex4fqxuEcZxE32G5RtWYTPwX
 N71M4CgP47D/+ChshFjAuT/b67b02TzzK1tOdF0WyeIXBmQ+6MuX1u0WzpIKm2wDyFTLsUtER
 dofNY613JQ23d/Jp4LBN4T1/2O++whlbnrR+18V7EI/uZUWj83TVkyrx3fmd8kjR6AMAwhTWJ
 RuRjjAEJXhIXzf6VJSeQGzht1OLsbfv9XYcIADMHU6d2mvwJb1YuN7e3KlGOyMy3LBdCK5URs
 P9NVNhBRzBfMNoZoFMu+OnubyHNeZOmqoPsDiy3NFc60lVJraa5InIiYATj7r0Fe2/gPzWfvi
 WUq0QvVLv7xZG0WEUktvidhJogX5ozxv0axHo9lo5Dnv2wXU0NHwr7gWfL8PiI7+VgGniYi4n
 3hR3Tm4Zm2ukM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> Gesendet: Sonntag, 01. November 2020 um 12:43 Uhr
> Von: "Marc Zyngier" <maz@kernel.org>

> On Sun, 01 Nov 2020 09:25:04 +0000,
> Frank Wunderlich <frank-w@public-files.de> wrote:

> > It looks like for mt7623 there is no msi domain setup (done via
> > mtk_pcie_setup_irq callback + mtk_pcie_init_irq_domain) in mtk pcie
> > driver.
>
> Does this mean that this SoC never handled MSIs the first place? Which
> would explain the warning, as there is no MSI domain registered for
> the device, and we end-up falling back to arch_setup_msi_irqs().

i tried 5.10-rc1 (without my patch of course) on bananapi-r64 to check if =
driver
on mt7622 works better (this does setup a msi-domain in pcie-driver)....an=
d i got no warning.
so mt7623 needs to create an msi-domain or handle it in the correct way e.=
g.
by returning -ENOSPC like in your code.

> If this system truly is unable to handle MSIs, one potential
> workaround would be to register a PCI-MSI domain that would always
> fail its allocation with -ENOSPC. It is really ugly, but would keep
> the horror localised. See the patchlet below, which I can't test.
>
> If this situation is more common than we expect, we may need something
> in core code instead.

thanks for your code-example, here we need a response from MTK (CC'd Chuan=
jia Liu)

regards Frank
