Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF5610F24
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJ1K4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ1K43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 06:56:29 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA1E2D1FE
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2022 03:56:27 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id k1so4719676vsc.13
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2022 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccqIL5SHWfgcf9gYrp0T9AJEDNgbEFyLA7s1nTzANVE=;
        b=RGD/dF0ZuZ6Nwrx6PZCQHZMvt1h95JhYB2QNxD9vk2/wUOJphy06EFNlVcng8Up10i
         diJ6HSg8zvAA4XnboRDwmIYGyyue6EESzfU+xto8Gfd8rcpj2RZmgYeSgpkefvMXLjju
         O/0qmaigEFRvPZvS/iRVqcUtvmwl9OMdLVDpxu5+lcjRb5A2j4uGdCmdy74ePDzG/Qef
         Bt4ICf7HUASZKo5v5IwKUCMTCnAQkivbAKcpbdXX/J4JDQNtISAaXk+qbABMzcO7Gcux
         KTqLGP1QnPejJ6ok+VSKQxgvZ7cn/h7AnfVWBW5hETymBOVatabXUyW690qftxgfY49d
         ZIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccqIL5SHWfgcf9gYrp0T9AJEDNgbEFyLA7s1nTzANVE=;
        b=r9apwBbb5HQkQSDq9DiKLIzBVYUQRGI7wuOetCeimFVYVPdxd9fTPJBS0R7ppy2kFf
         dnRe8zdI56/7Dj0OxFH3AYQhFZyW9WOaf65LnELowMyQHHQFDyRHqEd1y+sY4WnWwF5+
         kJmu3YUW+r4D1XJ6DV99b5vMhv5EZQORneWJNyrlD2sfpy2IRxV1ecCbE2nW5Tr7B6n0
         pf/92NwMFAg4hX9zKG6S4IjF0uO5MXrsIykWvRKksotFwfqgLwss/40inUeLhrLUG3A8
         JdX+pqdOTiEW2lxD7tD1S+/QhZwQCNHC8ytkdexxNWR8poXAlFR4oOgSh1ppOYww2uCw
         L8Bg==
X-Gm-Message-State: ACrzQf0bML4ghEjx2KK7m9BTT2S5I6RHzPP0y1eGusCkNwReYiRCy37W
        g8V+udRTbLnmWPx/5/kU5cBPYxcKGIfHgCgVgwGj1jGldoplnw==
X-Google-Smtp-Source: AMsMyM7W5qM/GpLl7VyqOVHqz3ZHXWjJaMdIn9LMmrTtlqak5vaa+fdgbfy31AQVNoBDdwW0wfCvgNku41150e/3wgE=
X-Received: by 2002:a67:fb41:0:b0:3a6:9b59:4b58 with SMTP id
 e1-20020a67fb41000000b003a69b594b58mr26051417vsr.39.1666954586524; Fri, 28
 Oct 2022 03:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220922092357.123732-1-mie@igel.co.jp> <20221025142143.GA109941@thinkpad>
 <HE1PR0401MB233126D2C7410EC5F6C3976488319@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjnbZMzFJt8kBtQz6FHc_QQYw7=fZp8kK87mZ-t75z+g@mail.gmail.com>
 <HE1PR0401MB23319EE329D62420919740C688339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221027151220.GC76627@thinkpad> <HE1PR0401MB233111DEC8F76341029183F188339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221027160932.GD76627@thinkpad> <HE1PR0401MB2331032AECAE30A8C31AF01A88339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB2331032AECAE30A8C31AF01A88339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Fri, 28 Oct 2022 19:56:15 +0900
Message-ID: <CANXvt5oApH90YzDpMNUhaLEVfcas+TDnhU63vC5NzTmGnF2rrQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
To:     Frank Li <frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2022=E5=B9=B410=E6=9C=8828=E6=97=A5(=E9=87=91) 1:25 Frank Li <frank.li@nxp.=
com>:
>
>
>
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Thursday, October 27, 2022 11:10 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: Shunsuke Mie <mie@igel.co.jp>; Jon Mason <jdmason@kudzu.us>; Dave
> > Jiang <dave.jiang@intel.com>; Allen Hubbe <allenbh@gmail.com>;
> > kishon@kernel.org; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof
> > Wilczy=C5=84ski <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > ntb@lists.linux.dev; linux-pci@vger.kernel.org; linux-kernel@vger.kerne=
l.org
> > Subject: Re: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a=
 check for
