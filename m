Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE04373B534
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 12:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjFWKX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFWKXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 06:23:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF0910F8
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2023 03:23:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b45b6adffbso7834191fa.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2023 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687515830; x=1690107830;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWkn1j4YDLKl0IK4GIRfG+rZU5Zz9V3+MlpELBvyLnE=;
        b=Lv5v6/WUOMe9EPELgwEGPtHCSnuEurKHRbsTC7Da2DPiVlnI09lyQs9/Ee2Uop4B3Z
         jJL65HJQNb2jK4sKg3XVosgAq1emxCS5SrCcK7SEt7x5jYfYxBlwzT0ZXhpgNtme5xFy
         oDI1HUald1kB6/GE5Z4VC0lEi7pOvE41wGDw5/IoKd8Gtlhr/+ygyXzZhxHhqwSY1dgT
         QyxZfHGW4pAx1WS+Jpmi3uCntDaqCscHRow4SdskaGF+za0nS5bY3DWJPkm3s4RSpW4b
         r5iD95vUN5xC7z+H6NIN69evurdfGM6VK8yatgH2a1YFop0LiFizrkFC99TqNi7Y5/A1
         8kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515830; x=1690107830;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWkn1j4YDLKl0IK4GIRfG+rZU5Zz9V3+MlpELBvyLnE=;
        b=EdFWhiVikh80+ZCfGJ+0PEMvHZVZJVyn176UnJ8Ol6TvaGLl1w5KBjVaqJ/xWQ9g33
         k/7IlkouO6Q0Xist3EgyPf1gmVcBU2H3xtDTDeFSPfEhamOXbdm40x1HuypoXYtZaa8T
         kfe5P0ifgO/S8/6tAGAOP780qLcBRSy6UMv95/05alYDTnBFrdLOkkzZMV+9cydBhjem
         h2Zla+x5Ff0wEI20aRjzHzSIRKWJ+5tpbgxmqvswozuXgbk41LpzmWeRYmyu1fTIq0yd
         DQ5Ril4aLfBuL5GHPml5k67gwFqKsF1YrEQ8CoE5AQIjlgot+u2N8S6gIfuHiJwV5FyA
         CxRw==
X-Gm-Message-State: AC+VfDw7b524FTDwZZxc0/zfh4LRo5KLStR27JjEj8vYVazt2750XgLk
        de+YgCnPu/CWuAEfZsyjCuUFwQ==
X-Google-Smtp-Source: ACHHUZ7WiiXjygu0C97ZUwok3q3Sy/rHAJt5AmZivWrId/kBRMGzvsAMvd/W1h55AkUURdJrpuBWrg==
X-Received: by 2002:a05:6512:252b:b0:4f9:644c:1edb with SMTP id be43-20020a056512252b00b004f9644c1edbmr3443015lfb.62.1687515830060;
        Fri, 23 Jun 2023 03:23:50 -0700 (PDT)
Received: from [192.168.1.101] (abxh63.neoplus.adsl.tpnet.pl. [83.9.1.63])
        by smtp.gmail.com with ESMTPSA id b4-20020ac247e4000000b004f86db4ce65sm1408380lfp.55.2023.06.23.03.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:23:49 -0700 (PDT)
Message-ID: <e85ca82f-1c7f-76dd-3599-793883dd0700@linaro.org>
Date:   Fri, 23 Jun 2023 12:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] dts: Reserve memory region for NSS and TZ
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, mani@kernel.org,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230623094403.3978838-1-quic_srichara@quicinc.com>
 <20230623094403.3978838-5-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230623094403.3978838-5-quic_srichara@quicinc.com>
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

On 23.06.2023 11:44, Sricharan Ramabadhran wrote:
> Add reserved memory region for NSS and fix the name
> for tz region explicitly.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
The commit title is divergent from what's in the commit message and
the patch body. Please separate these two changes.

>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 791af73334cb..d51ff9b4f5c1 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -86,6 +86,11 @@ reserved-memory {
>  		#size-cells = <2>;
>  		ranges;
>  
> +		nss@40000000 {
> +			reg = <0x0 0x40000000 0x0 0x01000000>;
Drop the leading zeroes from the size part.

Konrad
> +			no-map;
> +		};
> +
>  		bootloader@4a600000 {
>  			reg = <0x0 0x4a600000 0x0 0x400000>;
>  			no-map;
> @@ -104,7 +109,7 @@ smem@4ab00000 {
>  			hwlocks = <&tcsr_mutex 0>;
>  		};
>  
> -		memory@4ac00000 {
> +		tz@4ac00000 {
>  			reg = <0x0 0x4ac00000 0x0 0x400000>;
>  			no-map;
>  		};
