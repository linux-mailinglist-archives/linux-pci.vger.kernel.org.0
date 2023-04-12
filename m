Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C96DF42E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 13:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjDLLtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDLLts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 07:49:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1BC1BF;
        Wed, 12 Apr 2023 04:49:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63397c54c5aso1471566b3a.3;
        Wed, 12 Apr 2023 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681300179; x=1683892179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LU0NNrMj/8UlufToqKjMQMv6WJwb/IxRYgWWMch67x4=;
        b=qQOOyq6X4rTR64+g/4bntpfaKV6cLyGhlNoOUbD064dkffw6SlmvZEHgDYzMo0FNZ8
         OmaGl+MgxC1vMKI2HHaHwlpC2J3sCp1f1OlRQsQ9ripvMe607ZMF/SB7utiA6ohV/H83
         UFABZfVVKKIM+ynX6b+uDbQB/3sTRtONtrbNvJhEJJEBP70mb5CckJM1jPV4HX6mI2ts
         JH380mtDSf6WdKzJh2DfXaF7IsYP7GvT8f65g66c9H1cWNds1agqtGNFcW05IFUyIX8j
         xYggBo4BWcCYfpMMYEyyAHfGg+N8BlNZUMEl42anHcwTU/8SnYJ9plb44rEZ6NtPJv5g
         1uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681300179; x=1683892179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LU0NNrMj/8UlufToqKjMQMv6WJwb/IxRYgWWMch67x4=;
        b=JmxCdnV2ER/aD9sIHm8OtHSgENSu7rVVH5JZWaG08TQRxqlO781ZyC5El2Bj/OSGwh
         l3lt4epy5dQD++PxhcGekGWMABvZIhSpkcOSb4ZeOTX/WgoPumH92X579+qhq/f17bVy
         OysyqzZ7OmYJ0iGXwmQrVRaUSMNKEfPKTNTlkqVGxjZQLZamFQoXNSaee4//ISPIeeXg
         K9r7qU9ZyvZo9I2ih0JGzEWKTtb+L3+POl7OqdKRplYHcYSrqeM3PNlqIZSHlghhl9RT
         QwGrfFSIU4KxIK9VeKKydBIzukYr7v/3DXlR5bAChc8B/CZy3XnBnJI6qfVc+JJ9UFWs
         g5Mg==
X-Gm-Message-State: AAQBX9dwAYaUQ9d8MBZAA/bMP17fB7cNPiqeXhyYnT2lXGv9Le9lGISr
        7VzQQBhtLNSRzoglf9rSoqk=
X-Google-Smtp-Source: AKy350bFdYFz3IJL5nYzhZwjE0U1hAgIOeONbwcpftGqIbO4iVn75S8Kxf4U9HiU4tdSCCAdE1MDFg==
X-Received: by 2002:a05:6a00:2da1:b0:63b:20f3:a8c9 with SMTP id fb33-20020a056a002da100b0063b20f3a8c9mr96761pfb.29.1681300179503;
        Wed, 12 Apr 2023 04:49:39 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:8589:ba50:9cee:d1f4? ([2600:8802:b00:4a48:8589:ba50:9cee:d1f4])
        by smtp.gmail.com with ESMTPSA id c5-20020a62e805000000b0063b1d65cc6dsm441287pfi.127.2023.04.12.04.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:49:38 -0700 (PDT)
Message-ID: <78c18cdb-5757-8d30-e2a6-414f09505cc6@gmail.com>
Date:   Wed, 12 Apr 2023 04:49:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-2-jim2101024@gmail.com>
 <5a28e520-63e4-dbcf-5b3e-e5097f02dea2@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <5a28e520-63e4-dbcf-5b3e-e5097f02dea2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/12/2023 1:09 AM, Krzysztof Kozlowski wrote:
> On 11/04/2023 18:59, Jim Quinlan wrote:
>> Regarding "brcm,enable-l1ss":
>>
>>    The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
>>    requires the driver probe() to deliberately place the HW one of three
>>    CLKREQ# modes:
>>
>>    (a) CLKREQ# driven by the RC unconditionally
>>    (b) CLKREQ# driven by the EP for ASPM L0s, L1
>>    (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
>>
>>    The HW+driver can tell the difference between downstream devices that
>>    need (a) and (b), but does not know when to configure (c).  Further, the
>>    HW may cause a CPU abort on boot if guesses wrong regarding the need for
>>    (c).  So we introduce the boolean "brcm,enable-l1ss" property to indicate
>>    that (c) is desired.  Setting this property only makes sense when the
>>    downstream device is L1SS-capable and the OS is configured to activate
>>    this mode (e.g. policy==superpowersave).
>>
>>    This property is already present in the Raspian version of Linux, but the
>>    upstream driver implementaion that will follow adds more details and
> 
> typo, implementation
> 
>>    discerns between (a) and (b).
>>
>> Regarding "brcm,completion-timeout-us"
>>
>>    Our HW will cause a CPU abort if the L1SS exit time is longer than the
>>    PCIe transaction completion abort timeout.  We've been asked to make this
>>    configurable, so we are introducing "brcm,completion-timeout-us".
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> 
> What happened here? Where is the changelog?

It is in the cover letter:

https://lore.kernel.org/all/20230411165919.23955-1-jim2101024@gmail.com/

but it does not look like the cover letter was copied to you or Rob.
-- 
Florian
