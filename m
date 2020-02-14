Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91015CFC5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 03:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgBNCQy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 21:16:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36269 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBNCQy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 21:16:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so3123220plm.3;
        Thu, 13 Feb 2020 18:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8WSL1srlKefaq0F99EUBxceVRB2zzk2pjFciJq1lmoM=;
        b=NviinCR0oMk4qI4d2mKpLelYKzpQrp168dLQKrlj2kGO1vz2PooZPaDa58pTKuwiQc
         +ImsVH0fIz2PhVv7JiphElbM/R7o2yInpZJzBxOvBZnuQsx+OnEyy5Lr+Hxcb7atN33h
         aiCUdtlXGcFTMIZCodFcmaZMAU7b0RZxSQTnYz1cX9F625xfnyK8TghCjskieEN21fOR
         wFmWJJ/VYgfrOtZMvrkNl5MIQGsBxmZ2K6GQvFuQ3k0hIfEAf0srbU9VVEfi8cOKPJ6w
         rOI3aTNoHYZkKEdu7PAOr5FFeFy1+4PT7Xy8X1BpGQWN/8VWjVSBHzxumCbBF12ynXwm
         QJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8WSL1srlKefaq0F99EUBxceVRB2zzk2pjFciJq1lmoM=;
        b=dzA7+PgMqe20xWijGYf0+5M1JgLyNLRj0SMf7rnnJBLyoKvSnltsxavMyNZVcAYmzl
         W4VPSWO3T1/btqKFX/Y5lAk2eZw7F2kDOmEct5Ap9vhxvKhSCu+uOGzEUrTjhiYyaxVl
         ZbHQjk5HMyVwvI9iBOPjSiqDKBPtu6wOPVFD/n4T8eU2s24abCrme5neNWIuHa1kTyBX
         1o8FL4wGHQQim6G9+j/5VX+isSJ3zUSQpwviOwVU1XbLvJlmgpuO4fc4AMaH0dVaf66E
         e3apfbE6llEal35SLC0mvBwLdnhcY9aydV8rthHucI2M3m7q/mXc6VepV1LARZVXTzDo
         4BbA==
X-Gm-Message-State: APjAAAUck9OwDz8VkOQCbgyRtdxDvA7iowZwRfkVr1FT2ijjK11d95EC
        VfYfb6sBnPkh+8LdGLzlAuY=
X-Google-Smtp-Source: APXvYqwNycUdK+Z3JjK94o6igrgT3OAssaL84DBuSI3TwCZhtiJC9QPgSpnSDRlkxK/Ov/efHtWGPw==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr673097pjp.72.1581646613285;
        Thu, 13 Feb 2020 18:16:53 -0800 (PST)
Received: from [172.16.1.120] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id h26sm4890855pfr.9.2020.02.13.18.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 18:16:52 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 0/3] PCI: brcmstb: Add Broadcom STB support
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CA+-6iNyjXnz4tYk4edupbhsjvyh==MA0bJ+311k_wBcDHQHJ9g@mail.gmail.com>
Date:   Fri, 14 Feb 2020 11:16:47 +0900
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC33C637-FBEB-49EE-9C0C-E119E1839F37@gmail.com>
References: <20200213025930.27943-1-jaedon.shin@gmail.com>
 <6ba4bb21-034b-93f0-d4b7-13ac7c5a925d@gmail.com>
 <44052F86-D0DD-4FDD-A62B-09280E956405@gmail.com>
 <CA+-6iNyjXnz4tYk4edupbhsjvyh==MA0bJ+311k_wBcDHQHJ9g@mail.gmail.com>
To:     Jim Quinlan <james.quinlan@Broadcom.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> 2020. 2. 14. =EC=98=A4=EC=A0=84 12:54, Jim Quinlan =
<james.quinlan@Broadcom.com> =EC=9E=91=EC=84=B1:
>=20
> On Thu, Feb 13, 2020 at 12:15 AM Jaedon Shin <jaedon.shin@gmail.com> =
wrote:
>>=20
>>=20
>>> 2020. 2. 13. =EC=98=A4=ED=9B=84 12:54, Florian Fainelli =
<f.fainelli@gmail.com> =EC=9E=91=EC=84=B1:
>>>=20
>>> +Jim,
>>>=20
>>> On 2/12/2020 6:59 PM, Jaedon Shin wrote:
>>>> This series enables the ARM based Broadcom STB SoCs and supports =
GPIO
>>>> based regulators for its power supplies. and this has an =
improvement on
>>>> devm_ APIS.
>>>=20
>>> Which ARM-based SoCs did you try this on? We still have an issue =
with
>>> the multiple dma-ranges that must be handled to support 7445 with =
memory
>>> in the extension regions as well as 7278 and 7216.
>>=20
>>=20
>> I'm using BCM72604 which has only one memc. and device is Qualcomm =
Atheros
>> QCA6174 Wi-Fi module.
>>=20
> You apparently have a simple enough memory configuration such that the
> current upstream driver will work.  But this will not work for a
> 7445-based chip or other BCM7xxx chips that either have a memory
> region extension or a non-zero system memory offset.

I fully agree. It's not yet ready to enable ARM based BCM7445 SoCs. We'd =
better
not add ARCH_BRCMSTB and "brcm,bcm7445-pcie" string until the multi dma-
range problem is solved.

>=20
> IIRC, similar regulator code was submitted before as part of the
> complete driver that could handle our curious DMA situation, but was
> rejected because someone objected to us using a  generic list of
> regulators without specific explanation for each in the device tree
> documentations.  I hope you have better luck :-)

I'll refer to.

Thanks,
Jaedon

>=20
> Thanks,
> Jim
>>>=20
>>> See comments in specific patches.
>>>=20
>>>>=20
>>>> Jaedon Shin (3):
>>>> PCI: brcmstb: Enable ARCH_BRCMSTB
>>>> PCI: brcmstb: Add regulator support
>>>> PCI: brcmstb: Drop clk_put when probe fails and remove
>>>>=20
>>>> .../bindings/pci/brcm,stb-pcie.yaml           |  8 +-
>>>> drivers/gpio/gpio-brcmstb.c                   | 13 +++-
>>>> drivers/pci/controller/Kconfig                |  2 +-
>>>> drivers/pci/controller/pcie-brcmstb.c         | 78 =
++++++++++++++++++-
>>>> 4 files changed, 97 insertions(+), 4 deletions(-)
>>>>=20
>>>=20
>>> --
>>> Florian

