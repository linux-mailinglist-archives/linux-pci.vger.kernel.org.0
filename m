Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB598788370
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjHYJWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbjHYJVk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:21:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3591FD5
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 02:21:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so1107060a12.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692955288; x=1693560088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZgZaMT5PxJw7tH308zexA8qRHLlWqjM6kGNr72Z26s=;
        b=jgOPuKgBX8LsnrVBpxagR7rRtJfRP/bebUcJD3vsbi9xMm9l58gC5cw0r9Rwle91RV
         Wja0F4kONox6Ip3jRnT9XV1l0mvTExirg4luRv4XJDQm2JvV9/i18ZZPEhs3fb8wp/EA
         Wxi/KVB6lDqtjacSQIuEtNyipWhI37UPSYngi9L0IhEotJPJIBsZrQPxd+O2kFkqjPap
         Oyj83NsoppXK2usstyN2s52q7Xr8jf836fC2pwmfwgYphLNfckGneihT7c9/Z5C1tu3I
         pJV+fMDodmM9NYPDGckACE9KsEhilTtRo1YK5WuEF22EomDIDkAmJ9enp9I9A6eEpXa/
         D9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692955288; x=1693560088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZgZaMT5PxJw7tH308zexA8qRHLlWqjM6kGNr72Z26s=;
        b=fdEqupEveY/iqBNYX96n24TvUWVwCzjG6jbV3VEG4DBG//4E9+pzuNBaTnfK43KYD6
         2HY5cyBbsGdB8QWDFBAxQS/nM3haleavDl9Ri12UO3vjpAgt6HK4uSjcnC/ni4Njv4rZ
         62bbVBCTDClmDjDxTRKFsb4pgu4n1XZ4GUx8s/DNrmBzVnU5zh5sxHj9yWJjVtT+2klV
         sGicbSWlu5JZKNoA7ebrn70HpA6UxONvAaejhkY2a3y6oRe0SAuiuDNf4tIGBso4tiTD
         3EYSd9hSwpQJpo7PND9BveeJtFnQCQjYYkenKYrSCNWPtsWDHB9LqODw/HuHYOtDmrrC
         kW1Q==
X-Gm-Message-State: AOJu0Ywfa3oHWrC6vWvAWCYFbxoY5mxcN3D4vbdA7g6QAIe8xZCZGkAj
        NAUHejObY/qQPtoKKukdQcY1jg==
X-Google-Smtp-Source: AGHT+IEo+aS/DfSwbspGBPf6zJxemZO9RG5G7PRer+UtxBoyL3dwDOJaiFVu4h7L5dLcZvA/9TmNCQ==
X-Received: by 2002:a17:906:76cf:b0:9a1:b98a:c723 with SMTP id q15-20020a17090676cf00b009a1b98ac723mr9218632ejn.4.1692955287927;
        Fri, 25 Aug 2023 02:21:27 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id ck16-20020a170906c45000b00992b8d56f3asm738608ejb.105.2023.08.25.02.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 02:21:27 -0700 (PDT)
Message-ID: <f04b6606-6ca9-28d1-6a10-1e543a5d5fb7@linaro.org>
Date:   Fri, 25 Aug 2023 11:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 09/11] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
To:     Minda Chen <minda.chen@starfivetech.com>,
        Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Kevin Xie <kevin.xie@starfivetech.com>,
        linux-riscv@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84s?= =?UTF-8?Q?ki?= <kw@linux.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        devicetree@vger.kernel.org
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-10-minda.chen@starfivetech.com>
 <169228685644.1140409.12427674208274594176.robh@kernel.org>
 <5450650c-3750-a0ee-72a1-bfa0a4545e0a@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5450650c-3750-a0ee-72a1-bfa0a4545e0a@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/08/2023 11:06, Minda Chen wrote:
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
> Hi Rob
> Thanks. 
> I see other PCIe maintainer have not reviewed PCIe driver codes(or no coments).
> Could you help to review PCIe driver codes patches? (I just commit new version 4). Thanks.

Please relax, and help out by reviewing other patches on the mailing
lists in order to relieve the burden of maintainers and move your
patches higher up the list.

Best regards,
Krzysztof

