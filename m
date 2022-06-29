Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36B755F6B9
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiF2Gfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiF2Gfi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:35:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179F2C13A
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:35:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so20732761edb.11
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kBQFkusmcz/SMOWRD7R4YKEzcrVSUMw7+0eTSwhhg8c=;
        b=yFSGXOTThJGqGcl5Aqt8nukaqco/J/Pgq3+2L3gVKGxN1VDwiq1x4Up7LSaYhkD/TC
         SCJNYdoD9W+xphqJ8K1JVRWSKGoSzf5V5h0ZAW2Je8pKFCX3qeNQzWGohjrSoeB7aDVr
         5/1tbL02NJvJ5Or5SZsksmHCm7C5Ddp7tlwkMS9uZqM3Mh/jbnmdrFItF+nUUubxsan6
         LqcSGLbEXPYtw0t7M0BDt4cglwyGnZit3M4g/J/OmreW3aLwm8N8n+B54EZff+XF3+QX
         bo1yDSUHmJUZvDjm4nIEM5+98AdTJiFyH1Qhlts1LRsMVtxeZ92Bmj6+itR7oX5Bs20p
         WH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kBQFkusmcz/SMOWRD7R4YKEzcrVSUMw7+0eTSwhhg8c=;
        b=Tj6cYVE87US/0qNphB/x/YfgICseZxqx7Wevm41EnvHlh+l420L0dGIW+6V8ugsngD
         Rf1GqmLhfkQaxE+C0gJxygZCc+Kz7PaKZ4EUcPDqmtn0Q15XDKHUM/GTljXZfOKTpMWp
         y2Uiz+lQmMY4yyeJICflm3pRGjVRXWWyGJHrcIkpkSPxMHQS8+YK3RqfbmQXe9zMGSXt
         t5j8Fbh3xmuUZUVNleh3yCKMOP94naZuGJzBBK2lU9ND+GuLzUaz/+rDYBPoAZACaLRl
         6e+TNhtzR/hLxcnwShjAOsn2PoGjcVq02DGt6A9Lpk0UhwXYQu5sbXm7EvpKt86GHUSx
         xvpg==
X-Gm-Message-State: AJIora8d57CTHfg815pzcvBAZpa5yoO4UK/AN6I0PozepUogYz3HyPVU
        OsgEgQJOlcr15h6KoIlzekAYWQ==
X-Google-Smtp-Source: AGRyM1vnwG7UM1ZvSadQ2cbuw8dyvte78Wi8y82ra2acHs2+T3hSNHgNjjf/JkSlE3T81fgpoeGeJw==
X-Received: by 2002:a05:6402:2404:b0:437:d11f:b9c7 with SMTP id t4-20020a056402240400b00437d11fb9c7mr2203046eda.176.1656484534706;
        Tue, 28 Jun 2022 23:35:34 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090629d400b00704cf66d415sm7325538eje.13.2022.06.28.23.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 23:35:34 -0700 (PDT)
Message-ID: <07d2cbc3-07e2-85f4-1739-ffbe57d65519@linaro.org>
Date:   Wed, 29 Jun 2022 08:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V3 06/11] arm64: tegra: Add P2U and PCIe controller nodes
 to Tegra234 DT
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     kishon@ti.com, vkoul@kernel.org, kw@linux.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-7-vidyas@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629060435.25297-7-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/06/2022 08:04, Vidya Sagar wrote:
> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
> The Tegra234 SoC contains 10 PCIe controllers and 24 P2U instances
> grouped into three different PHY bricks namely High-Speed IO (HSIO-8 P2Us)
> NVIDIA High Speed (NVHS-8 P2Us) and Gigabit Ethernet (GBE-8 P2Us)
> respectively.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Added entries for all controllers that can operate in EndPoint mode
> 
> V2:
> * Added 'iommu-map', 'iommu-map-mask' and 'dma-coherent' entries for each
>   PCIe controller node
> 
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 935 +++++++++++++++++++++++
>  1 file changed, 935 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index 2ae2f11f289c..062417e3ede5 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -998,6 +998,198 @@
>  			status = "okay";
>  		};
>  
> +		p2u_hsio_0: phy@3e00000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e00000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_hsio_1: phy@3e10000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e10000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_hsio_2: phy@3e20000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e20000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_hsio_3: phy@3e30000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e30000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_hsio_4: phy@3e40000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e40000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_hsio_5: phy@3e50000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e50000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_hsio_6: phy@3e60000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e60000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_hsio_7: phy@3e70000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e70000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_nvhs_0: phy@3e90000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03e90000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_nvhs_1: phy@3ea0000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03ea0000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_nvhs_2: phy@3eb0000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03eb0000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_nvhs_3: phy@3ec0000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03ec0000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_nvhs_4: phy@3ed0000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03ed0000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_nvhs_5: phy@3ee0000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03ee0000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_nvhs_6: phy@3ef0000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03ef0000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_nvhs_7: phy@3f00000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f00000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_gbe_0: phy@3f20000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f20000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_gbe_1: phy@3f30000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f30000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_gbe_2: phy@3f40000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f40000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_gbe_3: phy@3f50000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f50000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_gbe_4: phy@3f60000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f60000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_gbe_5: phy@3f70000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f70000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_gbe_6: phy@3f80000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f80000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
> +		p2u_gbe_7: phy@3f90000 {
> +			compatible = "nvidia,tegra234-p2u";
> +			reg = <0x03f90000 0x10000>;
> +			reg-names = "ctl";
> +
> +			#phy-cells = <0>;
> +		};
> +
>  		hsp_aon: hsp@c150000 {
>  			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
>  			reg = <0x0c150000 0x90000>;
> @@ -1384,6 +1576,749 @@
>  		status = "okay";
>  	};
>  
> +	pcie@140a0000 {
> +		compatible = "nvidia,tegra234-pcie";
> +		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4CA>;
> +		reg = <0x00 0x140a0000 0x0 0x00020000>, /* appl registers (128K)      */
> +		      <0x00 0x2a000000 0x0 0x00040000>, /* configuration space (256K) */
> +		      <0x00 0x2a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
> +		      <0x00 0x2a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
> +		reg-names = "appl", "config", "atu_dma", "dbi";
> +
> +		status = "disabled";

Status goes to the end, not somewhere in the middle of properties.


Best regards,
Krzysztof
