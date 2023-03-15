Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E096BAAF8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 09:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjCOImV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCOImS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 04:42:18 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA8E6BC33
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 01:42:15 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-53d277c1834so353800467b3.10
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678869735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTuGpc9zZDajgS9JdSbz5gYMdquT7uBEBxyEc8YStMs=;
        b=X8dfDUdc1qERLh7GivTSF6wAoPsVAkvj2ArHJf+sy5lK6lCJ+gnt6wL8G/qq14xTSw
         mjda5Rut3a1LWApmKqwfqQTT+tSBy26JXXW25TL9FtRcv9N6sx/LgxDS08V/QhsObugK
         NPhFuy1fii5SXPjmXcWltoGvZ6O5zXLeT6G2mVMXU285VJC3/FnnB0qxQjSQBWCD73sb
         /rvd5t2nXr/fON39K8yDlmtX/XXXNBJXURsvDMLp87WsLKuIFCJcj+zScVTEDm7QRkIs
         JxXTDcIVqpp185Vi2Vqj2pWjdXkl22umV2cZKBxBJtkQkgT1Lrsv7TWOmyXJuVuz3FE+
         3XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678869735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTuGpc9zZDajgS9JdSbz5gYMdquT7uBEBxyEc8YStMs=;
        b=AbnAXmCTVMODmKUftTQvWAFqrXuacEq9/H5DPgirUsPjP0QhVGT69aaST8t5DHZ0B/
         LZ1/oZfukIR1SgYGR+aHi5xXHV0CC/nFxKf1xVQsmAtDs592iBoxVV2rbbB63K+sxvHR
         7qNlEseEDt0EzIBnLGmR7MxIq6mc96K/WpRtwFQ6B/2TAZvFRKVv5uO9rIkrcSPSfXqm
         Ok+liyQY4AswCmqaTvr3tHsW/v5yCaNX0FAQyQeputmfKg2EW5yP6i8tlNj7Sda4k26V
         oz7qTtM6i06BYKSHQMluNEYvTH9KlmWqaP9to6cEjP6+VhpH6wATdmNBEz/8vdSFXSOX
         SLEA==
X-Gm-Message-State: AO0yUKVpuNfmylD3Wb8wTRM0rwvOxYUOqdAbZfb+AQokgTyKVhOiCGIt
        R79HWee8D4gLC9djJxYwGiL6bRzOdQ3gwHiPMK1hSA==
X-Google-Smtp-Source: AK7set+PctbN8J4oXDXLyGrk3edHfMzatYBNgyGgTDyeQWW1ATtsR/bDqC9DIp18hftEPIAszZ48FGEmsyi1yIHsDoc=
X-Received: by 2002:a81:ad19:0:b0:541:a0ab:bd28 with SMTP id
 l25-20020a81ad19000000b00541a0abbd28mr6948301ywh.4.1678869734933; Wed, 15 Mar
 2023 01:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com> <20230314121216.413434-10-schnelle@linux.ibm.com>
In-Reply-To: <20230314121216.413434-10-schnelle@linux.ibm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Mar 2023 09:42:03 +0100
Message-ID: <CACRpkdbS1U8_qakdWV0YZq3bhr1NvFuL0Umv3QsXD0wYu7Hd9A@mail.gmail.com>
Subject: Re: [PATCH v3 09/38] gpio: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas,

thanks for your patch!

On Tue, Mar 14, 2023 at 1:12=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 13be729710f2..5a874e67fc13 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -688,7 +688,7 @@ config GPIO_VISCONTI
>
>  config GPIO_VX855
>         tristate "VIA VX855/VX875 GPIO"
> -       depends on (X86 || COMPILE_TEST) && PCI
> +       depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT

But is this the right fix? Further down in the Kconfig we have:

menu "Port-mapped I/O GPIO drivers"
        depends on X86 # Unconditional I/O space access

config GPIO_I8255
        tristate
        select GPIO_REGMAP

(...)

Isn't the right fix to:

1) Move this Kconfig entry (VX855) down under the Port-mapped /O drivers,
   and then:

2) Make the whole submenu for port-mapped IO drivers depend on
   X86 && HAS_IOPORT

Yours,
Linus Walleij
