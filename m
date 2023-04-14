Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4835B6E22EE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 14:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjDNMO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 08:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNMO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 08:14:56 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564DF1722;
        Fri, 14 Apr 2023 05:14:55 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y17so16210462vsd.9;
        Fri, 14 Apr 2023 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474494; x=1684066494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjiVKo1Y1OcOlbDVIJvSvV2H1MeJz//axCy7/BdCahk=;
        b=Fe8m4/mmLHl4ZcnIo9fRP/p9xuMfWjJd0XRYLnfACf08hAOaoZwHLltFHx4kbzMnkE
         m17/byXfxvA/+aYt3yW1bZihcAGFhsH816eL+hTqqE7+2ZMg06Gnia5UyfVGicIfMNK3
         d2WpCUBZcjPwHLk8ykizOLdXj6eeP4lDuB5bUYZP2nkW6GvzmIMwPhLij7rpCNNoUi6t
         T4O/ww+iNf7FrsuavkakQzLoEfwBCXLiuKaEX4UoQ7Z+1ovI1UIlSJVye70rkA/aPM5Z
         bEght6Q9hNTgs7ISxw+jVDYwfNTAR7i5aP3pdMaY8jM3yeY0Z9ZEyDrXdIToDaj5s3/8
         A5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474494; x=1684066494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjiVKo1Y1OcOlbDVIJvSvV2H1MeJz//axCy7/BdCahk=;
        b=jlrtnzUKbIHJwMxo+8jGPghSu/XFmv9CprFj08/PPXMy9DxYWeVIYOSE8s6ol1B5TT
         /FTx6O4CR1oeknu3My+dUzcQ7wCbsdl0nwiSjE0xY4rk+9as7zWyYAPXGoHMR15wYYKT
         i9W1NpPoE/tNl6oAVhnFVUSP2G6UGIp7cLWviNmQ6rlNMLXy+AF+UgFF6KT50p30tfNJ
         P3kLRx2ztJnPSxyOgRJxnd3zeNk1qxToTl/whsXavmU9wYPRtDoOxkqKAcdzpgWvXMKu
         vtEndZynHSuYO3egtpVIIyqWxqSFJ/XqrCsPEGRTW5+ZTuHgjmsmZz4Y4V/aT54lCWJj
         m06w==
X-Gm-Message-State: AAQBX9c5BCVE/BSJOpBG0b8O7Hgw7gd4ieQ8ANJBcQCLhvVOGEVJurn8
        BeleN1PWXAx6AHJPe38b4nwE4lrL8Ck470zw6T0=
X-Google-Smtp-Source: AKy350ayHjK9a/ULv1Go4EqUSXtpslgMBDkHswCkCXSD3vSN1LlLTEVtwPpfrdd4gpdos1YOr7fJY3+3FggVQsUq1Gc=
X-Received: by 2002:a67:ca8b:0:b0:42e:3afd:dc2d with SMTP id
 a11-20020a67ca8b000000b0042e3afddc2dmr1610104vsl.6.1681474494437; Fri, 14 Apr
 2023 05:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230411165919.23955-1-jim2101024@gmail.com> <20230411165919.23955-3-jim2101024@gmail.com>
 <20230413143935.pmbyjk2boxl3rwne@mraw.org> <CANCKTBtXKAYf1LxR4qN+dVyxsWgyDztUVB4EdG=xhHbuhNCq5w@mail.gmail.com>
 <20230413200646.ddgsoqgmaae343nl@mraw.org>
