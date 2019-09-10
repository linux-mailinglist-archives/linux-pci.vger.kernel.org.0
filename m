Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4BAE66C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2019 11:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfIJJO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Sep 2019 05:14:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36923 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJJOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Sep 2019 05:14:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so17984959wro.4
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2019 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KggzyQTt9YMyc2e0zeHCKuseEmxSFUreE/D03f8R1R0=;
        b=NDqL1gX8Ar9j3idQWlhCBLfl2ifiSbwLFgp/lPjUdkMLZVaLI+dxj+pmLWgfzN+VNn
         q5QilFx3dcH6M/qg8NNqF0Sf4nE5RoUTtj3Yi+/Qm1f6AqAsfVFBrJBqfqN0pasZ+Lqd
         DIOoV/SfplYO7hM12+n9yvnxfQ3tvM9yBmjbhuvptlv7rS8H7KpOwjjyZUVLLImTVVUL
         6vinHeRzaIAEIiaehPyRQzC2AGpeLXJ5mvCNe+j+SPubgah+fsciZ/J5sdoSFx9jjJ6k
         /TA6n+N+JiA/AZ6SECzRb4h+31h/Jq102kN+lmlW+MWyBGfepGzi9p68ppzwvuyptPtM
         zmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KggzyQTt9YMyc2e0zeHCKuseEmxSFUreE/D03f8R1R0=;
        b=hE9MNs7HMzNgZOq/s860QTzyluiPk/uMMh6/kUoeWWxpfviaVdg5u80QcCnCPao/S8
         xsmZp+Bw/OtmaX4qnl/kK6Y1jtvV6m/CraXbiHcWAU8gY6V0Ok3LEErIX4t5r0favhJN
         OeXy83HetmMehqWqHmBkyjukmAx9RA3k/FTFHv37fw0DLjnw2ZKycZv9TocIr9JlOjVb
         677VrD6B3F+d2xk9wDwv3KN7yGOtAqajimRX98GV863SivarXSjqqyQFALUc8FP2iobw
         sG42De72TgxAbyDlQ723tYKcNNeEhtywfJdbMtdUe6RVytshYuK7etUrjgItWEqD8mQN
         bAZQ==
X-Gm-Message-State: APjAAAV6QhszvVWjrZMVvuau1iMYFxoK0bT2UJIlDSizwqJpRLUT8XA4
        flp9QHT/n517U04wzbtcTqI4Ww==
X-Google-Smtp-Source: APXvYqxjKHgmYxziqpFCqlhzhz7yM8EGCE/yXsYx9BaDfdVvKV6ats+0t7Sgfw0b984HcDIj7YcQPQ==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr19319081wrr.354.1568106861769;
        Tue, 10 Sep 2019 02:14:21 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f143sm2485376wme.40.2019.09.10.02.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 02:14:21 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64: dts: khadas-vim3: add commented support for
 PCIe
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        repk@triplefau.lt, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
 <1567950178-4466-7-git-send-email-narmstrong@baylibre.com>
 <864l1ls9wy.wl-maz@kernel.org>
 <2c25e8b5-191f-96c9-8989-23959a7b1c4e@baylibre.com>
 <8636h4seeq.wl-marc.zyngier@arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <837e8ced-de84-1645-b5ba-6db1eacbc50d@baylibre.com>
Date:   Tue, 10 Sep 2019 11:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8636h4seeq.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/09/2019 11:12, Marc Zyngier wrote:
> On Mon, 09 Sep 2019 18:50:42 +0100,
> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Marc,
>>
>> Le 09/09/2019 à 18:37, Marc Zyngier a écrit :
>>> On Sun, 08 Sep 2019 14:42:58 +0100,
>>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>>>> lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
>>>> an USB3.0 Type A connector and a M.2 Key M slot.
>>>> The PHY driving these differential lines is shared between
>>>> the USB3.0 controller and the PCIe Controller, thus only
>>>> a single controller can use it.
>>>>
>>>> The needed DT configuration when the MCU is configured to mux
>>>> the PCIe/USB3.0 differential lines to the M.2 Key M slot is
>>>> added commented and may uncommented to disable USB3.0 from the
>>>> USB Complex and enable the PCIe controller.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>  .../amlogic/meson-g12b-a311d-khadas-vim3.dts  | 22 +++++++++++++++++++
>>>>  .../amlogic/meson-g12b-s922x-khadas-vim3.dts  | 22 +++++++++++++++++++
>>>>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  4 ++++
>>>>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 22 +++++++++++++++++++
>>>>  4 files changed, 70 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>>>> index 3a6a1e0c1e32..0577b1435cbb 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>>>> @@ -14,3 +14,25 @@
>>>>  / {
>>>>  	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
>>>>  };
>>>> +
>>>> +/*
>>>> + * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>>>> + * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
>>>> + * an USB3.0 Type A connector and a M.2 Key M slot.
>>>> + * The PHY driving these differential lines is shared between
>>>> + * the USB3.0 controller and the PCIe Controller, thus only
>>>> + * a single controller can use it.
>>>> + * If the MCU is configured to mux the PCIe/USB3.0 differential lines
>>>> + * to the M.2 Key M slot, uncomment the following block to disable
>>>> + * USB3.0 from the USB Complex and enable the PCIe controller.
>>>> + */
>>>> +/*
>>>> +&pcie {
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&usb {
>>>> +	phys = <&usb2_phy0>, <&usb2_phy1>;
>>>> +	phy-names = "usb2-phy0", "usb2-phy1";
>>>> +};
>>>> + */
>>>
>>> Although you can't do much more than this here, I'd expect firmware on
>>> the machine to provide the DT that matches its configuration. Is it
>>> the way it actually works? Or is the user actually expected to edit
>>> this file?
>>
>> It's the plan when initial VIM3 support will be merged in u-boot mainline,
>> and the MCU driver will be added aswell :
>> https://patchwork.ozlabs.org/cover/1156618/
>> A custom board support altering the DT will be added when this patchset
>> is merged upstream.
>>
>> But since these are separate projects, leaving this as commented is ugly,
>> but necessary.
> 
> I agree with the unfortunate necessity. However, could you please have
> a comment here, indicating that the user isn't expected to change this
> on their own, but instead rely on the firmware/bootloader to do it
> accordingly?

Yes, sure.

Neil

> 
> Thanks,
> 
> 	M.
> 

