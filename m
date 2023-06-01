Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D72719424
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 09:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjFAH0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 03:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjFAH0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 03:26:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A028219D
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 00:25:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fe2a1db26so57841366b.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 00:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685604354; x=1688196354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQ8Iw2iCGa9zj3iZr7ZFozqO805VgOcxoKQqsTGIsOI=;
        b=AYOT3xtsd+O//amhEezrgGaBtJnwib7gI+EnhAmJjLK/lj0xCMgszKY7m3jQJ9mJ9r
         tB2dzFP7H2mlZuZb3hwu3aedyQjMoTYBZAy1LDVLzr3GYSSg9f5hzBpn65G1qlbqI1us
         z4HAVdArGfSqbSg/Fjf3oxUPe3nSkHGU+MUauv+gGIFg5YNz1FaVaCGGkBV5ni5XthRM
         094SYl5G+zSumdo2gaohmKirbN/uSV2NTNihHyW+Ef0D067jBCVPdKPaJLl7AjeFlzQQ
         hSSco/FkC7mAkZ4R6y0qt86tDfFMRatSfaBo3pZuYzQxRIstmvCwJyEur31ubsSaw4o0
         MUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604354; x=1688196354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ8Iw2iCGa9zj3iZr7ZFozqO805VgOcxoKQqsTGIsOI=;
        b=LG9NtVql0nGr3FGOPuaAX4OksNZxrkavygm+ayMSxtreu6dTMSJwXnbTO2GPAHvidj
         ZEVXaqDqqgRyZbky7+SSTaDi45CxXO/u9OFc4UhXnzBRL7HLCOfHk9Ev6m7sjDFLVkId
         OCm8ex5gE2kFv141mGEjNBXenWSRnN00glwaleKO29qdRTFIgUUQC4nxU0atFWtX7qmv
         AQaiEAAz3DGQyXMi1FHPoW8gYKffLf3CF3nNnME6jyiANmtXqxGyOK2YUhNK74JXomTB
         nOqnsxCpxBFuBnfhF089zTnW48fACM4CZDcvXP//8tKCYWUBUHPRyN8WtQP+c7CrVGip
         yUGw==
X-Gm-Message-State: AC+VfDwNz9OC3nP4fSo+74pmMMVtqwBpyn0LDbEe7PnB2EJv09ROOjUv
        W8uNPuzo+Y8xruJM6ueHpHevSg==
X-Google-Smtp-Source: ACHHUZ7SXG2KxfCd7JaB/XvF7rLw1rxGUqsLf+kqSXRvkmd5jFRBeD/+UCk5Xok6o8WA9obEeLVwxw==
X-Received: by 2002:a17:907:7e85:b0:972:aa30:203e with SMTP id qb5-20020a1709077e8500b00972aa30203emr7818275ejc.34.1685604353919;
        Thu, 01 Jun 2023 00:25:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709060b0800b0096f920858afsm10109200ejg.102.2023.06.01.00.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:25:53 -0700 (PDT)
Message-ID: <1d1b42e9-dbc2-263e-b937-b12e961f892a@linaro.org>
Date:   Thu, 1 Jun 2023 09:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/15] dt-bindings: PCI: qcom: Fix sc8180x clocks and
 interrupts
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-2-vkoul@kernel.org>
 <4fcbb3b7-ed44-d8e6-a601-e3e957c55ebf@linaro.org> <ZHhG4LOgfYgWbFt7@matsya>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZHhG4LOgfYgWbFt7@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/06/2023 09:21, Vinod Koul wrote:
> On 31-05-23, 10:19, Krzysztof Kozlowski wrote:
>> On 30/05/2023 18:24, Vinod Koul wrote:
>>> Commit 45a3ec891370 ("PCI: qcom: Add sc8180x compatible") added sc8180x
>>> compatible and commit 075a9d55932e ("dt-bindings: PCI: qcom: Convert to
>>> YAML") converted the description to yaml
>>>
>>> But there are still some errors specific to sc8180x which this change
>>> attempts to fix. The clocks and resets for sc8180 pcie controller are
>>> different so need to be documented separately
>>
>> I don't get what's the error here to fix. The clocks you list are
>> already there as part of oneOf.
> 
> It was listed with sm8150 block which has different set of clocks than
> used in sc81880x, so this needs to have its own block of clocks and
> resets


Ah, after careful check I see indeed difference in one clock.

Best regards,
Krzysztof

