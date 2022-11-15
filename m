Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC046299CD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 14:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiKONO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 08:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKONOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 08:14:55 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C152714F
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 05:14:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so24318502lfs.10
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 05:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooyl1uFqat+f2ZNpkIjPxta1ZbRx2XG5h0e61uujqKk=;
        b=Le74PuhyssQXy39UPs3dvmgG7S+szyOwSa9W0c/Uxly7crv/XWyEfo/WDS01afAYCZ
         YXthv+RFSKt2FWOymLaBCAblLi0Vbrqex7wNGRnCbj3NhFLJ5ub0oQaOQ09pbZPIZmYl
         cQeUI0xOMJuoX6Ye2URpIdAQYtHZ0shGX9dx2zRb8GB0SkgHMBqqoyMqhcU8/PUBNA+W
         LOxmv+fpQAXT2e2woqIVlDRVU6DHlrfEhmiMnpEzB+clsq4D0CEpNSDbzxutKM/obSGF
         FbCSwB1DKWk6fQwj5Dxf6FsOqylkojIw1gvoCYNGHulpNhRTM2bvSVaHBbojVEqFgHzN
         Y33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ooyl1uFqat+f2ZNpkIjPxta1ZbRx2XG5h0e61uujqKk=;
        b=BS+vgXEhOS9Kz4qykhWGCeE5AEgjwo5P+CeE/NT8LNBHT/9p6bOYCrEHwDKwk+ovtj
         kh5DnWg23GWJEG40O5IfQzbXuw2XQlCzMXUyHf4f2jsttK25SlJl5qSDNrER+2VSToAx
         L+ErcNv/0TiA7DkW55IDzudA23ZaCAa+fL0hNztNxaMghMGBrOyGRhMLeYFg1rE+fowY
         CWj/ahJnNyLCuflmV/YIFM1a7QILEm/lUYAf9q0jbdNhSijChDK1j97jXCM7SheJb4S6
         Ci4PS+gkzJhUK7ukl3Cz6vMQMkMe8wZPLkMmdc1fusp1+/nG8LyLZKQbHCpVVJqOoXvv
         DcJA==
X-Gm-Message-State: ANoB5pkus0MNRLFZ6zFwNt4MmUIYSfd2eYPROFZYbBXAfGT2lvu2Xss+
        WLbfXQoW9Olq6CHaqMkJDMwgHg==
X-Google-Smtp-Source: AA0mqf5bf1tHm6zM/I+mQqK8jSttcy4XiXKdKL0ZzsOi9LJQ8cWmKlYfrjYcjMksIRh1tYVEjHzR0A==
X-Received: by 2002:a19:6442:0:b0:497:a17d:d848 with SMTP id b2-20020a196442000000b00497a17dd848mr5302938lfj.381.1668518092400;
        Tue, 15 Nov 2022 05:14:52 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id s21-20020a056512203500b004a8b9c68735sm2200581lfs.102.2022.11.15.05.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:14:51 -0800 (PST)
Message-ID: <93d30faf-da88-7bdc-dca7-82435b5f9fe9@linaro.org>
Date:   Tue, 15 Nov 2022 14:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] arm64: dts: msm8998: unify PCIe clock order
 withMSM8996
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
 <20221115125310.184012-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221115125310.184012-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 15/11/2022 13:53, Krzysztof Kozlowski wrote:
> PCIe on MSM8996 and MSM8998 use the same clocks, so use one order to
> make the binding simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 320a28232a32..539382dab0ad 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -929,11 +929,11 @@ pcie0: pci@1c00000 {
>   					<0 0 0 4 &intc 0 0 139 IRQ_TYPE_LEVEL_HIGH>;
>   
>   			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> -				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> -				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_AUX_CLK>,
>   				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> -				 <&gcc GCC_PCIE_0_AUX_CLK>;
> -			clock-names = "pipe", "bus_master", "bus_slave", "cfg", "aux";
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
> +			clock-names = "pipe", "aux", "cfg", "bus_master", "bus_slave";
>   
>   			power-domains = <&gcc PCIE_0_GDSC>;
>   			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
