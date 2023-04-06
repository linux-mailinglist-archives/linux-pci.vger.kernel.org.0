Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5B06DA04B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbjDFSsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbjDFSsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:48:20 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B54AD03;
        Thu,  6 Apr 2023 11:47:51 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id cu4so29002095qvb.3;
        Thu, 06 Apr 2023 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680806870; x=1683398870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzKwAbN5+E7CdKR7TeCdri2bLH9JWYK1Wg14/QsRyOU=;
        b=Hu1o3yY73YWrEILVt29Ij5/gv943m7nzE/zeaeMEl4cVnfP/+SSluhxXtIB/iGNjaW
         BVvMzavjF6fWm2fCdnwyVI/EihTJzZiglc525s/2PugDhWHJ1w1kfQTCdijR1bZSP/uV
         SKst96o/zMPG7+oUUot7riRauKKxdA/mtc8k5QQ3CtJQjXoHfZkQKrW0EbFSD1WN268q
         rdwsk44kEk8VtKFIFAaaDaxLKZLZrfyPaUXB6yJpB3DMI/TBdIDYGW9erd2N69ULqcTq
         gcVjjg/hXBKHi6YAwQEB3dQpFla/UgRf93Y7WBNJcugPDnne9Uw3Eev7fi5ePrmF8GET
         n+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806870; x=1683398870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzKwAbN5+E7CdKR7TeCdri2bLH9JWYK1Wg14/QsRyOU=;
        b=1d4MBC/7JFePEJsPAJL/HwZXhLKHjvdiaM9eElOSdIlz4ZMntGFT4etmFwkJlfhKJp
         N7uidr4OhG63o6UaJyTuWSujygeZT9iFgZorWkl770jMdKeEatm355WeZ3bbFMPrL4HS
         LKpUw6DYW82oRvlu/vqZBII/hkPyagsLS1WXuPBerpMFE6AB4MLVcZ0DwQz+zBzBAP8p
         bLJtXYNlHM/GeleajKwxGxSZ8KgyF0wc+UI0r1wyPcABpURLhfxJ4KcX8+3wXyIsd4mN
         UXrovnTxqjk+7MXqitwo5GrE7zcBbmBflJjPAHtcTKwyLf8V6PHvvWaG2Ng+stawqK13
         VLWw==
X-Gm-Message-State: AAQBX9fRhBkgScYAiOMTekT5hWhBJx9QmTD0q7/I+T7fNnN2Q24W/1Em
        OzILS77eOIe0pTRVWjs2ZFGNFV9dqSmbhA==
X-Google-Smtp-Source: AKy350acVMbAa/+pms/tgePINZD6ek4RJZHE17lJlBwcVveDuzUIg8xDERJUYbR27PODDYSUi6RoGA==
X-Received: by 2002:a05:6214:5083:b0:5e0:8f8f:dd7c with SMTP id kk3-20020a056214508300b005e08f8fdd7cmr421404qvb.4.1680806870431;
        Thu, 06 Apr 2023 11:47:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 79-20020a370452000000b007468cc74c77sm686981qke.4.2023.04.06.11.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:47:49 -0700 (PDT)
Message-ID: <5c6d0259-0fe2-4faa-5ecf-8621467533a1@gmail.com>
Date:   Thu, 6 Apr 2023 11:47:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
 <d0bf241b-ead4-94b7-3f03-a26227f9eb58@i2se.com>
 <CANCKTBsLxkPb1ajACkyhJk6J1aB2iwX0oKifHkADG0fFPUqMhQ@mail.gmail.com>
 <ab1b0161-20c2-83eb-e371-e8363547e758@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ab1b0161-20c2-83eb-e371-e8363547e758@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/6/23 11:35, Krzysztof Kozlowski wrote:
> On 06/04/2023 18:58, Jim Quinlan wrote:
>> On Thu, Apr 6, 2023 at 11:39 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>>
>>> Hi Jim,
>>>
>>> Am 06.04.23 um 14:46 schrieb Jim Quinlan:
>>>> Regarding "brcm,enable-l1ss":
>>>>
>>>>     The Broadcom STB/CM PCIe HW -- which is also used by RPi SOCs -- requires
>>>>     the driver probe to configure one of three clkreq# modes:
>>>>
>>>>     (a) clkreq# driven by the RC
>>>>     (b) clkreq# driven by the EP for ASPM L0s, L1
>>>>     (c) bidirectional clkreq#, as used for L1 Substates (L1SS).
>>>>
>>>>     The HW can tell the difference between (a) and (b), but does not know
>>>>     when to configure (c).  Further, the HW will cause a CPU abort on boot if
>>>>     guesses wrong regarding the need for (c).  So we introduce the boolean
>>>>     "brcm,enable-l1ss" property to indicate that (c) is desired.  This
>>>>     property is already present in the Raspian version of Linux, but the
>>>>     driver implementaion that will follow adds more details and discerns
>>>>     between (a) and (b).
>>>>
>>>> Regarding "brcm,completion-timeout-msecs"
>>>>
>>>>     Our HW will cause a CPU abort if the L1SS exit time is longer than the
>>>>     completion abort timeout.  We've been asked to make this configurable, so
>>>>     we are introducing "brcm,completion-abort-msecs".
>>>>
>>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>>> ---
>>>>    .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>> index 7e15aae7d69e..ef4ccc05b258 100644
>>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>> @@ -64,6 +64,18 @@ properties:
>>>>
>>>>      aspm-no-l0s: true
>>>>
>>>> +  brcm,enable-l1ss:
>>>> +    description: Indicates that the downstream device is L1SS
>>>> +      capable and L1SS is desired, e.g. by setting
>>>> +      CONFIG_PCIEASPM_POWER_SUPERSAVE=y.  Note that CLKREQ#
>>>
>>> not sure about this, but maybe we should avoid references to Linux
>>> kernel config parameter in a DT binding. Since the driver already gaves
>>> warning in case the DT parameter is present, but kernel config doesn't
>>> fit, this should be enough.
>>
>> Hello Stefan,
>> I will remove this reference.
>>>
>>>> +      assertion to clock active must be within 400ns.
>>>> +    type: boolean
>>>> +
>>>> +  brcm,completion-timeout-msecs:
>>>> +    description: Number of msecs before completion timeout
>>>> +      abort occurs.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>
>>> According to the driver at least 0 is not allowed, maybe we should
>>> define minimum and maximum here and let dtbs_check take care of invalid
>>> values?
>> I'm not sure I follow what you mean about a zero value;  the property
>> may have any value but the driver will clamp it
>> to a minimum of ~30msec.  Regardless, I can add a  "minimum: 30" line
>> to the YAML.
> 
> If "completion" means Linux completion, then it is not suitable for DT
> and entire property should be removed. If it is something else, then
> explain here and commit msg. So far both refer to some completion...

This is a PCIe root complex binding so completion needs to be understood 
in the context of PCIe, that is the time needed for the root complex to 
complete/finish/proceed with a PCIe transaction layer packet (TLP).
-- 
Florian

