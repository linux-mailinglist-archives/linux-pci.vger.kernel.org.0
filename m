Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C846D9FEF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbjDFSfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbjDFSfk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:35:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669BA59DA
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 11:35:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lj25so3597267ejb.11
        for <linux-pci@vger.kernel.org>; Thu, 06 Apr 2023 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680806137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRBfuBs8WR3evGR0Ox5esepb+ZZtacne/dKbCY/+uw0=;
        b=oUIbr+v90hVa39JXi3mXIgC1TeH9PSzaS7EZXT/F1GC6mYdTj06JgmgH66imoWFs9b
         d18y6Nz0GlpXkPinB/vaWWr75BD3Dbw+T6NBC1rfd7P7xecONruW6oPoBuPn1GPkNMBN
         FMYLMF6ApOxOJc1U7MEOJxd+dJuENgTGxY6GIKZxqNiYE+bazeQ4vIPmDf2lCu27q5D+
         Eghn3E3eKZfjMP7MhlQxjieTSCw729zE88FJLmof2bJflrIv114mm53l5VSXpZ+7lw/V
         l9tZ+UJQjQa9MPpBGjmm9IJkYtaGxxsdC9RWnpptOikl22clNtqPsHC+lMWP1M10tumL
         hiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRBfuBs8WR3evGR0Ox5esepb+ZZtacne/dKbCY/+uw0=;
        b=t61BbZbw5+6+gVFu1xnHyOKBeYL/Mnjnv+vXO2q4FCR21MSefwhRxYG8PYpfda7tq8
         T7OFiSVPJn4GZmOPemC2CfUsF9oY8Tw1wvJkrwX18GRUr/lneup2N1d93cAtGXkgcbU2
         tboNJSWIfCgbZrxisPEEQIZdMxghiTfpi9gDCo+tM9nQv8ntgMiIWeAEPjeLbOLz//z1
         L+qC7vbmmod+cle1YZ5GSUBs/csYCfwT7or2gGeFZrKkCIMk/GlhS4RnTF9QjE1fnb8z
         AeYYRsOtxkGW1xrH47lddT+82tdux4zTppQY++vWVp2l9oMZ/+wQbZv/bOQ4ctollLtL
         hyfA==
X-Gm-Message-State: AAQBX9ehNu1qcAYFuB/h+tGuQQiiY7npmQZU7tbpw65fUYQmy8YuMoMd
        7yCfSa3KJ6+O9Zk4sY/kP4Kp76uV7QsFCV/Ctaw=
X-Google-Smtp-Source: AKy350ZoCWdFCix4jBb7WjrNvH8yt8NUCimMUaMZqKAsERSMCHUu4hVoNIR0fwoKVcHwJ5dXCjsRlg==
X-Received: by 2002:a17:906:bfc9:b0:93d:b767:9fea with SMTP id us9-20020a170906bfc900b0093db7679feamr7614503ejb.31.1680806136900;
        Thu, 06 Apr 2023 11:35:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906319600b00930525d89e2sm1127806ejy.89.2023.04.06.11.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:35:36 -0700 (PDT)
Message-ID: <ab1b0161-20c2-83eb-e371-e8363547e758@linaro.org>
Date:   Thu, 6 Apr 2023 20:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANCKTBsLxkPb1ajACkyhJk6J1aB2iwX0oKifHkADG0fFPUqMhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/04/2023 18:58, Jim Quinlan wrote:
> On Thu, Apr 6, 2023 at 11:39 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>
>> Hi Jim,
>>
>> Am 06.04.23 um 14:46 schrieb Jim Quinlan:
>>> Regarding "brcm,enable-l1ss":
>>>
>>>    The Broadcom STB/CM PCIe HW -- which is also used by RPi SOCs -- requires
>>>    the driver probe to configure one of three clkreq# modes:
>>>
>>>    (a) clkreq# driven by the RC
>>>    (b) clkreq# driven by the EP for ASPM L0s, L1
>>>    (c) bidirectional clkreq#, as used for L1 Substates (L1SS).
>>>
>>>    The HW can tell the difference between (a) and (b), but does not know
>>>    when to configure (c).  Further, the HW will cause a CPU abort on boot if
>>>    guesses wrong regarding the need for (c).  So we introduce the boolean
>>>    "brcm,enable-l1ss" property to indicate that (c) is desired.  This
>>>    property is already present in the Raspian version of Linux, but the
>>>    driver implementaion that will follow adds more details and discerns
>>>    between (a) and (b).
>>>
>>> Regarding "brcm,completion-timeout-msecs"
>>>
>>>    Our HW will cause a CPU abort if the L1SS exit time is longer than the
>>>    completion abort timeout.  We've been asked to make this configurable, so
>>>    we are introducing "brcm,completion-abort-msecs".
>>>
>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>> ---
>>>   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> index 7e15aae7d69e..ef4ccc05b258 100644
>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> @@ -64,6 +64,18 @@ properties:
>>>
>>>     aspm-no-l0s: true
>>>
>>> +  brcm,enable-l1ss:
>>> +    description: Indicates that the downstream device is L1SS
>>> +      capable and L1SS is desired, e.g. by setting
>>> +      CONFIG_PCIEASPM_POWER_SUPERSAVE=y.  Note that CLKREQ#
>>
>> not sure about this, but maybe we should avoid references to Linux
>> kernel config parameter in a DT binding. Since the driver already gaves
>> warning in case the DT parameter is present, but kernel config doesn't
>> fit, this should be enough.
> 
> Hello Stefan,
> I will remove this reference.
>>
>>> +      assertion to clock active must be within 400ns.
>>> +    type: boolean
>>> +
>>> +  brcm,completion-timeout-msecs:
>>> +    description: Number of msecs before completion timeout
>>> +      abort occurs.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> According to the driver at least 0 is not allowed, maybe we should
>> define minimum and maximum here and let dtbs_check take care of invalid
>> values?
> I'm not sure I follow what you mean about a zero value;  the property
> may have any value but the driver will clamp it
> to a minimum of ~30msec.  Regardless, I can add a  "minimum: 30" line
> to the YAML.

If "completion" means Linux completion, then it is not suitable for DT
and entire property should be removed. If it is something else, then
explain here and commit msg. So far both refer to some completion...

Best regards,
Krzysztof

