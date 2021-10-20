Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9105B434AAE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJTMFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 08:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJTMFS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 08:05:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDC8C061746
        for <linux-pci@vger.kernel.org>; Wed, 20 Oct 2021 05:03:04 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id x1so24227639iof.7
        for <linux-pci@vger.kernel.org>; Wed, 20 Oct 2021 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Olwl5cHA/AN8tE4I0NNhWhyFygCXkQ/WoEuR0N13PWw=;
        b=VJqsxOcqVBqgVQV5Escnr3iK/6wesXLTM5jx4x87kEdlTxfcCjC6Rb2cXivDnDcl5Z
         PXAYrsHNKq0vHFmxQ4Jj7i6U0fmCHW323w36PTi+HD5J8AaZR7kZk84G0Qo2ERFJRRCW
         OyOFZyRKtGZfHp2xxmiGTCrACYIfXpgeqRf9lSQ52GjUH64rfLDMxPTuEbEHB8WaN2rH
         qy9l7wtRMZ/J6ncXuoxNZp9NfKorKamrYIezSHcRv5X+ON6z5CnMYvpaKGBDTu2CE6+O
         syz+mVahQRfih7gJ5yHkn3mW79nqm7tTY8J6je9aUgcWn6EyxuqEac4Owa2q4esDzdib
         P/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Olwl5cHA/AN8tE4I0NNhWhyFygCXkQ/WoEuR0N13PWw=;
        b=4uHxBO+VzrDFRE3bweL7O95cse4+bpzjW0VPfsJKt0mBip6DpVixNK+h9OxIx9craj
         okRBHWUK2U/9MfBWumR4bFAddOkZaPSI1N+3/uR5GwnmbIooB8VCnFxAA9LhmQv8A+Kq
         8+NB7TIUd+9oBg0/bF2RRGpO0ynr/xc+12SrauCuQD7v24TOgj7S6GRh4V8n8Vk3xCuq
         XH1o7RqlRbRXW1P27fM+AcGJbvTovi5eoB3/qxQQaeQL7rEQ9tHq/3ww9jdZnAh4/+ls
         aCsHatb+cZy2O8gesuFfa1wzZhWNRuBMBjts2dm6es2ZvnGKndhgTvoiCQN3DuKReDD1
         j3AQ==
X-Gm-Message-State: AOAM532CbEgKuzz4gjGeYAgprcf9gRvtr74YErgmkKo5j9UekEQm/+Qj
        16syKkpGxybfeJ8fWTaD4/ZBCikUsa8hJcX1+asxHOn03d6XRN7cldQ=
X-Google-Smtp-Source: ABdhPJy5ZGwbLgLK9QQOb15fTNWvpIqYexDdT/z5IK1r9rV5PtZtdkEbl3bXiv5TolZ6aZNLL6LsbDK8hL8/Plm/To8=
X-Received: by 2002:a6b:fd05:: with SMTP id c5mr22928713ioi.15.1634731383700;
 Wed, 20 Oct 2021 05:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <YW7jvR/2jpAwSpvd@fedora> <20211019194545.GA2393463@bhelgaas>
In-Reply-To: <20211019194545.GA2393463@bhelgaas>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Wed, 20 Oct 2021 09:02:52 -0300
Message-ID: <CAH7FV3nsOsJDKf9td1Gk-bf0w1jengDnD-K9NrghHw4iQenh9Q@mail.gmail.com>
Subject: Re: [PATCH] pci-imx6: replacing legacy gpio interface for gpiod
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm sorry about the commit log. I made an effort to do a better commit
log on v2 and sent the new version on the mailing list. Thanks for
reviewing the entry!


Em ter., 19 de out. de 2021 =C3=A0s 16:45, Bjorn Helgaas
<helgaas@kernel.org> escreveu:
>
> [fixed "linux-pci@vger.kernel.org" in cc]
>
> On Tue, Oct 19, 2021 at 12:26:53PM -0300, Ma=C3=ADra Canal wrote:
> > Removing all dependencies of linux/gpio.h and linux/of_gpio.h and repla=
cing
> > it with linux/gpio/consumer.h
>
> Run "git log --oneline drivers/pci/controller/dwc/pci-imx6.c" and make
> your subject line match -- capitalization, sentence structure, etc.
>
> Write commit log in imperative mood, i.e., "Remove" instead of
> "Removing": https://chris.beams.io/posts/git-commit/
>
> The commit log mentions the trivial part but omits the important part
> (converting from gpio to gpiod model).
>
> > Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 31 ++++++++++-----------------
> >  1 file changed, 11 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contro=
ller/dwc/pci-imx6.c
> > index 80fc98acf097..e5ee54e37d05 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -11,13 +11,12 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> >  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
> >  #include <linux/module.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_address.h>
> >  #include <linux/pci.h>
> > @@ -63,7 +62,7 @@ struct imx6_pcie_drvdata {
> >
> >  struct imx6_pcie {
> >       struct dw_pcie          *pci;
> > -     int                     reset_gpio;
> > +     struct gpio_desc    *reset_gpio;
> >       bool                    gpio_active_high;
> >       struct clk              *pcie_bus;
> >       struct clk              *pcie_phy;
> > @@ -526,11 +525,11 @@ static void imx6_pcie_deassert_core_reset(struct =
imx6_pcie *imx6_pcie)
> >       usleep_range(200, 500);
> >
> >       /* Some boards don't have PCIe reset GPIO. */
> > -     if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > -             gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > +     if (imx6_pcie->reset_gpio) {
> > +             gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
> >                                       imx6_pcie->gpio_active_high);
> >               msleep(100);
> > -             gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > +             gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
> >                                       !imx6_pcie->gpio_active_high);
> >       }
> >
> > @@ -1025,22 +1024,14 @@ static int imx6_pcie_probe(struct platform_devi=
ce *pdev)
> >               return PTR_ERR(pci->dbi_base);
> >
> >       /* Fetch GPIOs */
> > -     imx6_pcie->reset_gpio =3D of_get_named_gpio(node, "reset-gpio", 0=
);
> >       imx6_pcie->gpio_active_high =3D of_property_read_bool(node,
> >                                               "reset-gpio-active-high")=
;
> > -     if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > -             ret =3D devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
> > -                             imx6_pcie->gpio_active_high ?
> > -                                     GPIOF_OUT_INIT_HIGH :
> > -                                     GPIOF_OUT_INIT_LOW,
> > -                             "PCIe reset");
> > -             if (ret) {
> > -                     dev_err(dev, "unable to get reset gpio\n");
> > -                     return ret;
> > -             }
> > -     } else if (imx6_pcie->reset_gpio =3D=3D -EPROBE_DEFER) {
> > -             return imx6_pcie->reset_gpio;
> > -     }
> > +     imx6_pcie->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> > +                     imx6_pcie->gpio_active_high ?  GPIOD_OUT_HIGH :
> > +                             GPIOD_OUT_LOW);
> > +     if (IS_ERR(imx6_pcie->reset_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpio),
> > +                                       "unable to get reset gpio\n");
> >
> >       /* Fetch clocks */
> >       imx6_pcie->pcie_phy =3D devm_clk_get(dev, "pcie_phy");
> > --
> > 2.31.1
> >
