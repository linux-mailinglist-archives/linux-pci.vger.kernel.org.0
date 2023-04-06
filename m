Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C96DA05A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDFSx0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDFSxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:53:25 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A59D86A5;
        Thu,  6 Apr 2023 11:53:24 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a5so38978609qto.6;
        Thu, 06 Apr 2023 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680807203; x=1683399203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fkm1WIFQjf0PCje4i/w8NoBsWJO6GDFcmZxAmQoOl44=;
        b=Hk/h42787AxVBPwrLukrVXWSP1EEwYZ86x+YO7gowFQsitDPKp4OEua9Zuw8kAd6yD
         afvTz75pYSlKCpKUWGjbSbU2i+x1Adq/w8CT3r2sz1Om3L3i6/3ie8rB6AjJgizhnhPU
         HP+tQp9otXm5oXhhrrR7xy+NvquFJ99RNOB9nOQTbwRMm2pE2ckrbkO3KKiKmF03V5hj
         bnifesflc1ds0hnR8rHGoRhsd8cgrwcGIuE6qJAiJ8ddt+KrPZlOPjrNEpSb7E784PMI
         e6Fu43GE0QVTOAwq/Yuks2S+Un57LPeEb28vEtp9u15Wa+V7GVUSO9TwoFkeBjExVbQI
         hV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807203; x=1683399203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkm1WIFQjf0PCje4i/w8NoBsWJO6GDFcmZxAmQoOl44=;
        b=gsfjtdmjn6mAbbc5pKnmIF5hzb56yetM0Iz9eozKlDjVOm8fD3E6b6fZ0sp78HnUY6
         daMjnrdVprt+HlYC2RY3NyVqpjdPzpn3B6EmOFuLMwgNvv3yA49G5Egsy9Dfxb6BrFmr
         r+hi2TP4/GozPc7K57SodvzqYrY0PgOrnoVYLNVRZv+vZErFo96ZJGqxKuPuhTLPKkRZ
         momuL4tE4cHwJsSs3R5+Qmnv0Rd9YUA3BLCHjSQjvh3/JgJtm0/jgNotuN2WtT9r73f+
         Ip+FcAq9HtBW/tJ5htuR6fwk3Se4WviLniBRgT7lgDsFM2Se7tYzHbpM9fHqtKwt0wRi
         eK9g==
X-Gm-Message-State: AAQBX9cClAyA5sZDviUPPh9zjsXhhe9j8K6MK0ZkjU3sVn17zxcwS0Ad
        FZJQ0YnLfVnDKNMEXkpNDCg=
X-Google-Smtp-Source: AKy350Ygh+Zln0AyES3s+WW8OVnCmQVo50LSQ2mA1GXiXZIQpWrUZIfgBe1uOlV3Zzi7dprgaHTmyA==
X-Received: by 2002:a05:622a:202:b0:3e3:8bbc:d152 with SMTP id b2-20020a05622a020200b003e38bbcd152mr11802926qtx.66.1680807203095;
        Thu, 06 Apr 2023 11:53:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w24-20020ac86b18000000b003e64490a35bsm609139qts.21.2023.04.06.11.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:53:22 -0700 (PDT)
Message-ID: <9e98496b-73a0-78a5-e890-7d7e4be1f469@gmail.com>
Date:   Thu, 6 Apr 2023 11:53:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230406124625.41325-1-jim2101024@gmail.com>
 <20230406124625.41325-2-jim2101024@gmail.com>
 <ebde318b-53be-6779-4f0c-a614c01a0b0a@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ebde318b-53be-6779-4f0c-a614c01a0b0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/6/23 11:34, Krzysztof Kozlowski wrote:
> On 06/04/2023 14:46, Jim Quinlan wrote:
>> Regarding "brcm,enable-l1ss":
>>
>>    The Broadcom STB/CM PCIe HW -- which is also used by RPi SOCs -- requires
>>    the driver probe to configure one of three clkreq# modes:
>>
>>    (a) clkreq# driven by the RC
>>    (b) clkreq# driven by the EP for ASPM L0s, L1
>>    (c) bidirectional clkreq#, as used for L1 Substates (L1SS).
>>
>>    The HW can tell the difference between (a) and (b), but does not know
>>    when to configure (c).  Further, the HW will cause a CPU abort on boot if
>>    guesses wrong regarding the need for (c).  So we introduce the boolean
>>    "brcm,enable-l1ss" property to indicate that (c) is desired.  This
>>    property is already present in the Raspian version of Linux, but the
>>    driver implementaion that will follow adds more details and discerns
>>    between (a) and (b).
>>
>> Regarding "brcm,completion-timeout-msecs"
>>
>>    Our HW will cause a CPU abort if the L1SS exit time is longer than the
>>    completion abort timeout.  We've been asked to make this configurable, so
>>    we are introducing "brcm,completion-abort-msecs".
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>> index 7e15aae7d69e..ef4ccc05b258 100644
>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>> @@ -64,6 +64,18 @@ properties:
>>   
>>     aspm-no-l0s: true
>>   
>> +  brcm,enable-l1ss:
>> +    description: Indicates that the downstream device is L1SS
>> +      capable and L1SS is desired, e.g. by setting
>> +      CONFIG_PCIEASPM_POWER_SUPERSAVE=y.  Note that CLKREQ#
> 
> How does CONFIG_PCIEASPM_POWER_SUPERSAVE apply to *BSD?

In other words, there should be no OS/Linux specific comments in a 
Device Tree binding, which would be a friendlier and nicer way of 
providing the same feedback.
-- 
Florian

