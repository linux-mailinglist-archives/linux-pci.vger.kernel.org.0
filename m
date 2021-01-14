Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5776C2F60B2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 13:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhANMBo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 07:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbhANMBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 07:01:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42629C061573;
        Thu, 14 Jan 2021 04:01:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l12so264583wry.2;
        Thu, 14 Jan 2021 04:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lVUtXTfASqN/TWy3NquGPT8aT/KlmtuDYDs34qE3gm4=;
        b=IV+jvzwtAqIP62gZVHXVPQLwxlTq7VeCG59klxS9CVBbSUFpI8zjm9ROkB+4mvBzUX
         BFPKIgAm4e91bU63DhRkrAL3UYpXhuFt09z6Hc5TwlgT51cQxLe2RNcUdHiVjXq3mYEF
         dBT+8z0UpmeDUIKDOC1HKC2hNmid2231EZr71Vn1ZZou6yrb7LJI9Z4OtdoX9+lhsHUW
         4AC+iGc7J6TNZ0YvIJbnv9+PHOuQ9lhxt0q7DgUuPySrfvA74Qty1cBy5ALa6up5aRKg
         KLgOTEP0mHHfdcubxGYzi+AiG3eoYjEBRlG6rxL2HfxNs+fS0mW5XeQlCarW+hxUV3sv
         n8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lVUtXTfASqN/TWy3NquGPT8aT/KlmtuDYDs34qE3gm4=;
        b=OaMFw+QX90z7SX9oEIwocO2d+lnsfqNmLqGbm+VHurViqnZti5b9FnQj3tr4OyEUzo
         atWHoN4NnNYJGNUA7TO1MO6hGEmvl7CEsrJUPoE9IlDn1Tb075W1hkwZvCGqLw/y/SNz
         6EyHPtu4ucpvtHFp/54jgLSpAnzWrrLgYUmdoA+phD8fldEs9u6BEeq/hpdbfG8YeWun
         g3bqvVL1MndWMQUyt0MTn2yh4qPioGRPYxE9YucoZkl1Ci4lz3GDWRRwwkLAg76ZAPqW
         /fwpgpOi9InY9079H+c9Z2r6ca81fCftNrA6YysF1L5wnXZcP48fArRaX3q5HZE57hOS
         xQ9Q==
X-Gm-Message-State: AOAM530KbpaKWsXYtjYJwXtcmMspdo6B1lKwaXUlaq+v02Nm6E5NaQM5
        b2Nl1Ea21ell6JH+E2XmQFVLQylJkynKD3WC2nQ=
X-Google-Smtp-Source: ABdhPJycBCepUSrnOf1M7vLEYedHiJuRVWW90VEGQQLo84c8nQ65vh9Fv4pjNslXfrE4l3D3A8dn1+A3O5REAd6oHN0=
X-Received: by 2002:adf:decd:: with SMTP id i13mr3011179wrn.144.1610625662023;
 Thu, 14 Jan 2021 04:01:02 -0800 (PST)
MIME-Version: 1.0
References: <1610612968-26612-1-git-send-email-wuht06@gmail.com>
 <1610612968-26612-3-git-send-email-wuht06@gmail.com> <20210114085233.GO4678@unreal>
In-Reply-To: <20210114085233.GO4678@unreal>
From:   Hongtao Wu <wuht06@gmail.com>
Date:   Thu, 14 Jan 2021 20:00:50 +0800
Message-ID: <CAG_R4_UJ0=8=31XZD-SiiuL91M02N+fn=CLNA4_5Xm7jRDE1Rg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 2/2] PCI: sprd: Add support for Unisoc SoCs'
 PCIe controller
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 14, 2021 at 4:52 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jan 14, 2021 at 04:29:28PM +0800, Hongtao Wu wrote:
> > From: Hongtao Wu <billows.wu@unisoc.com>
> >
> > This series adds PCIe controller driver for Unisoc SoCs.
> > This controller is based on DesignWare PCIe IP.
> >
> > Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig     |  12 ++
> >  drivers/pci/controller/dwc/Makefile    |   1 +
> >  drivers/pci/controller/dwc/pcie-sprd.c | 293 +++++++++++++++++++++++++=
++++++++
> >  3 files changed, 306 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c
>
> <...>
>
> > +static struct platform_driver sprd_pcie_driver =3D {
> > +     .probe =3D sprd_pcie_probe,
> > +     .remove =3D __exit_p(sprd_pcie_remove),
>                    ^^^^^^ why is that?
>

Thanks for the review.

I think that if 'MODULE' is defined, '.remove =3D sprd_pcie_remove',
else '.remove =3D NULL'.
I would appreciate hearing your opinion about this.

> > +     .driver =3D {
> > +             .name =3D "sprd-pcie",
> > +             .of_match_table =3D sprd_pcie_of_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(sprd_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> > +MODULE_LICENSE("GPL v2");
>
> I think that it needs to be "GPL" and not "GPL v2".
>

Many platform drivers use 'GPL v2', but others use 'GPL'.
I am not sure whether to use 'GPL' or 'GPL v2'.
Could you tell me why =E2=80=98GPL=E2=80=99 is needed here?

> Thanks
>
> > --
> > 2.7.4
> >
