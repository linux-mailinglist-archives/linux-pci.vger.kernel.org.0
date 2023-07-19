Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98675936E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGSKxD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGSKxC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:53:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A77123
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 03:53:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-521650a7603so7369062a12.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689763979; x=1692355979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSY7y/1+6yYaMus6riUbfDhWCuuda/0kYuX0FoEcddU=;
        b=tg85zqDx6jj/Z3CoCLI5djTDjzQF9aAMa3YgvXDnU0pyHXw7rcuzBpIwA8yBdLN9sY
         Ph7R3+uuSvOImNSnY1NHoDAUTAI9eZIAa8K89C7emG9iKk/bPn/lnYIzYHtztZG4BHUZ
         82KSkhPwiqrlrW4m8Za04gw0wk89u/ON6TvOn1LTgo/vBT5OqPfteSB6j2KYSKFlB1gQ
         21T9jvMOgpYSRS+qKZSd7HgIOJPfBrPq2TJB8YnexUYD+Oy4n0kWA2RUqxWv+mk7OLZh
         cqV1ZhU0aoD1jPlxkUUCDZb00zf7OU9fnId5WENJqms4je4A/wNIjwLwJm/K8xh03b9i
         JOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689763979; x=1692355979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSY7y/1+6yYaMus6riUbfDhWCuuda/0kYuX0FoEcddU=;
        b=GdTPSEsIi65b3LtnR9N+oCDFsedYZYGij0OoG89GftawyZyyk6KPatwAoeg2KHDheL
         WyPjPDPFvXOPdb1CHjSXKnud2BxY9q7+CFotYn4sMOsopgxBVt8pBjP8XKIlkAY2eCx/
         884Mce2XkN450fHCIfWqhycFTuXRHz1TRjwoDbiyRbxC1rF9qe+79KuifTC9CVu68UTW
         9xLfD+Wfinou0ujXb7wV7aLjuEaVabfklj26tM5g2UUlVqDYyvMjDBzDS71B9zeytBA3
         i4caMbPlwzwW93rONBIdde4Tv3AbvTHQFSdbRh7h8dOx0v/FA92kfPiVqc7kmwcrSN3a
         j+Kw==
X-Gm-Message-State: ABy/qLbfrltDftS/BRkYejYdS8D6Mcfp8Z/r21CQrE4bk/iPUg84ID9H
        CVtux9FruiS5QXIj2z6L6cDZ2w==
X-Google-Smtp-Source: APBJJlEqIKUOT6GxeKOCN3apXOlhXrfPpHxzoJyFUMl+xVLbqY0+PPhlyCxzpRR+/9kMh+ghLV4jQg==
X-Received: by 2002:aa7:cfd8:0:b0:51d:e30b:f33a with SMTP id r24-20020aa7cfd8000000b0051de30bf33amr2089692edy.34.1689763978715;
        Wed, 19 Jul 2023 03:52:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7da12000000b0051d9de03516sm2570472eds.52.2023.07.19.03.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:52:58 -0700 (PDT)
Message-ID: <c1dea7c8-2bc4-a113-0d40-098228fe3860@linaro.org>
Date:   Wed, 19 Jul 2023 12:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/9] dt-bindings: PCI: Add PLDA XpressRICH PCIe host
 common properties
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-2-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719102057.22329-2-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/07/2023 12:20, Minda Chen wrote:
> Add PLDA XpressRICH PCIe host common properties dt-binding doc.
> Microchip PolarFire PCIe host using PLDA IP.
> Extract properties from Microchip PolarFire PCIe host.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pci/plda,xpressrich-pcie-common.yaml      | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml

How is it related with existing plda,xpressrich3-axi?

> 
> diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
> new file mode 100644
> index 000000000000..3627a846c5d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/plda,xpressrich-pcie-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PLDA XpressRICH PCIe host common properties
> +
> +maintainers:
> +  - Daire McNamara <daire.mcnamara@microchip.com>
> +  - Minda Chen <minda.chen@starfivetech.com>
> +
> +description:
> +  Generic PLDA XpressRICH PCIe host common properties.
> +
> +select: false

This should not be needed.

> +
> +properties:
> +  reg:
> +    description:
> +      At least host IP register set and configuration space are

"At least" does not fit here since you do not allow anything else.

> +      required for normal controller work.
> +    maxItems: 2
> +
> +  reg-names:
> +    oneOf:
> +      - items:
> +          - const: cfg
> +          - const: apb
> +      - items:
> +          - const: host
> +          - const: cfg

Maybe keep similar order, so cfg followed by host?

Best regards,
Krzysztof

