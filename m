Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294376DA056
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDFSw3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbjDFSw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:52:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8D192
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 11:52:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso2253479a12.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Apr 2023 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680807141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrhLW1wbWunykZQuk7rWh+aLPzkfPdyrzg855Rv1CC0=;
        b=OaKgd8Q3eIvAk3dfIAinRvzLlH3Y8HQCxJ2bDVYbCFX7+lVVoFg419mM/7U4yEoPhV
         ZqrjC4RhHtwo8d9Gu2d/2noJeUE/4dpDoWCHozpas2GyzxtLPfVYyVDPqZqXBPLRBDvN
         xCISl03ZkgYVy/gDl0tEyXS1EGq+7e9GCofDB43ARMRYwxQvX2qH+uvKtyr00ZbWr2Ln
         Qet7xdSannl+UqtG2pVXEJf/bT2B6yQznjP1rFBsO+NVc3LfTwFp1KEosh3jGGmG56TV
         U9Bh8WtP0ecw9+fan2B700lmQRQkCmP5ib4j+nIvlz27qEpuxiy+aPc5oBkTtwmD5viK
         kK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrhLW1wbWunykZQuk7rWh+aLPzkfPdyrzg855Rv1CC0=;
        b=BOP4dfHIyTiLsSSqk/S4L3haJuh0gEQdjlpOgaAc36mgtkP3WPXn2z8ddaE6K/vMeH
         kRwpDxcUnI18RiYbmUfgUUjaOhTR6oiI6obv/mAQlfnjQ4tXJzDSP8FDI8gJcVtebQxb
         YdsNXrJ7HwzvB+I3DnsW2T2dJ3SifAAC6U+kMD80db30Jeuq+Fre2PE/BfW7ex1g/jv9
         SpLdUkNZKaxhExXp7eHnVviCyTyuJW+97ENuoX6ZjLIvBJPbPr5URt6wOxY99qWXiU6B
         DLMfZGn7nA7uoSzScCkDPqAm0CgxK3O1dSJvUsmuZwa0CzghgEzqPiZXy5OnScwoHeZ/
         H+iA==
X-Gm-Message-State: AAQBX9dAK0jwJw4vDlx5XDDP/Hvmj3xsn1ZUwbMvW5sIDmSX3Aui6BQN
        TvZVlQfjtA+xiHYxQIl++YPenYlfPgXK51/X+l4=
X-Google-Smtp-Source: AKy350ZJs5t1rE5waKeG80x624AGOma/729jSi4OiOCKS9N8/7OjFDtBqoml11ylguqjP21qCf0h4g==
X-Received: by 2002:aa7:da88:0:b0:4ad:738b:6706 with SMTP id q8-20020aa7da88000000b004ad738b6706mr5919891eds.2.1680807141470;
        Thu, 06 Apr 2023 11:52:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id y30-20020a50ce1e000000b0050470829dbesm651614edi.63.2023.04.06.11.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:52:21 -0700 (PDT)
Message-ID: <fb78a687-9b01-de8b-b78a-9e62ddd3b9c0@linaro.org>
Date:   Thu, 6 Apr 2023 20:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-binding: pci: add JH7110 PCIe dt-binding
 documents.
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
 <20230406111142.74410-2-minda.chen@starfivetech.com>
 <38bc48bf-7d8c-8ddd-861f-3b7f3d2edce6@linaro.org>
 <20230406-revisit-patchy-a0063d964070@spud>
 <20230406-cinema-profile-1bfed00e4a5f@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406-cinema-profile-1bfed00e4a5f@spud>
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

On 06/04/2023 20:45, Conor Dooley wrote:
> On Thu, Apr 06, 2023 at 07:35:09PM +0100, Conor Dooley wrote:
>> On Thu, Apr 06, 2023 at 08:24:55PM +0200, Krzysztof Kozlowski wrote:
>>> On 06/04/2023 13:11, Minda Chen wrote:
>>>> +
>>>> +  interrupt-controller:
>>>> +    type: object
>>>> +    properties:
>>>> +      '#address-cells':
>>>> +        const: 0
>>>> +
>>>> +      '#interrupt-cells':
>>>> +        const: 1
>>>> +
>>>> +      interrupt-controller: true
>>>> +
>>>> +    required:
>>>> +      - '#address-cells'
>>>> +      - '#interrupt-cells'
>>>> +      - interrupt-controller
>>>> +
>>>> +    additionalProperties: false
>>>> +
>>>> +required:
>>>> +  - reg
>>>> +  - reg-names
>>>> +  - "#interrupt-cells"
>>>
>>> Keep consistent quotes - either ' or "
>>>
>>> Are you sure this is correct? You have interrupt controller as child node.
>>
>> I know existing stuff in-tree is far from a guarantee that it'll be
>> right, but this does at least follow what we've got for PolarFire SoC:
>> Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>>
>> Both PLDA and both RISC-V w/ a PLIC as the interrupt controller, so in
>> similar waters.
>> This note existed in the original text form binding of the Microchip
>> PCI controller:
>> | +NOTE:
>> | +The core provides a single interrupt for both INTx/MSI messages. So,
>> | +create an interrupt controller node to support 'interrupt-map' DT
>> | +functionality.  The driver will create an IRQ domain for this map, decode
>> | +the four INTx interrupts in ISR and route them to this domain.
>>
>> Given the similarities, I figure the same requirement applies here too.
>> Minda?
> 
> Further, if, as I currently suspect, there's a lot of commonality here,
> should the binding as well as the driver be split into common pdla bits
> and microchip/starfive specific ones?
> 
> Suppose that's more one for you Krzysztof.

Yeah, looks like only clocks and resets are different. At the end it
depends how much code you would remove...

Best regards,
Krzysztof

