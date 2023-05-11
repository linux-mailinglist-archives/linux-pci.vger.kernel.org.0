Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA26FEB05
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 07:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjEKFDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 01:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjEKFDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 01:03:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44E40EE
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 22:03:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-956ff2399c9so1550100566b.3
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 22:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683781416; x=1686373416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sEbxgolIUmjMoQJHrzBiAW9JiPuzPau1FkgVjAr2Lk=;
        b=JHUlyNtBDmJi7ZyhaZ+2XmG6NGuCZprqL5U1uevdReL5xyrr6B2xPEfWkkm0enqWj6
         aah0WBF6NxthDPziJHudJfQbdx1qq6KYmOQT3fWX3dHgW8FjP9AppC0CvV6SpY586ne5
         jr6ba2ncS283K9ja6T9KprKC5uaDfGYwAbRYtjz4GIzJgSXwCQVSx6gKfY9Y9C2hoqDd
         KvYFL3hbq1V0nQ6PbjoeZrpCDqH3r5B1YQ09/tB0wrjg3Tz9iP2SvjON7nTVzmCeTKm8
         KmsxIi9K6vivhMHO7hAb8S2fEwLkJj5vi83anB3n28ov1HZBdQDJt1XepOZq9wL/3zsB
         KCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683781416; x=1686373416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sEbxgolIUmjMoQJHrzBiAW9JiPuzPau1FkgVjAr2Lk=;
        b=QY06SWCwkZMzwyiU9ohRZesjrWOkR1db8TC4VFl6vkKtUQmGGgA8vKO4VvYrrbyJB8
         PpxlrteriRUcugcRA5f3LHI4xgQ6YbetkrEck6bE3YpNYr9BGBhjUgbEK0y3f5Ru2Zfz
         Z3Moa6IUGQWqOGAnTCk8SUV0Khz5Ndrjv8PS3u0BIy2tu6+9c0ROHdQVdU0FeVXZpJ82
         KjYDsLC+K5jj2OoZvBUh2oqeqDL1AArsX8LreiHRbfOLTtVZW0xnj0znjvIXgyiUZNmO
         WTPzbyV2IOYbNodFfmdlkt/GdsJz7jHE5mujtX8tJAwp/HbAZ8vugnkc6SLkRAPqRDB9
         F41Q==
X-Gm-Message-State: AC+VfDzY9NWbHC1N4FU7So5j5bpHHzJdpfhKqxHnjvBwvdnFoSWto3lS
        PccnLday+/fV6RC/SgoDA+oMyw==
X-Google-Smtp-Source: ACHHUZ6hUvyAqt6ZB1PqKCv8CJoeSHW7WOek/O5ToLGtQQz1dGpJoODgI5zUJ2Sgkiv+nLrL0GwcZA==
X-Received: by 2002:a17:907:3f88:b0:96a:6e42:7123 with SMTP id hr8-20020a1709073f8800b0096a6e427123mr351552ejc.36.1683781416396;
        Wed, 10 May 2023 22:03:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a01e:5c6:be3:7baa? ([2a02:810d:15c0:828:a01e:5c6:be3:7baa])
        by smtp.gmail.com with ESMTPSA id lf23-20020a170906ae5700b0094ee700d8e4sm3435867ejb.44.2023.05.10.22.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 22:03:35 -0700 (PDT)
Message-ID: <09988b0a-91cc-1253-2a5a-10922699b4d0@linaro.org>
Date:   Thu, 11 May 2023 07:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v16 18/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kw@linux.com" <kw@linux.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-19-yoshihiro.shimoda.uh@renesas.com>
 <20230510100309.e3ggidtc35xi7jde@krzk-bin>
 <TYBPR01MB5341D96B3E3F65BD12434F09D8749@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYBPR01MB5341D96B3E3F65BD12434F09D8749@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/05/2023 02:23, Yoshihiro Shimoda wrote:
> Hi Krzysztof,
> 
>> From: Krzysztof Kozlowski, Sent: Wednesday, May 10, 2023 7:03 PM
>>
>> On Wed, 10 May 2023 15:22:30 +0900, Yoshihiro Shimoda wrote:
>>> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
>>> PCIe endpoint module.
>>>
>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>>> ---
>>>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 98 +++++++++++++++++++
>>>  1 file changed, 98 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
>>>
>>
>> BTW, you keep not-ccing me. Since long time. I don't understand why. I
>> don't have the emails in inbox, so I won't be responding to your
>> patchset.
> 
> I'm sorry. This is my bad. My using script for sending PCI patches didn't describe
> your email address and I didn't realize that until now. Today I added your email
> address and Conor's email address into my script.
> 
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.example.dtb:
>> pcie-ep@e65d0000: reg: [[0, 3864854528, 0, 8192], [0, 3864864768, 0, 2048], [0, 3864866816, 0, 8192], [0, 3864875008,
>> 0, 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too long
>>       From schema:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.example.dtb:
>> pcie-ep@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'addr_space'] is too long
>>       From schema:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 
> I believe these errors disappear if we apply the patch [16/22] of this patch series.
> So, we can ignore these errors.

Yes, seems so.

Best regards,
Krzysztof

