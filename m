Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019576DFAE5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 18:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDLQMQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 12:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDLQMP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 12:12:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84427A98;
        Wed, 12 Apr 2023 09:12:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so12129907pjb.1;
        Wed, 12 Apr 2023 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681315931; x=1683907931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3JlLGJe9jNa5faHy1EPzLcl/UMrCDP3TfzXac4OOno=;
        b=r5Dv39pjzRFLTOrswhX14WN1TKtSDHvIkzKr0J6xP7GyGqT1lo0LETECLtXba1+yhv
         YCj5VG2KQXS/HfF42nhSZMVpQMddoCS8Vyz5nKJqzqZ6K3qzccpNmZkwvRTmzItWUF/H
         o86O88rq1eROZOiJcZKGATR5B2awQ+OydniBYAEdEx49Db7DD+ua5ry+RoCSRIdZEgLh
         yzF+fneYf21YAslt+c5jGmuEFnmhgmEzE02VKKw/iHK2OI1YExvdnF+ttCb/2N1F86UJ
         F8mT8OKA5n+s+sYFx8LWffSdXdUr+HZ7DV/2IRXS2TPah5l/iYitu+FDUtQCSmEgC4Hh
         eMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681315931; x=1683907931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3JlLGJe9jNa5faHy1EPzLcl/UMrCDP3TfzXac4OOno=;
        b=cSZ0k1W/Rd/D2qF947YwJAU+3KppszJPSda8VvzMOMS4OP3uCj6EKLd/ImYQND7i+t
         48hBKxcGFs3cP5w8HOwCn9FEi5OKHKYVf4yn5gewzStnF0sOniddrRhFG+VbpBu1kwCf
         Ze0VHcT8ZtzTHJ3tZjVwFlRy6nWAZiDvkwmKflhBOk+MrE+2McTP8RbA+nlnbPk7n1po
         ZLafWgyOcYykcVN9Pr5RVBSCASr1m1t3oCgvPJxDtLiSGr3Tsd64yrS+0KSC58UFE+90
         sf4BwBFsYvK3bmEvv1Wqq0RCm+Lm0AeHZE45Oqu74hfz3d87eAwvSfFJtZn2Ii/bbm/p
         hEVA==
X-Gm-Message-State: AAQBX9dq1FdtvBuocdpypo6A36UuoQV2/jMJi9D6ez7wIf/hJsYwxV33
        kiIQ9iAup+aHSvBDvRF3pCo=
X-Google-Smtp-Source: AKy350Y6kmiAwS7hEYCLDrpnIlAWZb/8PtllMixj3VFO4bphJSzuZ7ECxrqTg9LOJrjffudyj5+8Lw==
X-Received: by 2002:a17:90b:3ec4:b0:240:3ee4:d2d1 with SMTP id rm4-20020a17090b3ec400b002403ee4d2d1mr9349740pjb.13.1681315931213;
        Wed, 12 Apr 2023 09:12:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id me18-20020a17090b17d200b00244991b3f7asm4938222pjb.1.2023.04.12.09.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:12:10 -0700 (PDT)
Message-ID: <ac2245fd-52c8-3255-3e54-bd8daab1282d@gmail.com>
Date:   Wed, 12 Apr 2023 09:12:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
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
 <78c18cdb-5757-8d30-e2a6-414f09505cc6@gmail.com>
 <66b7d0b9-9569-ddaf-89ca-5a0133074a17@linaro.org>
 <CANCKTBtZt9QRkT4yAW5LsfHGf5TTL7tQ025H42+PPEi-=rWE8A@mail.gmail.com>
 <20230412153723.GA2473030-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230412153723.GA2473030-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/12/23 08:37, Rob Herring wrote:
> On Wed, Apr 12, 2023 at 10:14:46AM -0400, Jim Quinlan wrote:
>> On Wed, Apr 12, 2023 at 7:56 AM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 12/04/2023 13:49, Florian Fainelli wrote:
>>>>
>>>>
>>>> On 4/12/2023 1:09 AM, Krzysztof Kozlowski wrote:
>>>>> On 11/04/2023 18:59, Jim Quinlan wrote:
>>>>>> Regarding "brcm,enable-l1ss":
>>>>>>
>>>>>>     The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
>>>>>>     requires the driver probe() to deliberately place the HW one of three
>>>>>>     CLKREQ# modes:
>>>>>>
>>>>>>     (a) CLKREQ# driven by the RC unconditionally
>>>>>>     (b) CLKREQ# driven by the EP for ASPM L0s, L1
>>>>>>     (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
>>>>>>
>>>>>>     The HW+driver can tell the difference between downstream devices that
>>>>>>     need (a) and (b), but does not know when to configure (c).  Further, the
>>>>>>     HW may cause a CPU abort on boot if guesses wrong regarding the need for
>>>>>>     (c).  So we introduce the boolean "brcm,enable-l1ss" property to indicate
>>>>>>     that (c) is desired.  Setting this property only makes sense when the
>>>>>>     downstream device is L1SS-capable and the OS is configured to activate
>>>>>>     this mode (e.g. policy==superpowersave).
>>>>>>
>>>>>>     This property is already present in the Raspian version of Linux, but the
>>>>>>     upstream driver implementaion that will follow adds more details and
>>>>>
>>>>> typo, implementation
>>>>>
>>>>>>     discerns between (a) and (b).
>>>>>>
>>>>>> Regarding "brcm,completion-timeout-us"
>>>>>>
>>>>>>     Our HW will cause a CPU abort if the L1SS exit time is longer than the
>>>>>>     PCIe transaction completion abort timeout.  We've been asked to make this
>>>>>>     configurable, so we are introducing "brcm,completion-timeout-us".
>>>>>>
>>>>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>>>>
>>>>> What happened here? Where is the changelog?
>>>>
>>>> It is in the cover letter:
>>>>
>>>> https://lore.kernel.org/all/20230411165919.23955-1-jim2101024@gmail.com/
>>>>
>>>> but it does not look like the cover letter was copied to you or Rob.
>>>
>>> As you said, I did not get it.
>>
>> Yes, sorry about that; I use a wrapper over the "cocci_cc" script and
>> I need to modify one or both scripts to send the cover to the
>> superset of recipients in the constituent commits.
> 
> Try out 'b4'. It's much easier.
> 
> In any case, I don't read cover letters. Changes to a patch belong with
> the patch.

This is not what most other maintainers do, and there does not appear to 
be a general consensus amongst maintainers that the changes belong in 
the individual patches, or in the cover letter. Some trees like the 
networking tree do merge commits of patch sets where the cover letter is 
used as part of the merge commit message. Other maintainers don't, and 
some want the change log after the '---' and some do not.
-- 
Florian