In-Reply-To: <20230413200646.ddgsoqgmaae343nl@mraw.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 14 Apr 2023 08:14:42 -0400
Message-ID: <CANCKTBuZ=Hxy9WgnjbauhHqXGx4QU_t8pgX=3che2K89=2BT9A@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 13, 2023 at 4:06=E2=80=AFPM Cyril Brulebois <kibi@debian.org> w=
rote:
>
> Hi Jim,
>
> Jim Quinlan <jim2101024@gmail.com> (2023-04-13):
> > Can you provide (a) the full boot log prior to applying the patch
> > series and (b) full boot log after applying the series, using an
> > IDENTICAL setup. If it fails on both then it has little to do with my
> > patch series.
>
> Just to be clear, the issue I reported was with:
>  - Raspberry Pi Compute Module 4 (Rev 1.1, 4G RAM, 32G storage)
>  - Raspberry Pi Compute Module 4 IO Board
>  - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
>
> This was my minimal reproducer for the kernel panic at boot-up, which
> goes away with either v1 or v2. When I realized I didn't actually check
> whether the SupaHub board was working correctly, I plugged 2 devices to
> obtain this setup:
>  - Raspberry Pi Compute Module 4 (Rev 1.1, 4G RAM, 32G storage)
>  - Raspberry Pi Compute Module 4 IO Board
>  - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
>  - Kingston DataTraveler G4 32GB on USB-A port #1 of the SupaHub board.
>  - Logitech K120 keyboard on USB-A port #2 of the SupaHub board.
>
> It turns out that this particular revision of the SupaHub board isn't
> supported by xhci_hcd directly (failing to probe with error -110) and
> one needs to enable CONFIG_USB_XHCI_PCI_RENESAS=3Dm and also ship its
> accompanying firmware (/lib/firmware/renesas_usb_fw.mem). With this
> updated kernel config, I'm able to use the keyboard and to read data
> from the memory stick without problems (70 MB/s).
>
> > In my last series your testing somehow conflated the effect of an
> > unrelated MMC interrupt issue so please be precise.
>
> I wish things would be simpler and didn't involve combinatorics, let
> alone other bugs/regressions at times, but I'm really trying my best to
> navigate and report issues and test patches when I can spare some time=E2=
=80=A6

Hi Cyril,

I want to encourage you and others doing testing and bug reporting:
everyone wins when a bug or issue is reported, fixed, and tested.
I'm just asking that when you have negative results, that you provide
information on the "before" and "after" test results of
the patch series, and run both on the same test environment.

Regards,
Jim Quinlan
Broadcom STB

>
>
> In my defence, the very similar board PCE6U1C-R02, VER 006 boots without
> a kernel panic, and works fine with xhci_hcd without that extra module
> and its firmware. It's based on the exact same chip (Renesas Technology
> Corp. uPD720201) though, that's why I didn't realize the need for an
> extra module until now for the PCE6U1C-R02, VER 006S one. (Florian,
> thanks for mentioning .config earlier=E2=80=A6)
>
> To sum up, it seems both (sub)versions of that SupaHub PCE6U1C-R02 board
> are usable with this patch series: the kernel panic at boot-up is gone,
> and USB devices plugged into those boards are working as expected.
>
>
> But, speaking of combinatorics, while the patch series helps fix
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217276 on that particular
> initial combination of CM4 and SupaHub PCE6U1C-R02, VER 006S, it also
> generates a regression if I use a different CM4=E2=80=A6
>
> Setup:
>  - Raspberry Pi Compute Module 4 (Rev 1.0, 8G RAM, 32G storage)
>  - Raspberry Pi Compute Module 4 IO Board
>  - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
>
> You'll find attached (a) and (b) as requested above, for this setup, as
> well as the kernel configuration file:
>  - (a) =3D dmesg-unpatched.txt =3D boots fine (and USB devices work fine =
if
>    memory sticks or keyboards are plugged in).
>  - (b) =3D dmesg-patched.txt =3D kernel panic.
>  - cm4+pcie.config
>
> I'm getting similar results with the other SupaHub board:
>  - Raspberry Pi Compute Module 4 (Rev 1.0, 8G RAM, 32G storage)
>  - Raspberry Pi Compute Module 4 IO Board
>  - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006
>
>
> This is probably best summarized this way:
>
>                               | unpatched    | patched
> ------------------------------+--------------+--------------
> CM4 Rev 1.1 4G/32G + VER 006  | OK           | OK
> CM4 Rev 1.1 4G/32G + VER 006S | Kernel panic | OK            =E2=86=90 Bu=
gzilla entry
> CM4 Rev 1.0 8G/32G + VER 006  | OK           | Kernel panic
> CM4 Rev 1.0 8G/32G + VER 006S | OK           | Kernel panic
>
>
> (And I'm of course using the same settings regarding the serial console,
> to get traces when needed.)
>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant
