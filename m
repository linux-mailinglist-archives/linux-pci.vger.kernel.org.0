Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E72559D2D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiFXPX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 11:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiFXPXw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 11:23:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FC4ECD8
        for <linux-pci@vger.kernel.org>; Fri, 24 Jun 2022 08:23:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g18so3548227wrb.10
        for <linux-pci@vger.kernel.org>; Fri, 24 Jun 2022 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+bhqNUnBw2VlBb+vKh9BVjK86IEzMRn9rbxeRT0RpzU=;
        b=unSq8mf41jKUNz0zl0xeXhApqvYec4N3cTR8n5fovaRhwmji9yx7zuESRXHRXiIgtb
         kbkB9TDS6IQFZtFmjwOYK6SS2XmBHK/SGChPmng3OZGRqr5o1Eu9OYieOjdRmwYRldOe
         XptsV14p+JHshQP7F3oBh05e6GPreOfhXUpnqAhQo3yOMHWQu4Dsp829OUV1a++xItDc
         B94B+a2nf0H6T4gUUrBefrDJ7RzZMxETNjhcir5Re9++JIz88YRFgFl0mT/DPRzQGicO
         5KnUPkgJzqnO8mEm/Fj8vH/JPd93G6DAnle4x0/9ZrC4deqywXDK/DASo9VEp43Ot8FZ
         mu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+bhqNUnBw2VlBb+vKh9BVjK86IEzMRn9rbxeRT0RpzU=;
        b=fbqkAKB+nuzHm+rGXRAcEg5Gol0YDu0n1DSfTM+oQvKqabrrUhAgWJgA/FF319OAVW
         iSxBvSy+iqsLsWtpg7mkqDi//9HuuhU3PHSlEGWKScDQqaWdgLiJOJ9ePCDSUy5vddV/
         8Qqy/HnJlLKnw2ygnS5k9kwvXEDACKYo3xoTQcp4EBkT0566kuqjoi4RPhCTtB0L29XZ
         cXBmeqFmmYJSyFWQAKL+I9PNoJ+/k4eTKbvTfjsrfk13m+C1pvUReYMbM0VB/kP/MWUG
         KgkRk37p65WUMilxKbhFeZx0GrQHGJlTh4onegSEN1DEvbLS5ejgIZb4SbmHP7h77Usn
         3euQ==
X-Gm-Message-State: AJIora/h6xvYY0KIPw4fAdaZzC7VucyRZjl5LDXEB4Fe3RCNm3CPIHjT
        4lFCypu5DDQN9DEyXOXhMTRdJw==
X-Google-Smtp-Source: AGRyM1s9YBvmKfcs61SMXYZ8cH6Yai5Wzlk65zklCRkC8/sqfy96FjnpPWRBJJj5I7pxa5IPeTokBw==
X-Received: by 2002:adf:df8a:0:b0:21b:9219:634c with SMTP id z10-20020adfdf8a000000b0021b9219634cmr13427248wrl.669.1656084229815;
        Fri, 24 Jun 2022 08:23:49 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k31-20020a05600c1c9f00b0039c5642e430sm3309268wms.20.2022.06.24.08.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 08:23:49 -0700 (PDT)
Message-ID: <329101e6-4f81-78c3-818b-8d70905248a6@linaro.org>
Date:   Fri, 24 Jun 2022 17:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: sc7280: Add missing pcie clocks
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
 <1656062391-14567-4-git-send-email-quic_krichai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1656062391-14567-4-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/06/2022 11:19, Krishna chaitanya chundru wrote:
> Add missing pcie clocks.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Thank you for your patch. There is something to discuss/improve.

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index e66fc67..a5ce095 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2043,6 +2043,8 @@
>  				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
>  				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
>  				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
>  				 <&gcc GCC_DDRSS_PCIE_SF_CLK>;
>  
>  			clock-names = "pipe",
> @@ -2055,6 +2057,8 @@
>  				      "bus_slave",
>  				      "slave_q2a",
>  				      "tbu",
> +				      "aggre0",
> +				      "aggre1",
>  				      "ddrss_sf_tbu";

Unfortunately wrong order.

Please test your patches with `make dtbs_check`.


Best regards,
Krzysztof
