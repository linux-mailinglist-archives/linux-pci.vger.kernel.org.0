Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF53B3E30
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFYIIS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 25 Jun 2021 04:08:18 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:33479 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229799AbhFYIIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 04:08:16 -0400
Received: from [77.244.183.192] (port=64446 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lwgqY-000EWi-K3; Fri, 25 Jun 2021 10:05:54 +0200
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20210622115604.GA25503@lpieralisi>
 <20210622121649.ouiaecdvwutgdyy5@pali>
 <18a104a9-2cb8-7535-a5b2-f5f049adff47@lucaceresoli.net>
 <4d4c0d4d-41b4-4756-5189-bffa15f88406@ti.com>
 <20210622205220.ypu22tuxhpdn2jwz@pali>
 <2873969e-ac56-a41f-0cc9-38e387542aa1@lucaceresoli.net>
 <20210622211901.ikulpy32d6qlr4yw@pali>
 <588741e4-b085-8ae2-3311-27037c040a57@lucaceresoli.net>
 <20210622222328.3lfgkrhsdy6izedv@pali>
 <CACRpkdai2cvoNFR8yH2MHP+R27nQm1HZNK4-mJ50mE7DHrBmXw@mail.gmail.com>
 <20210624233448.ouvczfbogmtnbrye@pali>
 <CACRpkdZyMr-8Qmf3S7R+RcWe5shhnMeBoEsJoQdREimpB-xw+g@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <20966897-c2c9-92e2-c73e-78e0e8acc13d@lucaceresoli.net>
Date:   Fri, 25 Jun 2021 10:05:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZyMr-8Qmf3S7R+RcWe5shhnMeBoEsJoQdREimpB-xw+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
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

Hi,

On 25/06/21 02:09, Linus Walleij wrote:
> On Fri, Jun 25, 2021 at 1:34 AM Pali Rohár <pali@kernel.org> wrote:
> 
>>> gpiod_set_value(gpiod, 1) == assert the line
>>> gpiod_set_value(gpiod, 0) == de-assert the line
>>
>> Problem is that some pci controller drivers (e.g. pci-j721e.c or
>> pcie-rockchip-host.c) expects that gpiod_set_value_cansleep(gpiod, 1)
>> de-asserts the line and it is already used in this way.
>>
>> Which is opposite of the behavior which you wrote above.
> 
> I sketched a way out of the problem using a quirk in
> gpiolib in another response. We have a few of these
> cases where we have to code our way out of mistakes,
> such things happen.
> 
> The problem is common, and due to the fact that device tree
> authors ignores the flag GPIO_ACTIVE_HIGH (which has
> been around since the early days of device tree on PowerPC)
> instead they opt to do the inversion in code. Which violates the
> contract that the DT should describe the hardware.
> 
> The ambition of the DT specifications/schemas are to be operating
> system independent, and this kind of stuff creates a situation
> where other operating systems can't use the specification without
> also going and looking at how Linux has implemented stuff.
> Which is against the ambition of the device tree work.
> 
>> I would suggest to define enum/macro with word ASSERT and DEASSERT in
>> its name instead of just true/false boolean or 0/1 int.
>>
>> In case of this PERST# misunderstanding, having assert/deassert in name
>> should really help.
> 
> Hm that looks useful, Bart &co what do you think?
> 
> #define GPIOD_ASSERTED 1
> #define GPIOD_DEASSERTED 0
> 
> in consumer.h, would that be helpful for users?

Looks like a good idea to me. It would help making people aware that
gpiod_set_value() & co do _not_ take a physical line value. It's done
that way since ages, it's documented, yet many developers are still
unaware of that...

-- 
Luca

