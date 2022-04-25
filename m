Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC150E210
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiDYNoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiDYNn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 09:43:59 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC84926F
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 06:40:55 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ec42eae76bso148301887b3.10
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0iW0lfnOAQF5cFI1vUpJrSs+pwJtGVWKWvpMUuWdKzw=;
        b=a+4h19FIk30YOSOnT/EZ40c6x1uajSyiYVz5RRsTKaKN1eJGtIyF+2r5q+eNdqyBBl
         XIQoID+tBiBPNrscesCiG4KqQt0dg0KP03zgfjtqy8IXImQPeYwJTvXtbhdA9/9YKgVa
         za6lWLnHoXo+B9bQTRCOygkqQD8Uzd9Gvvxg45OueC7y69tCefIlMbj0v7FaR/0VXpqJ
         SRSU1QAVzrqhVDWYqVcpTwWWxpXq0DAaGj9oJyWbE8h6Ru6nmgFRoZUV5vtHrXZs0DYh
         Nz8aN0NZaESQOyygNvXnoDRbUCvTEuQ0xFVpJxPQpuloFRUaXbhytj2y2xhHlkWmyNu1
         nNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0iW0lfnOAQF5cFI1vUpJrSs+pwJtGVWKWvpMUuWdKzw=;
        b=jeZSroJ8LQK5/rmspWda3pZ170E8joW7yQAY2Edu3PlZdl9GNersNApcg3UPIxCIjv
         bNnD+rp/q7NIHykXxP0zUA2xc6oJ6kWQIvLtahaohc7L0EmdQmk+Rgi2O7RnoOGQt66j
         0FR+Dwf7qHR8k+OTLNOtQBdZ8zgeKJDrNz3za2JIpSpb6qrS848WZk1nYcxI7wsdGa7G
         EdgVi54Wanmem28BzykvBYQJe4aKh6/MVJEVO/o73z9wTdB1rCH8iUQ8QavHPXj3RsJY
         GkkpOjRzLEgAu2VlFb6EkoDbXizTOohtfKHXqvvdZZJfS4AcRIa718xuKrJqrc93BsEG
         UK1g==
X-Gm-Message-State: AOAM530QeacArAGcjXQGupBqkrt2DpU0+dw/04Smriohstu7eN/PWJo8
        9ni4Ti0UdIgiCnTlp3mw0a5bucVx7kYidbKIP/NMVA==
X-Google-Smtp-Source: ABdhPJyLGPhTNmwcVKp/aPjOE6zhKyC+wcn0ap56Z0HIRwG+0xlW9MTQtYt2TvyL34lPTJFEh5UsTwcwn5RaRNHPmiQ=
X-Received: by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr17318800ywd.448.1650894054719; Mon, 25
 Apr 2022 06:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <YYCOTx68LXu1Tn1i@fedora> <CACRpkdYmw4yBm3Y1P42TcRs4fFNEiy3LXxmO_j=zeTv_usDR+g@mail.gmail.com>
 <56052bc6e3b6cab6bfdfc5f706ec9984bea16bba.camel@pengutronix.de>
In-Reply-To: <56052bc6e3b6cab6bfdfc5f706ec9984bea16bba.camel@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Apr 2022 15:40:43 +0200
Message-ID: <CACRpkdZYgym8f0o00EU7QKOUzkzOJZMeZYmQL6XoNLP6V7rz3g@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod interface
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        hongxing.zhu@nxp.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 25, 2022 at 2:07 PM Lucas Stach <l.stach@pengutronix.de> wrote:

> The binding explicitly describes the GPIO as not polarity aware and has
> a separate property "reset-gpio-active-high" to avoid breaking old
> DTBs. I don't think it's helpful to dismiss this explicit backward
> compat just because the driver code looks nicer that way.

I see. We handle such things a specific way.

Look in drivers/gpio/gpiolib-of.c, especially the function
of_gpio_flags_quirks().

Here we special-case all bindings which for some reason introduced
something necessary custom, like in this case not using the proper
polarity flag.

Add code to this file in the proper place to handle and hide the
old style DTBs using "reset-gpio-active-high" as active high flag
and assuming active low otherwise in this file.

I imagine it begins with

if (IS_ENABLED(CONFIG_PCI_IMX6)) { ... }

Then modify the code in drivers/pci/controller/dwc/pci-imx6.c
to act as if gpiolib handles polarity inversion. Include all changes
to all files in the same patch so this is changed in tandem (one technical
step).

Yours,
Linus Walleij
