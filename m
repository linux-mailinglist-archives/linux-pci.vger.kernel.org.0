Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE8441CCF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 15:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhKAOrb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAOra (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 10:47:30 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174DC061764
        for <linux-pci@vger.kernel.org>; Mon,  1 Nov 2021 07:44:57 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l8so850102ilv.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Nov 2021 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nTgNimfUoPCIrDoKeVyIYbRT+tZhs8KL4QGLyrkvSyA=;
        b=HUIod4TGIvbg2CAZjR6JNNaCMdnX5/bkqP4kNIF0LVxCuVID9ki4COu7zCxwssTtTy
         VBNfkoQMyU/3BGKPEVQK1LBad1U8IGk7KqBOqnvZVLjrPg4EZeSWl7JxKKpZtWE2Afc+
         qqNC5zGw0uhf74khGk8+FYKmSpRv7gekc2Nxp5aXZL635PtmeYgpiMCWv+G/+XMu7wOG
         e/WhZu466u1PGtEs9tLkd5z1eAakwRYLu4FGsJxTbVk5lcVPw45bBRLWO7L92r63oYu4
         4rE0NFJ9llVksLpFqeEfJMf57pbkGFOnEardVRmFbMyJpv8d3/rVxMiulQqPsgN7fjfN
         TVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nTgNimfUoPCIrDoKeVyIYbRT+tZhs8KL4QGLyrkvSyA=;
        b=y2hTWy+4TWUfHQ/WmJG//6FHsWSFsIp4269NNJIKg+34FJLwC4HeOWafG4i04p4Rhb
         3/M8QTY64dqSzlIj0qDlI2zwESZcmBkE2JHA9RxkB4xDZXHE4aHJeNVuOs54+34uIFvw
         YQMdqc0iIm3Ax4S9E9AgmmUx/eBj18bvlx8HUS04xE49Cy+IgkzTgEeBvF8ljWZOM2Rj
         CiYEi6TwZ2Hd5fkMMSt6AhhzbkmGCeUljRZq2RO010ZQFWZn8WLrTeE/p1b6Rhln5NE/
         61p9HHt6Q+Hd/O2cPl4JjANAC5jN21UR+Pua92JToEIzLUPafzauBlHn76z5y4HDmF4G
         PU7g==
X-Gm-Message-State: AOAM533UQvJca6NujBB7QabZdI5eS2FPtmtM9wuVmWH9FJespcFIzukS
        0VEgs2QwpJ38YGKIiTl8RTEj9cVz6Fot/MKYsPWeFg==
X-Google-Smtp-Source: ABdhPJxzLpaPTvNyx3YNoBE/B8Ej6xYGtp2QXo+2idhrHDksvJl08AvaMK3spnFwjy5jIbCdefktgsljwLFVyba7NvA=
X-Received: by 2002:a05:6e02:1bcb:: with SMTP id x11mr16355301ilv.94.1635777896880;
 Mon, 01 Nov 2021 07:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <YX/zlRqmxbLRnTqT@fedora> <4f1b60bab451b219c7139e2204eb5b9f462ee4e0.camel@pengutronix.de>
In-Reply-To: <4f1b60bab451b219c7139e2204eb5b9f462ee4e0.camel@pengutronix.de>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Mon, 1 Nov 2021 11:44:45 -0300
Message-ID: <CAH7FV3nyyLndqTdJYN8HDxU4C7pW0-DLu6ZSOLof2=tEEHbHxQ@mail.gmail.com>
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

?
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
>
> I don't think this is correct. gpiod_set_value sets the logical line
> state, so if the GPIO is specified as active-low in the DT, the real
> line state will be negated. The only reason why the reset-gpio-active-
> high property even exists is that old DTs might specify the wrong GPIO
> polarity in the reset-gpio DT description. I think you need to use to
> gpiod_set_raw_value API here to get the expected real line state even
> with a broken DT description.
>
> Regards,
> Lucas
>

I'm a beginner in kernel development, so I'm sorry for the question.
If I change gpiod_set_value_cansleep for gpiod_set_raw_value, wouldn't
I change the behavior of the driver? I replaced
gpio_set_value_cansleep for gpiod_set_value_cansleep because they have
the same behavior and I didn't change the logic states. Thank you for
the feedback!

Regards,
Ma=C3=ADra
