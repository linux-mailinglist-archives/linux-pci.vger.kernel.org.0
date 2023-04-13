Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB916E1079
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjDMO5i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjDMO5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 10:57:35 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4743AF0D;
        Thu, 13 Apr 2023 07:57:32 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id ba16so10485827uab.4;
        Thu, 13 Apr 2023 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681397852; x=1683989852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSEimHdm7p/unMCCqfVT8tZ9/6y51iFVf9+ovV+dNLo=;
        b=dd8F+74grz+6Z1qZXKAYYwJX2e7u+RkP96GWsTXwM7sa5bswJrKZ63HtRlLEjTuDLE
         iTtBlyNwd3lVtfTdIKvBz3nIVQ9vOc64G8ITEkjIt4QkIlCdXC8Kyqw1C2xHrvCPrTPl
         hVE0tucXAVoFJdr1qtz+HPXkXBbegGWaA27IyiWoTkdRwSmMGruFLLs8DRLdrtlTLEmL
         me4eRTa36V9xkETc9lhRiKCi3RameJHYrXpH7cdivO9S1p7SV7NVEhJSJ8pGxrEF50L+
         o2DPoAnqykH69Zz5TiIFUxF1ZdtOQftQ22okIADw6axoasmDCNpndZTezVPaaktNi5Wt
         ZEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681397852; x=1683989852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSEimHdm7p/unMCCqfVT8tZ9/6y51iFVf9+ovV+dNLo=;
        b=S05wCEAf3yPUXW0MzRbDTNwAvzxWgMM70y6dVzGJNbvZWBuXECn4JS9MGUdUrjqQj2
         RNWaVYoA5jA1FDQgypq6GFefXETorgrn627c4z8pXAsyLLnreP5BJJ8LAjBjX1yXg5VF
         8J5n46Tmj6ELrYj6Gg5vTHusKGZ2sm2Rfxwkugyg1qsALPcwlkvsebBD2qp4s1odIUE4
         +McVMiGiek1oZazpcdXe1Cf+y3dGTZfwmMT0LEA86ODJn0yzPaxGRiM46OdJ86NeRhAa
         uWLqexZTPPmPAiEzRH5icCfSDmPzO6qF0JAqFOUhYOLv/guVXx3VowIMwScCAeecScVx
         UOXQ==
X-Gm-Message-State: AAQBX9f5EVcCo/PtffqvsCb5LPteUT2e9HW7h4G8wC8Y5Nx4gWFFObZN
        Tn+eLoWfX46gpAV6TgD9cQEeioZe5t+KWIpA0FI=
X-Google-Smtp-Source: AKy350bUwtczUoXLbVWtNIum5fqpYWprDuoCGISwx0WMwjFle9l9FFmiPwx6mvYb6vtRCBL+h+yr/nxXqrGsnlCQOhs=
X-Received: by 2002:a1f:2081:0:b0:43c:2acb:9a60 with SMTP id
 g123-20020a1f2081000000b0043c2acb9a60mr1195742vkg.3.1681397851795; Thu, 13
 Apr 2023 07:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230411165919.23955-1-jim2101024@gmail.com> <20230411165919.23955-3-jim2101024@gmail.com>
 <20230413143935.pmbyjk2boxl3rwne@mraw.org>
In-Reply-To: <20230413143935.pmbyjk2boxl3rwne@mraw.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 13 Apr 2023 10:57:19 -0400
Message-ID: <CANCKTBtXKAYf1LxR4qN+dVyxsWgyDztUVB4EdG=xhHbuhNCq5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream device
To:     Cyril Brulebois <kibi@debian.org>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Cyril,
Can you provide (a) the full boot log prior to applying the patch
series and (b) full boot log after applying the series, using an
IDENTICAL  setup.
If it fails on both then it has little to do with my patch series.

In my last series your testing somehow conflated the effect of an
unrelated MMC interrupt issue so please be precise.

Regards,
Jim  Quinlan
Broadcom STB

On Thu, Apr 13, 2023 at 10:39=E2=80=AFAM Cyril Brulebois <kibi@debian.org> =
wrote:
>
> Hi Jim,
>
> Jim Quinlan <jim2101024@gmail.com> (2023-04-11):
> > [=E2=80=A6]
> > This property has already been in use by Raspian Linux, but this
> > immplementation adds more details and discerns between (a) and (b)
>   ^^^^^^^^^^^^^^^
>   implementation
>
> > automatically.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217276
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>
> Sorry, it seems like my initial tests with v1 (applied on top of
> v6.3-rc5-137-gf2afccfefe7b) weren't thorough enough, and I'm seeing the
> same problems with v2 (applied on top of v6.3-rc6-46-gde4664485abb):
>  - same setup as in https://bugzilla.kernel.org/show_bug.cgi?id=3D217276
>  - the kernel panic is indeed gone;
>  - a USB keyboard connected on that SupaHub PCIe-to-multiple-USB adapter
>    isn't seen by the kernel;
>  - a USB memory stick connected on the same adapter isn't seen by the
>    kernel either;
>  - of course both USB devices are confirmed to work fine if they're
>    plugged directly on the CM4's USB ports.
>
> Logs with v2:
>
>     root@cm4:~# dmesg|grep -i pci
>     [    0.610997] PCI: CLS 0 bytes, default 64
>     [    1.664886] shpchp: Standard Hot Plug PCI Controller Driver versio=
n: 0.4
>     [    1.672083] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d50000=
0 ranges:
>     [    1.679125] brcm-pcie fd500000.pcie:   No bus range found for /scb=
/pcie@7d500000, using [bus 00-ff]
>     [    1.688279] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603=
ffffff -> 0x00f8000000
>     [    1.696463] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x00ff=
ffffff -> 0x0400000000
>     [    1.705282] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:0=
0
>     [    1.711629] pci_bus 0000:00: root bus resource [bus 00-ff]
>     [    1.717172] pci_bus 0000:00: root bus resource [mem 0x600000000-0x=
603ffffff] (bus address [0xf8000000-0xfbffffff])
>     [    1.727653] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
>     [    1.733768] pci 0000:00:00.0: PME# supported from D0 D3hot
>     [    1.740235] pci 0000:00:00.0: bridge configuration invalid ([bus 0=
0-00]), reconfiguring
>     [    1.855826] brcm-pcie fd500000.pcie: CLKREQ# ignored; no ASPM
>     [    1.863666] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SS=
C)
>     [    1.870115] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
>     [    1.876205] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff=
 64bit]
>     [    1.883177] pci 0000:01:00.0: PME# supported from D0 D3hot
>     [    1.888881] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated =
to 01
>     [    1.895581] pci 0000:00:00.0: BAR 14: assigned [mem 0x600000000-0x=
6000fffff]
>     [    1.902707] pci 0000:01:00.0: BAR 0: assigned [mem 0x600000000-0x6=
00001fff 64bit]
>     [    1.910279] pci 0000:00:00.0: PCI bridge to [bus 01]
>     [    1.915293] pci 0000:00:00.0:   bridge window [mem 0x600000000-0x6=
000fffff]
>     [    1.922412] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>     [    1.928633] pcieport 0000:00:00.0: PME: Signaling with IRQ 23
>     [    1.934609] pcieport 0000:00:00.0: AER: enabled with IRQ 23
>     [    1.940340] pci 0000:01:00.0: enabling device (0000 -> 0002)
>     [    6.946090] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bu=
g?) status =3D 0x1801
>     [    6.954026] pci 0000:01:00.0: quirk_usb_early_handoff+0x0/0x968 to=
ok 4896180 usecs
>
> Please let me know what I can do to help.
>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant
