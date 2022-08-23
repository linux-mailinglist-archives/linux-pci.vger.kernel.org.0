Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A8859E857
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbiHWQ5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 12:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbiHWQ5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 12:57:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B714039F
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2022 06:27:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s6so8440722lfo.11
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2022 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=RYaoT64rLSiAkBu6ZnEVRKnzaukCu6pGqQ25YPlgRlQ=;
        b=B4xc8gVe0InX3hW6P2VMd5XAFlRh66yotF7S/ardado2iYgZjMEMVv/wy06PQiQzah
         iazrBekEqxteSA9KQm8t30AOVGmmi2nqx+2DGZ7Rq28j7lCsHF5PEdVGKgG6RIQmO0Fd
         TrUySKUx3jVYjXeBUawdAJqP6R3BQQxAxPTfHbzUIMMVAxhGc6IUzHJW8HDB12SbIiKY
         YAHWEi1w26iX4K5bZPKPW7Wq/uEH5qV9Z9fb5lYcGrpfKgmY8uFQ//8YoXjzDA9JYV4P
         xoObMYAS/nuo9PtQT9msLlV1ST+v6Cp2WrTbz0h1PZIgDndRXBVkSPar3tku5vdUhLZ5
         iJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RYaoT64rLSiAkBu6ZnEVRKnzaukCu6pGqQ25YPlgRlQ=;
        b=gKJfjssVAGUvVIOXp/A/FT/tOavK++x1yf8NPCfTFjQRsEcBFjSMxz3XriewY+XM+F
         WurwCgOxXGnxBJdp8GcjPZAr7BTYv//LD062MmE2+eY+19ISgagf9QDm8Ax/EZL9DpIX
         RaofAGaQY/0N0GtVA/de4h+lmn6NYlP7HPMMv93ZvRcn9Jx69HranLiYr0O62qppdKj2
         82EXVRNko753GvKFV6xGTlXiN9BgfRvkRaFqFyxxXHo54V82Sxl9RsP7Rya0Gie6y/A3
         Ua3Nwy3CruCQRcLiRg8MkYj1F2wWER4khGT1MW9KMsLuEwNb+f3Z1WMmsF5fu/GTi3+2
         UB0A==
X-Gm-Message-State: ACgBeo10vgLBNnPMJm2HirnRX7NbgiYUuD2PO7JjZUowqLwhcFP4CCch
        d5hVvk0HsDdAzOeIkhE+Qwg9DQ==
X-Google-Smtp-Source: AA6agR7yDkNWoU8CznVAgBBUwBldaGBGAZ63skSgJLnHIYu5wpua5KrElt1bP4h+zbTgu4ZNMHb0Ew==
X-Received: by 2002:a05:6512:4009:b0:492:f0f7:d83c with SMTP id br9-20020a056512400900b00492f0f7d83cmr1587481lfb.449.1661261251555;
        Tue, 23 Aug 2022 06:27:31 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id p8-20020ac24ec8000000b0048b12ff12e8sm2417459lfr.99.2022.08.23.06.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 06:27:28 -0700 (PDT)
Message-ID: <f5dd04b8-2560-2987-328b-3697aaf1dd74@linaro.org>
Date:   Tue, 23 Aug 2022 16:27:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>, Rex-BC.Chen@mediatek.com,
        TingHan.Shen@mediatek.com, Liju-clr.Chen@mediatek.com,
        Jian.Yang@mediatek.com
References: <20220802120624.19258-1-jianjun.wang@mediatek.com>
 <5c14e959-10cc-5520-e88f-b47a195b99e9@linaro.org>
 <YwTNXaaotJW/vUT9@lpieralisi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YwTNXaaotJW/vUT9@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/08/2022 15:51, Lorenzo Pieralisi wrote:
> On Wed, Aug 03, 2022 at 08:44:11AM +0200, Krzysztof Kozlowski wrote:
>> On 02/08/2022 14:06, Jianjun Wang wrote:
>>> MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as MT8192.
>>>
>>> Also add new clock name "peri_mem" since the MT8188 and MT8195 use clock
>>> "peri_mem" instead of "top_133m".
>>>
>>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
>>> ---
>>> Changes in v4:
>>> Remove "items" for "mediatek,mt8192-pcie" since it only have one item.
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Should I pick this up ?

Yes, go ahead. Thanks!

Best regards,
Krzysztof
