Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8046FA0F5
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 09:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjEHH0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 03:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjEHH0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 03:26:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F559E9
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 00:26:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-956ff2399c9so782989366b.3
        for <linux-pci@vger.kernel.org>; Mon, 08 May 2023 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683530779; x=1686122779;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9aHGA+jO7cMEgzbNb3ypVNL0H6FHl05IdAj+fSVKig=;
        b=gTjX4u3IpA4pn47Tdd0h4eFjIX53iIECyoirltT1FldZgqT9Amyye1kXpS9Zs76IKs
         h0fAbxnLYFmg6Qkto2ypZKr122EbJ7V3EvAURqGjQ85fpRn8l+jeOuDItIfV5Ce8R/N9
         OKfBnJzIOZyzMrC/9bVT9ImCd2fF5W4tluXLjkhEr93S+oj6RdMG20qlRYGzXD0sfcNb
         51D6LQM30LRTdDky7+rtcy7IX0PS8W5wXpEKlBa2tpiWNgREiJtkcVvPMGIDgmNgHuSV
         tuGz3uUjXUutlmb+HAloiJm9A/VHs/hokRecEX40nysNSzSf4i7h34DQyLrPNonAYPHk
         awNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683530779; x=1686122779;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9aHGA+jO7cMEgzbNb3ypVNL0H6FHl05IdAj+fSVKig=;
        b=an72zvOaqCyTyea0D40RX1hcVCmakFFveZzWIx1Lf3QAoY8je5uhT91K1kzlvt8YC7
         Of2b4z+b/pKAPzSdnVv0sfldXqxYRvMecQWI02AhgantcyZxRGyMExX5G4MfRsmUN4rE
         vc9FerJGJl+E/fjaXslb1xFv6qy1omH/lWowyr61vJC7y1gl8p9oXxQs2JOsxX+iom7M
         o7FgKfMkqzDIYiwxYcVjihRZ+w4OZ1KNFOG5ivLJV9yrFK9+ZylwkKJ17aTB9PeSMQrv
         W/Qhm3r0l94+9gEWjLbd1ZckQ8TB09k+Jsmkt37UsRJG9kzuxYe6AAN1TDYXj3Ln5yJr
         zfPQ==
X-Gm-Message-State: AC+VfDwdfmAtQTZ4AkQygFKuvNfm2bpQK+Um85N+kpaLhRIjb1yA4UzO
        pT4I+hwpSGQXU+hebwjeaWH8qWpE1OwhSYBQRXdAug==
X-Google-Smtp-Source: ACHHUZ6q/QTYajv59lM3eSj37SXuFdhTQp1p9Tge8vM1azglbIhH2IMrrn8qrDEeOEisL+Oe9cfnqg==
X-Received: by 2002:a17:906:ef0a:b0:959:bbda:fa51 with SMTP id f10-20020a170906ef0a00b00959bbdafa51mr6433901ejs.41.1683530779014;
        Mon, 08 May 2023 00:26:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id bk4-20020a170906b0c400b009659ad1072fsm4661281ejb.113.2023.05.08.00.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:26:18 -0700 (PDT)
Message-ID: <8c7c69c1-33de-8634-4482-50f5dfcbf35d@linaro.org>
Date:   Mon, 8 May 2023 09:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RESEND v10 1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe
 schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, l.stach@pengutronix.de,
        shawnguo@kernel.org, lorenzo.pieralisi@arm.com, peng.fan@nxp.com,
        marex@denx.de, marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1676441915-1394-1-git-send-email-hongxing.zhu@nxp.com>
 <1676441915-1394-2-git-send-email-hongxing.zhu@nxp.com>
 <4853c769-e1ec-f2e7-aaf7-5b67a2cd6b5f@linaro.org>
In-Reply-To: <4853c769-e1ec-f2e7-aaf7-5b67a2cd6b5f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/05/2023 08:49, Krzysztof Kozlowski wrote:
> On 15/02/2023 07:18, Richard Zhu wrote:
>> Restruct i.MX PCIe schema, derive the common properties, thus they can
>> be shared by both the RC and Endpoint schema.
>>
>> Update the description of fsl,imx6q-pcie.yaml, and move the EP mode
>> compatible to fsl,imx6q-pcie-ep.yaml.
>>
>> Add support for i.MX8M PCIe Endpoint modes, and update the MAINTAINER
>> accordingly.
>>
>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   | 279 ++++++++++++++++++
>>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  85 ++++++
>>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 240 +--------------
>>  MAINTAINERS                                   |   2 +
>>  4 files changed, 372 insertions(+), 234 deletions(-)
> 
> This keeps reporting errors since a month, so I would assume author
> would fix his patch... Now failures are in Linus' v6.4-rc1.

Sent a fix:

https://lore.kernel.org/all/20230508071837.68552-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

