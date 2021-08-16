Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1219D3ECD37
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhHPDVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:21:31 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45376 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S232779AbhHPDVa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:21:30 -0400
Date:   Sun, 15 Aug 2021 23:20:30 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
Message-ID: <YRnZfhBXy/yYFurU@sunset>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io>
 <CAHp75VeKeGgUgALLztA3Q3jizF2=OkSzU9bzaPmTHO9Pad=QOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeKeGgUgALLztA3Q3jizF2=OkSzU9bzaPmTHO9Pad=QOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

Thanks for the review.

>      +       depends on GPIOLIB
> 
>     It doesn’t seem to provide a GPIO. 

I thought that was needed to consume GPIOs, but it looks like other
PCI drivers don't do it. Removed.

>      +       if (IS_ERR(port))
>      +               return -ENODEV;
>      +
>      +       reset = devm_gpiod_get_index(pcie->dev, "reset", i, 0);
> 
>    Use appropriate flag.
>     
> 
>      +       if (IS_ERR(reset))
>      +               return PTR_ERR(reset);
>      +
>      +       gpiod_direction_output(reset, 0);
> 
>    Ditto and remove this line.

Fixed in v2, thank you.

>      +       usleep_range(5000, 10000);
> 
>    Sleep of such length should be explained.

Removed in v2.

>      +
> 
>    Redundant blank line 

Presumably fixed in v2.

>      +       pcie->bitmap = devm_kcalloc(pcie->dev,
>      BITS_TO_LONGS(pcie->nvecs),
>      +                                   sizeof(long), GFP_KERNEL);
> 
>    devm_bitmap_zalloc()

Done in v2.

>      +static const struct of_device_id apple_pci_of_match[] = {
>      +       { .compatible = "apple,pcie", .data = &apple_m1_cfg_ecam_ops },
> 
>     
> 
>      +       { },
> 
>    No comma for termination entry 

Fixed in v2.

BR,

Alyssa
