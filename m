Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1366D74DA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbjDEG7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 02:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbjDEG7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 02:59:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C746AC
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 23:58:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-93071f06a9fso23800166b.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Apr 2023 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ge5tZ9KDzAcz+JwWlyHU3EWycDUOLBemzfQQA19mRWg=;
        b=YMIQo8YkmwBb6P+OGjuYO1WXzdBweIi2Y9+BX+C+/kXe5iH+V896NMvfco3//uos7u
         C0/JpSV7XK5y4nPJ+JxPoukF9kEzF3vdSOimcaYrQp7mUnAqVGq/mt8QK9ThSQ2Ek/3r
         7PRU3fe4tjLaf3TDqObZ7PIAzNhvyMSaRh12rCGkQVecARcZLyhrDF6lrXUEtVYJZ41f
         zW+qqYnRd6hC059vdRuhFmClVxvyynzjeOXzagE4JByU8Vn3wG3DP4tsQAlySbTZGKCC
         TsbSk7neQooFmn/m39OR9NoohtRFaeBPP9uQ19SfNJo5jCwvkUuO13BUDO//8/9wqjkM
         FPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge5tZ9KDzAcz+JwWlyHU3EWycDUOLBemzfQQA19mRWg=;
        b=8N010ez4V0KlUREwToJR25ij1nmMj9bPzlE1KE2pEGm9CfdhJdU+3hVhUvka9g7lLX
         G5Pb5mSrp9feqqA5IU1fuqLg0UMggoGX/eQJg/jnqqNsNsXzm3vppe59piaQa9tPMvzS
         LtlZc7inE0l9lPdWpLVKYG2WM4v1KdnsuxnPtaSKIGdYzh5XOQ4wFUDCIoZWhVOZ7XJY
         8/bopqVVy3R9ELIesV+AmHxcZgJ3ovdKKZZqq30tHIrlX/MHfRWXjlsyuivPXRQq+Iey
         EsHuL/bKi1AF1C1gV/V+xYKpq8ChGrGYN5nrKuuV1WSW3QjsYTvceUaiO8MAtplpo18C
         mi0g==
X-Gm-Message-State: AAQBX9fD7ky/V4igP72HMQ4yhORvVVVgsGS6R3Ay/gpwKPCjUnesv8ul
        dLp0PXhhU7l891xWpIxFw/IewQ==
X-Google-Smtp-Source: AKy350Z/ugZFHsOXP6wXHv4FffyN3fDhJJCINwRAzsn82Xp0UViumtoK44fbCd5Nln9hyNPOjd0iUg==
X-Received: by 2002:aa7:de07:0:b0:4fd:2675:3785 with SMTP id h7-20020aa7de07000000b004fd26753785mr962704edv.22.1680677938487;
        Tue, 04 Apr 2023 23:58:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id kd24-20020a17090798d800b00933d64cd447sm6913431ejc.121.2023.04.04.23.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 23:58:58 -0700 (PDT)
Message-ID: <445ed49a-9ea6-0851-b0c5-bdd1d420689e@linaro.org>
Date:   Wed, 5 Apr 2023 08:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 6/9] dt-bindings: pinctrl: qcom: Add few missing
 functions
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mani@kernel.org, p.zabel@pengutronix.de,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
 <20230404164828.8031-7-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230404164828.8031-7-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/04/2023 18:48, Devi Priya wrote:
> Added the missing functions cri_trng2, gpio and removed the
> duplicate entry qdss_tracedata_b
> 
> Fixes: 5b63ccb69ee8 ("dt-bindings: pinctrl: qcom: Add support for IPQ9574")

Fixes are either separate patches or sent as first in the series. This
is not really related to PCI, so it should be separate patchset.

> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

