Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8B1536F18
	for <lists+linux-pci@lfdr.de>; Sun, 29 May 2022 04:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiE2CLY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 May 2022 22:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiE2CLX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 May 2022 22:11:23 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B782A8;
        Sat, 28 May 2022 19:11:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y131so2731127oia.6;
        Sat, 28 May 2022 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=smiwtbi/0KCKQ9mAxuPcwH47K9rL1ME6DA+PRBcWPyA=;
        b=ma2BZ8i4KKcn6aDYzmcJdLkipZraQNaNX1gxwNPeTJEV7ZYi9qFsX4ectiwrFmcss0
         96e3NgEd1L8XuzHduzIIIUl1iqoOoFbiqYoDYnDy7Fl/kJRrA1EXhsIZdt7QW7svhQ5j
         OUombPD77hZLviNC7jrIhGpF8srctEdyyPBEuUIzK1ODNpBPjNrFTOsdbaNax+/il5CL
         I+wSPW2IlwGKl2jwe4yljp2waTo0Ludu3NI/uRFkJxJB2PvfG8tS8QWY7i59dd6iPFIA
         GRkE1rzZT9hf+XMLTJ/JuPNzCXZYBC8ETQkJCbvtt87Z1naEz83EA42ljSunQuRjzaAX
         TxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=smiwtbi/0KCKQ9mAxuPcwH47K9rL1ME6DA+PRBcWPyA=;
        b=aY67XkU91/Q4EDL8iEMgRZsTtQsLSu6K7tf9Gaj3GN5Sru4CODzlptoEq+M8nCFV83
         pjh6SSXtvitQHTqCaEjU9b5w9RSpgXoykiXm00/0DSiuN+ye8tYoA26tuWTmtbQtlu5I
         7nImUkKcXhssmPdQGDcej1yLvQ56ysqnOv3ui0WQyj8tR4RvkhfaIEjKk+vdVKAlnbS6
         vh0bd4LpiaYo1Fqs8dfo0e4bXZ0pZ/HodVg6SQ0aZ4yoSZk5N5OucTeQ5OIDCb27/gHJ
         dRqSEdpoGhJE8rm9vcGGfDTroBeRtiYdq2XB2F/R3udiSWlBUfbT52/IMaKhYrIUUf7x
         tnuw==
X-Gm-Message-State: AOAM532p596TE4f64CMkjqddb7tLLXSD+pGlXjk5BvI8WOWdumPwV4/P
        ASB6b1ISG9Ac5ycDfmZY6sHhYcSkvk9DK+EzBXU=
X-Google-Smtp-Source: ABdhPJx+kRriykk8K/OOKZ2b7La96R0lYMDM7upPEK4Xa37+RL/3ASeemnFqUaBEhPDtwc22HhFRHZJAG5W2qavBN3c=
X-Received: by 2002:a05:6808:1825:b0:32b:a1e9:fdb6 with SMTP id
 bh37-20020a056808182500b0032ba1e9fdb6mr7107048oib.73.1653790281356; Sat, 28
 May 2022 19:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220528224423.7017-1-jim2101024@gmail.com> <20220528224423.7017-2-jim2101024@gmail.com>
 <20220529011526.4lzuvkv5zclwntce@mraw.org>
In-Reply-To: <20220529011526.4lzuvkv5zclwntce@mraw.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Sat, 28 May 2022 22:11:10 -0400
Message-ID: <CANCKTBvPxxNnVCpo3ZQ9ZkFYCeGBhg4gngjONYo5KqRrF-JWsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing
 PCIe linkup
To:     Cyril Brulebois <kibi@debian.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 28, 2022 at 9:15 PM Cyril Brulebois <kibi@debian.org> wrote:
>
> Hi Jim,
>
> Jim Quinlan <jim2101024@gmail.com> (2022-05-28):
> > commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage re=
gulators")vpcie3v3-supply
> >
> > introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
> > root port DT node described in [2] was missing, no linkup would be atte=
mpted,
> > and subsequent accesses would cause a panic because this particular PCI=
e HW
> > causes a CPU abort on illegal accesses (instead of returning 0xffffffff=
).
> >
> > We fix this by allowing the DT root port node to be missing, as it beha=
ved
> > before the original patchset messed things up.
> >
> > In addition, two small changes are made:
> >
> >   1. Having pci_subdev_regulators_remove_bus() call
> >      regulator_bulk_free() in addtion to regulator_bulk_disable().
> >   2. Having brcm_pcie_add_bus() return 0 if there is an
> >      error in calling pci_subdev_regulators_add_bus().
> >      Instead, we dev_err() and turn on our refusal mode instead.
> >
> > It would be best if this commit were tested by someone with a Rpi CM4
> > platform, as that is how the regression was found.  I have only emulate=
d
> > the problem and fix on different platform.
>
> Testing is less flawless than it was with the earlier version, but this
> might be related to the fact master has moved a lot since then (from
> v5.18-rcX to open merge window).
>
> Overall, it's still a net win over the status quo (broken boot).
>
>
> Applying your patch on 664a393a2663a0f62fc1b18157ccae33dcdbb8c8 and
> performing cold boots is mostly fine:
>  - without anything on the PCIe slot;
>  - with a PCIe=E2=86=92quad-USB extension board, a USB keyboard and a USB=
 stick
