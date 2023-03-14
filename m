Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0344B6B9170
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCNLTO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 07:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjCNLS4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 07:18:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB3B9
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 04:18:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o12so60485144edb.9
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678792686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTLw347ZTk76CB3YCjWqXtSW/kYt7O7yegt9D9Y6FXA=;
        b=DfbXKcyFf2lJtqM9kxnIwQgXX5YHPtmETobmmHOm3Xih8xuS22CBz9vhum+UjfNGnT
         AX/sKetrvq19eNac6gFFkYcUDW6YBAVFgQXHp0yZuDLZpSYPkIMzfI0FWzowlfHnt+Vg
         37NzIbYf2dKi907JOSf7p5gsNRdYl9kzMZYTJfbO8Hhm9o3V41bI153d7ILKIqjA6vue
         qJxEVrZnAfIBudOJryrUnv2DX36HSLb0kv7MZFCynatG/tp0k9WpQp0YWQv6HyLnadxU
         DzejyEjiM9TQ/0IOkDw4drPhRZBZ+wH+gSAyM8Q7/yWZ1UYuvNE0o0xX07pvvqoFd1Cq
         1DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTLw347ZTk76CB3YCjWqXtSW/kYt7O7yegt9D9Y6FXA=;
        b=ew993MWoOiv10pHZVCS5CYaRItAsFH/i93DqBdr6qXzxHL0Mp+6uBAJ0LjSxEApq2i
         dGloDVCl5JpFrrJHujNDdik5pPa4z0YMkFInY2qX4SbnNpB/fyBkEI3jhGEMfxVYt9Hw
         7OCANky0G6lP2ALTVXms2ol4BHASi5aPlViru/+gt9+HGf1I25N3S+uINm3a7nddDkjy
         tAR0vaaCEBTZlgcHQy4B8i0PDgBJKjboO6aDlLGMUoWUmLZ8fVe8a9MuMyiaFWxEXHIP
         qAPFIZywvKzL47lkwrCTmp+Hi+PRj24mwFoRREU7claLw+F+YEdRkJlsJdAWhA7nBfmW
         ykoQ==
X-Gm-Message-State: AO0yUKVBExb3zW4K4+oL5P28Bydth0U2dOPi5eig9mlf39uaZ/kEA9gM
        mes62EwTb7Gci+odceq5AVO2ew==
X-Google-Smtp-Source: AK7set9AeqSbWbMpQSeHyDHFZ0ow4SZlOYcmpT9uXkJZMQnegdxX9KuOMQUBc32BeUqDoZUsjzpCaQ==
X-Received: by 2002:a17:907:a0e:b0:895:58be:957 with SMTP id bb14-20020a1709070a0e00b0089558be0957mr2625143ejc.2.1678792686070;
        Tue, 14 Mar 2023 04:18:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id xa13-20020a170907b9cd00b0091ec885e016sm1016273ejc.54.2023.03.14.04.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:18:05 -0700 (PDT)
Message-ID: <4ca61aac-a901-1bfa-6cf4-8c2917621667@linaro.org>
Date:   Tue, 14 Mar 2023 12:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] dt-bindings: PCI: dwc: Add rk3588 compatible line
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com
References: <20230313153953.422375-1-lucas.tanure@collabora.com>
 <20230313153953.422375-2-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313153953.422375-2-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/03/2023 16:39, Lucas Tanure wrote:
> RK3588 uses the same driver as RK3568

Subject: drop line

Commit msg: drop driver and focus on hardware. Missing full stop.

> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 2be72ae1169f..91aa9070ee31 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -23,6 +23,7 @@ properties:
>    compatible:
>      items:
>        - const: rockchip,rk3568-pcie
> +      - const: rockchip,rk3588-pcie

According to your driver change, these are compatible, so maybe this
should be expressed in the bindings?

Best regards,
Krzysztof

