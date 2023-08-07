Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC346771B0B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 09:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHGHEI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjHGHEG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 03:04:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC3172A
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 00:04:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe655796faso1643428e87.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Aug 2023 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691391843; x=1691996643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+rw0PkBch+x5hluKRN9y9M6u6RDlB7pTYALP+C2pTI=;
        b=IMmHkFwTPoVTTAJKTv2YSlJEQqbjwWPFpMGhcVb8DDERqTuTp7qJPiN+bebugzw5Kf
         L64z2wDnGLu5OvwikTPq+MVkXVWNz2QN/uOUYQQrKLgHWP/BaHc8oM4/fWMPyNPKmzQl
         D17txum1ifEKzxZEJuDMBrrtZ7dH82MzHnSbf36zxrQeEq9rfdAbI9y+fkp8Wfmes4B9
         Sl/DmU0P7SkHXQguiGtJus+O4/RNbe6DcyZ6lh6eaePtleTNN+9JwDZOQb/RR3IlA+pq
         0oJgitZ3ux+VKOOCzbFqVyXwGjELBpW+HYp2JzFmeK2huU0RxqM8v+skKkNtq4CC6QUi
         yyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691391843; x=1691996643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+rw0PkBch+x5hluKRN9y9M6u6RDlB7pTYALP+C2pTI=;
        b=JoBFzZVm9Y9rBo8mLFGJUcgCcMcnqqtO3S8EYk/h9yudSGYobUtyN4i9MLrOO02Vsi
         Jpd9N/BbkffNzBF+An7fRmZKeFwqY20aDTMWV75YGoUE5arZ98bXcLfBYC/cVhEmQGce
         aT5rXT9QU/w2GF0XGXtq1yq5R6TDJFl5+qJYCwyaVJjpTZR0F59lPaUpR/ymLv5VxNhU
         XEWlnuulkyYPn+y+iJrwDz7oU6UaB/li6+4ArAdXGtcYfEeoxIDDB91sTTFP9k8uAti7
         GK1nhcJWfUCeJhFDnTCdFaawd/4DW6kkuupvrx34vEVg00Z6R4argEzcN3n+g4r4IGEO
         VzmA==
X-Gm-Message-State: AOJu0YxegdWWUZUK/kqVcd97vrXNbrjeH7GsSqb6PYgQcqX8yNvhUnGb
        mFw/bCsVyqPH27VdWqm+gY3f3A==
X-Google-Smtp-Source: AGHT+IGc2IuyGt84wLzH8x7oM/cgKKUL6knUyu0Can+UVev5txwwNw0x8Iz1k+9q6LFzQAOYrUVi0Q==
X-Received: by 2002:a05:6512:3ca6:b0:4fe:279b:7609 with SMTP id h38-20020a0565123ca600b004fe279b7609mr6620028lfv.17.1691391842679;
        Mon, 07 Aug 2023 00:04:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b009920e9a3a73sm4748830ejb.115.2023.08.07.00.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:04:02 -0700 (PDT)
Message-ID: <400580a1-237b-73e1-6367-c246f7217aaf@linaro.org>
Date:   Mon, 7 Aug 2023 09:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/9] dt-bindings: PCI: fsl,imx6q: Add i.MX6SX PCIe EP
 compatibles
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, frank.li@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org, lpieralisi@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1691114975-4750-1-git-send-email-hongxing.zhu@nxp.com>
 <1691114975-4750-3-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1691114975-4750-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/08/2023 04:09, Richard Zhu wrote:
> Add i.MX6SX PCIe EP compatibles.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

