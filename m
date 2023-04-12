Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3796DF463
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 13:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDLL4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 07:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDLL4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 07:56:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E525B4C1F
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 04:56:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504a37baf98so2233506a12.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681300592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viozi8WsbH/DNbU6I8Kpp6YtafxtKSmvjW088VP7BVQ=;
        b=Kn6u/ENoZ+oxbCROGKcAR6CGVFthkc7bgQ1xOWjxoHq7fMIHgBptias+YEhQzLgKOG
         6GUdcL91fMKJRLw/pk7A14is6kWS0nXXBeVrD6KZsHQVyL/hR+73csTlodLSrWPlimso
         91sMW38iuc3FnNQiONjMQpzDEu67Zjwi8x6eFZ/MLG+Q/NBeIhQ93VYu1BIvTGNL2DQV
         MrJafhEdDQRR60jeofPYda8oAkAnhUGm1c3SSGOGgcrwhLg1MCacBWLXHXr/I8dWCxFt
         WMs5S7XXwukMGZWyW8eSjO4bv9c+egekJDfVB7qxpi7uxVXyBXb1jSOqeiuh0RyZNSSt
         CEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681300592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viozi8WsbH/DNbU6I8Kpp6YtafxtKSmvjW088VP7BVQ=;
        b=1hT2Hh083AQDqSoaESe3CujCrPRGt17RA6CAv4bdyU0ripAO8j2pkFBeyZdF4T1lLz
         kOOY+tcuHfIHQ4PXPSmsmDe3zMqnlyEd/lmEZoiDL03hQbx8HY4mODvMRe/wZdSywGus
         UGS5pP3MzjKj/RMTTeYwE+a9B97YVC/nC6sHTN6vdrSYku/xxo+A5/ArWy+mndrO/dZP
         IUf39W6Su4jvIPcOL8J4gSQVAzentZYQKojx0Xzp7qE/odTsvKoP57vcKhEiJWZBITiz
         FEhS3Jmvx5cQwm8r2P3bCbXMgjpF+/nn0oZDvaSnsCToc7V3c9krG0O+RI4uC5ARGXsu
         swjw==
X-Gm-Message-State: AAQBX9c6bvK8ylD6MBCk73LRyyG10zkDHDNo3OWTaP33qIruRDwrDKt2
        I3fAeDCrBNUoUU2pEGSarp3eMA==
X-Google-Smtp-Source: AKy350aiP1FqqXG9WgEtDAIm9FtFj3ZnLVTn/hVAgjhJD+CkVEs9E5WifMD2ZngCXeeyRHodV3LmFw==
X-Received: by 2002:aa7:c2d2:0:b0:4fa:fcee:1727 with SMTP id m18-20020aa7c2d2000000b004fafcee1727mr13574263edp.13.1681300592394;
        Wed, 12 Apr 2023 04:56:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id i13-20020a50c3cd000000b004fa012332ecsm5383882edf.1.2023.04.12.04.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:56:31 -0700 (PDT)
Message-ID: <66b7d0b9-9569-ddaf-89ca-5a0133074a17@linaro.org>
Date:   Wed, 12 Apr 2023 13:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <78c18cdb-5757-8d30-e2a6-414f09505cc6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/04/2023 13:49, Florian Fainelli wrote:
> 
> 
> On 4/12/2023 1:09 AM, Krzysztof Kozlowski wrote:
>> On 11/04/2023 18:59, Jim Quinlan wrote:
>>> Regarding "brcm,enable-l1ss":
>>>
>>>    The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
>>>    requires the driver probe() to deliberately place the HW one of three
>>>    CLKREQ# modes:
>>>
>>>    (a) CLKREQ# driven by the RC unconditionally
>>>    (b) CLKREQ# driven by the EP for ASPM L0s, L1
>>>    (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
>>>
>>>    The HW+driver can tell the difference between downstream devices that
>>>    need (a) and (b), but does not know when to configure (c).  Further, the
>>>    HW may cause a CPU abort on boot if guesses wrong regarding the need for
>>>    (c).  So we introduce the boolean "brcm,enable-l1ss" property to indicate
>>>    that (c) is desired.  Setting this property only makes sense when the
>>>    downstream device is L1SS-capable and the OS is configured to activate
>>>    this mode (e.g. policy==superpowersave).
>>>
>>>    This property is already present in the Raspian version of Linux, but the
>>>    upstream driver implementaion that will follow adds more details and
>>
>> typo, implementation
>>
>>>    discerns between (a) and (b).
>>>
>>> Regarding "brcm,completion-timeout-us"
>>>
>>>    Our HW will cause a CPU abort if the L1SS exit time is longer than the
>>>    PCIe transaction completion abort timeout.  We've been asked to make this
>>>    configurable, so we are introducing "brcm,completion-timeout-us".
>>>
>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>
>> What happened here? Where is the changelog?
> 
> It is in the cover letter:
> 
> https://lore.kernel.org/all/20230411165919.23955-1-jim2101024@gmail.com/
> 
> but it does not look like the cover letter was copied to you or Rob.

As you said, I did not get it.

Best regards,
Krzysztof

