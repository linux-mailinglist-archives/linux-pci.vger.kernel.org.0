Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFEB61070D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 03:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiJ1BGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 21:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJ1BGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 21:06:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48372281;
        Thu, 27 Oct 2022 18:06:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b5so3456272pgb.6;
        Thu, 27 Oct 2022 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eouvp87d3Uwj62ptbIwj2FltIDQrDKmm7rl+pdi32U0=;
        b=nQ7weogHhMIC9v9rAl3TVZ1zfLs3IGvA3QKHPCFBZ+KojUNUj5TChT+OvOY12ityd8
         VbE20EYGCMWZidXQ0mA4iREKWBtYaSnvAUNEf/MGSFONDmzlPI+MR4CrUM9ksmAsrDKt
         cj+aWdebIPLIeH6IbKuwGrCytZHTwYkz2OUKYh4KijicqkVXtFp7vt0bi0LKmFm6i4xU
         q4LDtjxwFqoNAonlD9dnY2gWjZ01CSB3ruJJV2hDr7cYI/uKy5RyQ+vTowUxUWeVa6zy
         zJdma15Tr6xjC12xRbPs+cXXQMqUWSrtgiCQqqToh1CNrevC/C1rFj6Z+ww6/oTseywE
         yduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eouvp87d3Uwj62ptbIwj2FltIDQrDKmm7rl+pdi32U0=;
        b=YJCxjLtFm7y0sEMXbj1eKbX0QlUiXPUngQaAwdCZjhQIzdtbY3aP5QegzsWUN42Wkh
         0ZEUC0kS0Pf3GYX7vsgB9mz+ayamk/3s5CCGUcDq2Sev3f1sO6Ypqj1ijns1k6DlXNIV
         ZfGIOK0Bev2YqbHa0133Ags3wYn0jIy1w/wiN49AIqHjcFF34GRBKNt7UUwTArLtbxm7
         PtqrLHy4fiYgwXTXsaJDA8IiyAqASOCnwOVJXOjhrF+qPgBN4KmEMenBemDCbS6zCUgk
         tH1zG0cX9ysOHnTEGOyf0NJyr+FyYqV6hRpKYIkWvKPq2iPQ3B0kE5QMCY5xDc5MCiIR
         RYVw==
X-Gm-Message-State: ACrzQf2Q7nlWqBWzVMjsinkftkikMq/bES8E2NpaVSH1YUoVrLwSNvV0
        AlOSiddJ6BFtUnfuW33d+OY=
X-Google-Smtp-Source: AMsMyM71t2M2+k7329f4iPqjn+WDD27m67jwDQ968XupuMJUSxT0+/ISWLqKZwmQAQWuSE8GPvBuVA==
X-Received: by 2002:a63:1917:0:b0:43c:1471:52b7 with SMTP id z23-20020a631917000000b0043c147152b7mr43836410pgl.522.1666919195743;
        Thu, 27 Oct 2022 18:06:35 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ea9a:801b:ed52:2db1])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902e21300b0017f57787a4asm1747996plb.229.2022.10.27.18.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:06:35 -0700 (PDT)
Date:   Thu, 27 Oct 2022 18:06:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: (subset) [PATCH v1 00/11] Get rid of
 [devm_]gpiod_get_from_of_node() public APIs
Message-ID: <Y1srFi6mJGl5/3gi@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <166687787352.847482.10005684512699510391.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <166687787352.847482.10005684512699510391.b4-ty@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Thu, Oct 27, 2022 at 03:38:11PM +0200, Lorenzo Pieralisi wrote:
> On Sun, 4 Sep 2022 23:30:52 -0700, Dmitry Torokhov wrote:
> > I would like to stop exporting OF-specific [devm_]gpiod_get_from_of_node()
> > so that gpiolib can be cleaned a bit. We can do that by switching drivers
> > to use generic fwnode API ([devm_]fwnode_gpiod_get()). By doing so we open
> > the door to augmenting device tree and ACPI information through secondary
> > software properties (once we teach gpiolib how to handle those).
> > 
> > I hope that relevant maintainers will take patches through their trees and
> > then we could merge the last one some time after -rc1.
> > 
> > [...]
> 
> Applied to pci/tegra, thanks!
> 
> [01/11] PCI: tegra: switch to using devm_fwnode_gpiod_get
>         https://git.kernel.org/lpieralisi/pci/c/16e3f4077965

Any chance you could also pick up

 [06/11] PCI: aardvark: switch to using devm_gpiod_get_optional()
 (20220903-gpiod_get_from_of_node-remove-v1-6-b29adfb27a6c@gmail.com)

 - Pali Rohár has acked it.

Thanks!

-- 
Dmitry