> > no epc alignment constraint
> >
> > Caution: EXT Email
> >
> > [Added Kishon's new email address and removed the old one]
> >
> > On Thu, Oct 27, 2022 at 03:34:11PM +0000, Frank Li wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Sent: Thursday, October 27, 2022 10:12 AM
> > > > To: Frank Li <frank.li@nxp.com>
> > > > Cc: Shunsuke Mie <mie@igel.co.jp>; Jon Mason <jdmason@kudzu.us>;
> > Dave
> > > > Jiang <dave.jiang@intel.com>; Allen Hubbe <allenbh@gmail.com>;
> > Kishon
> > > > Vijay Abraham I <kishon@ti.com>; Lorenzo Pieralisi
> > <lpieralisi@kernel.org>;
> > > > Krzysztof Wilczy=C5=84ski <kw@linux.com>; Bjorn Helgaas
> > > > <bhelgaas@google.com>; ntb@lists.linux.dev; linux-pci@vger.kernel.o=
rg;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: f=
ix a check
> > for
> > > > no epc alignment constraint
> > > >
> > > > Caution: EXT Email
> > > >
> > > > On Thu, Oct 27, 2022 at 02:35:56PM +0000, Frank Li wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Shunsuke Mie <mie@igel.co.jp>
> > > > > > Sent: Wednesday, October 26, 2022 8:43 PM
> > > > > > To: Frank Li <frank.li@nxp.com>
> > > > > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>;
> > Jon
> > > > > > Mason <jdmason@kudzu.us>; Dave Jiang <dave.jiang@intel.com>;
> > Allen
> > > > > > Hubbe <allenbh@gmail.com>; Kishon Vijay Abraham I
> > <kishon@ti.com>;
> > > > > > Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczy=C5=
=84ski
> > > > > > <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > > > > > ntb@lists.linux.dev; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > > > Subject: Re: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}nt=
b: fix a
> > check
> > > > for
> > > > > > no epc alignment constraint
> > > > > >
> > > > > > Caution: EXT Email
> > > > > >
> > > > > > Hi Frank,
> > > > > >
> > > > > > 2022=E5=B9=B410=E6=9C=8826=E6=97=A5(=E6=B0=B4) 1:07 Frank Li <f=
rank.li@nxp.com>:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > > > > > > > Sent: Tuesday, October 25, 2022 9:22 AM
> > > > > > > > To: Shunsuke Mie <mie@igel.co.jp>
> > > > > > > > Cc: Jon Mason <jdmason@kudzu.us>; Dave Jiang
> > > > <dave.jiang@intel.com>;
> > > > > > > > Allen Hubbe <allenbh@gmail.com>; Kishon Vijay Abraham I
> > > > > > > > <kishon@ti.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>;
> > Krzysztof
> > > > > > > > Wilczy=C5=84ski <kw@linux.com>; Bjorn Helgaas
> > <bhelgaas@google.com>;
> > > > > > > > ntb@lists.linux.dev; linux-pci@vger.kernel.org; linux-
> > > > > > kernel@vger.kernel.org
> > > > > > > > Subject: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}nt=
b: fix a
> > check
> > > > for
> > > > > > no
> > > > > > > > epc alignment constraint
> > > > > > > >
> > > > > > > > Caution: EXT Email
> > > > > > > >
> > > > > > > > On Thu, Sep 22, 2022 at 06:23:57PM +0900, Shunsuke Mie wrot=
e:
> > > > > > > > > Some PCI endpoint controllers have no alignment constrain=
ts,
> > and
> > > > the
> > > > > > > > > epc_features->align becomes 0. In this case, IS_ALIGNED()=
 in
> > > > > > >
> > > > > > > [Frank Li] why not set epc_features->align 1
> > > > > > > no alignment constraints should mean align to byte.
> > > > > > It is one of the solutions too I think. But in that case,  we n=
eed to
> > > > > > write epc_features->align =3D 1 to all epc drivers, dwc, qcom, =
rcar,
> > > > > > tegra, and etc.
> > > > > >
> > > > > > I think that my change is better.
> > > > >
> > > > > I think it should be based on what original term defined.
> > > > > It should be fixed at where make mistake.
> > > > >
> > > >
> > > > 1byte is the default alignment that drivers can assume, why do you =
want
> > > > drivers
> > > > to set them explicitly when they do not want any special alignment?
> > >
> > > What's definition of not alignment by align variable?
> > > Using both 0 and 1 as no alignment is not good enough.
> > >
> > > I grep whole kernel driver directory, not one use
> > >       If (align && IS_ALIGNED(x, align))  statement.
> >
> > I can see multiple hits:
> >
> > lib/ubsan.c
> > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > drivers/gpu/drm/i915/i915_vma.c
> > drivers/nvdimm/pfn_devs.c
> > drivers/misc/pci_endpoint_test.c
> >
> > But in most of the places, the alignment is guaranteed to be set by the=
 client
