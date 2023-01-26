Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FB567D00C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 16:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjAZPYK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 10:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjAZPX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 10:23:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E8929E3A
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 07:23:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3463740wma.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsProH1FLDNaI7BK1VAv3F5PPttHIZQfk9ow0JlU4mM=;
        b=jA1aIZapv4TbXEQf1jQNWsfVqEmo5Ggy7VU6/5IYzjx+EtuQ59Tj2FwVIpgWgacEcN
         LCwMPMl6rAx5SnNztLlQ0yydukfIypegA5hzfANAIDAt4zjjOl4VXGjp6H+NQBg+p0s4
         0rwMJFPYr69/wpjY4lI0n0x5QHv7fxjafyJK2d8He10GFEzZ6eMxBeU8ktgvrRz077wf
         6js8psJPQ362Kx1m/me5QSi/KOzm+JzuEViqpO8g3ub9x4QJRq9x6f+ybC6JP7ahNqFb
         Hp42W+nnlmaGYBm7Ei9uVrUtOBvYeCD7RzDzECYqSFhqsosvRf7Ez71f3t9o4FWFJBHv
         90fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsProH1FLDNaI7BK1VAv3F5PPttHIZQfk9ow0JlU4mM=;
        b=KU+p77bWpuS1xd22iK5yqDqevK4Fr5cpTG4wvResDXSw4TpLxERgInW2o2/1GalZYW
         HKa7FbyzbqwZrLlYqhasI2f7GofyUFPQu2bZ8rmox9MST0mlK4joslSAdzmNx9lD+Ua3
         GTp4O4T2mJJaFIRX7fZ8bjaNo39o2CHzZbTFP+ylZ23nFwK4Z6ccy0hbYFVwP+pT2alK
         /16NrvFnB+QVKtrj+t0Grx1z15fQr1vH+Y049jZDmEc4SFAVNEBNAi4/I2R8tiWy9GrO
         JuWyM+H8qT8ZVpKlObVT/AWFA2ZZJ+swRhkRaIa7mgRumrwyBgpz9/mjHpfF+WNujau2
         3eVA==
X-Gm-Message-State: AFqh2kqX/fbnTJ2WM1xTOAAcC1gQyxMeEg4ppXwYmxRpkV++bgqQTlep
        kGLdZkYfEpl58c0Ig9UoKGFx3g==
X-Google-Smtp-Source: AMrXdXsCXXjCTiIflpPPkWf3wTVp2oNNsqJ+e83FbNBDZM59FqaEVQ9WDFsH7yvv5Ng4srWuycjQFQ==
X-Received: by 2002:a05:600c:310e:b0:3db:fc3:6de4 with SMTP id g14-20020a05600c310e00b003db0fc36de4mr33027373wmo.35.1674746609151;
        Thu, 26 Jan 2023 07:23:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c439300b003cfd4e6400csm1723340wmn.19.2023.01.26.07.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:23:28 -0800 (PST)
Message-ID: <6a54a51b-cf1a-c601-275f-00f825fcec5d@linaro.org>
Date:   Thu, 26 Jan 2023 16:23:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 5/8] PCI: rockchip: Added dtsi entry for PCIe endpoint
 controller
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, wenrui.li@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
 <20230126135049.708524-6-rick.wertenbroek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126135049.708524-6-rick.wertenbroek@gmail.com>
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

On 26/01/2023 14:50, Rick Wertenbroek wrote:
> Added missing PCIe endpoint controller entry in the device tree. This
> entry is documented in :
> Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt

There is no such file

> The status is disabled by default, so it will not be loaded unless
> explicitly chosen to.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 9d5b0e8c9..5f7251118 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -265,6 +265,31 @@ pcie0_intc: interrupt-controller {
>  		};
>  	};
>  
> +	pcie0_ep: pcie-ep@f8000000 {
> +		compatible = "rockchip,rk3399-pcie-ep";

reg is usually second property...
> +		#address-cells = <3>;
> +		#size-cells = <2>;
Best regards,
Krzysztof

