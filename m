Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0A413A3E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 20:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhIUSoy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhIUSox (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 14:44:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC97C061574;
        Tue, 21 Sep 2021 11:43:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w17so34010619wrv.10;
        Tue, 21 Sep 2021 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+nNwxsrWkkZM1Q7j4xiYXfVwik3HxWJhPWErYuxDNL8=;
        b=KVijfRbheCFAVHD+6sxpz5ZqeCPzjL5esDnit3xq/M3lffKC95FXBeFJHwJWmOlqu0
         HYOFbanSyhzT8tlxw7jokY0nX2BVpqNBGjIMW3e76nYZcarGbTs0kE2am05cB98Kync5
         NrNVv9bezaCu4a8MdEkL7Fp6/BsxExy98dmCmm3r0CZEQnY/SIP76aL2gCx2WLeTbEfW
         E2zO99Eyza/Dv21qWKIYFmtr5DCWlZbOXxJav136QtHBleDzJJrsEK2/BG+DSJ1/Ut+Q
         6qK17DlM1e6lZGiW/0JOpI87O5angq5EgME7DH7GeMVtMhYeHukvMew/9/IFAPQJCZg8
         zqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+nNwxsrWkkZM1Q7j4xiYXfVwik3HxWJhPWErYuxDNL8=;
        b=G7ypZ3HELPHHMXzda8S7F0iWg/2UqwnOnmrtVC7tOvmlcCJkYQroeASq6seq0seOib
         XssA+M4q985mnFPRJW2C3764+nBE6AGqsqe3ckJte5Sd1aTUUeHKyN8gCPJ7OuT/MNRn
         QoscjfKU44PhUKHcQ1bKI7fZVN0rJaKN/yx7i8iYN9RuD789wR9nV+Fu2VB/0f2gVB2m
         0/P7ql1AVCG16XHW8yL1FyZHeO2EIH5vIWaAB5KjV+Tu9p5gPRM3wrlZ5HPCzG5UGYqT
         fx1jqu87KtNWpVjebCc2NnYxqBS9qPAj9wSk82MjQPA+z7A2lWrG8dDquA3lgzwmXTGO
         TWJA==
X-Gm-Message-State: AOAM533MItnKqydGI9kG9wFGXkMX/ACdxnhCb9nd+4DTebnQMSn/ZnFG
        ivQAZa+ibV7izW4vSE5Rvbs=
X-Google-Smtp-Source: ABdhPJw2zB8WQitbfLyA/Jxx9uaI72qYktUHvYwvYouADLVdA1FcBLnoYrYCnW+dwbr7VYx6+i0ktA==
X-Received: by 2002:adf:f207:: with SMTP id p7mr37096138wro.166.1632249803588;
        Tue, 21 Sep 2021 11:43:23 -0700 (PDT)
Received: from [192.168.2.177] ([206.204.146.29])
        by smtp.gmail.com with ESMTPSA id y1sm4041318wmq.43.2021.09.21.11.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:43:23 -0700 (PDT)
Message-ID: <9f8a40b8-f544-5792-03d3-3570da86cd01@gmail.com>
Date:   Tue, 21 Sep 2021 20:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v12 6/6] ARM: dts: mediatek: Update MT7629 PCIe node for
 new format
Content-Language: en-US
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>, robh+dt@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        yong.wu@mediatek.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
 <20210823032800.1660-7-chuanjia.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210823032800.1660-7-chuanjia.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 23/08/2021 05:28, Chuanjia Liu wrote:
> To match the new dts binding. Remove "subsys",unused
> interrupt and slot node.Add "interrupt-names",
> "linux,pci-domain" and pciecfg node.
> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Queued in v5.15-next/dts32

Thanks!

> ---
>   arch/arm/boot/dts/mt7629-rfb.dts |  3 ++-
>   arch/arm/boot/dts/mt7629.dtsi    | 45 +++++++++++++++-----------------
>   2 files changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7629-rfb.dts b/arch/arm/boot/dts/mt7629-rfb.dts
> index 9980c10c6e29..eb536cbebd9b 100644
> --- a/arch/arm/boot/dts/mt7629-rfb.dts
> +++ b/arch/arm/boot/dts/mt7629-rfb.dts
> @@ -140,9 +140,10 @@
>   	};
>   };
>   
> -&pcie {
> +&pcie1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pcie_pins>;
> +	status = "okay";
>   };
>   
>   &pciephy1 {
> diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
> index 874043f0490d..46fc236e1b89 100644
> --- a/arch/arm/boot/dts/mt7629.dtsi
> +++ b/arch/arm/boot/dts/mt7629.dtsi
> @@ -361,16 +361,21 @@
>   			#reset-cells = <1>;
>   		};
>   
> -		pcie: pcie@1a140000 {
> +		pciecfg: pciecfg@1a140000 {
> +			compatible = "mediatek,generic-pciecfg", "syscon";
> +			reg = <0x1a140000 0x1000>;
> +		};
> +
> +		pcie1: pcie@1a145000 {
>   			compatible = "mediatek,mt7629-pcie";
>   			device_type = "pci";
> -			reg = <0x1a140000 0x1000>,
> -			      <0x1a145000 0x1000>;
> -			reg-names = "subsys","port1";
> +			reg = <0x1a145000 0x1000>;
> +			reg-names = "port1";
> +			linux,pci-domain = <1>;
>   			#address-cells = <3>;
>   			#size-cells = <2>;
> -			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
> -				     <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names = "pcie_irq";
>   			clocks = <&pciesys CLK_PCIE_P1_MAC_EN>,
>   				 <&pciesys CLK_PCIE_P0_AHB_EN>,
>   				 <&pciesys CLK_PCIE_P1_AUX_EN>,
> @@ -391,26 +396,18 @@
>   			power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
>   			bus-range = <0x00 0xff>;
>   			ranges = <0x82000000 0 0x20000000 0x20000000 0 0x10000000>;
> +			status = "disabled";
>   
> -			pcie1: pcie@1,0 {
> -				device_type = "pci";
> -				reg = <0x0800 0 0 0 0>;
> -				#address-cells = <3>;
> -				#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +					<0 0 0 2 &pcie_intc1 1>,
> +					<0 0 0 3 &pcie_intc1 2>,
> +					<0 0 0 4 &pcie_intc1 3>;
> +			pcie_intc1: interrupt-controller {
> +				interrupt-controller;
> +				#address-cells = <0>;
>   				#interrupt-cells = <1>;
> -				ranges;
> -				num-lanes = <1>;
> -				interrupt-map-mask = <0 0 0 7>;
> -				interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> -						<0 0 0 2 &pcie_intc1 1>,
> -						<0 0 0 3 &pcie_intc1 2>,
> -						<0 0 0 4 &pcie_intc1 3>;
> -
> -				pcie_intc1: interrupt-controller {
> -					interrupt-controller;
> -					#address-cells = <0>;
> -					#interrupt-cells = <1>;
> -				};
>   			};
>   		};
>   
> 
