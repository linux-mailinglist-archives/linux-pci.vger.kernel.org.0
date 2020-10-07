Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF71286880
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgJGTpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgJGTpE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 15:45:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295DBC061755;
        Wed,  7 Oct 2020 12:45:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 33so3400622edq.13;
        Wed, 07 Oct 2020 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oM1KSjc+Cmt4y9Jj6zCUXHMJeHtERnQiykUH9iP1mAs=;
        b=X2MaHONZDjMMlot2K0Pp4HEsKv73KiL7KKKLkTAfaFw90cV1qYFyDIE2mgXka0Ztz+
         1JOUbW8L8JRv0UE5x1l4Nr/c6o+Sp0mXSLRi76LAD5vxnmHQ27MF72zL7/C0kOKzWQiv
         /cdarhUUZjaQftwXRyN3cIree84pfhAGuYrYaE/oV47i+9z9G2YEG5luyO+T2O4BL2CY
         R6O8X0bgn711qKaEZPyPEH8UWdKnnKYOJZQBhAJG8GYGNOHYFEUTX1kUUwaVjkqUOHDY
         EdHnf9glGr1Dnmyv86V7ZIrFzgz19iHheA+5+vr6xdcxZyO7O24HdDgW0g+WZZtRzqnw
         EM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oM1KSjc+Cmt4y9Jj6zCUXHMJeHtERnQiykUH9iP1mAs=;
        b=Og0lfQ/CQY3Y6oq38nndT61hZEQIpM7BS1Bpvoa7dgsZ79i+fPc6J70txieRlLCfW8
         SmR8xQzWXm6BW9f5r/aAp3Vi0spJFIyAXooFhlaQjK1OcJ0OA5YhYQYxvdMUeoMxrGTj
         Nk0rdXr/mJBt+oTN8pRu4xI+27l4C1MmPsyRRJX05zA75wgzMnQVj4hnAOpEs5pnXBzp
         LQohS4zwgXVha/tZPWBbY1Ut+4e1+kywxR6lVhsD2yf2nD8C2fT/a0oBANArspmtk6JA
         eG6QEDTFBatVoEGqfRJVvbfHzzVtksRcUlredv4HBo6srBpVz7oNonJHgr0U5Z325INN
         SrmQ==
X-Gm-Message-State: AOAM530kHFrGQnGsm3j5/r0AY9frdMs+799XcXRhUILF9CwEjJq4Up3v
        zM6Ie9JsxU0117qwX6MoIdnfj37FLrRwZMh6inQ=
X-Google-Smtp-Source: ABdhPJwPdwGlw4IFKDK4W2jf3Z76PcuSjeAnAyU0yA3tEwciGwk1gnziLCS9g/iYuCY63ApZS0IY8pd5+rJCqSemS3o=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr5591929edf.52.1602099902773;
 Wed, 07 Oct 2020 12:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-4-martin.blumenstingl@googlemail.com> <CACRpkdZo-U_cAhbKb4E+d+p+5FenXkGYW0RXxyk4M5uyEPCpzw@mail.gmail.com>
In-Reply-To: <CACRpkdZo-U_cAhbKb4E+d+p+5FenXkGYW0RXxyk4M5uyEPCpzw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 7 Oct 2020 21:44:51 +0200
Message-ID: <CAFBinCCLubmDvxfabQHx2-ucgAsm1NArMUrtPx-UA2nX5xoFFA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] gpio: ej1x8: Add GPIO driver for Etron Tech Inc. EJ168/EJ188/EJ198
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

On Wed, Oct 7, 2020 at 11:29 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Martin,
>
> thanks for your patch!
thank you for reviewing the whole series!

> As noted on the earlier patches I think this should be folded into the
> existing XHCI USB driver in drivers/usb/host/xhci-pci.c or, if that
> gets messy, as a separate bolt-on, something like
> xhci-pci-gpio.[c|h] in the drivers/usb/host/* directory.
> You can use a Kconfig symbol for the GPIO portions or not.
OK, I will do that if there are no objections from other developers
I am intending to place the relevant code in xhci-pci-etron.c, similar
to what we already have with xhci-pci-renesas.c

[...]
> This should not be necessary. Tie the GPIO state into the PCI device
> driver state, possibly using some #ifdefs.
>
> > +static u8 ej1x8_gpio_shift(unsigned int gpio, u8 mask)
> > +{
> > +       return (gpio * fls(mask));
> > +}
> > +
> > +static u8 ej1x8_gpio_mask(unsigned int gpio, u8 mask)
> > +{
> > +       return mask << ej1x8_gpio_shift(gpio, mask);
> > +}
>
> This looks a bit like regmap but trying to use regmap for this
> would probably be overengineering.
the problem is also the "INIT" register which needs to be set before
writing the registers

> Looking at the code I get annoyed that it uses the config space to
> manipulate the GPIOs, else you could have used GPIO_GENERIC
> but now you can't, how typical.
I think this won't work in practice because of the EJ1X8_GPIO_CTRL for
which we have to read from bits [7:0] but write to bits [23:16]
due to this (and the INIT register as mentioned above) I did not
consider GPIO_GENERIC any further

> Other than that the code looks nice, but fold it into the USB
> host driver somehow unless there is a compelling argument
> as to why not.
will do so, thanks!


Best regards,
Martin
