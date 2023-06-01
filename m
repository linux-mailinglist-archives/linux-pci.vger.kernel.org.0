Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D411719421
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFAH0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 03:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFAH0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 03:26:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A88E7B
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 00:26:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso836248a12.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685604366; x=1688196366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efjgwa47sKdbQI5f0Y5Te1289OZlpl1XHNO5YkX5Te0=;
        b=cwmM1/QRNcPFgdRbmAlxEPsMPtcbIqFu8f5t0j8PNhuZRWwypSnwSIg4uk3wH88CSe
         7IL2r4wEA9zK8eVuw0jPJ5xlIrdIMzzkGCrMiGKqnY4zRlJd+4RYrYso4g93FjDXQC0j
         kNf7ElYTrceV1T8cZN4nKc7a48AD5lhXGccieGToR3B8f2IaWOvXXfCObV9Dui6FinCw
         pD20aQvU3J/9tynVp2BT4hYCRxMNgycPonvNqLSyDHOor/s2f64cvFqKABIJfHeSlBgY
         +fbzHYC10P82MZQd8k0huHIBMR8cjV+PduBOLFISNzj4SvU8jhDbAjrRmimEpAJeGHRt
         Ei3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604366; x=1688196366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efjgwa47sKdbQI5f0Y5Te1289OZlpl1XHNO5YkX5Te0=;
        b=kcZM28k0/VXFDpDhoQzz2Z3qgZjoTgTzCTZCuuDayr3wuc0nIrK0zY9a7ZZ3j7Tvs5
         pflrgLEbvzBq9CCvoUmfit/5W2T27T2QJOxE0a80rYIwdTVX+hox7VMaXxARukhhSnaD
         G19m3TWEr84EnfWd3IOJEO7P1bAMpt5dzu5WNu3NQnSXl16fhUPvPGQJc6hSa6ANcUkO
         9rBFLs3E4bzFqJ3byp8DSgIJskf4R/Sez2PIZErbTFshr8dYopyftG29XLFowW3psUwT
         u3DyFhRNVyvTChnAt4tUvEJCuNqZutED1SpADunp5AI7phPuwibdZiBN6KSNGe62/CXC
         nHow==
X-Gm-Message-State: AC+VfDxEiapGc1bEqcSL3STbGk1YwH8YxL7ejJXdrySn+x+mB9yCGQsN
        DKCEPr45BG9huqSIjFfLM8X9Aw==
X-Google-Smtp-Source: ACHHUZ7Wy6Q2fmCVQlbBa0wFjjl26nbeUeLu79/Cr/qPYWhnaGnaCDoh0mPxUxxNlNIQ//7IwX9a5A==
X-Received: by 2002:a17:907:7293:b0:966:1984:9d21 with SMTP id dt19-20020a170907729300b0096619849d21mr6902847ejc.9.1685604366378;
        Thu, 01 Jun 2023 00:26:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id re22-20020a170906d8d600b0096aae0b36a1sm10126474ejb.33.2023.06.01.00.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:26:05 -0700 (PDT)
Message-ID: <e7d75e43-c2cc-3bb4-5a21-f64e0b3e1d5a@linaro.org>
Date:   Thu, 1 Jun 2023 09:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/15] dt-bindings: PCI: qcom: Fix sc8180x clocks and
 interrupts
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530162454.51708-2-vkoul@kernel.org>
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

On 30/05/2023 18:24, Vinod Koul wrote:
> Commit 45a3ec891370 ("PCI: qcom: Add sc8180x compatible") added sc8180x
> compatible and commit 075a9d55932e ("dt-bindings: PCI: qcom: Convert to
> YAML") converted the description to yaml
> 
> But there are still some errors specific to sc8180x which this change
> attempts to fix. The clocks and resets for sc8180 pcie controller are
> different so need to be documented separately
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

