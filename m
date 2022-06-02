Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D782753B2BD
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 06:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiFBE2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 00:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiFBE2v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 00:28:51 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639D62A2C
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 21:28:50 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h18so2695137ilj.7
        for <linux-pci@vger.kernel.org>; Wed, 01 Jun 2022 21:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFqjWV2Ith82CnZrH8dD4ZFb6IS0NIVNKzvmGau+WJ4=;
        b=HaB/VBetc4zrPwsBU021Xh7S8nPC7puqH2WPN8J0U81JuV+1OXDuPrYY6ZPSldxYME
         PNdmLBFEhGM9JYbsyv/r5E+kDKuTSBxep++t3HfcYfWqp4VQKFwL7bZyOqXQngztH7lw
         GrtMDEZIles+Cy2U669M10WKe1Mg890Nee6u0VAGu1WpOF2LVRwQHaiHCK5tNJgtNcrV
         FVrCW3kvvzj98ykZwgNrYxYGTPPk8WNroSq0EVGLz7AJuEAsdl/nZfjsXuld60JxTUGZ
         0KqDO0ZdsimVQ2hnxETpZG6JnRQIrM+2LdhY6Zr6z4x8wLCVaFBUWVmSlM0K4ay4+Pm8
         RrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFqjWV2Ith82CnZrH8dD4ZFb6IS0NIVNKzvmGau+WJ4=;
        b=sOE2H5E8dZznPEDLYJ7+5icfo3MGxNblM1OuBxlGQyirfwTqUnzlWfuFYxAH+Owy5V
         K4WLTrCYrLAu2RQFkemx7IXh5E7jwCPyYNaFAYZ0h+nr6f7MD2mQC/gBoVe1vUEw75Ia
         yoGVyq73++QbH2ROukQ03Lw6MVekIa5a2bus1dwLMeZdCRB0Cn2JvFaUehRZEYMI3s5m
         GyAroJOlVEcq8T4vxzodZ8YeMw3xVcs0FZdU6CjL8Tu0hwAvyFNrgZCF2wVmANcSotX8
         BIehDqgViuSC2Zk3lgLu2qgT2hluu+qE5exVmPHDLakEq1MxU09pfVmFvLztkfGe1jJ5
         rwFw==
X-Gm-Message-State: AOAM531WCZXRWQEbK8KfI5/l/tLk/3PkUge3Lyv/0apgbL/hLED1AFxh
        tPM/iJNFNLQ3CLx7ryigf+6+Z9yWrQDHzZRrMBo=
X-Google-Smtp-Source: ABdhPJy6uk+uYcXnJnaXGZoAoOdjPJ/9jaKnTzMP2O7XfZPbbsSA9ttV9Erc7QdNULLnFtFsJHvuwWRifC/xTThHRk0=
X-Received: by 2002:a92:194c:0:b0:2c8:2a07:74e7 with SMTP id
 e12-20020a92194c000000b002c82a0774e7mr2088892ilm.272.1654144129684; Wed, 01
 Jun 2022 21:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220430084846.3127041-4-chenhuacai@loongson.cn> <20220531231407.GA795410@bhelgaas>
In-Reply-To: <20220531231407.GA795410@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 2 Jun 2022 12:28:40 +0800
Message-ID: <CAAhV-H5c5ytuaG5dk+bXwRKiM1Mxfut_2uaZfFK1JUiO2VkqZA@mail.gmail.com>
Subject: Re: [PATCH V13 3/6] PCI: loongson: Don't access unexisting devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Wed, Jun 1, 2022 at 7:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Apr 30, 2022 at 04:48:43PM +0800, Huacai Chen wrote:
> > On LS2K/LS7A, some unexisting devices don't return 0xffffffff when
> > scanning. This is a hardware flaw but we can only avoid it by software
> > now.
>
> s/unexisting/non-existant/ (many occurrences: subject line, commit
> log, comments below)
OK, thanks.

>
> What happens in other situations that normally cause Unsupported
> Request or similar errors?  For example, memory reads/writes to a
> device in D3hot should cause an Unsupported Request error.  I'm
> wondering whether other error handling assumptions might be broken
> on LS2K/LS7A.
Hardware engineers told me that the problem is due to pin
multiplexing, under some configurations, a PCI device is unusable but
the read request doesn't return 0xffffffff.

>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index adbfa4a2330f..48316daa1f23 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -138,6 +138,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
> >                              int where)
> >  {
> >       unsigned char busnum = bus->number;
> > +     unsigned int device = PCI_SLOT(devfn);
> > +     unsigned int function = PCI_FUNC(devfn);
> >       struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
> >
> >       if (pci_is_root_bus(bus))
> > @@ -147,8 +149,13 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
> >        * Do not read more than one device on the bus other than
> >        * the host bus. For our hardware the root bus is always bus 0.
> >        */
> > -     if (priv->data->flags & FLAG_DEV_FIX &&
> > -                     !pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
> > +     if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
> > +             if (!pci_is_root_bus(bus) && (device > 0))
> > +                     return NULL;
> > +     }
> > +
> > +     /* Don't access unexisting devices */
> > +     if (pci_is_root_bus(bus) && (device >= 9 && device <= 20 && function > 0))
>
> Yuck.  This is pretty nasty magic.  If this is something that might be
> fixed in future versions of the hardware, maybe you should factor this
> out into a function pointer in loongson_pci_data or something.
OK, seems providing a pdev_is_existant() is better.

Huacai
>
> >               return NULL;
> >
> >       /* CFG0 can only access standard space */
> > --
> > 2.27.0
> >
