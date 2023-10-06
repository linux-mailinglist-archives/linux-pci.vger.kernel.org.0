Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A5A7BC10C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjJFVRn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 17:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjJFVRm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 17:17:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8693BE
        for <linux-pci@vger.kernel.org>; Fri,  6 Oct 2023 14:17:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a645e54806so464364266b.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Oct 2023 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696627059; x=1697231859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wfo4YqiJevFxT2ANmYz9EDuFHXzL9pI4Z9ll56yG/84=;
        b=rFilQbMRyrI11jXv3rew07tbsSWJ5EwTvWkbAYUGP3SyF1YSmhHFeTFWNjz/W44b6M
         8UPzWUdK56Ti6q3qtVqsCAwe2ntLoQVTw7VrdaxCtUZLGlHNrwaNCev3ko1/Q0iRXQ4l
         FiERf49JsIQYjODGO7NXDgbFH5VX+KFkWksGOz0Zgm3loWO61stXMI9Ym7GCIfKCbIvB
         Igc4vGKwxzzHfaMNfsWCEupTee5unKR1iilgqhElciLMurdtyJUT06gSDoFNU7H/fSCt
         xYAHFWINmyEPQumhHhhj68mpUWIzeGJMAVzkiRt3huBWD9agejqjKwXgWwfzjcySH4/B
         kQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627059; x=1697231859;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfo4YqiJevFxT2ANmYz9EDuFHXzL9pI4Z9ll56yG/84=;
        b=natGifD1oiR1E77ZeetNDABm+UFkNSDLnbjjfjk4QfWEtWDHo7T03rLuTgDh+3K12D
         wQYr09f8KHhs1H11hi7PlWNr4Fwhma4rI9xiecuSnyAVpSAOIIKChIXwXK0mQ3uZxZxi
         s76XNGBzhOT2/zlO16xZE++2EZbiii5YQYHtqi/Z0f9QPDycgXHtRng6eGWgiijD02gB
         e5bE2wkKQjUGQaFpqsva8yW51M330o1612alxjXpIpFQA2yQNhNZs2ZRBd1DVsULt6FY
         FFL9XNwvjDT5ge6nKAfw9GIVD2wGXWWVPB0ZnYYTw+1OQYH5kL787roLpqR4omhKpRjb
         Fnog==
X-Gm-Message-State: AOJu0Yzhoqd1G/a3oHGapPEvozYh6CDADfxVpMursSx+0ULoOIwGnuZm
        xPItY5Fqeej8M4OMTFy+sNk9iA==
X-Google-Smtp-Source: AGHT+IGCssLhLFlyLUXl5vGJFCLvugJzS7TwfdmRX4XSQziRf6ZVaMH/vnjl1cwgh21QaBqKk4Z4MA==
X-Received: by 2002:a17:906:51ca:b0:9b8:9838:1df9 with SMTP id v10-20020a17090651ca00b009b898381df9mr8532029ejk.59.1696627059244;
        Fri, 06 Oct 2023 14:17:39 -0700 (PDT)
Received: from [192.168.200.140] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id ca9-20020a170906a3c900b009ae587ce128sm3414983ejb.216.2023.10.06.14.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:17:38 -0700 (PDT)
Message-ID: <8f243944-f836-4f80-9ff4-cc936ef57bed@linaro.org>
Date:   Fri, 6 Oct 2023 23:17:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI: qcom-ep: Use PCIE_SPEED2MBS_ENC() macro for
 encoding link speed
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org
References: <20231004164430.39662-1-manivannan.sadhasivam@linaro.org>
 <20231004164430.39662-2-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231004164430.39662-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4.10.2023 18:44, Manivannan Sadhasivam wrote:
> Instead of hardcoding the link speed in MBps, use existing
> PCIE_SPEED2MBS_ENC() macro that does the encoding of the link speed for us.
> Also, let's Wrap it with QCOM_PCIE_LINK_SPEED_TO_BW() macro to do the
> conversion to ICC speed.
> 
> This eliminates the need for a switch case in qcom_pcie_icc_update() and
> also works for future Gen speeds without any code modifications.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
