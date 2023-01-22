Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6B676D6D
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jan 2023 15:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjAVOLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Jan 2023 09:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjAVOLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Jan 2023 09:11:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36025125A1
        for <linux-pci@vger.kernel.org>; Sun, 22 Jan 2023 06:11:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3320115wmb.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Jan 2023 06:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZRXyEWbQpFjtg2DB58n/2kfQoLivtArMtPHHmMjBIw=;
        b=psPxgqGBE3X6rF+vKXfc90XELktrxm99+p7puFRyKXyvgJOEM7cWOJAe9c8MHVOV6R
         WJenH8vfT/zVfX6uAI5TXufWIIDSVHawLUB6oYhP9YKxzeO1YOKBkFzPggepvoZU3qw7
         g3W1PPKldLW1ev8Mq1Spw8NdEzYVwYbhlcVEoE8CBZQ/oNthZ//XhZugJ3BWvDfMoKG4
         QgcSe4wDY0xzbLHKCipclV272WMrAWjzoC6lBOCKM+WxXib6/8qOYCk9wcx9u9M08zak
         nozizZGLUwRcQtvxi+hDPbgw6/kh2QUJnvaY5Z85kvcDOEyT2WhT/IYCLKw57NYOqicD
         pH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZRXyEWbQpFjtg2DB58n/2kfQoLivtArMtPHHmMjBIw=;
        b=5EfS4zsncB4laOQ3VvSTybKM07LhN9Za5bP05P1VBFJFgLFOnWwJAXWHJT8dcu6pcc
         0piEkZMA1bWRS+9ou5QsHciiewdrBevlWEQQ6LXS2ek/M3vwLnGDquUWFGFqzPm4Rv0T
         TyGeEqAJyezckkfXSodrMtsc2ta5Sa7VwKdp4ztmdzuUkziHr1x+e+zB4YpWnPlF9vBW
         2v209FaVa9ee3OstDCVTmCeuKgwDsyZz3Tx1jqDvdZYAjtLPLCYHM9GBZ4IW1d+/TPzi
         YcvjzAOntmzcSd8OJn1oXNeVKnci+4cljQ2Dq5+ar27AXpvUxAKaHYudKjjHOGJQ7WTk
         i14w==
X-Gm-Message-State: AFqh2krL8zlTBJnaDKAsVmdQrGRffn8Y5/Vs8rAmemcdyQXyz433VoDi
        5fTlYBqlD6Mw1YWJIsRIXui24g==
X-Google-Smtp-Source: AMrXdXuPwv8v/1rV46mJhP+RM46Rt+X2nwPmAaFNL2bvKuSE7jTpSNYsqqad9bPQYmUdop/7BzGARg==
X-Received: by 2002:a05:600c:4f56:b0:3db:1f68:28f with SMTP id m22-20020a05600c4f5600b003db1f68028fmr12804784wmq.24.1674396661774;
        Sun, 22 Jan 2023 06:11:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b003d35acb0fd7sm8138526wmb.34.2023.01.22.06.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:11:01 -0800 (PST)
Message-ID: <7af21247-a44e-cb46-7461-204fa6b4fcab@linaro.org>
Date:   Sun, 22 Jan 2023 15:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 09/12] dt-bindings: PCI: qcom: Add SM8550 compatible
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-10-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119140453.3942340-10-abel.vesa@linaro.org>
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

On 19/01/2023 15:04, Abel Vesa wrote:
> Add the SM8550 platform to the binding.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v3 of this patchset is:
> https://lore.kernel.org/all/20230119112453.3393911-1-abel.vesa@linaro.org/
> 
> Changes since v3:
>  * renamed noc_aggr to noc_aggr_4, as found in the driver
> 
> Changes since v2:
>  * dropped the pipe from clock-names
>  * removed the pcie instance number from aggre clock-names comment
>  * renamed aggre clock-names to noc_aggr
>  * dropped the _pcie infix from cnoc_pcie_sf_axi
>  * renamed pcie_1_link_down_reset to simply link_down
>  * added enable-gpios back, since pcie1 node will use it
> 
> Changes since v1:
>  * Switched to single compatible for both PCIes (qcom,pcie-sm8550)
>  * dropped enable-gpios property
>  * dropped interconnects related properties, the power-domains
>  * properties
>    and resets related properties the sm8550 specific allOf:if:then
>  * dropped pipe_mux, phy_pipe and ref clocks from the sm8550 specific
>    allOf:if:then clock-names array and decreased the minItems and
>    maxItems for clocks property accordingly
>  * added "minItems: 1" to interconnects, since sm8550 pcie uses just
>  * one,
>    same for interconnect-names
> 
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a5859bb3dc28..58f926666332 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -34,6 +34,7 @@ properties:
>        - qcom,pcie-sm8250
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
> +      - qcom,pcie-sm8550
>        - qcom,pcie-ipq6018
>  
>    reg:
> @@ -65,9 +66,11 @@ properties:
>    dma-coherent: true
>  
>    interconnects:
> +    minItems: 1
>      maxItems: 2
>  

I don't see my concerns from v3 answered.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

