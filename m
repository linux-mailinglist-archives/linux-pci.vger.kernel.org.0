Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0692E771B02
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 09:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjHGHD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 03:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjHGHD1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 03:03:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0412B10EB
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 00:03:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c10ba30afso1114836866b.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Aug 2023 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691391804; x=1691996604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPv78rFQ0GszV8FZCKlxOdCrJLAh0N75ySEJ0htjbYQ=;
        b=xZkUM51omcyTeVIx/PvrGilJUJJDc+fHLxQp46/GeR1Hz+nNk4Ndv98sw9GegdHWRZ
         //plUlvH0/LdApbInSe+K+tm55X1B/Bmpy01xsTtEAQOZ/eklAPIlkjt0fASCDP8hJYZ
         9Z9gJnh3ElJZV8yPBQbw23Co90SYCXOH3IVwYP7vx0aR/yNMJp390wSlbizky6Ycdnx0
         +RO2FTupPspA7oMTMnlOKEthsnG0oN5qdt7JhAfKwPko27WxpG1WU9pJfObtqF31eazT
         +YtSgzoovfBUERFOa4dM7A+Y8PxIyyO0WhTB78ZO0OaqvYGE8j586gEx1wsMrO4A4/1u
         CMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691391804; x=1691996604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPv78rFQ0GszV8FZCKlxOdCrJLAh0N75ySEJ0htjbYQ=;
        b=IkAPACKDbp/4H2/3TbSmlnfWgKQYbb236vxbMxo8Cw2vCza0YUqR22iTeDoCOPWTwq
         ZCA0lV/o3NcfiSyZx4j7juMu/eyw4QKO7DYXdxAaJVMOO/G3PuWXOcElX35r8CjRFvN2
         iBvxwVheHboYAOsc6Djd1yfxomLOmHDMkeY1JzERYLQPCAQvzAjrzqC4UpU5hwjKhQD9
         yzm2D9m8l+JmqpegRm7gPjCA1iZeBGb2PAaiw8zPzfWlB5Ebv6MkAQLxfOLA8GguCeDO
         D467cCy9zRz1uej+v1GHQ+EScukUB1pSknk14E33nSyBgzCMCnWSsSO99Ue2DOs/D9fe
         DoEA==
X-Gm-Message-State: AOJu0YzR4D7wztM9pe1J0OyZUuARRn3k5nra9xEa/JPGKCViixg/dpHH
        tmmGy9cgBkwXMR37wlG5vF5i2Q==
X-Google-Smtp-Source: AGHT+IFdE7sDjxMpbUtadgfD4FLe6aWyTSjhFkXt0/yaIj5Xj5JsVH1ZIjbBUNKdVMyvPzdhEzaFjA==
X-Received: by 2002:a17:906:7494:b0:988:71c8:9f3a with SMTP id e20-20020a170906749400b0098871c89f3amr7002264ejl.16.1691391804510;
        Mon, 07 Aug 2023 00:03:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id q14-20020a170906388e00b009737b8d47b6sm4719768ejd.203.2023.08.07.00.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:03:24 -0700 (PDT)
Message-ID: <7b2785de-640e-9912-ca84-7c8376c22762@linaro.org>
Date:   Mon, 7 Aug 2023 09:03:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/9] dt-bindings: PCI: fsl,imx6q: Add i.MX6Q and
 i.MX6QP PCIe EP compatibles
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, frank.li@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org, lpieralisi@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1691114975-4750-1-git-send-email-hongxing.zhu@nxp.com>
 <1691114975-4750-2-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1691114975-4750-2-git-send-email-hongxing.zhu@nxp.com>
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
> Add i.MX6Q and i.MX6QP PCIe EP compatibles.
> - Make the interrupts property optional, since i.MX6Q/i.MX6QP PCIe
>   don't have DMA capability.
> - To pass the schema check, specify the clocks property refer to the
>   different platforms.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

