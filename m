Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA4277CCB4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 14:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjHOMcD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjHOMbe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 08:31:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEAC1990
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 05:31:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c93638322so1110043766b.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692102689; x=1692707489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3JquWo+PhnRtxv5g8Z8h2LMAj8f61Bdb2igirOa0jM=;
        b=dp2t8K3rQLReEkq8+il3zNjCfqzoSV52QkRvqwOJXzNReL1sNVI636pULvQcFPpJaR
         V+aNLoVRQqZyuXMGW9HVCuVKZXXE54NCrg+DeukyswbIGgkS9zc+S+/e/kxqe6UVRRUl
         P2aD3nOj1rXv6j+R/JbypnD8E6gOZRDEuYviqyNnGvNpy3B1QpnWNMjCP7SfdEceUvRP
         WvNYT58K8LtLQhGWIjYzmrcZ/XxgERoOgsaiEwqUg7jv1srkCBgM6KF0Q93pTM/uuS9W
         1UNH4iXuKiS+eJXQwDAACduANt1QFGgnYoYgV2izjPWyEBUqsE3JZ3kXzC67yXx67aBO
         upBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692102689; x=1692707489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3JquWo+PhnRtxv5g8Z8h2LMAj8f61Bdb2igirOa0jM=;
        b=h0cXu6DnNb7beKffbuz8ubN69xAlpH0BVrIxULPjE5az4mauEm47N2Qs4f2NMN13pF
         YWLA7knUMDPeenKuDvPT1bh16IioJlDEOD7NzWbj3Nup/VdWr2uxLBUjVL0/nJNIu2gV
         eUj0xnHhWgpDsFe8QfL9RhNMUA7HzeCxtucpjCCqRcetfehmQksuCPEnDJUS8TH9AnyU
         XyHLnr/OKsrbS9U3e2Fdda7OQnKlxA4eJrq1UkjfB+FfucqJBRmVclKWovVU1zYy8vkh
         Tf3Ud0uNU7HUvaRIJVRBjr6bdA92CvE0lCCDKlV1kYArS0OIKz1Vz4TbMNYhZ8WkpDa8
         hP+w==
X-Gm-Message-State: AOJu0YzDYNudqIlFpX4tAy/fDvH+yLyJvc/BmMfbmEa/557ccl05aIIA
        Nb7uCJZKKXPI2SvcRILFq0lGHA==
X-Google-Smtp-Source: AGHT+IEiYJSPT35S7+7Wzy05+K/JOnc4rIBxfI9zhqdwci8Y3J9mEVZ/8574G6ZEikqQrY/sPJTi9w==
X-Received: by 2002:a17:906:7315:b0:98e:4f1:f987 with SMTP id di21-20020a170906731500b0098e04f1f987mr2028420ejc.3.1692102689508;
        Tue, 15 Aug 2023 05:31:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0052567e6586bsm2349583eds.38.2023.08.15.05.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 05:31:29 -0700 (PDT)
Message-ID: <7fe554e9-27c3-9af4-8167-ae4329c40eb7@linaro.org>
Date:   Tue, 15 Aug 2023 14:31:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
 <1692102408-7010-3-git-send-email-quic_krichai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1692102408-7010-3-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/08/2023 14:26, Krishna chaitanya chundru wrote:
> PCIe needs to choose the appropriate performance state of RPMH power
> domain based upon the PCIe gen speed.

This explanation should be also in bindings patch, otherwise why would
we consider the bindings patch?

> 
> So, let's add the OPP table support to specify RPMH performance states.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 595533a..681ea9c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -381,6 +381,49 @@
>  		};
>  	};
>  
> +	pcie0_opp_table: opp-table-pcie0 {
> +		compatible = "operating-points-v2";
> +
> +		opp-2500000 {
> +			opp-hz = /bits/ 64 <2500000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-5000000 {
> +			opp-hz = /bits/ 64 <5000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-8000000 {
> +			opp-hz = /bits/ 64 <8000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +	};
> +
> +	pcie1_opp_table: opp-table-pcie1 {
> +		compatible = "operating-points-v2";
> +
> +		opp-2500000 {
> +			opp-hz = /bits/ 64 <2500000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-5000000 {
> +			opp-hz = /bits/ 64 <5000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-8000000 {
> +			opp-hz = /bits/ 64 <8000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-16000000 {
> +			opp-hz = /bits/ 64 <16000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +		};
> +	};
> +
>  	reserved_memory: reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -1803,6 +1846,8 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie0_default_state>;
>  
> +			operating-points-v2 = <&pcie0_opp_table>;

Why the table is not here? Is it shared with multiple devices?

Best regards,
Krzysztof

