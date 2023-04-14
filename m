Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713B36E2449
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDNNbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDNNbd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 09:31:33 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3887DB6;
        Fri, 14 Apr 2023 06:31:32 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id x11so13507595vsq.2;
        Fri, 14 Apr 2023 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681479090; x=1684071090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM9q9Y54sXyv6cniNQQKVsTI/DeEE1bYT7mPqmcTa6I=;
        b=aeavtgJGBdpoXhwbCFBOk7PlQ92wqh7ChMBqnUJX3W7WkvQnQEp+Tf2QemjKzDEkOZ
         87dyEh0OkjGLf4LoWdJUJPMxzcz0gzWNeKX5oNF0pTqzSQUOam1nCmCw7wTpOcE69dAt
         b+rTEqKKxfzMLFoz5m8sqeGqYP/+nW3IULpv8I4WzLgYwjckGDL48GKFWCJSMvX0RHIe
         7xDfBTM2cttvD+hXdfbxUcWO4XVEnH0I3EOEigzx3BljTpzxMUaecqiQkNoE6bmwyvRe
         1s/dvLi/LG2nUHC6+llm5IL3tM8O+73lhNugKx9TfoBnxTbxIc+Au8QEem0kFjFy5JcL
         bVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681479090; x=1684071090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM9q9Y54sXyv6cniNQQKVsTI/DeEE1bYT7mPqmcTa6I=;
        b=LhZ2gdDe0sZMzc19cCj6IxSDrvc3BpYrWpcNRA+eLMaJ4wffBJIFKB6yESM+1sWaXP
         fGbPqMyjKV4AN4+HiKGyPc6EmJBMFpDPHxMCAG0EFJGr2l5w1tp0mMaCBN/NHxwl92bj
         r5VtUSFHMUvkXgFrnL7yHTm7Zknonlf2ybix8LbXEfhAIMH6Z2guyFKn33Y00oYqaZw9
         9GNSoxLtll9081ysF4UyVl2RYdRu9OCimvRQBTEuCmHAg0Aj9bkpxjanHSLwT+9S+LZc
         2ajCNJhBUxPL2SJutVgX+/feuENmLJOuvS8AMrUSQidumFfKSFp3jHo69UEDrmLBxGfh
         ha3Q==
X-Gm-Message-State: AAQBX9f/8JnrQJDxqnjfKNVknK/7V7XBQMrjzeSiUfmFZ4xxFEJjuYeW
        spTAC16wBI8+iOwlNEr1TMjFb9dEpOBZ8zVEueU=
X-Google-Smtp-Source: AKy350YCZhLR48W8DsYGYGVeQAFH2/xzOWn3bmIBk6YzJc5PVasvK6ImFrSLSLU3udj13WiiMT3m6F9KQdOUw/iYPq8=
X-Received: by 2002:a67:ca8b:0:b0:42e:3afd:dc2d with SMTP id
 a11-20020a67ca8b000000b0042e3afddc2dmr1734729vsl.6.1681479090482; Fri, 14 Apr
 2023 06:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230411165919.23955-1-jim2101024@gmail.com> <20230411165919.23955-3-jim2101024@gmail.com>
 <20230413143935.pmbyjk2boxl3rwne@mraw.org> <CANCKTBtXKAYf1LxR4qN+dVyxsWgyDztUVB4EdG=xhHbuhNCq5w@mail.gmail.com>
 <20230413200646.ddgsoqgmaae343nl@mraw.org> <CANCKTBuZ=Hxy9WgnjbauhHqXGx4QU_t8pgX=3che2K89=2BT9A@mail.gmail.com>
 <85a1cca1-f59b-6a0c-dee3-9d9ed5d6b6d1@gmail.com>
