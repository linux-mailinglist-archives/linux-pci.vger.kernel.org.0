Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF827F361
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 22:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgI3UeX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 16:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3UeX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 16:34:23 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 540F92075F;
        Wed, 30 Sep 2020 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601498062;
        bh=QfKwLKJeboaj9ZoI7BhbZ+bcUjrWN0qiAPiA8FEHF94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f7Glgz5TcfN7f4iEiAg9hTjORT0PqxZOT+WoRIIyzU1VivBV00GvNO1JKB2gK8aRN
         Hs8x7vFljnJ9//ngSVSsQRGcdtDtzEQxHczFoyeavNGzeDIP+OWCSvZqxNHlGiHm4g
         EjSNeIJXnLqaqJdcz4pc6WDdiW3bz4RC4o/jdUmg=
Received: by mail-ot1-f50.google.com with SMTP id g96so3143931otb.12;
        Wed, 30 Sep 2020 13:34:22 -0700 (PDT)
X-Gm-Message-State: AOAM531jZC4XzPFiOdwPcJOev856EKc8rR0xxmCc7wkyx9RAwtyOm84c
        E+xV5pwNY8kZqJT4OL46N5LxNVHs2REOuo+n8A==
X-Google-Smtp-Source: ABdhPJyzwAAPRXXAS2xvoZvN/yxKutEE4lHyxhoMfTZUFh2tvOgKBBCP8Z5+2QRHxiT4htRIoCYE3EgLLi4n0QpHamU=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr2700531otp.129.1601498061577;
 Wed, 30 Sep 2020 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819094255.474565-1-maz@kernel.org> <20200930162722.GF1516931@oden.dyn.berto.se>
 <977f60f07a4cb5c59f0e5f8a9dfb3993@kernel.org> <20200930173744.GG1516931@oden.dyn.berto.se>
In-Reply-To: <20200930173744.GG1516931@oden.dyn.berto.se>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Sep 2020 15:34:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+xBKbYXWipwmZ=ZidorsMUFDw2NpUyxobx4FCTn+8Hmg@mail.gmail.com>
Message-ID: <CAL_Jsq+xBKbYXWipwmZ=ZidorsMUFDw2NpUyxobx4FCTn+8Hmg@mail.gmail.com>
Subject: Re: [PATCH v2] of: address: Work around missing device_type property
 in pcie nodes
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Android Kernel Team <kernel-team@android.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 12:37 PM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
>
> Hi Marc,
>
> On 2020-09-30 18:23:21 +0100, Marc Zyngier wrote:
> > Hi Niklas,
> >
> > [+ Samuel]
> >
> > On 2020-09-30 17:27, Niklas S=C3=B6derlund wrote:
> > > Hi Marc,
> > >
> > > I'm afraid this commit breaks booting my rk3399 device.
> > >
> > > I bisected the problem to this patch merged as [1]. I'm testing on a
> > > Scarlet device and I'm using the unmodified upstream
> > > rk3399-gru-scarlet-inx.dtb for my tests.
> > >
> > > The problem I'm experience is a black screen after the bootloader and
> > > the device is none responsive over the network. I have no serial cons=
ole
> > > to this device so I'm afraid I can't tell you if there is anything
> > > useful on to aid debugging there.
> > >
> > > If I try to test one commit earlier [2] the system boots as expected =
and
> > > everything works as it did for me in v5.8 and earlier. I have worked
> > > little with this device and have no clue about what is really on the =
PCI
> > > buss. But running from [2] I have this info about PCI if it's helpful=
,
> > > please ask if somethings missing.
> >
> > Please see the thread at [1]. The problem was reported a few weeks back
> > by Samuel, and I was expecting Rob and Lorenzo to push a fix for this.
>
> Thanks for providing a solution.
>
> >
> > Rob, Lorenzo, any update on this?

The fix is in Bjorn's tree[1].

Bjorn, going to send this to Linus before v5.9 is out?

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=
=3Dfor-linus
