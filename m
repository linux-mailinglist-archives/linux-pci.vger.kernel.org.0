Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98EF4424DD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 01:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhKBArz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 20:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhKBAry (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 20:47:54 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6858C061766
        for <linux-pci@vger.kernel.org>; Mon,  1 Nov 2021 17:45:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i14so23590126ioa.13
        for <linux-pci@vger.kernel.org>; Mon, 01 Nov 2021 17:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CdQjx0HGt5etDdjQfXz4rMpreR3TwFiKL0chx+EioEw=;
        b=F9PkwVOBx0rYvi51997OwY6dfgJ3I+V/W1M9p2GzsmoMx768QZjmjUGrI1P92KHDvm
         +4ZSUPUbmedpRRouesQI96TEuwr/ROwn6kljAUZ1AuSz7ctQ15WZTI5DKuNlkXeGgYZh
         kKN8lzNg+WF3Tb4MeaBmO6u3xiD6gGZyl+4P/dZrDkQCEalQZ28hZHLZweq1Xleys/T+
         XhIVj2oCIpgOLdCvzx2+z4JxrzAybEqEku4DUSYeMYJlHRUSkvFX68lqdyDt4wAp05Jx
         THTxnMCg6BuzAk29SFZLbHiJHnawNWgx5KTqsd3eYR1qtggN8tVUzkuO2HoLoE8KI6V2
         yDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CdQjx0HGt5etDdjQfXz4rMpreR3TwFiKL0chx+EioEw=;
        b=TnwmCdTnwdvPNd7YFD17/Jue5NjdOYDoLDzQ7/vU4qYvLaANgQnDtAcq6wE9fOYRIY
         u9VTAbUAOd5gM3xVL2Uo2zsOqLvTV1ArlLMPliLEszOzXCeM1iDCXeIWqB2B9OJmNEFB
         odNfOHG0qWTi+5VQe77fRtvS1ScdVIYuQ25+1FNZifSAcNw08Xye4s7WY8avD6qlQLHs
         okY65BClenpP8H6Vki17GvfXmvIVhbxbtOPckB700N86eEWVbi8RhJEJ5qoiaIymOUgn
         WOAw30j8I6XHKI52lHR0DsoOhts9eL96MkNXch2uGMDriLTf3jO3aMCaxXQKOa89kRP5
         iL1w==
X-Gm-Message-State: AOAM532LWIFXgtZoZj+uCs8DJ53QK/1Bs3230B0bN+cFVSkDtdOSDa69
        L64WGXP8+BOFoQdfsNHYQ3m4lDA5PWcbzVINeO/4QQ==
X-Google-Smtp-Source: ABdhPJx35C1DFToM8I+/8vn3pb+0BVcZmhi7R/yAadTa2d4BnYEiWtS0uvxY91mtpifdmpuP5XpEWRNIkCKpi9IMpjw=
X-Received: by 2002:a05:6638:134f:: with SMTP id u15mr24353893jad.7.1635813918186;
 Mon, 01 Nov 2021 17:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <YX/zlRqmxbLRnTqT@fedora> <4f1b60bab451b219c7139e2204eb5b9f462ee4e0.camel@pengutronix.de>
 <CAH7FV3nyyLndqTdJYN8HDxU4C7pW0-DLu6ZSOLof2=tEEHbHxQ@mail.gmail.com> <557e68ad15634ddb65c98ebf80cd7ef962ac2608.camel@pengutronix.de>
In-Reply-To: <557e68ad15634ddb65c98ebf80cd7ef962ac2608.camel@pengutronix.de>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Mon, 1 Nov 2021 21:45:07 -0300
Message-ID: <CAH7FV3nfkihmc9UTvmGC7kL=tO40CL4350smc4FKiLVdsesxkA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] PCI: imx6: Replace legacy gpio interface for
 gpiod interface
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     hongxing.zhu@nxp.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em seg., 1 de nov. de 2021 =C3=A0s 11:58, Lucas Stach
<l.stach@pengutronix.de> escreveu:
>
> Am Montag, dem 01.11.2021 um 11:44 -0300 schrieb Ma=C3=ADra Canal:
> > ?
> > > >       /* Some boards don't have PCIe reset GPIO. */
> > > > -     if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > > > -             gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > > > +     if (imx6_pcie->reset_gpio) {
> > > > +             gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
> > > >                                       imx6_pcie->gpio_active_high);
> > > >               msleep(100);
> > > > -             gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > > > +             gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
> > > >                                       !imx6_pcie->gpio_active_high)=
;
> > >
> > > I don't think this is correct. gpiod_set_value sets the logical line
> > > state, so if the GPIO is specified as active-low in the DT, the real
> > > line state will be negated. The only reason why the reset-gpio-active=
-
> > > high property even exists is that old DTs might specify the wrong GPI=
O
> > > polarity in the reset-gpio DT description. I think you need to use to
> > > gpiod_set_raw_value API here to get the expected real line state even
> > > with a broken DT description.
> > >
> > > Regards,
> > > Lucas
> > >
> >
> > I'm a beginner in kernel development, so I'm sorry for the question.
> > If I change gpiod_set_value_cansleep for gpiod_set_raw_value, wouldn't
> > I change the behavior of the driver? I replaced
> > gpio_set_value_cansleep for gpiod_set_value_cansleep because they have
> > the same behavior and I didn't change the logic states. Thank you for
> > the feedback!
>
> Yes, you need to use the _cansleep variant of the API to keep the
> context information. The point I was trying to make was that you
> probably (please double check, that's just an assumption on my side)
> need to use the _raw variant of the gpiod API to keep the current
> behavior of the driver, as we are setting the physical line state
> purely depending on the reset-gpio-active-high property presence, not
> the logical line state, which would take into account the polarity
> specified in the DT gpio descriptor.
>
> I guess the right API call here would be
> gpiod_set_raw_value_cansleep().

I got it now. Thank you for your attention! I will send the v3 with
the correction.

>
> Regards,
> Lucas
>
