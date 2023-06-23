Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE7773B527
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjFWKWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 06:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjFWKWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 06:22:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC41987
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2023 03:22:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b46bfa66d2so7717781fa.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2023 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687515765; x=1690107765;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhgEvVyNUt5/Q7JUxga8FPEpdH5L7dqFe7w5Qikinc8=;
        b=ulmbaW7R3yXW6Y5BPFLdJuT85VuDEiHnwKkDLvQgeUnL5mDJdZ2J5ZeCxLlVYPwOzK
         7azheeXIax6oXPosqO/csRedizRRtu9onew5GSM5YnlC/eZQPgASDS6qdgStk1hxGViP
         K+UfNrJmfJwmrI44kVVAC0kVQRzCsOtZLrcxzinawKnNbYBSB39yBxPNmnym7PXV3ku0
         fExpGXG4YtzfcTJjVfAep8rfCzQPGClQ5abM5gkvdOJHy2cZDndRQuyLo4RCRXzaB9Yc
         /1lv5JubH6x2bGhPjcF0DYbsX/Y0laQnWux3+kKyC3W2FX2GjgYfSV1cpdSP/Hj1IToJ
         UsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515765; x=1690107765;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhgEvVyNUt5/Q7JUxga8FPEpdH5L7dqFe7w5Qikinc8=;
        b=hVFHbyu2M2gh7wjQpc3XEwpFBOXKki0l93QB0LgJjmF3C1xAFjotfQ/zCHItZPps++
         Qo4fZX8GyMnlMcXBo7DL9LdneAw/Eex/hBjW3fxuWHI2sQtQh6YYeWYDS2/3d3cS++Jg
         Ifgo+liY9iD5ILFl7hjp5R/+V8Y8XzsQDi2BqQNRrKf33Juq70BVNdFYBzmZkcbCyem6
         F4Pd4kPnxtA/MhESmGHu2KYTLIyqavtNxyJNuRqMJ4USM3ZObJSXrhbwRGiir3H2FRT9
         cIyV2ZXnKJUIeXWdTg3WmKvT46zPNJBpN1pucptBdd3qpBdqvYZVsQNPD1WYiLUQG8uM
         AJaw==
X-Gm-Message-State: AC+VfDxk2M5xkfYx9HqhnIa2AXF73dukqQcogRXH2nqJ5h/1QupqNCfk
        Rjo6qv35SUapu8bixZyaernIbw==
X-Google-Smtp-Source: ACHHUZ4GE0bjgJrBNQZsrL2c0JJvp3yaIbHgR/Wb+zT2JgRq/cetteDiQe0i8aYUjWMN4q1OH9ZuNQ==
X-Received: by 2002:a05:651c:1022:b0:2b4:636a:67f4 with SMTP id w2-20020a05651c102200b002b4636a67f4mr12907108ljm.20.1687515765251;
        Fri, 23 Jun 2023 03:22:45 -0700 (PDT)
Received: from [192.168.1.101] (abxh63.neoplus.adsl.tpnet.pl. [83.9.1.63])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e7a12000000b002ad8174d025sm1674711ljc.122.2023.06.23.03.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:22:44 -0700 (PDT)
Message-ID: <b3a1bca2-1867-aa4d-47c7-63c5f9df868f@linaro.org>
Date:   Fri, 23 Jun 2023 12:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] pcie: qcom: Fix the macro
 PARF_SLV_ADDR_SPACE_SIZE_2_3_3
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, mani@kernel.org,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230623094403.3978838-1-quic_srichara@quicinc.com>
 <20230623094403.3978838-2-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230623094403.3978838-2-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23.06.2023 11:44, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro used for IPQ8074
> pcie slave addr size was initially set to 0x358, but
> was wrongly changed to 0x168 as a part of
> 'PCI: qcom: Sort and group registers and bitfield definitions'
Surely not, this commit only moved the definition containing 0x358 up.

Konrad
> Fixing it back to right value here.
> 
> Without this pcie bring up on IPQ8074 is broken now.
> 
> Fixes: 769e49d87b15 ("PCI: qcom: Sort and group registers and bitfield definitions")
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..59823beed13f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -43,7 +43,7 @@
>  #define PARF_PHY_REFCLK				0x4c
>  #define PARF_CONFIG_BITS			0x50
>  #define PARF_DBI_BASE_ADDR			0x168
> -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
> +#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x358 /* Register offset specific to IP ver 2.3.3 */
>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
