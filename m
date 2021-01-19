Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5D2FB87E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 15:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbhASMuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 07:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732149AbhASJQm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 04:16:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF18623139;
        Tue, 19 Jan 2021 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611047759;
        bh=b4Cf+wcAxaeMO0xd+RigZ7MJ8HZVYfOhWxJaBWs7WvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aq0084h9/Uccjg5CXUGB4RCgPArQsWrOYebgPiDSxJHpWp1+mU+8aWXHfHThHEQ8f
         A7ms7bqN+3jJWIthcfpeYhHCagIBHEsK/Pau6kwWubLLAIWAY0mDpN2hi2wqHSszBr
         IqIQYoBCyF4DuFlP/seAev0fagLUsTUzqTYUwpUsQ3IkJSn8O+HR399TWKcO9UGd8q
         Fugvl/mK6d6ZM6qvwDbeSGjAMc+wU797GbSBQ6OQ5fvsWct//qBsL6JAt+2LLD7w9X
         OCDM+c+twgMHOknYTi3Y27h5D+VxkCqu4pWsXOS1Imy/FVFOUaP1ZocgpOVaX7T/Ye
         IfLGZMXxlZWuw==
Received: by mail-lj1-f169.google.com with SMTP id f11so21079364ljm.8;
        Tue, 19 Jan 2021 01:15:58 -0800 (PST)
X-Gm-Message-State: AOAM531cPqsYLDJ4eZeR8ArWGAhnUDyq0xFhfZj/ftW18Zgbw5Bq94/n
        tQWbP/msEES2kPKwCX2lSW1rxqxOGG5lvMVx9ww=
X-Google-Smtp-Source: ABdhPJxJw2lsSdR7flCVVMsk1gJDngPvsMkcb4tyQaAdRbQn4c0NHfz8kj4UCwHmvZb8kLehVQpFq3arCeY7Dh6sAWI=
X-Received: by 2002:a2e:8852:: with SMTP id z18mr1618577ljj.94.1611047757110;
 Tue, 19 Jan 2021 01:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20210106134617.391-1-wens@kernel.org> <20210106134617.391-2-wens@kernel.org>
 <12687142.y0N7aAr316@diego>
In-Reply-To: <12687142.y0N7aAr316@diego>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 19 Jan 2021 17:15:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v67qN9wQW9ddYu6VpGm+nid7Bws5i94mjkKqVncG28TYxA@mail.gmail.com>
Message-ID: <CAGb2v67qN9wQW9ddYu6VpGm+nid7Bws5i94mjkKqVncG28TYxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 19, 2021 at 5:11 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 6. Januar 2021, 14:46:14 CET schrieb Chen-Yu Tsai:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The Rockchip PCIe controller DT binding clearly states that 'ep-gpios' =
is
> > an optional property. And indeed there are boards that don't require it=
.
> >
> > Make the driver follow the binding by using devm_gpiod_get_optional()
> > instead of devm_gpiod_get().
> >
> > Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller suppo=
rt")
> > Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC drive=
r")
> > Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt()=
 to parse DT")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > Heiko, I dropped you reviewed-by due to the error message change
> >
> > Changes since v2:
> >   - Fix error message for failed GPIO
> >
> > Changes since v1:
> >   - Rewrite subject to match existing convention and reference
> >     'ep-gpios' DT property instead of the 'ep_gpio' field
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/contr=
oller/pcie-rockchip.c
> > index 904dec0d3a88..90c957e3bc73 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -118,9 +118,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *r=
ockchip)
> >       }
> >
> >       if (rockchip->is_rc) {
> > -             rockchip->ep_gpio =3D devm_gpiod_get(dev, "ep", GPIOD_OUT=
_HIGH);
> > +             rockchip->ep_gpio =3D devm_gpiod_get_optional(dev, "ep", =
GPIOD_OUT_HIGH);
> >               if (IS_ERR(rockchip->ep_gpio)) {
> > -                     dev_err(dev, "missing ep-gpios property in node\n=
");
> > +                     dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
> > +                                   "failed to get ep GPIO\n");
> >                       return PTR_ERR(rockchip->ep_gpio);
>
> looking at [0] shouldn't that be just
>         return dev_err_probe(dev, PTR_ERR(.....)...);
> instead of dev_err_probe + additional return?

You're right. I was only expecting dev_err_probe() to deal with -EPROBE_DEF=
ER.
I believe there won't be any future changes that would add any code here,
so I'll respin with the proper changes you mentioned.

Thanks!

ChenYu

> Heiko
>
> [0] https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4=
223
>
> >               }
> >       }
> >
>
>
>
>
