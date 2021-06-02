Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F033B39886D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFBLe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 07:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFBLez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 07:34:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB98EC061574;
        Wed,  2 Jun 2021 04:33:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so1139822wmc.0;
        Wed, 02 Jun 2021 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YpPo5MBLVYvDn/sYz6mEnGVnyd3ShtD58F9/Awc2BpA=;
        b=kVW6e8YiNo8g5jZzT0Bts2a0UncmcVWmaRW0M7i4O2D8xy+KvvmKD3sAyTGlgTG7kt
         zw+1i5ixEjtOgD6RVEZzoDp2k/njyKH8jrPuyLIhznfIc7VHdbm7b2UtgWB1YssswsbU
         ZuIG6NmLFgWN39RK9Ar7QVDrYpjbPUUYabz1oDvms+e9b8+DlXxRFI9wmNh2YngkXUdJ
         lKbjZZb5/P4fv7UmikpEZgwofHnuLV55T8byBfhsgH8pQXC9ZYV2Vb3cRkrUOE4AYVqL
         gLrtgaMlJQ6Zn10S60flrArFRJTPtIyhRQzDHlklc3hkveSxrwR+7R5zPjil+GV7TUdC
         fYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YpPo5MBLVYvDn/sYz6mEnGVnyd3ShtD58F9/Awc2BpA=;
        b=EQ5srSw1kWPtWDYSGwTu1zlNTwXyL1Fr2qTfirTvLMJeMMy2US4RaifgXpCHnPQlug
         IPhHqDg+gPeSAmzOj66t3qaJ8CNz1LbKlUsZLPwZXROmk7ybKd8F21dsXqDE0PsUEy1w
         cN7CFcmJZDeGz4yJ4c74QP4oxB1nPtq64fkekOUdRwtmy+gdfROXA6nRsrvVmiK2xVHv
         pBpWGPrVopASJvhC1Ft9BJ5IqTa3fGcilH6uBO+pUy1fHmR/ggXC8qzcysyZve9YKdLu
         KVX47oH3PD3cwDHrnPRc6Eq8q+N4ryvInqq91g7BW+BtKksyP4TO3FiXUbWHsHzC904B
         ITvw==
X-Gm-Message-State: AOAM5330sIpbDAkFCIt5WW6nB4X71cHVLyfw57jEWm5NZnbKm6fSXC49
        ALxDdf88YJ65+xvMNOwHK4I=
X-Google-Smtp-Source: ABdhPJwCYFHyPJ4mtPKQH6YK0yXLSoUWALZ/L3nQxpyEn8N3GhSJpqhz2Lz5eakMQ6A+sxu6jdDVOg==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr31535267wmb.118.1622633590311;
        Wed, 02 Jun 2021 04:33:10 -0700 (PDT)
Received: from ziggy.stardust ([46.6.149.244])
        by smtp.gmail.com with ESMTPSA id r7sm3057110wma.9.2021.06.02.04.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 04:33:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8195
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Randy Wu <Randy.Wu@mediatek.com>, youlin.pei@mediatek.com
References: <20210601024408.24485-1-jianjun.wang@mediatek.com>
 <20210601024408.24485-2-jianjun.wang@mediatek.com>
 <CAGXv+5G-8+ppafiUnqWm2UeiL+edHJ2zYZvU-S7mz_NdrM3YsA@mail.gmail.com>
 <1622526594.9054.6.camel@mhfsdcap03>
 <CAGXv+5GMTbC5TTgURhPAvxBEY18S6-T-BZ9CpXsO91Trim7TXw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <db62910b-febd-6cba-8a72-2bf718f7b110@gmail.com>
Date:   Wed, 2 Jun 2021 13:33:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAGXv+5GMTbC5TTgURhPAvxBEY18S6-T-BZ9CpXsO91Trim7TXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 01/06/2021 08:07, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Jun 1, 2021 at 1:50 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>>
>> On Tue, 2021-06-01 at 11:53 +0800, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> On Tue, Jun 1, 2021 at 10:50 AM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>>>>
>>>> MT8195 is an ARM platform SoC which has the same PCIe IP with MT8192.
>>>
>>> Based on what I'm seeing internally, there seems to be some inconsistency
>>> across the MediaTek platform on whether new compatible strings should be
>>> introduced for "fully compatible" IP blocks.
>>>
>>> If this hardware block in MT8195 is "the same" as the one in MT8192, do we
>>> really need the new compatible string? Are there any concerns?
>>
>> Hi Chen-Yu,
>>
>> It's ok to reuse the compatible string with MT8192, but I think this
>> will be easier to find which platforms this driver is compatible with,
>> especially when we have more and more platforms in the future.
> 
> If it's just for informational purposes, then having the MT8192 compatible
> as a fallback would work, and we wouldn't need to make changes to the driver.
> This works better especially if we have to support multiple operating systems
> that use device tree.
> 
> So we would want
> 
>     "mediatek,mt8195-pcie", "mediatek,mt8192-pcie"
> 
> and
> 
>     "mediatek,mt8192-pcie"
> 
> be the valid options.
> 
> Personally I'm not seeing enough value to justify adding the compatible string
> just for informational purposes though. One could easily discern which hardware
> is used by looking at the device tree.
> 

I agree, if no differences between the two chips are known, adding a binding
withe new compatible and a fallback is a good thing. If we later on realize that
mt8195 PCI block has differences, we can add the matching to the driver.

Regards,
Matthias

> 
> Regards
> ChenYu
> 
> 
>> Thanks.
>>>
>>>
>>> Thanks
>>> ChenYu
>>>
>>>
>>>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
>>>> index e7b1f9892da4..d5e4a3e63d97 100644
>>>> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
>>>> @@ -48,7 +48,9 @@ allOf:
>>>>
>>>>  properties:
>>>>    compatible:
>>>> -    const: mediatek,mt8192-pcie
>>>> +    oneOf:
>>>> +      - const: mediatek,mt8192-pcie
>>>> +      - const: mediatek,mt8195-pcie
>>>>
>>>>    reg:
>>>>      maxItems: 1
>>>> --
>>>> 2.18.0
>>>> _______________________________________________
>>>> Linux-mediatek mailing list
>>>> Linux-mediatek@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
>>
