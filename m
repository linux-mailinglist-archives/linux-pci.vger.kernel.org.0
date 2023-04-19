Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB436E8248
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 22:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjDSUBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 16:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSUBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 16:01:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D252717
        for <linux-pci@vger.kernel.org>; Wed, 19 Apr 2023 13:01:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a5so1211916ejb.6
        for <linux-pci@vger.kernel.org>; Wed, 19 Apr 2023 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681934487; x=1684526487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uR1sg37u4yLqstygNFNs5VOG/aJjyMp9p6EHpt4xrlU=;
        b=t8UO6709ej90L404wmD+d6lwQDgZJ3lnbmCFTtcjX2lYbOOp6jCA8/PNdrpn+g+Dz5
         /ufKN1PjfmQNz8C5jLDjv7sCFtpttLjH8Isk1T90rZGK2qeJquSTpMuT/qCxfmU8V5oP
         wbrnjdvQ+Jq8Zo4PBL172EiONjNMF9HbAxCdqXkrEdMEsAZN77ahqq3iQa0J2jBffHfu
         D5rloRoTmMyjdkp0dBPkN50iwhKXYLlnJW+5uXikYZwSxCla0reblEDRbmdsepE9w0GM
         P9KWA5G0Y4vPtQVAcrqNRGu4mU2zmmqjkFNqioPaovUJnb4YEoPDJJdaMtMfY/HA+DeK
         zYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681934487; x=1684526487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uR1sg37u4yLqstygNFNs5VOG/aJjyMp9p6EHpt4xrlU=;
        b=ahM32rFJ6oDQgw/evoPzzUbVOXn+g+rm9IVYPULSn2ATFGUp4MKwC9NKa8p8DwVSA7
         1jWaN21SMqlyWKwyiwRu+ZKFKr0hS5YnbjnR1nm728IqKjEOe1yQl4wRi3+rYluoCMOe
         bMEyE/YgbEHZPGds+Z8xxrOFAyyXzrnD8tZiIJJtsxtew21kHuG7p0qBdNAKxu99TOu3
         3RW7yg8LqwBPPhd5p+x4Pqc7//d6oNo/Ie8ZAeKwfdtE5FW3ULPP1dKnRiS3NP7R+DI0
         NWqQfemHS7xxnC9HqxnxCcMmSP5AjoEL/w8rmUffdq0SJ+QHv7IHPKaiUMTnAMnHE+t1
         XeZg==
X-Gm-Message-State: AAQBX9c158tF2BF5wZ3LuxSNUxO0m+GazytfcVwLrEr8/lfwDCeyPP3W
        E2quhR50sq23iEyX/t6Wy0H1ug==
X-Google-Smtp-Source: AKy350Ymx4qFw5Wb5XaUf2ClN/hYaKBoxle02tqUxYWB3N1hLco5TfUFJFyOd9eaddTXOetVPigRsg==
X-Received: by 2002:a17:906:7006:b0:94a:44bc:31e7 with SMTP id n6-20020a170906700600b0094a44bc31e7mr17921518ejj.60.1681934487403;
        Wed, 19 Apr 2023 13:01:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:976c:1d6c:6ed0:8935? ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090606cf00b0095336e8e012sm1922174ejb.176.2023.04.19.13.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 13:01:26 -0700 (PDT)
Message-ID: <172c46b7-256e-b09d-3940-880fa8989b49@linaro.org>
Date:   Wed, 19 Apr 2023 22:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 06/11] dt-bindings: PCI: Update the RK3399 example to a
 valid one
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, dlemoal@kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Brian Norris <briannorris@chromium.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
 <20230418074700.1083505-7-rick.wertenbroek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418074700.1083505-7-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/04/2023 09:46, Rick Wertenbroek wrote:
> Update the example in the documentation to a valid example.
> Address for mem-base was invalid, it pointed to address
> 0x8000'0000 which is the upper region of the DDR which
> is not necessarily populated depending on the board.
> This address should point to the base of the memory
> window region of the controller which is 0xfa00'0000.
> Add missing pinctrl.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> index 88386a6d7011..6b62f6f58efe 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> @@ -47,7 +47,7 @@ examples:
>  
>          pcie-ep@f8000000 {
>              compatible = "rockchip,rk3399-pcie-ep";
> -            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
> +            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
>              reg-names = "apb-base", "mem-base";
>              clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
>                <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
> @@ -63,6 +63,8 @@ examples:
>              phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
>              phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
>              rockchip,max-outbound-regions = <16>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pcie_clkreqnb_cpm>;

This is just example of the binding, you do not need to fill all
unrelated (generic) properties like pinctrl.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

