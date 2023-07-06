Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524B2749A6F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjGFLSU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 07:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGFLST (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 07:18:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67126170F
        for <linux-pci@vger.kernel.org>; Thu,  6 Jul 2023 04:18:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so723046e87.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Jul 2023 04:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688642296; x=1691234296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TBZJkcS0xaN6VJinb4rdEWKvi8fXW3P7v3shc5NZsI=;
        b=hcwgCj8Vk/DA24xeSADs5QG5iUhOWDhL9BmAGOZ1OrucSLIE/d9A9OM7mWtY/++Igh
         39gF/Ny+Q1laJgwaesi2S6ba8+Cv7cc5j3DaZDwOSVnXDAvrhnjvtKNA4uHOF5SAa13i
         p9B3zEFF6V7LDCH8VYvZ2jTNWy9JDAkz4oSp3sQ+WsMWL4vq5WHzGG4WUSgobuYKKVP4
         RUVn8Zxke2oaJXtIchlcM8POmf3cr79z01Kx/ZSurpyr7bSW5eKh1YcsahpuDv8ymbnc
         rUwWwcLgXkJ66G++1kxcFhP0pJAUs+w4sP3mIYmVal0UpC1ukCg6xZNBoI1eyJvc+Dgu
         KJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688642297; x=1691234297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TBZJkcS0xaN6VJinb4rdEWKvi8fXW3P7v3shc5NZsI=;
        b=c1WdMTboJNDohkhaKaTohIn+wqBr3E/Dsuar2w7jZHOEV0SZQ6r/r0uv3D2AaFA71G
         38Yh7pZl0+ar4nUBTSEiOI7zFkDtaHeZ1H+qWXhTx9G1Tehu06il/tNpNR8YzeDmj+8t
         HYgphN9UMcLtYLDpb42Dg2NlF8YWHFQ2KrmFLWF5WdL0P2Wo2cYrnwlhn5VExjiibbWC
         NqzxAwMrYUHL7HWsJL+KZkatJO/PyXIsRtG1tYJ1gq35KZJ0PQLMp6Ee/aHWWkR6wzov
         tZsbMPQ62G27iS2+S840K1e6kQC87guVYV856SrExR4gkc84o/zkPUliCElv1fUYdyW/
         vWww==
X-Gm-Message-State: ABy/qLZYZ3b7T8upDxPRIeFhFWLK2Wez01iwpAfYhRO6odVljqs0eLcO
        1D1ZfjXmrkXvuC9ZhCZE+kJxPw==
X-Google-Smtp-Source: APBJJlEdV0G0y1a9Ie1Ud8CkuIhX4rGYpvbYdBYmnQe3S0XJ61PAyQlUCsBvEmEzaYesJ54UzAWjpQ==
X-Received: by 2002:ac2:5e68:0:b0:4fb:845d:9e8f with SMTP id a8-20020ac25e68000000b004fb845d9e8fmr1114939lfr.53.1688642296658;
        Thu, 06 Jul 2023 04:18:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id er14-20020a05651248ce00b004fb844a03c7sm211188lfb.186.2023.07.06.04.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 04:18:16 -0700 (PDT)
Message-ID: <c71b5f8d-c3dc-4213-1665-43dcbca7a159@linaro.org>
Date:   Thu, 6 Jul 2023 13:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 6/6] arm64: dts: qcom: sa8775p-ride: enable pcie nodes
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-7-git-send-email-quic_msarkar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1688545032-17748-7-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5.07.2023 10:17, Mrinmay Sarkar wrote:
> Enable pcie0, pcie1 nodes and their respective phy's.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
grep for '&[a-z0-9]\{' and please fix all missing spaces before the
opening braces.

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 68 +++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index ab767cfa51ff..4a39294259fe 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -443,6 +443,74 @@ qup_uart17_rx: qup0-uart17-rx-pins {
>  			bias-pull-down;
>  		};
>  	};
> +
> +	pcie0_default_state: pcie0-default {
> +		perst {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		clkreq {
> +			pins = "gpio1";
> +			function = "pcie0_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake {
> +			pins = "gpio0";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie1_default_state: pcie1-default {
> +		perst {
> +			pins = "gpio4";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		clkreq {
> +			pins = "gpio3";
> +			function = "pcie1_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake {
> +			pins = "gpio5";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
> +&pcie0{
> +	status = "okay";
> +};
> +
> +&pcie1{
> +	status = "okay";
> +};
> +
> +&pcie0_phy{
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1_phy{
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +
> +	status = "okay";
>  };
>  
>  &uart10 {
