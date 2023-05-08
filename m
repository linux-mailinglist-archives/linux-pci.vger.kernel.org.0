Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3072C6FA020
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjEHGtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 02:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjEHGto (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 02:49:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D608D30E1
        for <linux-pci@vger.kernel.org>; Sun,  7 May 2023 23:49:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso7535066a12.2
        for <linux-pci@vger.kernel.org>; Sun, 07 May 2023 23:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683528581; x=1686120581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owglAIa5kuQUWU8LYudk3cpBwsL5QOQS+UaPIohU72s=;
        b=juqBhIy3mhApMy45yj/452aJRsvKSFWXCaTisxLtLGzdkVQy2g8YtKV97x46AMQlDB
         tOjjJV81f+HnSjTItl6rSfo2/WJq1oj/2JuF5HEUK6RsXMzblJRdrQOH/QPMEWVvijoG
         T8FnD/H35XmKkieclMTkJilDiGma6tACTf5KpOjxpTrf+DnykodPhhTPuxah0w/b9f5s
         6rnCuTjqnB+QIPA8qXIqfyPmMVZ9taEIR4BvXq60iG/RIqeCk/MO2Va2XPcxiVV9UM5h
         lDh8SpRXIOulJ8EQMt6pnLTbOkbN0Rn8w9ZiuF4quIT+ENfLQu40yiJ+TV+SYknK6rI6
         Xu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683528581; x=1686120581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owglAIa5kuQUWU8LYudk3cpBwsL5QOQS+UaPIohU72s=;
        b=KpJKLRGc+Voc1FQUMvWMZfgJKwHrF5PQwsaYvJH+Ej87lb7JUG+ZsVk+caf8s6L3Ku
         QWhtWG3d0/rhJxuvT7btvt0r9adaKR3jfdoYJA1EbI7IgoCrlIIHm2yPO5HWfor2aY7i
         Wh00ZPJq+VxEFRkTO4lU2ZzGRYwu7eNUtMljh+SgoNxjEpOOqwM1vvDdX2qN1PKnw4V/
         u+T627uJ4Yp7s5siCUeqDG6Ng2tv20p3oQdGWzGdmq2BFuQbwNqudow0PFdMGaUNXy+i
         3lRcKSfaxtfWeDugD31bvG570wMm3i3SH72ncQ6roXjOcQskV8bE6DwRPO/Fz5CxZeEi
         4pUg==
X-Gm-Message-State: AC+VfDwgacl9xufLlSbaIl9Nmc/Z4P2Srs8kzITwajwqE4E5AsDWp57F
        KC2NNax1XcvnpNudPsHAQaZ6dQ==
X-Google-Smtp-Source: ACHHUZ5RjRP/6P+ztDo5LfTWm2+d+eo6dAfjRkQUYH7xhjnhTgUHFVJmwZvj6Z4gYSXrbJD44porzg==
X-Received: by 2002:a17:907:2da9:b0:94f:247d:44d2 with SMTP id gt41-20020a1709072da900b0094f247d44d2mr8728072ejc.5.1683528581386;
        Sun, 07 May 2023 23:49:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz19-20020a17090775f300b00965c6c63ea3sm4549615ejc.35.2023.05.07.23.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 23:49:40 -0700 (PDT)
Message-ID: <4853c769-e1ec-f2e7-aaf7-5b67a2cd6b5f@linaro.org>
Date:   Mon, 8 May 2023 08:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RESEND v10 1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe
 schema
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1676441915-1394-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/02/2023 07:18, Richard Zhu wrote:
> Restruct i.MX PCIe schema, derive the common properties, thus they can
> be shared by both the RC and Endpoint schema.
> 
> Update the description of fsl,imx6q-pcie.yaml, and move the EP mode
> compatible to fsl,imx6q-pcie-ep.yaml.
> 
> Add support for i.MX8M PCIe Endpoint modes, and update the MAINTAINER
> accordingly.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   | 279 ++++++++++++++++++
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  85 ++++++
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 240 +--------------
>  MAINTAINERS                                   |   2 +
>  4 files changed, 372 insertions(+), 234 deletions(-)

This keeps reporting errors since a month, so I would assume author
would fix his patch... Now failures are in Linus' v6.4-rc1.

Best regards,
Krzysztof

