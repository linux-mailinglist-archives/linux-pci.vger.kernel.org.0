Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90832F620C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbhANNbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 08:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbhANNbc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 08:31:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D4EC061574;
        Thu, 14 Jan 2021 05:30:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g25so5531068wmh.1;
        Thu, 14 Jan 2021 05:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5gtQnymxrJU4U/yydHBIyEMWxn2DtKpp2p8TKsUkvAE=;
        b=t9ScDnhL0kdFbaMBnwSr9ldDMzRrCHF9JPG0ADBs9MXR22YBlAMfQN/Ueh2rMCnm7u
         eQQPj3w2VkmPEUPXyDFOrbA5FOBygYyxBIEYkPhjhic+YsFagMhrLUzqJ+zFqAJyh/o2
         jyf1eu4HMnvxZaS2LHmHjEFqh1quRV0GENmo8k/ALq5UMMJITIP5/d0YRSSlibxwzNjp
         VnE7wLD1hU+K89DfF6+SGvWBBWCNWgVM/f8Lohc61CBNp8rU2cSBcjN6tAZsZ7lYrUOU
         0td8b1yKdmLe/YoBsMyRBO96kwXwZmiEJSs0zmATSe6x/H4UCOAFGeA+XAJVrarwhDcd
         40OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5gtQnymxrJU4U/yydHBIyEMWxn2DtKpp2p8TKsUkvAE=;
        b=CM0rc8YvO8lDDwElEkakzfio4tJjGVdqohYukRNlX10vDx/xFVefI1x1+5txauTOgD
         yP2TmyLDNW4cRPEhR6Tpvi7VG6n4wA4eXK9uKE9vRoPFaidAKAnLVFHwfExrXx7CfpLn
         XKTT6Fo2wiBJgwnwjg6p1BgpIF2CEmIjT1DvAh41XnknC1JLnnU+bw8jOyswYKfV1ECv
         0YquADyFkwn2i3K7cCs3jkZbGi1Tqks9uBISb6LIcSxV+lQDPi9arX0JWBUFIWmpQlsR
         dB10E9okP52XYCiwb4rD8JxDGa17PZ1OV05g/K4H4DSz2Pwkf0YubcJtS8rScj8feFl2
         DCVA==
X-Gm-Message-State: AOAM530mMbCDdiU1P7yJG7slE3YrUoZNJXctx9KvNURLje12tuxCcXfk
        7GNJowyp0Wb/rhhTc7ZEkV4YKHYdtXjuxvletlw=
X-Google-Smtp-Source: ABdhPJy80OE8PhB2egv6HX2NYHBoNMNittli7hcX0Nr+DiNqxs15T3dg1QBQfZMC4NvRDIlHuRmEePmxzhmx6m2U1Js=
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr3814488wmq.89.1610631050890;
 Thu, 14 Jan 2021 05:30:50 -0800 (PST)
MIME-Version: 1.0
References: <1610612968-26612-1-git-send-email-wuht06@gmail.com>
 <1610612968-26612-3-git-send-email-wuht06@gmail.com> <20210114085233.GO4678@unreal>
 <CAG_R4_UJ0=8=31XZD-SiiuL91M02N+fn=CLNA4_5Xm7jRDE1Rg@mail.gmail.com> <20210114130624.GR4678@unreal>
In-Reply-To: <20210114130624.GR4678@unreal>
From:   Hongtao Wu <wuht06@gmail.com>
Date:   Thu, 14 Jan 2021 21:30:39 +0800
Message-ID: <CAG_R4_UdQay0xh11Snt7G+uS+1E7E0NQf1rE-JpA0fge9jeLRQ@mail.gmail.com>
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

On Thu, Jan 14, 2021 at 9:06 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jan 14, 2021 at 08:00:50PM +0800, Hongtao Wu wrote:
> > On Thu, Jan 14, 2021 at 4:52 PM Leon Romanovsky <leon@kernel.org> wrote=
:
> > >
> > > On Thu, Jan 14, 2021 at 04:29:28PM +0800, Hongtao Wu wrote:
> > > > From: Hongtao Wu <billows.wu@unisoc.com>
> > > >
> > > > This series adds PCIe controller driver for Unisoc SoCs.
> > > > This controller is based on DesignWare PCIe IP.
> > > >
> > > > Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/Kconfig     |  12 ++
> > > >  drivers/pci/controller/dwc/Makefile    |   1 +
> > > >  drivers/pci/controller/dwc/pcie-sprd.c | 293 +++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 306 insertions(+)
> > > >  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c
> > >
> > > <...>
> > >
> > > > +static struct platform_driver sprd_pcie_driver =3D {
> > > > +     .probe =3D sprd_pcie_probe,
> > > > +     .remove =3D __exit_p(sprd_pcie_remove),
> > >                    ^^^^^^ why is that?
> > >
> >
> > Thanks for the review.
> >
> > I think that if 'MODULE' is defined, '.remove =3D sprd_pcie_remove',
> > else '.remove =3D NULL'.
> > I would appreciate hearing your opinion about this.
>
> If module not defined, these .probe and .remove won't be called.
>
> >
> > > > +     .driver =3D {
> > > > +             .name =3D "sprd-pcie",
> > > > +             .of_match_table =3D sprd_pcie_of_match,
> > > > +     },
> > > > +};
> > > > +
> > > > +module_platform_driver(sprd_pcie_driver);
> > > > +
> > > > +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> > > > +MODULE_LICENSE("GPL v2");
> > >
> > > I think that it needs to be "GPL" and not "GPL v2".
> > >
> >
> > Many platform drivers use 'GPL v2', but others use 'GPL'.
> > I am not sure whether to use 'GPL' or 'GPL v2'.
> > Could you tell me why =E2=80=98GPL=E2=80=99 is needed here?
>
> Because GPL already means v2, see Documentation/process/license-rules.rst
>
>   447
>   448     "GPL v2"                      Same as "GPL". It exists for hist=
oric
>   449                                   reasons.
>

Thanks for the explanation!
I'll update =E2=80=9CGPL=E2=80=9D and ".remove" in the next version.

>
> >
> > > Thanks
> > >
> > > > --
> > > > 2.7.4
> > > >