>    (both work fine).
>
> However, with an empty PCIe slot, I'm no longer able to perform the
> following (which was rock solid, and has been used in all my testing up
> to now):
>  - boot the exact same Debian stable image as before (running v5.10.y if
>    that matters);
>  - deploy the patched kernel;
>  - enable serial console;
>  - reboot into the patched kernel.
Hi Cyril,

Thanks for the quick response.  As you may have guessed our CM4 did
not arrive yet although we did get the CM4 IO
board.  I don't know if you have the bandwidth to try one or both of
these tests:

(1) Same experiment except remove the V2 commit and use my V1 commit.
Unless this is exactly what you tried before.
(2) Same experiment except commenting out the call I made to
regulator_bulk_free().


>
> PCI-related messages, a call trace, and broken storage:
>
>     [    3.425331] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d50000=
0 ranges:
>     [    3.425353] brcm-pcie fd500000.pcie:   No bus range found for /scb=
/pcie@7d500000, using [bus 00-ff]
>     [    3.425388] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603=
ffffff -> 0x00f8000000
>     [    3.425420] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x003f=
ffffff -> 0x0400000000
>     [    3.426229] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:0=
0
>     [    3.426243] pci_bus 0000:00: root bus resource [bus 00-ff]
>     [    3.426255] pci_bus 0000:00: root bus resource [mem 0x600000000-0x=
603ffffff] (bus address [0xf8000000-0xfbffffff])
>     [    3.426303] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
>     [    3.426398] pci 0000:00:00.0: PME# supported from D0 D3hot
>     [    3.428797] pci 0000:00:00.0: bridge configuration invalid ([bus 0=
0-00]), reconfiguring
>     [    3.745909] brcm-pcie fd500000.pcie: link down
>     [    3.747915] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated =
to 01
>     [    3.747944] pci 0000:00:00.0: PCI bridge to [bus 01]
>     [    3.748294] pcieport 0000:00:00.0: PME: Signaling with IRQ 23
>     [    3.748691] pcieport 0000:00:00.0: AER: enabled with IRQ 23
>     [    3.749201] pci_bus 0000:01: busn_res: [bus 01] is released
>     [    3.749462] pci_bus 0000:00: busn_res: [bus 00-ff] is released
>     =E2=80=A6
Does "..." here mean you removed some lines or that it hung?  If you
removed lines can you please post the
full bootlog?  I do not need to see the mmc0 sdhci errors though.

>     [    5.617308] irq 35: nobody cared (try booting with the "irqpoll" o=
ption)
>     [    5.617335] CPU: 0 PID: 127 Comm: systemd-udevd Not tainted 5.18.0=
+ #1
>     [    5.617350] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (=
DT)
>     [    5.617358] Call trace:
>     [    5.617362]  dump_backtrace+0xc0/0x130
>     [    5.617386]  show_stack+0x24/0x70
>     [    5.617396]  dump_stack_lvl+0x68/0x84
>     [    5.617415]  dump_stack+0x18/0x34
>     [    5.617426]  __report_bad_irq+0x54/0x16c
>     [    5.617436]  note_interrupt+0x324/0x41c
>     [    5.617445]  handle_irq_event+0xc0/0x180
>     [    5.617460]  handle_fasteoi_irq+0xc8/0x1fc
>     [    5.617468]  generic_handle_domain_irq+0x38/0x50
>     [    5.617481]  gic_handle_irq+0x68/0xa0
>     [    5.617489]  call_on_irq_stack+0x2c/0x60
>     [    5.617500]  do_interrupt_handler+0x88/0x90
>     [    5.617511]  el0_interrupt+0x58/0x124
>     [    5.617526]  __el0_irq_handler_common+0x18/0x2c
>     [    5.617538]  el0t_64_irq_handler+0x10/0x20
>     [    5.617549]  el0t_64_irq+0x18c/0x190
>     [    5.617558] handlers:
>     [    5.617563] [<(____ptrval____)>] sdhci_irq [sdhci] threaded [<(___=
_ptrval____)>] sdhci_thread_irq [sdhci]
>     [    5.617613] Disabling IRQ #35
>     =E2=80=A6
>     [   15.581894] mmc0: Timeout waiting for hardware cmd interrupt.
>     [   15.581914] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHC=
I REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     [   15.581920] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001=
002
>     [   15.581931] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000=
000
>     [   15.581937] mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000=
000
>     [   15.581944] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000=
001
>     [   15.581951] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000=
080
>     [   15.581957] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00007=
d07
>     [   15.581964] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00018=
000
>     [   15.581971] mmc0: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1=
003
>     [   15.581976] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000=
001
>     [   15.581982] mmc0: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a=
525
>     [   15.581988] mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00080=
008
>     [   15.581996] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000=
000
>     [   15.582001] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000=
000
>     [   15.582005] mmc0: sdhci: Host ctl2: 0x00000000
>     [   15.582011] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000=
000
>     [   15.582016] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> This last part gets repeated over and over, and storage (external SD
> card) never comes up. I can share fuller logs if that's desirable. I can
the
full bootlog?

>     [    5.617308] irq 35: nobody cared (try booting with the "irqpoll" o=
ption)
>     [    5.617335] CPU: 0 PID: 127 Comm: systemd-udevd Not tainted 5.18.0=
+ #1
>     [    5.617350] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (=
DT)
>     [    5.617358] Call trace:
>     [    5.617362]  dump_backtrace+0xc0/0x130
>     [    5.617386]  show_stack+0x24/0x70
>     [    5.617396]  dump_stack_lvl+0x68/0x84
>     [    5.617415]  dump_stack+0x18/0x34
>     [    5.617426]  __report_bad_irq+0x54/0x16c
>     [    5.617436]  note_interrupt+0x324/0x41c
>     [    5.617445]  handle_irq_event+0xc0/0x180
>     [    5.617460]  handle_fasteoi_irq+0xc8/0x1fc
>     [    5.617468]  generic_handle_domain_irq+0x38/0x50
>     [    5.617481]  gic_handle_irq+0x68/0xa0
>     [    5.617489]  call_on_irq_stack+0x2c/0x60
>     [    5.617500]  do_interrupt_handler+0x88/0x90
>     [    5.617511]  el0_interrupt+0x58/0x124
>     [    5.617526]  __el0_irq_handler_common+0x18/0x2c
>     [    5.617538]  el0t_64_irq_handler+0x10/0x20
>     [    5.617549]  el0t_64_irq+0x18c/0x190
>     [    5.617558] handlers:
>     [    5.617563] [<(____ptrval____)>] sdhci_irq [sdhci] threaded [<(___=
_ptrval____)>] sdhci_thread_irq [sdhci]
>     [    5.617613] Disabling IRQ #35
>     =E2=80=A6
>     [   15.581894] mmc0: Timeout waiting for hardware cmd interrupt.
>     [   15.581914] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHC=
I REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     [   15.581920] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001=
002
>     [   15.581931] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000=
000
>     [   15.581937] mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000=
000
>     [   15.581944] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000=
001
>     [   15.581951] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000=
080
>     [   15.581957] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00007=
d07
>     [   15.581964] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00018=
000
>     [   15.581971] mmc0: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1=
003
>     [   15.581976] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000=
001
>     [   15.581982] mmc0: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a=
525
>     [   15.581988] mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00080=
008
>     [   15.581996] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000=
000
>     [   15.582001] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000=
000
>     [   15.582005] mmc0: sdhci: Host ctl2: 0x00000000
>     [   15.582011] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000=
000
>     [   15.582016] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> also test booting with irqpoll if that's desirable. Or anything else tha=
t
> might help.
I have seen this before and I do not think it is related to my V2
commit. Nonetheless, let us
assume that it is related until we can prove otherwise.

>
>
> I did check that applying the same patch on top of the v5.18 tag gives
> good results (cold boots and reboots are fine, with or without an empty
> PCIe slot, as that was the case during earlier test sessions), so I'd
> guess something changed since then, and makes reboots more brittle than
> they used to be.
Okay, that's why I'd like to see if my v1 works and the v2 doesn't.  That
will tell me a lot.

Kind regards,
Jim Quinlan
Broadcom STB
>
> I can also check applying the v1 patch on top of master and compare
> results, to give a different perspective.
>
> But I'd also be happy to get some directions as to which test(s) would
> be most beneficial, which would help me cut down on combinatorics.
>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant
