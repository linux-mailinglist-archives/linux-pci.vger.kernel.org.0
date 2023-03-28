Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F466CC0E2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjC1Nas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjC1Nae (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 09:30:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15075C64F
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 06:30:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y15so15829780lfa.7
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680010202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKTtxXBQXNdB3mDvc7ywZLQeEEIHxxzdUGBM34gb4BA=;
        b=I8xms0l0rNHplSHi9RGLTwbge69HPDturDYNFRl1tfLXCHpa4y2XoX38Ka1qyUMkaN
         cv25wbwMfJl0YsVfSM03v0dD6iUxuK/4A/g+14/BZxf/Gdo5n0RF7yrGRkh8ZZGGJfUH
         BpEcmPTZ/ap7X+dADikfLPXa3GMl3fBI86ZeXlf5tClGBx5msFW/Vyq83tkAhoMgSnlX
         tdYXJDVfe3DV1wpnbfCepRRSBo2jupakArQOwSIRt4RTYICNhYbgfDshBloUqNHcyd5G
         DDK83XrJ3p+X51CwwIPB6V6etzQFw0o6FBN/suhAqEw+fNBNX2olqYFPHH7WtMvwH4sE
         hvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKTtxXBQXNdB3mDvc7ywZLQeEEIHxxzdUGBM34gb4BA=;
        b=csfZyG8Jx+NL+KQzHqxYlVL6a71CyqJzXdECQ086mwnh67Lk5oo/XSjrYrOCyP45xz
         W/nLqHDq5kDi3eTNIOQ8PGT+8t93HSxwccFL3LW8X9GYh+isFm1Nr1684uW8S8cZ/ut6
         8mWRS1iksxUTJGJTxmz322oVflGBik6bgd3u7Zg59hGwNxwin+4f5LrV3hGfUhmVRbqd
         5QF2Rn2J8BRCK17O3nlIOE8fRVk9C6Llh7jsiR2NoDr5XKmm7FwDr/OjBvuAA/TS1hmc
         ASHX9JS2VmgqoyQSsCZ9R9vPNfYIghcF3QmTdbYgH6shxPkPom4eEBAUAu26C1lgSx+d
         zhBQ==
X-Gm-Message-State: AAQBX9efmfoaTfbpTN5fZp5rwUKQSBlqcRO2QMRMOzvUFqXwQ/1g44pT
        artC48x8pR00D5WSsDLUHkqYOg==
X-Google-Smtp-Source: AKy350aQBV4ZvZHbN/PDT47IBCkZUFzZ1c/0U0S8aAiHh6D2eyakbST1XrzpZ1XrLEJ90DUuXhbH3A==
X-Received: by 2002:a05:6512:3c2:b0:4dd:98c6:ee2 with SMTP id w2-20020a05651203c200b004dd98c60ee2mr4295986lfp.15.1680010201754;
        Tue, 28 Mar 2023 06:30:01 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id b26-20020a056512025a00b0048a9e899693sm5080765lfo.16.2023.03.28.06.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:30:01 -0700 (PDT)
Message-ID: <b1eb5e35-87a5-fd8f-da35-f2303fa29ade@linaro.org>
Date:   Tue, 28 Mar 2023 15:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 4/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
 <1679036039-27157-5-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1679036039-27157-5-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 17.03.2023 07:53, Rohit Agarwal wrote:
> Enable PCIe PHY on SDX65 MTP for PCIe EP. While at it,
> updating status as last property for each node.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index ed98c83..70720e6 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -245,6 +245,13 @@
>  	status = "okay";
>  };
>  
> +&pcie_phy {
> +	vdda-phy-supply = <&vreg_l1b_1p2>;
> +	vdda-pll-supply = <&vreg_l4b_0p88>;
> +
> +	status = "okay";
> +};
> +
>  &qpic_bam {
>  	status = "okay";
>  };
> @@ -265,8 +272,9 @@
>  };
>  
>  &remoteproc_mpss {
> -	status = "okay";
>  	memory-region = <&mpss_adsp_mem>;
> +
> +	status = "okay";
>  };
>  
>  &usb {
> @@ -278,14 +286,16 @@
>  };
>  
>  &usb_hsphy {
> -	status = "okay";
>  	vdda-pll-supply = <&vreg_l4b_0p88>;
>  	vdda33-supply = <&vreg_l10b_3p08>;
>  	vdda18-supply = <&vreg_l5b_1p8>;
> +
> +	status = "okay";
>  };
>  
>  &usb_qmpphy {
> -	status = "okay";
>  	vdda-phy-supply = <&vreg_l4b_0p88>;
>  	vdda-pll-supply = <&vreg_l1b_1p2>;
> +
> +	status = "okay";
>  };
