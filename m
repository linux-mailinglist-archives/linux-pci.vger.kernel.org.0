Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF275F74D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGXMyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjGXMx4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 08:53:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E883A87
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 05:50:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so6508978e87.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690203019; x=1690807819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nQOx8QpxMl4xmqW1W/cGtwpWNmlYQb9ZRl8qG0IXSc=;
        b=H42F9CvMDBCmp/gcoj+qvE3TzKL0C0wnAK6FhL/5CkghE/BdP6230yQCDn8Uo3KsKE
         Z/AWBpf4KY6/Jg2e3r/EcR1hBVil+EeKBjKKgu7U+t5lpDaVaqFLP8bHw48Ij4dSO1Vh
         om1aBhL5sbB/rXTBhV649ENYl4muzyHAxyRo8jj5d0jx0rCc8+DM1W3krz6GjXpQxdbe
         ylS38WrFQ2U5k7qUTTE4rtiuABlJopLu5qJTl6+tcwmkCiBEQW7QDQwWAwVJg3LUC2nJ
         aOZrVfT/PRSnoJ3wv6ke7JCZIvUOr31RcXNAtiFsVsrQ4xZhxuF6sL3bv07i+lOBMMym
         gTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690203019; x=1690807819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nQOx8QpxMl4xmqW1W/cGtwpWNmlYQb9ZRl8qG0IXSc=;
        b=aRwrUJNpBCuuy/Z54JyBU5td6WOFP4S1bXfDttXwGD6BQ57C0eSxOZbsU0/9sD75iJ
         zWsryP80fraslt7y2mAM6/wn1lFhZwebMAgkk44EMNcQu9hKEtf608K8KiE/faYrLOm5
         mSBixpmZopXcyvFGEAf7TnQR6QTdgvhNFcBHwPsGIwMCYvWIFYYcQwW6ocoXPFKc9Su1
         d0JIC6pTq3fn54sneX5gA48r3b6ZLPvAvVbp8+cuzl53jAl59YbnaKQInqJ8IKcGC2dO
         FTBxwUJwayLt5tNdUIpk4lB7moOn5NRZ+bLzgeNvvulWaMqpXq+mgCYdqtXiJ/WqCILO
         OE2A==
X-Gm-Message-State: ABy/qLZGVyR2A1kdjEIoL7Wd+70/I2toDqG9BjT/Y/23v7p0jNIFjbo+
        k/19QZrwrpP1clV588xULntjew==
X-Google-Smtp-Source: APBJJlE51EVSVuXAKr+xHydyC8+tcdP1mFIRU18KrDnY3qMmkv5DqpaiYwmGatjBS2+9NkHgR11Wtw==
X-Received: by 2002:a05:6512:20ce:b0:4fd:d213:dfd0 with SMTP id u14-20020a05651220ce00b004fdd213dfd0mr4827935lfr.11.1690203019023;
        Mon, 24 Jul 2023 05:50:19 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id q19-20020ac246f3000000b004fb7cd9651bsm2192458lfo.98.2023.07.24.05.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 05:50:18 -0700 (PDT)
Message-ID: <5f707d2e-f944-d991-2c0d-5ea9d02f7572@linaro.org>
Date:   Mon, 24 Jul 2023 14:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Set may payload size for IPQ9574
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, mani@kernel.org,
        agross@kernel.org, andersson@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com, quic_devipriy@quicinc.com
References: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24.07.2023 14:47, Praveenkumar I wrote:
> IPQ9574 supports 256 bytes of payload size and setting the max will allow
> to use it when capable partner is connected.
> 
It's not necessary to send a (bogus) cover letter with a single patch.

Please consider using the b4 tool, which takes care of almost all sending-
related complaints:

https://b4.docs.kernel.org/en/latest/index.html

Konrad