In-Reply-To: <85a1cca1-f59b-6a0c-dee3-9d9ed5d6b6d1@gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 14 Apr 2023 09:31:18 -0400
Message-ID: <CANCKTBv+jxYRsXXVguwuYrBZFdCO7=-RQPCOrR7pTCcoLuE4aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream device
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Cyril Brulebois <kibi@debian.org>, linux-pci@vger.kernel.org,
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 14, 2023 at 8:27=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
>
>
> On 4/14/2023 5:14 AM, Jim Quinlan wrote:
> > On Thu, Apr 13, 2023 at 4:06=E2=80=AFPM Cyril Brulebois <kibi@debian.or=
g> wrote:
> >>
> >> Hi Jim,
> >>
> >> Jim Quinlan <jim2101024@gmail.com> (2023-04-13):
> >>> Can you provide (a) the full boot log prior to applying the patch
> >>> series and (b) full boot log after applying the series, using an
> >>> IDENTICAL setup. If it fails on both then it has little to do with my
> >>> patch series.
> >>
> >> Just to be clear, the issue I reported was with:
> >>   - Raspberry Pi Compute Module 4 (Rev 1.1, 4G RAM, 32G storage)
> >>   - Raspberry Pi Compute Module 4 IO Board
> >>   - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 0=
06S
> >>
> >> This was my minimal reproducer for the kernel panic at boot-up, which
> >> goes away with either v1 or v2. When I realized I didn't actually chec=
k
> >> whether the SupaHub board was working correctly, I plugged 2 devices t=
o
> >> obtain this setup:
> >>   - Raspberry Pi Compute Module 4 (Rev 1.1, 4G RAM, 32G storage)
> >>   - Raspberry Pi Compute Module 4 IO Board
> >>   - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 0=
06S
> >>   - Kingston DataTraveler G4 32GB on USB-A port #1 of the SupaHub boar=
d.
> >>   - Logitech K120 keyboard on USB-A port #2 of the SupaHub board.
> >>
> >> It turns out that this particular revision of the SupaHub board isn't
> >> supported by xhci_hcd directly (failing to probe with error -110) and
> >> one needs to enable CONFIG_USB_XHCI_PCI_RENESAS=3Dm and also ship its
> >> accompanying firmware (/lib/firmware/renesas_usb_fw.mem). With this
> >> updated kernel config, I'm able to use the keyboard and to read data
> >> from the memory stick without problems (70 MB/s).
> >>
> >>> In my last series your testing somehow conflated the effect of an
> >>> unrelated MMC interrupt issue so please be precise.
> >>
> >> I wish things would be simpler and didn't involve combinatorics, let
> >> alone other bugs/regressions at times, but I'm really trying my best t=
o
> >> navigate and report issues and test patches when I can spare some time=
=E2=80=A6
> >
> > Hi Cyril,
> >
> > I want to encourage you and others doing testing and bug reporting:
> > everyone wins when a bug or issue is reported, fixed, and tested.
> > I'm just asking that when you have negative results, that you provide
> > information on the "before" and "after" test results of
> > the patch series, and run both on the same test environment.
>
> Cyril, based upon the table and logs you provided whereby you have used
> the following:
>
> - Raspberry Pi Compute Module 4 (Rev 1.0, 8G RAM, 32G storage)
> - Raspberry Pi Compute Module 4 IO Board
> - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
>
> in the before/unpatched case we have a PCIe link down and in the
> after/patched we have a PCIe link up but a kernel panic. Neither are
> great nor resulting in a fully functional PCIe device.

The data do not make sense to me. My new code is executed AFTER pcie
link up/down determination.  Both test results should have the same
link status -- either "link up" or "link down".

If the system is wishy-washy, i.e. it has link-up in 5/10 boots, then
we need to repeat  the experiment to compare the "link up" cases only.
Or discount the test completely

If the system is not wishy-washy, then something has been changed
between the "before" and "after"  tests.


>
> Looking at:
>
> https://www.amazon.co.uk/SupaHub-Express-BandWidth-Capable-Expanding/dp/B=
092ZQWG5B
>
> it would appear that it can accept an external power supply, do you have
> one connected to that USB expansion card by any chance? Are you able to
> boot the kernel before/after if you disconnect any USB peripheral?
>
> This looks like a broader electrical problem than the scope of this
> patch, though it would be neat if we could find a combination that
> works. At least with Jim's patch we have a PCIe link with
> uni-directional CLKREQ# so we could try a variety of things.
>
> Does that SupaHub board plugged to the CM4 1.0 system work fine in the
> Raspberry Pi kernel tree?
> --
> Florian
