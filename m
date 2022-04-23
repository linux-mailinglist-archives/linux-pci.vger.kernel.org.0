Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B150CCAF
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiDWRpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiDWRps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 13:45:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4183E1C82D1
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 10:42:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id el3so9162237edb.11
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9p7hpzsmtTc9QGDX/fB8QkBk2oCeRKBf5+Q+ZQxOGkM=;
        b=Suk07hwdPec/Z3adst9dj8gL5IksUcg4Ok3VxZfv5T5c0pdeoMm3coxmgQf44Fxzo6
         gDo68MjbOf77xyVkuG8XZTeuPkq45Ac6u/IYdVEwrrXaCq67vIu23mjMTC54qd6sFTkt
         4sVkvVJxnMxCZZY4T2XbPamtGrdONf6Zd00WUmJLtJtZaOhdQDwXq1akaRMLI95lq6VN
         Nz943hO6o4QuiFUyCBA1EqJ0TMFlps3IY2tJKwx2C6AY8Yg1Ib0uO5XwpQwyeBZ3HrUU
         FEQMTP7QoL7FBM86CjeFOYRm3TGsGlwVDlndMG8WF52mgmC7ESjEnAl90IH15o5eFrL2
         8IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9p7hpzsmtTc9QGDX/fB8QkBk2oCeRKBf5+Q+ZQxOGkM=;
        b=2qFVwi+j34E74auJmxfpCpYJfltIxpd0TPLBYcrQxlh/mTYbSs8cbAzoV1fHqwuB3O
         TpuApINTaO1Izad3fMG/8YyXbZZf4TsUWKetD0JUnD6fXo7bH61KuSQ8vbyTUEmeetbQ
         yAk2mjzfK7Vw8nCPF4LwHLVU83ccMcEhrzyvUeG05dcSH7HqRvz/xzHXPQ6+U17t47IW
         02hGHNt0RHZk+GonXWLex3ZrB0G1Elzxgot17QiQeJNPA8bQJXYvi+sGkS/F93rcPGPY
         nw7JBQZQS+Yb/HCAzHkndoT2/2nCAM2/gK5ysC0k6zm7O6QM60nXzfDr9PmVrE40/a/C
         yEDg==
X-Gm-Message-State: AOAM5311Iiah/wY7COKT+9jnqJpc6Kruril6yzVcjzn//R9DH8a7dIwy
        QG9pxPWWdyrJSRvDlNFCbE6Ff9RcDjtdRQ==
X-Google-Smtp-Source: ABdhPJxPkJiKp+E7kn89TmKjM2//C+xbJlsbhWKOeu3wjaURwfWEdlQFVbRy63L3MGIxGg3aIT7B+w==
X-Received: by 2002:a05:6402:4414:b0:419:28bc:55dc with SMTP id y20-20020a056402441400b0041928bc55dcmr11116781eda.130.1650735769898;
        Sat, 23 Apr 2022 10:42:49 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906768200b006e89514a449sm1848954ejm.96.2022.04.23.10.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 10:42:49 -0700 (PDT)
Message-ID: <9d79c0bf-45ba-6370-ed48-a3fa6ad5db29@linaro.org>
Date:   Sat, 23 Apr 2022 19:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/7] dt-bindings: pci/qcom,pcie: resets are not defined
 for msm8996
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
 <20220422211002.2012070-3-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422211002.2012070-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/04/2022 23:09, Dmitry Baryshkov wrote:
> On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
> resets. So move the requirement stance under the corresponding if
> condition.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
