Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0459C6E7C7C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDSOYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjDSOYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 10:24:42 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1205976A5;
        Wed, 19 Apr 2023 07:24:06 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id v18so11658030uak.8;
        Wed, 19 Apr 2023 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681914239; x=1684506239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1WTh5tAbWrd9+DY82MbH//HicCuqopdYUorpC0WJeI=;
        b=aL0NggV3xngUc/myEWqZ8Lqe3xTihoNP1mh0oyQmYj5CTAM9w6utd8P6PKieuJ15UQ
         nEYBRykLlkr4OSG9xMZB9Tbi1Hs4osdnoMicliQMd5cB0tw54A3R7bgmM4mYMuTuSiT+
         8aHHChZEbWsmjXPkGqH0XV9z2atkh1YayZag87tLWMk15NeSJmPk7AJkmBE6TiJUKR+f
         BOzi9gNI7f293MQNHVcuJbihPbwtBYDXbRga/CEv4/YgkQzU3GskB10/dzPzTmqxwftQ
         czlzSUlTKpaRiGjlMVQvBP5WqJgJk5ipNUcF78Ft1cwfTwrlTEDU52h764TbuuHFAYnj
         Oc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914239; x=1684506239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1WTh5tAbWrd9+DY82MbH//HicCuqopdYUorpC0WJeI=;
        b=PVxpD7joEyjejw2T/ZT9ND5gPOFNW+6LTxDfIMK3a2Syp1AD0Dr1Y7izAPddnI71UI
         VfnMR1fUFQK0ND5Y7zuU1H6BV97Q5fSGYB2+eSCsDhvDJ999ovsvoMpnYxpoOgA9mpTA
         v75MsknEGO5CUr0at8eiJbIfnowj5uJVlvFloN5xMWlpYe9p+eLwW8fblkXkraN2y0mD
         6x9AoHPp8Vno2uiwXWEgvpJT738hVhQ9oQITSz/YYg1VZ2nTbW1sFIElHAmKjRqm646w
         wUp5EFD63BWg6kpl3TkWgQNFnZUCi1EQlFKIC5ffmkTe4slojlXLVxpC7dbEqieh1tgM
         Otmg==
X-Gm-Message-State: AAQBX9dSsgBSNbjQbPtafKdiyL2VIBXShx9WT0QIpBhJ9sR48qFA+rCu
        XgbkRSBVp+XWTpW3uy7pgt4NOHmm8fSzlfNemmE=
X-Google-Smtp-Source: AKy350ZFyn5W2/GGnxLxLBg+Iw3saMmI1Tp1Q2pTC75/oCOfXytsakfO7PSjFu6Sg9RCdp3xARNoSLTReRizaWX05mk=
X-Received: by 2002:a1f:4305:0:b0:43b:eed8:98a4 with SMTP id
 q5-20020a1f4305000000b0043beed898a4mr99817vka.7.1681914239159; Wed, 19 Apr
 2023 07:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230411165919.23955-1-jim2101024@gmail.com> <20230411165919.23955-3-jim2101024@gmail.com>
 <20230413143935.pmbyjk2boxl3rwne@mraw.org> <CANCKTBtXKAYf1LxR4qN+dVyxsWgyDztUVB4EdG=xhHbuhNCq5w@mail.gmail.com>
 <20230413200646.ddgsoqgmaae343nl@mraw.org> <CANCKTBuZ=Hxy9WgnjbauhHqXGx4QU_t8pgX=3che2K89=2BT9A@mail.gmail.com>
 <85a1cca1-f59b-6a0c-dee3-9d9ed5d6b6d1@gmail.com> <20230414161907.zfd2ibshfx4rz56j@mraw.org>
In-Reply-To: <20230414161907.zfd2ibshfx4rz56j@mraw.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 19 Apr 2023 10:23:47 -0400
Message-ID: <CANCKTBsgkv-8cCMi+H=3xYrdgVcDVTRNczg667L7b=DH2J76Bw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream device
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 14, 2023 at 12:19=E2=80=AFPM Cyril Brulebois <kibi@debian.org> =
wrote:
>
> Florian Fainelli <f.fainelli@gmail.com> (2023-04-14):
> > Cyril, based upon the table and logs you provided whereby you have used=
 the
> > following:
> >
> > - Raspberry Pi Compute Module 4 (Rev 1.0, 8G RAM, 32G storage)
> > - Raspberry Pi Compute Module 4 IO Board
> > - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
> >
> > in the before/unpatched case we have a PCIe link down and in the
> > after/patched we have a PCIe link up but a kernel panic. Neither are gr=
eat
> > nor resulting in a fully functional PCIe device.
>
> Based on Jim's feedback, I'm attaching a new dmesg for the aforementioned
> setup, with an unpatched kernel (dmesg-unpatched-pcie-link-up.txt).

Hello Cyril,

I'm still seeing things in the logs that do not make sense to me.

First, the "unpatched" version logs -- including the Raspian case --
all have the following lines:

    [    0.000000] Movable zone start for each node
    /* ... */
    [    0.000000] pcpu-alloc: s88232 r8192 d30552 u126976 alloc=3D31*4096
    [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3

The above lines are also in my logs.  But they are missing from your
"after patch" logs -- what did you  change to have these lines
disappear on the patched logs?

Second, you say that you used a different "CM4" from the one used in
the Bugzilla  report -- what do you mean by that?   Are you referring
to the CM4 module proper, whose only change was going from 4GB to 8GB,
or the IO board being used?  My  testing is done with a standard RPi
CM4 and standard RPi IO board.  Before this patch series, the only way
this standard configuration can work for most hobbyist PCI cards (i.e.
floating CLKREQ# pin) is by using Raspian AND adding
"brcm,enable-l1ss" to the DT node.

I'm guessing that you are using the configuration that you described
to me in  a personal email: "[the] chip is embedded directly on the
modified PCB, as opposed to plugged into the PCIe slot on the official
CM4 IO Board".  If true, you are testing on a configuration that (a)
is unique to you and your group and (b) must be doing something with
the CLKREQ# signal so that your "before" case does not panic.  Is this
the case?

Finally, and this is a big one, is the fact that in both of the
"before" and "after" cases the value written to the internal Brcm
CLKREQ# register is the same.
This is evident by this line in the "after" patch:  "brcm-pcie
fd500000.pcie: uni-dir CLKREQ# for ASPM".  This mode is the only mode
supported by the "before"
case.  Now there are  some other things going on in the patch series
-- reading two registers and extending the timeout value of a
completion abort, but I'm having
a hard time imagining how they could cause a panic.

Regards,
Jim

PS  Can you please include in your logs the output of  "sudo lspci
-vvv" for those cases that boot to prompt?
>
> I fear that initially I might have not waited enough before power off and
> power on when replugging the SupaHub adapter, and I've only seen the PCIe
> link down a few times (now that I'm actively paying attention to that
> part). I'm indeed seeing PCIe link up consistently (100%) when using the
> following method:
>
>     for i in $(seq 1 20); do
>       # power on, let the system boot up and settle:
>       sispmctl -t 4; sleep 2m
>       ssh cm4 sh -c "dmesg > dmesg-$i.txt; poweroff"
>       # let the system power down, and power off:
>       sleep 30; sispmctl -t 4
>       # wait before power cycling:
>       sleep 10
>     done
>
> > Looking at:
> > https://www.amazon.co.uk/SupaHub-Express-BandWidth-Capable-Expanding/dp=
/B092ZQWG5B
> >
> > it would appear that it can accept an external power supply, do you hav=
e one
> > connected to that USB expansion card by any chance?
>
> With the patched kernel, I have tried several things (leaving the regular
> 12V adapter plugged in all the time):
>  - No external power supply (that's what I've been using in all previous
>    attempts).
>  - Using a 5V PSU with 2 pins (ground and 5V) plugged on the Ext PSU
>    4-pin header on the IO Board.
>  - Using a 5V PSU with a SATA connector plugged directly onto the SupaHub
>    adapter.
>
> I'm getting the same trace in all cases.
>
> > Are you able to boot the kernel before/after if you disconnect any USB
> > peripheral?
>
> The trace is obtained without any USB peripheral (on the extension card o=
r
> on the onboard USB slots). Besides the SupaHub adapter on the PCIe slot, =
I
> only have Ethernet and HDMI plugged in (I'm getting traces via serial
> console, and operating the system over SSH when it boots fine).
>
> As soon as I unplug the SupaHub board itself, the system boots fine.
>
> > Does that SupaHub board plugged to the CM4 1.0 system work fine in the
> > Raspberry Pi kernel tree?
>
> With the Raspberry Pi OS (64-bit) > Raspberry Pi OS Lite image
> (2023-02-21-raspios-bullseye-arm64-lite.img.xz), the system at least
> boots fine; I haven't tried adding devices to the mix just yet, trying
> to stick with that particular setup.
>
> A full dmesg is attached (dmesg-raspios.txt).
>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant
