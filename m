Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A76620D81
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 11:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiKHKin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 05:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiKHKim (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 05:38:42 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D1A1A5
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 02:38:40 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f37so20618423lfv.8
        for <linux-pci@vger.kernel.org>; Tue, 08 Nov 2022 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIJOCsaQlOWgJQ5ApMxd9tPJK7uAENvlixXq8WQS0q8=;
        b=P2bJkxBMmJkGflbYsSSEZImEP1kCLNB778vrIN/eLrcdXPHopi3rfLZ/EBDDiMsJl3
         gNrITOXtBUUuh3VmeWoFUhNFx0EFnYN4xJMhDP8bhMEeNnA9GDtQhgM8T8TsRHX/ihxM
         AlSxvu0Tk6XyWbt6MTU6sHRlY9rNB8iOokyf2/JUvP/v+DWYZopL+oFt/HjX1rm8dhrj
         ib4d/NvigsB1RyRb287lD57Zn2rPiua/u5Cr05U+FQxaLUiP/RSR78i5nm+juXOEoKJJ
         aeFvZ2FIf0cOJM06OudYKzSLf/+jNpB5FlU1Zsi40rZyWtX+lZq6xlUgAKNRo7TDeRo1
         OEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIJOCsaQlOWgJQ5ApMxd9tPJK7uAENvlixXq8WQS0q8=;
        b=IPMIVank2yQC6ANobsPFEJtElHWYI4j0bczDPdb6K7v2NSFXpnFjOSxfCmD/JirfO8
         wVQBMCfJviPkoGZW6EYYazgdrD3nLYcs2jduqEKuDn26Uoyc+PiCCYx9LxTl51Lmp30w
         NzFeQfU8jyhyYolgqCW15Z4zTDT0obB1XQRCBEp/nr1ALSnwM3MAkH6D2XtbiF7VAemz
         q3yI8f44ATHubKcxCBMToUN/3s4sSNmDOwoDmLwQflTg+8hqJ7bW2P1C+wEpZxJ3dpbB
         juhayrG3B2DoRBKRxZwLdK4LwrC/EvwwZnhZY3RloBq50kN7J3zlpuGv8/G89cnPKY30
         n+Gg==
X-Gm-Message-State: ACrzQf2cdHAMtzSUpjodygi5vGdhD92kdTBSu9d3oGp93rkVUPZGqziB
        lLB/mWuZ+VtXnIjEYN7w4Wfz916g4HnsQA==
X-Google-Smtp-Source: AMsMyM6yYZAe4CVDILmz58Ocgj3LvAXbaC1NItWa2Gv2AKnpnp0aSi/Q9Z1oazZlir6CQAvqD2PTwQ==
X-Received: by 2002:a05:6512:2e9:b0:4ac:5faa:654d with SMTP id m9-20020a05651202e900b004ac5faa654dmr440084lfq.684.1667903919177;
        Tue, 08 Nov 2022 02:38:39 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id q7-20020ac25107000000b004b40c2fccfdsm207162lfb.59.2022.11.08.02.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 02:38:38 -0800 (PST)
Message-ID: <5604fc7d-5ce4-227c-230c-21480af179a0@linaro.org>
Date:   Tue, 8 Nov 2022 11:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML
 schemas of Xilinx AXI PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
References: <20221108035030.1040202-1-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108035030.1040202-1-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/11/2022 04:50, Thippeswamy Havalige wrote:
> Convert to YAML dtschemas of Xilinx AXI PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Dropped additional blank line before sob.


This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

