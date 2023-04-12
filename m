Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD86DED3B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDLIJN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDLIJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 04:09:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3603955BD
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 01:09:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5050491cb04so197235a12.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681286947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/dGyY5TVITXQ9f4V3PWQDgLG26tGuInk2+5HFdtqR8=;
        b=c+2NF6or5H/VIFSDJXyhSL+skI9ti8M2domvgV4yoDxz7yfc28S8trr32nb2BeOton
         sRYRm54/JE9s0pd1E+K3QrhhEpSvioNkGpkDHuaAmwGE5XnKzc/oH2aJvvcnXi5QIXZR
         3gTl1osfhP/7NvYulngudhiVVyKtASlOs2BD0ouCglCkguhiu9375QXPtZyt3aRu6gSX
         6jcRErDcQ4Mwt0WVUczPRWufNVz/+yaeh2VvW2pK5jyP5xAlChaB1fMfMaF6R97ZbdrP
         l4wmrrmMv5/qwVkFRTbiCUBzbgHaoVyrOmXLKsgGBQ+Vcd+Y0IiWSnHmo38sPBjOMsHC
         deCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681286947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/dGyY5TVITXQ9f4V3PWQDgLG26tGuInk2+5HFdtqR8=;
        b=eO5K49E3lXAKcz2iTvseDDUUszw+pc6nXjrYKYjJxH7zzOh3IcRyNEocVo4tWBHY7e
         1qvxZNH4fTx9Ba/szfa7R7lqrqOi5HfADL9FoahPmJsKRtItmYFqovPfleiq+1OhOjew
         wLI5pIPXauWFt8yb7NpsTls0+ReW2a0IYmfJQvs5kjuZAjmG9ampZcclS3bnaWydK96C
         hVP02HZqEdTK+fva3CWQSqND/Wx2GMm0B+cJ6oDy33Rc+jgZY57l4M8iytmIbhN0n35U
         /fvCpC9hkzr6ZHZrBE+DhlyXPNIGoKBHZWfFPK+72ExjOm0XRQQdgbI11FNwECLQzYni
         sESw==
X-Gm-Message-State: AAQBX9cs1R9VVIrrXMFTBzkW6xeuKlrDdkqW5povn1g4yOuHlxZc4aed
        IEpYkahEuNCFXcG1wmPQCZOapQ==
X-Google-Smtp-Source: AKy350bz0IrllROlyNxN4r5spnZP79yYjDpGswbEYI/n4wTyHF5BJPKSElpsgQxSPRBPFk8+VKgh3Q==
X-Received: by 2002:a05:6402:1154:b0:504:c269:1497 with SMTP id g20-20020a056402115400b00504c2691497mr1462520edw.27.1681286947468;
        Wed, 12 Apr 2023 01:09:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id h2-20020a50c382000000b004ad601533a3sm6626809edf.55.2023.04.12.01.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:09:07 -0700 (PDT)
Message-ID: <5a28e520-63e4-dbcf-5b3e-e5097f02dea2@linaro.org>
Date:   Wed, 12 Apr 2023 10:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411165919.23955-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/04/2023 18:59, Jim Quinlan wrote:
> Regarding "brcm,enable-l1ss":
> 
>   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
>   requires the driver probe() to deliberately place the HW one of three
>   CLKREQ# modes:
> 
>   (a) CLKREQ# driven by the RC unconditionally
>   (b) CLKREQ# driven by the EP for ASPM L0s, L1
>   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> 
>   The HW+driver can tell the difference between downstream devices that
>   need (a) and (b), but does not know when to configure (c).  Further, the
>   HW may cause a CPU abort on boot if guesses wrong regarding the need for
>   (c).  So we introduce the boolean "brcm,enable-l1ss" property to indicate
>   that (c) is desired.  Setting this property only makes sense when the
>   downstream device is L1SS-capable and the OS is configured to activate
>   this mode (e.g. policy==superpowersave).
> 
>   This property is already present in the Raspian version of Linux, but the
>   upstream driver implementaion that will follow adds more details and

typo, implementation

>   discerns between (a) and (b).
> 
> Regarding "brcm,completion-timeout-us"
> 
>   Our HW will cause a CPU abort if the L1SS exit time is longer than the
>   PCIe transaction completion abort timeout.  We've been asked to make this
>   configurable, so we are introducing "brcm,completion-timeout-us".
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

What happened here? Where is the changelog?

Best regards,
Krzysztof

