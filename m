Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C80729A2C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 14:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbjFIMlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 08:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbjFIMlQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 08:41:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FE1BC6
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 05:41:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1badb8f9bso18951471fa.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Jun 2023 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686314473; x=1688906473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAbk5K5T7EimIImnFE4kZxayLfuVA86dV2h+g48YHm8=;
        b=wYw/zG/6yf5TloEjQGKFZj4Xmm78ziBJ1uCXesppIT9VereP2CeQ+Jl5ahKzJiuJ7e
         wBCZJ6w3DndVFgC2/MOBy5vHDR5/1twEMEIJbE9lKTna8lfU1amPfGDyMuxaLkbEpitk
         v9Xe+zJ5RMHzg+PjcopKrgDb0d7yTPKp+aMLus50vu3awc+DV7+03xfg3tWGIMgBfqwt
         5CyiymjCZPixxbPNSMx1gMPz2c9Sgc9yrspj/q/Qz1ZRZzpeH20Gp2M3gWkhKjXs4hhP
         Gx5FCWvroU7gyXvEAv4t1CmAl8LovyGl0lUJGi2KCaLlONNHUjTuXVfpKqWaUS0nBVmY
         f32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314473; x=1688906473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAbk5K5T7EimIImnFE4kZxayLfuVA86dV2h+g48YHm8=;
        b=YeuEkwZWgXGVRIa8WG2NT4GMm+akE7fe90IP7EvvjHZ3VQ73yNMCsCsHw8Z1Gn4Mo/
         HZe8JFB4jOI7l9Rz25b0jHBijO+6sT7yfcCMIutBZt0n3rJVmx08+/j3azlXdU7l+d8C
         T3H16iHi39pw2eV7lAJ0pHT88n5EpoS1iizmud0ArCRkaPwqQVufZnL+WCaMP9e3GaYc
         zEsWxapii8IHEz7x3wriX6cyuYX/lV1VlP/3sOqI9ANIw7+qu/gI1WpdFbo/nBudZCbI
         W2l/IRy8pT7oULHNr3MAeYQdjjFIKt+nROuUNZEtcj288Sv3RIXUg99K4KzYJGQ30o0t
         5AEQ==
X-Gm-Message-State: AC+VfDwkIiMU7ZCpTK9YatViznyRqN6E6jdKPs8Lq19lx+tEL3ZcrMS1
        UND5q3a6Z0v+JdCApzYk7v93/Q==
X-Google-Smtp-Source: ACHHUZ5okdIhfZ1lUdCz754l/opk34vtezEoVF1Q6tWPVmnYuJJTAEO+2ROflh8eu+31rfndM/6GOg==
X-Received: by 2002:a2e:b0e7:0:b0:2af:1844:6fdb with SMTP id h7-20020a2eb0e7000000b002af18446fdbmr907329ljl.5.1686314472624;
        Fri, 09 Jun 2023 05:41:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d7-20020a2e96c7000000b002b1ad0e7357sm379857ljj.51.2023.06.09.05.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 05:41:12 -0700 (PDT)
Message-ID: <dbb847c4-1043-081b-f28b-ea57fe5cad2d@linaro.org>
Date:   Fri, 9 Jun 2023 14:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
 <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9.06.2023 13:47, Krishna chaitanya chundru wrote:
> Some platforms may not boot if a device driver doesn't initialize
> the interconnect path. Mostly it is handled by the bootloader but
> we have starting to see cases where bootloader simply ignores them.
> 
> Add the "pcie-mem" interconnect path as a required property to the
> bindings.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
Hi, only patches 1 and 2 made it to both me and linux-arm-msm.

Consider using b4 (https://b4.docs.kernel.org/en/latest/index.html) to
avoid this.

>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index b3c22eb..656e362 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -70,6 +70,13 @@ properties:
>      description: GPIO used as WAKE# output signal
>      maxItems: 1
>  
> +  interconnects:
> +    maxItems: 1
> +
> +  interconnect-names:
> +    items:
> +      - const: pcie-mem
> +
>    resets:
>      maxItems: 1
>  
> @@ -97,6 +104,8 @@ required:
>    - interrupts
>    - interrupt-names
>    - reset-gpios
> +  - interconnects
> +  - interconnect-names
>    - resets
>    - reset-names
>    - power-domains
> @@ -194,6 +203,8 @@ examples:
>          interrupt-names = "global", "doorbell";
>          reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
>          wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +	interconnects = <&system_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
> +	interconnect-names = "pci-mem";
The indentation is off and my brain compiler says that it will not compile
without including some headers.

Konrad
>          resets = <&gcc GCC_PCIE_BCR>;
>          reset-names = "core";
>          power-domains = <&gcc PCIE_GDSC>;