> > drivers because they might be read from the hardware register or fixed =
for
> > an
> > IP. But in this case, I don't think we should _force_ the drivers to se=
t
> > alignment to 1 (default) if they don't really care about it.
>
> I keep my opinion.  I think EP controller have not reported correct data.
> Hardware register also can be set 0 as no alignment means.
> It broken "align" conversion.
It is certainly true. In addition, I don't think it is a good design
for the framework to
require the same check for all ep function drivers. like this patch.

But I can't be determined, so I'm going to look into other
drivers/subsystems to find a
common and better way.

> If most people prefer this way, I suggest change api document at
> Include/linux/pci-epc.h to explicitly said 0 is validate option.
Yes. If we take the way, I'll add the explanation.
> >
> > Thanks,
> > Mani
> >
> > >
> > > There are a common convention, align is 2^n
> > >
> > >
> > > >
> > > > I think this patch is fine.
> > > >
> > > > Thanks,
> > > > Mani
> > > >
> > > > > Are there other place use align =3D=3D 0 means no alignment in ke=
rnel?
> > > > >
> > > > > >
> > > > > > > > > epf_ntb_config_spad_bar_alloc() doesn't work well. Check =
for
> > this
> > > > > > before
> > > > > > > > > IS_ALIGNED().
> > > > > > > > >
> > > > > > > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > > > > > >
> > > > > > > > Reviewed-by: Manivannan Sadhasivam
> > > > > > > > <manivannan.sadhasivam@linaro.org>
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Mani
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > > Changes in v2:
> > > > > > > > > * Fix the commit message in phrasings and words.
> > > > > > > > > ---
> > > > > > > > > ---
> > > > > > > > >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
> > > > > > > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
> > > > > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > > > > > > b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > > > > > > > index 9a00448c7e61..f74155ee8d72 100644
> > > > > > > > > --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > > > > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > > > > > > > @@ -1021,7 +1021,7 @@ static int
> > > > > > epf_ntb_config_spad_bar_alloc(struct
> > > > > > > > epf_ntb *ntb,
> > > > > > > > >       peer_size =3D peer_epc_features->bar_fixed_size[pee=
r_barno];
> > > > > > > > >
> > > > > > > > >       /* Check if epc_features is populated incorrectly *=
/
> > > > > > > > > -     if ((!IS_ALIGNED(size, align)))
> > > > > > > > > +     if (align && (!IS_ALIGNED(size, align)))
> > > > > > > > >               return -EINVAL;
> > > > > > > > >
> > > > > > > > >       spad_count =3D ntb->spad_count;
> > > > > > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.=
c
> > > > > > > > b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > > > > index 0ea85e1d292e..5e346c0a0f05 100644
> > > > > > > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > > > > @@ -418,7 +418,7 @@ static int
> > > > epf_ntb_config_spad_bar_alloc(struct
> > > > > > > > epf_ntb *ntb)
> > > > > > > > >       size =3D epc_features->bar_fixed_size[barno];
> > > > > > > > >       align =3D epc_features->align;
> > > > > > > > >
> > > > > > > > > -     if ((!IS_ALIGNED(size, align)))
> > > > > > > > > +     if (align && !IS_ALIGNED(size, align))
> > > > > > > > >               return -EINVAL;
> > > > > > > > >
> > > > > > > > >       spad_count =3D ntb->spad_count;
> > > > > > > > > --
> > > > > > > > > 2.17.1
> > > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=
=AE=A3=E0=AE=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=
=AE=B5=E0=AE=AE=E0=AF=8D
> > > > > >
> > > > > > Best,
> > > > > > Shunsuke
> > > >
> > > > --
> > > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=
=AE=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=
=AE=AE=E0=AF=8D
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D

Best,
Shunsuke
