Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7917D3B3E41
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 10:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhFYIM3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 04:12:29 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:43655 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229748AbhFYIM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 04:12:28 -0400
Received: from [77.244.183.192] (port=64458 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lwguc-000GX1-Pd; Fri, 25 Jun 2021 10:10:06 +0200
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
 <20210622110627.aqzxxtf2j3uxfeyl@pali> <20210622115604.GA25503@lpieralisi>
 <20210622121649.ouiaecdvwutgdyy5@pali>
 <18a104a9-2cb8-7535-a5b2-f5f049adff47@lucaceresoli.net>
 <4d4c0d4d-41b4-4756-5189-bffa15f88406@ti.com>
 <CACRpkdYp17MLavG_OMSHmS5DfMGLXrfK11nDfJX86rM9LJ9DtQ@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <e9ab9c22-f73b-fe72-820a-4f2825c3dabc@lucaceresoli.net>
Date:   Fri, 25 Jun 2021 10:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYp17MLavG_OMSHmS5DfMGLXrfK11nDfJX86rM9LJ9DtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

On 25/06/21 01:11, Linus Walleij wrote:
> On Tue, Jun 22, 2021 at 3:57 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
>> While the patch itself is correct, this kind-of changes the behavior on
>> already upstreamed platforms. Previously the driver expected #PERST to
>> be asserted be external means (or default power-up state) and only takes
>> care of de-asserting the #PERST line.
>>
>> There are 2 platforms that will be impacted due to this change
>> 1) arch/arm/boot/dts/am57xx-beagle-x15-common.dist (has an inverter on
>> GPIO line)
>> 2) arch/arm/boot/dts/am571x-idk.dts (directly connected to #PERST)
>>
>> For 1), gpiod_set_value(reset, 0) will assert the PERST line due to the
>> inverter (and GPIO_ACTIVE_LOW)
>> For 2), gpiod_set_value(reset, 0) will assert the PERST line because we
>> have GPIO_ACTIVE_HIGH
> 
> The presence of an inverter makes it necessary to model this the right
> way to get out of the situation.
> 
>> So this patch should have to be accompanied with DT changes (and this
>> patch also breaks old DT compatibility).
> 
> There are ways to deal with this perfectly. It may or may not be worth
> the extra work. But I can show how it is done.
> 
> Make the patch to the driver that assumes driving the gpio descriptor
> to 1 (asserted) has the desired effect.
> 
> In this patch, I would include a hunk that fixes the above device trees,
> so they are correct from this point. This is one of the few cases where
> I think it warrants to fix the driver and the DTS file at the same time,
> but the DTS can also be patched separately because of the described
> solution below:
> 
> To avoid regressions with old device trees, add code to
> drivers/gpio/gpiolib-of.c in function of_gpio_flags_quirks()
> to react to the old incorrect device trees. This is where we
> stockpile OF errors and bug fixes.
> 
> This needs to be pretty elaborate. It begins like this:
> 
> if (IS_ENABLED(CONFIG_PCI) &&
>       (of_machine_is_compatible("ti,am572x-beagle-x15") ||
>       of_machine_is_compatible("ti,am5718-idk")) &&
>       of_node_name_eq(np, "pcie")) {
>       /* ... add code to check and enforce the flags ... */
> }
> 
> You see the idea here. Include this in the patch to make the
> Perfect(TM) solution to this problem both fixing all device trees
> in place and dealing with the old erroneous ones using some
> elaborate code.
> 
> There are plenty of examples on how to detect warn and
> modify flags in of_gpio_flags_quirks() make it clear and add
> some warning prints and comments. Keep me and Bartosz
> in the loop. It'll look fine in the end.

Thanks for thaking the time to explain this in detail!

As I volounteered to write the patch, and since I'm lazy, I was going to
vote for the former solution. But to be honest the latter has some good
reason to exist as it handles the case of kernel upgrade without DT
upgrade...

My bad, this two-liner patch is growing so big. :-)

-- 
Luca
