Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5143462DC71
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 14:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiKQNQ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 08:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiKQNQZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 08:16:25 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841E06D495
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 05:16:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h12so2621566ljg.9
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i33sxe8YJAvtvzx995z6301l/SnWDqnZWm9Vht72DH4=;
        b=tU7jXVbE/9IZhnkgZ2a2TR1cKrpxezzQgb08KohVcnbcFwh8xSb1SK8MR4QuXvS9Pm
         XihBbnMW8DhfFgPSZHICrxqW3120Lq1P53poDCUvvZreXVcLnys74vyrtcoGZ23iFVlF
         6XrA+BcxZB0URUC1GOjvTL0xUZsIoAMJrOTPvZwJRTN+YwbFxM7nP+xHf0uvt+yw5XI+
         6S4Esw86xL2AAWM1pZoiHc6p8maew1osrjr+BUAosRDPX/evJSt0NIsrqd7InhKAJI4F
         Dva5EE/QVjWaTs/cyxG7tne+9PKCnz9YvtXPqB+3nThZ7+tl5njGv8LdCBRzCq1Dyz28
         94gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i33sxe8YJAvtvzx995z6301l/SnWDqnZWm9Vht72DH4=;
        b=r9fVxXGlGyzhwvhV0lYz2CK1eNsacyFDiYEEttr8/I8DS73cLu/SpA/Hs7i/RGc3PU
         KJfJiSoGu5m9fDsrSyT5TbA2K4BugJMru40QGF42ghenmw1aKFSkypVRR1CM6Um2+52j
         6A7XSM2TqpJVHBJqhFK0Ebs/ZyVA4/9BIswKJyzqMZ/1u+rNlOVl3wQJlvnbknn0e/tI
         jqKD8HZnCNoveNbo8hfBvn7aLC5aoOs6FTe5bdvHpXFA35A4HAXg/oYMFc4mIGeVrpvt
         GasJHcvQjZb9Mnm015/45fxc2nV37kbWesiNKCFSZUZ81tAKjszx6jqaSrkk3GfZi2Io
         ZwSg==
X-Gm-Message-State: ANoB5pnM1rBCrUltai8x0p2G4xlzGkdrpvCTZB+UUivsceVIL7VlYLLe
        kL0CRnmw/Ykwky/fDveHnSuWiQ==
X-Google-Smtp-Source: AA0mqf52Yxq0LSiDFcb9qJsPRrRyCkW3YFJEfEhpUMT9fdxNufjsn01xmLLHGsqOPY/x/LtHAYjLag==
X-Received: by 2002:a2e:a309:0:b0:277:88e:f5d7 with SMTP id l9-20020a2ea309000000b00277088ef5d7mr1067109lje.434.1668690982973;
        Thu, 17 Nov 2022 05:16:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q18-20020a194312000000b00494643db68fsm147572lfa.81.2022.11.17.05.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:16:22 -0800 (PST)
Message-ID: <aff1e286-b32c-f0ac-40bb-9be0d9588a1c@linaro.org>
Date:   Thu, 17 Nov 2022 14:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/9] dt-bindings: PCI: qcom: alphabetically sort
 compatibles
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221116214841.1116735-1-robimarko@gmail.com>
 <20221116214841.1116735-5-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116214841.1116735-5-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/11/2022 22:48, Robert Marko wrote:
> Sort the compatibles list alphabetically for maintenance.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 8 ++++----


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

