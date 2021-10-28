Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0815743D8DA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 03:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJ1Br4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 21:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1Br4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 21:47:56 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC0C061570;
        Wed, 27 Oct 2021 18:45:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w193so6167817oie.1;
        Wed, 27 Oct 2021 18:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GvIDzwndi4kOaXgwdqTw9zkmY4QEl0D1mqqX44XzZOs=;
        b=PnLhLYRXlzg2rWP0WMtl2acm00UXMnFhALl3OMVuiEYwMHQjWOI0XIy2phw+4B5+Xb
         I1TrNVmTqU29jEL9JHpUUN+syXUsKinkcjT13Lrvl0zl4q2M7liAS5BS9IfoEX7xVOds
         qbtt1r4StBzMZ5wUnXAvwUJ5L3E0CKdshQyueYNIWX7HE3JlyAUZyIGoPqILLo5ms1wA
         ovMjZ+ouNLN3YSMxAeWUewUW7Egpddlb489m8JlgNuIsEzeo2a6WcquMQ6py0Ul93x5X
         vFYpTdHSc6UezG5puSY4sNOJFqHSjsCBln2IC49j6NsdukzZgQ0gEl9Xc2LFh2z9S1no
         4hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GvIDzwndi4kOaXgwdqTw9zkmY4QEl0D1mqqX44XzZOs=;
        b=mFVwmN9guVcnLoyijV2YzQZE0UlpVm/s9xqS1W7FXqBwg3B5soruOucz3keSbeC6+T
         Sn9QqJcB+AXxLwqkuomG6Uoq5tXdhy/jFMo64jpKk81fR8/RnS3O6+jou/vXookp1h+9
         sdqibwvHUh3dsE8tycrTtaXa9s67qaboxfpiSad7bLnQENvY7tw1G4m0o+hteN1eBywv
         QyXsbO6n6qeGGZfoR9zFMZFxyIAy1hhmUI/TaocVCgo44sh374LnFVkZb6uRcOKWjFku
         gh9YRdgVGbaKnpRRFlZVDrw41AT7gMtLXyOVCZpAthtsXUaW5D9i74sicbIuJx9x5JVh
         PyVQ==
X-Gm-Message-State: AOAM530usSUPRi0E8ox7akWRiQLlmOJjRNzEC0FdNMDtpEKl5Vz7C+m5
        wGWq0vkmb0saGq9S4pde2uf8/J/rVJUF2K6wlhA=
X-Google-Smtp-Source: ABdhPJy7NnH/7A0gckbkUdoounQCLUKhPDDBZRlb+HQP1s9JbW5pMDT6xTwrbcA+Lr7C6SfsBtlbl0PBenhJv8tmoEw=
X-Received: by 2002:aca:b809:: with SMTP id i9mr829009oif.103.1635385529677;
 Wed, 27 Oct 2021 18:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635333327.git.siyanteng@loongson.cn> <50f5f509c15251fb10b0c87304d272e2c89841f0.1635333327.git.siyanteng@loongson.cn>
 <CAMhs-H9MANfLThCC-m9Q5whAgRAbnzXjUpipQdnwRf0iqPwJuw@mail.gmail.com>
In-Reply-To: <CAMhs-H9MANfLThCC-m9Q5whAgRAbnzXjUpipQdnwRf0iqPwJuw@mail.gmail.com>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Thu, 28 Oct 2021 09:45:17 +0800
Message-ID: <CAEensMxOn2Uz7d051C=N6xCLFM8JHr1PCpDETM6z2xkC46XV7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: mt7621: Add MODULE_* macros to MT7621 PCIe host
 controller driver
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Yanteng Si <siyanteng@loongson.cn>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        sterling <sterlingteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sergio Paracuellos <sergio.paracuellos@gmail.com> =E4=BA=8E2021=E5=B9=B410=
=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:00=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> On Wed, Oct 27, 2021 at 1:32 PM Yanteng Si <siyanteng01@gmail.com> wrote:
> >
> > Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host =
controller driver")
> > the MT7621 PCIe host controller driver is built as a module but no MODU=
LE_*() attributes
> > were specified, causing a build error due to missing license informatio=
n.
> >
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie=
-mt7621.o
> >
> > Fix this by adding MODULE attributes to the driver.
> >
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/control=
ler/pcie-mt7621.c
> > index b60dfb45ef7b..668b737f86fb 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -598,3 +598,5 @@ static struct platform_driver mt7621_pci_driver =3D=
 {
> >         },
> >  };
> >  builtin_platform_driver(mt7621_pci_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
>
> I guess this is needed for COMPILE_TEST scenarios?
yeah!
>
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thank you very much!

Thanks,
yanteng
