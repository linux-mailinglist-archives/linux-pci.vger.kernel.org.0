Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC446DC857
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDJPV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDJPV1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 11:21:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95725585
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2023 08:21:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j17so3588281ejs.5
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2023 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681140084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKtT8o0nbJmVFZqD5xdbccYQdI3DXqK9lUo8ZKY2dTM=;
        b=slRgyI+52iHvXahH4qL+XTlfEV2EYvwSLocgDrob8uaIhQZ3yakolVzAMrfa/SVTr5
         zw6N5MS3nEXHySmGbN8az93HXCIcM847M0OeJhKETsfurQfLrNjTE8N8EnW4371zjGlg
         GJVq2n0bi+ECEXB+yycG1nvKDHQ8Vvcq3CIx06lfAMuypio7bmFfEjsBI1De4alSCTyo
         R6wsBrFSro1UVghATZTWEumTkEy7hmL1riDtURZBUQQZNHtOJGGDoCYM459p2uSZfr9o
         T9XhhkBJYEj/ke5x/eSG9pp59xwTVmG2meoAfyri3bvyuD5wQlyxiC6zy0hV2HltnP7j
         yR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKtT8o0nbJmVFZqD5xdbccYQdI3DXqK9lUo8ZKY2dTM=;
        b=BeyDRfJoi4BuSZnThWkt3Frsh9xzffTfqbd9EOX0YxXMTPVCItXQ7wMNKhT7AAucp4
         KlGmEn9yZoI3BokU6oo5LqGH4DXZ+vYgQ5c/46Jm+Hh8+jBDOHfWe2tO0a34PWZFsWbT
         Ij2GE1+ZkZ5hPIGXpGfz7iP/ZH6TXY1NyLgTgwur9G7HMAJWgvVYQRZU8tUTG4ZaiyDs
         Yis86C82uwAGfQw3GHvaBypkk/pvIwSoKZ8+A58/ustlwV/903jU+xat4wJpmfRg7wSQ
         Zj8QW5w8ZGjK9Xq/yfEvrTjK9MQA5pZOK1uZTvE0YYVE5AiUvI0UUCaqeRnyn7DxVkD8
         Gxbw==
X-Gm-Message-State: AAQBX9dXdV/Z5bCLsb13i4/SVd7FwVFaD7/BXsouSnxRtwVssfPt5ETH
        7rx6/xcaGvERMcUPnRy9787P9w==
X-Google-Smtp-Source: AKy350abdMkfY6LcbSY98RHE9h5BYQT2H/JkkaLfVPvhxnTdQpqI7LYU2qzjeoqCvj/JaN79xyfXJg==
X-Received: by 2002:a17:906:f0da:b0:94a:9ae2:1642 with SMTP id dk26-20020a170906f0da00b0094a9ae21642mr2200834ejb.46.1681140084267;
        Mon, 10 Apr 2023 08:21:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eacd:ffa4:1df7:3870? ([2a02:810d:15c0:828:eacd:ffa4:1df7:3870])
        by smtp.gmail.com with ESMTPSA id wv1-20020a170907080100b0094c4dd34a0asm412826ejb.114.2023.04.10.08.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:21:23 -0700 (PDT)
Message-ID: <f37964c6-0a75-2900-e6a7-282f5366696c@linaro.org>
Date:   Mon, 10 Apr 2023 17:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-binding: pci: add JH7110 PCIe dt-binding
 documents.
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
 <20230406111142.74410-2-minda.chen@starfivetech.com>
 <38bc48bf-7d8c-8ddd-861f-3b7f3d2edce6@linaro.org>
 <430f1eb0-e348-8a4e-b501-16b8c3b2494f@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <430f1eb0-e348-8a4e-b501-16b8c3b2494f@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/04/2023 11:05, Minda Chen wrote:
>>> +
>>> +  starfive,stg-syscon:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    items:
>>> +      items:
>>> +        - description: phandle to System Register Controller stg_syscon node.
>>> +        - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>>> +        - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>>> +        - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>>> +        - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>>> +    description:
>>> +      The phandle to System Register Controller syscon node and the offset
>>> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters offset
>>> +      for PCIe.
>>> +
>>> +  pwren-gpios:
>>> +    description: Should specify the GPIO for controlling the PCI bus device power on.
>>
>> What are these? Different than defined in gpio-consumer-common?
>>
> power gpio board level configuration. It it not a requried property

What is "board level configuration"? Again - is it different than
powerdown-gpios from gpio-consumer-common.yaml?



Best regards,
Krzysztof

