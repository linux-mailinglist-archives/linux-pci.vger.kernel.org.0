Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883D771B0F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjHGHE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 03:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjHGHEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 03:04:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E88199B
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 00:04:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so8872685a12.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Aug 2023 00:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691391854; x=1691996654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0W6+QdLUJgynbZQgwWh7N15Tm3OM7n0lMK69GE2HrE=;
        b=zFk4nCcRVFsDnk9v0UmcphZoXlpxMkP2BQ4nYRj+4kLnB9P/L+hISywfUnTwdoX/KS
         FbNccluyX1lqC/26YenM0GhQAKepKshQ/Lcfu4Wmj2P2Gq5A4+/IJmMzcHFzZOBTbgBW
         1CxvHtgRYv5TMit8/44jV/WNiLNOOzEOXRJTkRotyNNLHBVHlYEK9qsN00854OPPHKr0
         5i1AfmBEqkxmACQoLLk07PolkIc7qcsxvW147Zn5v22lgi2kEkpPpPkDaJUmG0bFTZOE
         CGKuJeGOdM2NPQHDo/fTwQ7g78vyhk8XZY62qtVpqCnY+telRRRUiooKQAV5imshZ2eI
         8YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691391854; x=1691996654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0W6+QdLUJgynbZQgwWh7N15Tm3OM7n0lMK69GE2HrE=;
        b=ZesPAk1DU8E5IewE4dQZ0tC7RB12lmxrW1skA+ZMeXAg1DkizzNb5y+KHZBTNAaTFF
         PkUK3ljV/o05EDizUh2EIDm27spzpUXvM6SYyZ5iVZR4phg9F7DvSh8lqeLi5lzfy+8s
         q+1NxpjxXPIGr73IuUGY9G+kvM6ZGzqf71MSJaAzYrz6af4UC1AeJocnPAo33cagdp5x
         e33kQ2G5KF4Mjw48cD6XtT3o6COgLLsjMW797d3N1yGty5YhO2yUqBMs5ojKDHMTEYLR
         KLheEUVo4dceAD7PiFyu8kWeb12YTd8S/8GZMCxOfU5+md0lC8vMu3BE/6jD3fnn2lwE
         ISDQ==
X-Gm-Message-State: AOJu0YyVMsrUVe9mUtIgGS2YFTa654GTSgrXHrXRAnlQBHgwH5GIxV0h
        qQzZla6m22c4alIeMqWobX4FAw==
X-Google-Smtp-Source: AGHT+IEiwyAhsNltvxs223l22JolgdfXujvQSbMR8kUItZ3zoEsOz8v5drYKxaTaP1z/S0WHRBUPpA==
X-Received: by 2002:aa7:c784:0:b0:51e:421e:d209 with SMTP id n4-20020aa7c784000000b0051e421ed209mr6723609eds.13.1691391854494;
        Mon, 07 Aug 2023 00:04:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id g17-20020a056402115100b005230f2a12b9sm4722187edw.43.2023.08.07.00.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:04:14 -0700 (PDT)
Message-ID: <a6553faa-8522-d47a-8446-296e3d69ef31@linaro.org>
Date:   Mon, 7 Aug 2023 09:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/9] dt-bindings: PCI: fsl,imx6q: Add i.MX7D PCIe EP
 compatibles
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, frank.li@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org, lpieralisi@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1691114975-4750-1-git-send-email-hongxing.zhu@nxp.com>
 <1691114975-4750-4-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1691114975-4750-4-git-send-email-hongxing.zhu@nxp.com>
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
> Add i.MX7D PCIe EP compatibles.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

