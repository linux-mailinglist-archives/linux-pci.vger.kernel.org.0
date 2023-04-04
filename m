Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33076D5B28
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjDDIpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 04:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjDDIpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 04:45:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6DEA4
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 01:45:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er13so86490523edb.9
        for <linux-pci@vger.kernel.org>; Tue, 04 Apr 2023 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680597914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFniWraH9Zx9AU/nIcDS2ZhpqD+XkT7RdXcaMNk7s1Q=;
        b=NDZD77ERGU54AP9UX0o03dGSoBhWlpLKC1F1q4/spgOo6ufcp1HxDNMlcs9ACQsg5g
         if12rdV9irOBZhnU32KKzvVzlnakoLV2M8HJFMZHycBL2tyxRRJglIdqhzJi0BeKuBr7
         3o5j7aFQsVplZuwdxXisbDR4gD8sGyzUJfXM1xJV0bqsYok3UsukvOyR6pS9U0VG2alJ
         +k7+G5jtRkwQL2dWwZ8ukA/TvGors5PwA8qn0S5gLvnl0yNHMz2HzvH8l84W+ZF0t2Id
         1PjxnFzuMk48SnEshbFf5lEHfBUCmrcXWupGnPVpbAT25YbnSx1jCkcArKyqhZn12kj1
         zsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680597914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFniWraH9Zx9AU/nIcDS2ZhpqD+XkT7RdXcaMNk7s1Q=;
        b=q1ljnur6g2UgwHS8l7SUnwKJOea/LCRGnjegNX/c7CNEW8FiaXS/zrix7wYJAqvjk2
         RXue4XTjV2IznCqbCwJNc55zdN1UxyCmTcLZIlH5Vt5kVGqAB5pzM2TXyQHOMHkfV3O1
         Yb3ulgBBq6qU+sd6X48TzPRgwsxEJCdUpoqbyF/tpx0lPyujppFFbfz4M/m9On8EFtj0
         wubdNhk2OiFV5OmX1sW4kgqqHBpOHW/0/DvPh7PU/r2aoKLoNCzIC1azKnWHeZX79j7J
         ata/RnebGXadm+SNPF/VQLsYzXjWzC7Ykbul8FoxxBrPLxmPGBOJra3uu7RIwA036KMO
         Slww==
X-Gm-Message-State: AAQBX9fa5MuJMxxFIfqfaVyHcLoHT5xaBhJYOODKS2/OfACPQQ7b3zPq
        oVAaIm6/VzefHAl/xPd2tL5EOA==
X-Google-Smtp-Source: AKy350Ys/jY0eQu2PLhBd/9LlS3jfRprWxeYmK085EYvR7AsZb+OPy/s/HlCkHQWIcfQXOxPTxsZ0A==
X-Received: by 2002:aa7:d618:0:b0:4af:6c5e:225c with SMTP id c24-20020aa7d618000000b004af6c5e225cmr1829126edr.33.1680597914216;
        Tue, 04 Apr 2023 01:45:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id r19-20020a50c013000000b004fd29e87535sm5561237edb.14.2023.04.04.01.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 01:45:13 -0700 (PDT)
Message-ID: <d9afc07f-0346-1fe7-907c-261e4c6f92cd@linaro.org>
Date:   Tue, 4 Apr 2023 10:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/11] dt-bindings: PCI: Update the RK3399 example to a
 valid one
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     damien.lemoal@opensource.wdc.com, xxm@rock-chips.com,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
 <20230404082426.3880812-7-rick.wertenbroek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230404082426.3880812-7-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/04/2023 10:24, Rick Wertenbroek wrote:
> Update the example in the documentation a valid example.
> The default max-outbound-regions is 32 but the example showed 16.

This is not reason to be invalid. It is perfectly fine to change default
values to desired ones. What is not actually obvious is to change some
value to a default one, instead of removing it...

> Address for mem-base was invalid. Added pinctrl.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml  | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> index 88386a6d7011..0c67e96096eb 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> @@ -47,14 +47,15 @@ examples:
>  
>          pcie-ep@f8000000 {
>              compatible = "rockchip,rk3399-pcie-ep";
> -            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
> -            reg-names = "apb-base", "mem-base";

Reg (and reg-names) is usually second property, why moving it? What is
incorrect in the placement?

> +            rockchip,max-outbound-regions = <32>;
>              clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
>                <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
>              clock-names = "aclk", "aclk-perf",
>                      "hclk", "pm";
>              max-functions = /bits/ 8 <8>;
>              num-lanes = <4>;
> +            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
> +            reg-names = "apb-base", "mem-base";
>              resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
>                <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
>                <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
> @@ -62,7 +63,8 @@ examples:
>                      "pm", "pclk", "aclk";
>              phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
>              phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
> -            rockchip,max-outbound-regions = <16>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pcie_clkreqnb_cpm>;
>          };
>      };
>  ...

Best regards,
Krzysztof

