Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656AB6D9FBE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbjDFS0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbjDFSZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:25:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7DD61A5
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 11:25:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-944bbbb17f7so159007366b.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Apr 2023 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680805556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7Q2Y5PSxjfNuuYETIJE0tc7Nl05PML4hPeE9FZ3t1U=;
        b=LyZ0MroWIx7yQATTWi7dnR72e4lHzBaxVKcXKV8E0fOBtt5cs33Bxj0rkLYm1qvpjt
         71iqLmw6M1SjavFuptr1hBspndmbtGClUbMoef355RRW6Kjj64Vfjzch8aDKLvoitFbU
         2iacdF2BOo8dFbpfDl0fCQgD7CUTVlNKhJ0IGbFt6oeJ/i1t27Dw2UbjcONJ6coEyzYO
         gDo7HDb1tVCN12jaKk6KhYoL0Jn8wtZsjFhCOh34qTKOwIGIzbHMgFLvenMjg/RvpxV4
         X6ZxgN4fsN7VPwD5qbKOC47UKOeC4fGrgg+04Pkgm1xqJfUvV6SlB6vTN00qA+YH+n7d
         3QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7Q2Y5PSxjfNuuYETIJE0tc7Nl05PML4hPeE9FZ3t1U=;
        b=yHYHft28w4GRvMHU30KpBILnWkfU+jQf6lDrupu2w6XSspCjV/ptQMwS26pXP8SVc4
         9zVTLsX5rhwGdiWU47MWV8JZeWUrqod6H1KOuWYtPVOL9eM9A3P72M/pKb+ODMwLppa7
         ezvcxnfr5hy6dnBr8KvGoudjjKJgEoWcKSVNTzNF8uapXb6B9S6eJ7YIU131XKaUPBgf
         yrbAyWjtfSjzHvu5cNAhkWRUcdvGA4iAc9FuJTWfIqhLwhKkArHX5Lxk6YYlPp5Px+/D
         5RyFxdx9dD380I43jUt+tI8sQJoF+tS/e2WAF7kD/DRg67wtNd7YFZjVkpsWmKr9No7l
         my2Q==
X-Gm-Message-State: AAQBX9f37y35ebtqu+7emaiHqY5rqGbd0jntnMMrrgjkpWnA39ogGFRg
        0H0tHj/BGikpdClTlGMPkRvbIg==
X-Google-Smtp-Source: AKy350Z+LY2W1omro8GAJRTq6Ah27eM8V7j5+Ouj215Swxjc9vV2rpYK6UOXULEWcDwfHrTaFnUnhw==
X-Received: by 2002:aa7:c647:0:b0:4fc:6475:d249 with SMTP id z7-20020aa7c647000000b004fc6475d249mr434834edr.3.1680805556612;
        Thu, 06 Apr 2023 11:25:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id a29-20020a509b5d000000b004fd204d180dsm1029128edj.64.2023.04.06.11.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:25:56 -0700 (PDT)
Message-ID: <56e47e45-b3c0-4d32-923c-88023faef827@linaro.org>
Date:   Thu, 6 Apr 2023 20:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: add PCIe dts configuration
 for JH7110
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
 <20230406111142.74410-4-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406111142.74410-4-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/04/2023 13:11, Minda Chen wrote:
> The PCIe is a PCIe2, single lane PCIe compliant controller.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 58 ++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 88 +++++++++++++++++++
>  2 files changed, 146 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index cf0a66faf5d3..4552919e69b0 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -191,6 +191,50 @@
>  		};
>  	};
>  
> +	pcie0_wake_default: pcie0_wake_default {

No underscores in node names. Test your patches against bindings before
sending.


>  	uart0_pins: uart0-0 {
>  		tx-pins {
>  			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> @@ -228,3 +272,17 @@
>  	dr_mode = "peripheral";
>  	status = "okay";
>  };
> +
> +&pcie0 {
> +	pinctrl-names = "default";
> +	reset-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
> +	phys = <&pciephy0>;
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	pinctrl-names = "default";
> +	reset-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
> +	phys = <&pciephy1>;
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 2f67196ffac0..c309ec550ba7 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -642,5 +642,93 @@
>  			#reset-cells = <1>;
>  			power-domains = <&pwrc JH7110_PD_VOUT>;
>  		};
> +
> +		pcie0: pcie@2B000000 {

Lower case hex.

> +			compatible = "starfive,jh7110-pcie";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;

Why reg is not second property?

> +			reg = <0x0 0x2B000000 0x0 0x1000000
> +			       0x9 0x40000000 0x0 0x10000000>;
> +			reg-names = "reg", "config";
> +			device_type = "pci";
> +			starfive,stg-syscon = <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
> +				 <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
> +			interrupts = <56>;

Your binding requires cells, so I am pretty sure you did not test what
you wrote.



Best regards,
Krzysztof

