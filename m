Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7D6DA05D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbjDFSxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbjDFSxu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:53:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE4F8688
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 11:53:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id by26so3700603ejb.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Apr 2023 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680807228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r086pEvAwnkI+t+FrbVlMKVk0z/S6f7zvSW+2dtrwjk=;
        b=CkFwoMdvVZqf1/VDlfvYyP7FST6Dy/l5+WHIRC4ybBECyATtAgRJyFd2IuegQtD5n7
         53KTTRc7l4ed/hdK8v77cJY3rwW+cBr9kHD7EME5p0UqxX3aw747/Q5L4VjLGMUtBoSX
         tGRnhvt5h3GtpVjh+t53YXZnmIXF+XFCsItoF3swoTouTcc2rqORGGUrPb+sfXqBOSrV
         q5ntg8v7CatGIMS9w5mVcBVXmiNUhc45fisNfBLavEXzRYZRJYQLSKdNtRRnifht6lR+
         ngdMaBklQCijCdLZepNl8nlrKMUI6MJEucMnCN9WWi5xp+vYU3QXcm2tvT6wRV15GkEL
         TF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r086pEvAwnkI+t+FrbVlMKVk0z/S6f7zvSW+2dtrwjk=;
        b=QK8XD3s/tI7zEEka7Dhlm/DjwGwlogbKhhv6p6zOgkK8TJfIw0Br9XKAVCH0kBdyg7
         H7Lcnk91kOP879/WgF6iI3SsKladLD8UrnzSOnR1pC1qKECQwADKHWX1Z96AqSe3g2n3
         f26uCKs7Vf1hidbvbyWDZzKtIzDAmXsAxvH9pkz6qcifWxlRTGo7w+Kzd9Gilz/tdFdQ
         ftZBn/L1raTNZkDgkq06HUketc7AazDiPt1M4+OvoJeRmSmgizbdw1PvNJLcMZTbY86G
         rVXgQDm7YcSfJ8RM5EqAXUkbTB/HmXUm6VzirLZNPnu+V0fn9zniZXj2tc8DiSGZr7j0
         UuMA==
X-Gm-Message-State: AAQBX9cX/KIasu2JMGACvXo1VRoCaa2FNYTZW+BeG0eYW94mA2LaEKCG
        WSmjOXOulm1Uw/GctMFc6L+K8A==
X-Google-Smtp-Source: AKy350YUb7fLNNac3a4lGLU5X3AMFtj1+tmZriv1BqVg6ictVe76XvECQJL7Ts5JSvVOWs7gJpvVPg==
X-Received: by 2002:a17:907:8b0a:b0:949:ab5c:f10c with SMTP id sz10-20020a1709078b0a00b00949ab5cf10cmr3796432ejc.63.1680807228014;
        Thu, 06 Apr 2023 11:53:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id hs19-20020a1709073e9300b00949cb8d6904sm1011575ejc.201.2023.04.06.11.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:53:47 -0700 (PDT)
Message-ID: <d7b965cf-dc83-47dd-5e84-2796229fdfb9@linaro.org>
Date:   Thu, 6 Apr 2023 20:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
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
 <5c6d0259-0fe2-4faa-5ecf-8621467533a1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5c6d0259-0fe2-4faa-5ecf-8621467533a1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/04/2023 20:47, Florian Fainelli wrote:
>>>>> +
>>>>> +  brcm,completion-timeout-msecs:
>>>>> +    description: Number of msecs before completion timeout
>>>>> +      abort occurs.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>
>>>> According to the driver at least 0 is not allowed, maybe we should
>>>> define minimum and maximum here and let dtbs_check take care of invalid
>>>> values?
>>> I'm not sure I follow what you mean about a zero value;  the property
>>> may have any value but the driver will clamp it
>>> to a minimum of ~30msec.  Regardless, I can add a  "minimum: 30" line
>>> to the YAML.
>>
>> If "completion" means Linux completion, then it is not suitable for DT
>> and entire property should be removed. If it is something else, then
>> explain here and commit msg. So far both refer to some completion...
> 
> This is a PCIe root complex binding so completion needs to be understood 
> in the context of PCIe, that is the time needed for the root complex to 
> complete/finish/proceed with a PCIe transaction layer packet (TLP).

OK, so I assume keyword "completion" is well known term in PCI (although
for some reason no other bindings mention it).

Best regards,
Krzysztof

