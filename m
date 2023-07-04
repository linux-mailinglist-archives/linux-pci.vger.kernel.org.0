Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC38C74716F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGDMdU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGDMdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 08:33:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852EE7E
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 05:33:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso8803328e87.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Jul 2023 05:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688473987; x=1691065987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzgQQIKNDoBtiJAoujjApNzPmxlwUw+BR/55LC+iVio=;
        b=CfEh/KBX/LDElugpqwu2sDiT5kzXeo1eUeTMkkVqIJI2SqJcdnjVe2vPA2dqVHS1To
         /DvB2YRM9V3P7Wch1cEt6adXxVs7BbjGuxZ/Vhq0SLNNWwyq4OPGy+biCdIp3o2brOyo
         +875WKhU9m/NCiMugZ8F4R84ttG3MSGh4kOeMs+jZRbLoGVYQUh10a/jZqZ4jvHnT92f
         XaKepWIKwo/gHccmOsMfF2VjUwXlbOtmaelEDM7XXjHvrcvLki6YRaV4K1EGdAg69d9V
         PdlIrairKLZ2UQLKC1Ir5xWwHix969JD4ISXs3esm7Co8feRDKjFLuBsq1cPMfpDdeQ5
         G0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473987; x=1691065987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzgQQIKNDoBtiJAoujjApNzPmxlwUw+BR/55LC+iVio=;
        b=Kddn949Ge5WXaKrk6wqo3U75SeZ+cKEVVR3bPynhyVDBSC8s2qBRs/A7PX7lDtp7xh
         feP5Zqj0INWNVGsAIHutPI/zL6jnGqrtDB70JYw6B4/sMn6sNlmB2dS8tKABadSvJaAD
         sIcSreMkjanQcDZ2Zd8cE/4WTl+jxCN31QlEudbMfd5BBZ0uad7yQvsAfSqX+FHR+VuW
         IcKShxDnSOdHNJe19RvcvxLi9PDmIC89qLUKeQS4618ecnH5d2Cn93gRbmJuqyaiAhgN
         ynPlK126QZ4Iyl49Lxnl7RyKODoQXHpgXDbizGz471Td1MyJDITru82vW9yxd/BxudB4
         Mo+w==
X-Gm-Message-State: ABy/qLbu/I+jEkeObDu/Ij8RQKXY19mxQFIdGV6abmhLRaFAUqXFZzSe
        Rh8pDEtbAAT/IynkZBj4NwjsGQ==
X-Google-Smtp-Source: APBJJlES1dFuMDEMs90e8mGzZJHQmmY+3FjM1O68m2ZDGiywI0ysXyovZjddRxhtodG9hlyCBhFx7Q==
X-Received: by 2002:ac2:4ec5:0:b0:4fb:7de4:c837 with SMTP id p5-20020ac24ec5000000b004fb7de4c837mr8424423lfr.68.1688473987006;
        Tue, 04 Jul 2023 05:33:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id r4-20020a19ac44000000b004fba5c20ab1sm2527946lfc.167.2023.07.04.05.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 05:33:06 -0700 (PDT)
Message-ID: <05666bf0-07f8-1e3a-22bf-fc779e2b7367@linaro.org>
Date:   Tue, 4 Jul 2023 14:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2] PCI: qcom: Use PARF_SLV_ADDR_SPACE_SIZE for ops_2_3_3
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, mani@kernel.org,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20230703175757.2425540-1-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230703175757.2425540-1-quic_srichara@quicinc.com>
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

On 3.07.2023 19:57, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
> 2_3_3 post_init ops. pcie slave addr size was initially set
> to 0x358, but was wrongly changed to 0x168 as a part of
> "PCI: qcom: Remove PCIE20_ prefix from register definitions"
> Fixing it, by using the right macro PARF_SLV_ADDR_SPACE_SIZE
> and removing the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
> 
> Without this pcie bring up on IPQ8074 is broken now.
> 
> Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  [V2] Fixed the 'fixes tag' correctly, subject, right macro usage
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..1689d072fe86 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -43,7 +43,6 @@
>  #define PARF_PHY_REFCLK				0x4c
>  #define PARF_CONFIG_BITS			0x50
>  #define PARF_DBI_BASE_ADDR			0x168
> -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> @@ -811,7 +810,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  	u32 val;
>  
>  	writel(SLV_ADDR_SPACE_SZ,
> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
> +		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>  
>  	val = readl(pcie->parf + PARF_PHY_CTRL);
>  	val &= ~PHY_TEST_PWR_DOWN;
