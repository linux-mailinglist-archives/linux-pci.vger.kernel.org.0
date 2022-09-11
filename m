Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218395B4F2E
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIKNp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiIKNpy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 09:45:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610B12CCBD
        for <linux-pci@vger.kernel.org>; Sun, 11 Sep 2022 06:45:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w8so10676734lft.12
        for <linux-pci@vger.kernel.org>; Sun, 11 Sep 2022 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YFbVYa//8OpdO0rLIMSveFawhyNr9m0sY0aQlbJUg10=;
        b=VwUDIswuvOEkntdvv5bUGGdciOiwCizT7BQjpEz2JuO6G4wpXDb12O7eFCfQwC5ull
         6qEX5rRFNf9sGMQhkHsKc/I+YNUKmZitI9P3hU7GH4SkBDEoVek09HFbyKmtuihVbLI4
         Y8sbi1SuwmaZz8gQr0XaPrSsBMzhWU6aN7ZhxIU6yD7NlYtN8PvqNbW7lwLitx3RNIpD
         sRPErzlfoORDks63Pp7ntbotMfSs6poPFZ/zt9RnrYQCk52LMlB3c3eKaUBMHpRRiTHY
         zLksHlxSgurRhx37xgFBI6iQTRgrNewz8B9uRLNmrrhuSYcBILQNSrRZdrqZbNrKTOS4
         2MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YFbVYa//8OpdO0rLIMSveFawhyNr9m0sY0aQlbJUg10=;
        b=udNCUNEqKZqa960k0VROAtqVxZpUNIcDJ2br7jh2fdHQSO579BSdGFbcIB5rqMSZ21
         qCUu2FdnJ4ij0rJsTlXDwNVdRW0DGIC3AM4aEwyvI9Ex96w32MaMFw7RH8eZ77ag9Mga
         BCWugP3xUMocLbJfbfGwHwzYe6Pw1m/g5fMu8QEKAeqa2bc6NcGg3Zz+2QQfZN23nCqX
         +XgZQeCHH8JAOZpMB3pICvB+jOdLPz43q/RFhRzgKGc7hNn1HB3j4KJG5O9q9hvcuY7A
         V0T+48/5dsqbcDquB+pQDJovYPcEKQG5rhRkAH3ozzekFTEqGlTXQCWjxGU/t5ZbsDeL
         t9gg==
X-Gm-Message-State: ACgBeo01YqaaLj/w7hmSeYFs7mE/L4WWhpu+ZaEcNEYq+Nkuj6haYWTu
        GJB+Jkpsio4rrVgHes9Cw2bOdzb3rE/4AQ==
X-Google-Smtp-Source: AA6agR7a9HULEswlNTwQBhJHFvYfRzpw0Ndua2PWOkF+3fp6GbULyIifmwXczZb5Ouf1LaeLivPjcw==
X-Received: by 2002:ac2:5d6e:0:b0:494:99aa:6548 with SMTP id h14-20020ac25d6e000000b0049499aa6548mr7134092lft.508.1662903935800;
        Sun, 11 Sep 2022 06:45:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c19-20020ac25f73000000b004948f583e6bsm613049lfc.138.2022.09.11.06.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 06:45:34 -0700 (PDT)
Message-ID: <8a113866-c922-fc79-a112-e19d74da9f75@linaro.org>
Date:   Sun, 11 Sep 2022 15:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 11/12] dt-bindings: PCI: qcom-ep: Add support for
 SM8450 SoC
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lpieralisi@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dmitry.baryshkov@linaro.org, kw@linux.com
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
 <20220910063045.16648-12-manivannan.sadhasivam@linaro.org>
 <1662821635.191877.34702.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1662821635.191877.34702.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/09/2022 16:53, Rob Herring wrote:
> On Sat, 10 Sep 2022 12:00:44 +0530, Manivannan Sadhasivam wrote:
>> Add devicetree bindings support for SM8450 SoC. Only the clocks are
>> different on this platform, rest is same as SDX55.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 39 +++++++++++++++++--
>>  1 file changed, 36 insertions(+), 3 deletions(-)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> pcie-ep@40000000: qcom,perst-regs:0: [27] is too short
> 	arch/arm/boot/dts/qcom-sdx55-mtp.dtb

This is independent issue. I'll fix it.


Best regards,
Krzysztof
