Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42186B3A55
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 10:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjCJJ0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 04:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCJJ0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 04:26:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C52104615
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 01:22:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy23so17729362edb.12
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 01:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678440101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqoSvA3BE4hlW0EisauwDL4Ab2mgiGZ1yfRt/25M91M=;
        b=XT5chFCk2GbpR89HEaS6IQ1eGV2FP75YTLxKpA8VQ00JLTMDb5+NEXWgo6C02HPgiq
         iN+gjpCCiWnjfJjol/lm8utvDTgml0WOHxmnXoN7R6M2B5vJ9t75GIKgfa42Lkc3XTnX
         XAezjeLILFCd6RFiO2hbJimqcuTMASpcTqC3a+pS3rxcG5zFDtohYobCEdaRypwjgwIB
         UfUjpQfStLuzE4eE0K4vuK09EuWSa99iF/rYyCg94Ntg4LF9mP6s41EAfq9pZiejyiOr
         3gN+/uvkkF3CYncRCLAqQNeYkPFXl18awT2dYSqA0e22zxFZxUNcvDAp/IzyH8iKmY6V
         mUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqoSvA3BE4hlW0EisauwDL4Ab2mgiGZ1yfRt/25M91M=;
        b=SPSR/rBRe/PegP6tmiIrxoqdJBbZgA4B9P7mBW+xpn/cO2PaOU0PAR0//TrIJ5s+BO
         qPosKvXZixHjLEjhnL5SRT6GhlJnfSfI/7pfAgBj/dbo2F5YYusrfIHsoZQUZRaUWsm1
         hLu2Z9IXNwI1xNkAlGHHt3Z1G8sXvOBvdwMWTBGGoFQ35fet+1bf8uU8AJMc/MD0zTbR
         bEuPkmN9YhtB+T/iK0hpiIiTgEj5NWCFpY2k72cEQtJX5YPVrb4gITh/9NmfPXV4i965
         9kRBlwUBkzTNmofnt/Vvf9B07EzC2J10qwYTxPQ6S3z6yvCHlKIyh/WqcItJ8Rg+Gbqm
         vKUw==
X-Gm-Message-State: AO0yUKXVyI9FLbeU5srJ4CnJLtyzeyrG/CbiRXbrBnhwVdjh0Xk7OrnR
        bi1rstn3VYEBrBpRbzmk8ZG7Kwqgo1voXmId+ag=
X-Google-Smtp-Source: AK7set9Oux/RlqFUwN2hx9XW9TdGr/C1JJr6ZctFv5/bjhJUV1SypzNB0obKg0sK/jWUoqMtyeIQ2Q==
X-Received: by 2002:a17:906:265a:b0:8e5:c06b:90e2 with SMTP id i26-20020a170906265a00b008e5c06b90e2mr1405414ejc.21.1678440100921;
        Fri, 10 Mar 2023 01:21:40 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906358700b008de729c8a03sm727261ejb.38.2023.03.10.01.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:21:40 -0800 (PST)
Message-ID: <34b0e873-45ac-4d6e-c748-79cad50a2208@linaro.org>
Date:   Fri, 10 Mar 2023 10:21:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 14/19] dt-bindings: PCI: qcom: Add "mhi" register
 region to supported SoCs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
 <20230310040816.22094-15-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310040816.22094-15-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/03/2023 05:08, Manivannan Sadhasivam wrote:
> "mhi" register region contains the MHI registers that could be used by
> the PCIe controller drivers to get debug information like PCIe link
> transition counts on newer SoCs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

