Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750F4651471
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 21:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiLSUwW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 15:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiLSUvt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 15:51:49 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A21612AB3
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 12:51:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p36so15491423lfa.12
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 12:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vz0gc2fIsvgndZrJ67LKywnyviecBh18rwcvp2t84Fw=;
        b=nf6XxcHkdQC2FMDbYR9XAhPdkk2xaGquNl3GuERuC4t50ok1sYXsase9CbyZDkwnIl
         uawAJR/j2g2EwktEiKGOs6yunQFYLYGjTivUZM7ymkb+9U/qryXGYIbnQS0UeygfXFcb
         2j7sxTReJrJSrKQW8vXZyDEpqyIThKRL/cpK30PZVqphi2R5J8z4vl0tYYIL8+VVhBKH
         wWj9Ed6rJo+W8/hvtt2AXOyZqKxMcjWwoxb93eAv5LdWFTl1cnRCcaPocduf/efJRtcF
         SYMA1ZcUX4qV265HO38TjKDi7ZIhEp+5FSydlJoPcfM5qGC/kTSpibou+Q2lgZU0HWiZ
         AAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz0gc2fIsvgndZrJ67LKywnyviecBh18rwcvp2t84Fw=;
        b=co66BHXXhbfseMBSKGG5BpWd6ru21fQY7kNWDKlcgXMxGSNxzwSv+eCMNK1sDRDYkP
         h7nN4NnwG4t8d/mMoqe1bwKLckRdumG0aPA+Hi6vaiFMkkMIS7dhQzM2Da4DP+ChGcaF
         PDyZHiq+z8BbeoBkZhNS99l1NZf3kvOfLLyDXlaesSCpvCKaO9lfSU6wKAmYhf3goC5d
         J6k+D2vYq+iAJhuSusHE91jZff6EzS0yR4OKBKGWzAxA7emoYN0oOh9EOnF1ziwjDNA4
         IaZhNFMoOBBA63RuPnc6FyOrMhBJDIaE6ApVSYDfoMxvgR8TcbEFe0yDICzrOLy7sKp2
         +Ccg==
X-Gm-Message-State: ANoB5plw+mUEa7YnbHBB2l/bVmkuyrcAcRUpvz4uttYJlU6LY2a2lHrt
        qqMzU4Ty0MB1ElCQsOY+Np4gLQ==
X-Google-Smtp-Source: AA0mqf6CB4pooKYg9NjiLjkT2SYb0YciwIVIJ0CFILLTIYRz/BmCumCuClKBt4taEUaN5PoMzv74wQ==
X-Received: by 2002:ac2:5e29:0:b0:4b5:b10b:6824 with SMTP id o9-20020ac25e29000000b004b5b10b6824mr11054994lfg.55.1671483102454;
        Mon, 19 Dec 2022 12:51:42 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b00498fbec3f8asm1192956lfq.129.2022.12.19.12.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 12:51:42 -0800 (PST)
Message-ID: <741887b5-8f83-4db5-bb17-755afc18716d@linaro.org>
Date:   Mon, 19 Dec 2022 21:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and
 PCIe1
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221219191427.480085-1-manivannan.sadhasivam@linaro.org>
 <20221219191427.480085-4-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221219191427.480085-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 19.12.2022 20:14, Manivannan Sadhasivam wrote:
> Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
> endpoint devices using GIC-ITS MSI controller. Add support for it.
> 
> Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> msi-map-mask of 0xff00, all the 32 devices under these two busses can
> share the same Device ID.
> 
> The GIC-ITS MSI implementation provides an advantage over internal MSI
> implementation using Locality-specific Peripheral Interrupts (LPI) that
> would allow MSIs to be targeted for each CPU core.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
This breaks PCIe Wi-Fi on Xperia 1 IV:

[   32.711199] ath11k_pci 0000:01:00.0: Adding to iommu group 5
[   32.713738] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem 0x60400000-0x605fffff 64bit]
[   32.715447] ath11k_pci 0000:01:00.0: MSI vectors: 32
[   32.715485] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
[   32.873873] mhi mhi0: Requested to power ON
[   32.873896] mhi mhi0: Power on setup success
[   65.161798] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x91517088, fsynr=0x640001, cbfrsynra=0x1c00, cb=5


Konrad
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 570475040d95..276ceba4c247 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1733,9 +1733,9 @@ pcie0: pci@1c00000 {
>  			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>  				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>  
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			msi-map = <0x0 &gic_its 0x5980 0x1>,
> +				  <0x100 &gic_its 0x5981 0x1>;
> +			msi-map-mask = <0xff00>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>  					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> @@ -1842,9 +1842,9 @@ pcie1: pci@1c08000 {
>  			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
>  				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
>  
> -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> +				  <0x100 &gic_its 0x5a00 0x1>;
> +			msi-map-mask = <0xff00>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>  					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
