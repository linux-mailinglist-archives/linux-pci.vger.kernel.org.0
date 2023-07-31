Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CB07692A1
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 12:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjGaKBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGaKBT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 06:01:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F091D3598;
        Mon, 31 Jul 2023 02:59:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bccc9ec02so684228666b.2;
        Mon, 31 Jul 2023 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690797569; x=1691402369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6btwtxFM0exA7hajr4yQPObG72hgpwZQHb0o/diXn8=;
        b=KYGP/raz1IL6SXz9GdbWlegE4tKzmySleQiJiEGnai6C+nJmxDJp+0DqPvH1sJAWDa
         o8c9+MdioOU3zMbVBRWb0jVLuw4ZhMcAuF0+5Be3d+QPyk/ODbFKcYwhVgHz1Yw0gUmu
         OKYhrI/OANqx2fS9VE6yhVCNakZw1OYVFWNmbYtk2Q7hycUQIZFQzwCaqol4IMiIAoNc
         ZY5JlKXzpoBKFq/EAou7z/1GDYtKlOE7XQtFH7V5S1O+fdWPZ2QAhQgEn8tXTaDBaZS9
         lYxkKXxBkpOcOwl4XZ2nQNQe5ItCo98rDX+k0wJ+1Bt0fwsEE8evnf299mTaKvZqHGwf
         1mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797569; x=1691402369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6btwtxFM0exA7hajr4yQPObG72hgpwZQHb0o/diXn8=;
        b=PdI4j4P9I2VsoGkrqBAr7Po85JT8PuHIx3WagNg8Jn9r0Pcb+D3D/hmr+omSHTqo+C
         S3gY0LifZSaBpirEa64iFQcYZd8DIGhpddd0fhKQr5/+qtyUfkXaT6ohHY4m8ZoHuMgM
         GWZvGL+KoWWwHHeV2S8NuUR67iOtAwwv4c7XbTlp575v5HT12/FnsD237dK5jgx9eCmi
         El+qCbEQ9xIHlH+oRxLFkfkyV/uBkhmtEHKPTYN63efW9gxJgYj8noCXy5AuzwTBzCUv
         PHouve+bmqI0OXfgQGZ7M9/BfQ8Q5N61NrlmlWFcL4D29+ipfgbfq14/orqRC3dL458d
         22vQ==
X-Gm-Message-State: ABy/qLZdr46hLLdkFOvf3I9VKLgMMCy2DkprlMtdjBfd4D8pFEdbSi3q
        4sH+vCPwnUQgIo8Z3lkGAHM=
X-Google-Smtp-Source: APBJJlHXWtuHxida9k1IkQW8Pq1jD1+TJQF0qW3h0tswoDv7cYKWZ9nDxIcCkHwunl05C+kCHUlXcQ==
X-Received: by 2002:a17:906:2219:b0:99b:e5c3:2e45 with SMTP id s25-20020a170906221900b0099be5c32e45mr6118052ejs.28.1690797568995;
        Mon, 31 Jul 2023 02:59:28 -0700 (PDT)
Received: from [192.168.3.32] ([213.149.38.169])
        by smtp.gmail.com with ESMTPSA id x23-20020a1709065ad700b009893b06e9e3sm5991877ejs.225.2023.07.31.02.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:59:28 -0700 (PDT)
Message-ID: <ee25836b-f49f-acf2-086f-3c39f1e088b8@gmail.com>
Date:   Mon, 31 Jul 2023 11:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V5] PCI: qcom: Fixing broken pcie enumeration for 2_3_3
 configs ops
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh@kernel.org, mani@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com, kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org
Cc:     stable@vger.kernel.org
References: <20230724063429.3980462-1-quic_srichara@quicinc.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20230724063429.3980462-1-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 24. 07. 2023. 08:34, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074 2_3_3 post_init.
> PCIe slave addr register offset is 0x358, but was wrongly changed to
> 0x168 as a part of commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix
> from register definitions"). Fixing it, by using the right macro and remove
> the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
>
> Without this access to the registers of slave addr space like iATU etc
> are broken leading to pcie enumeration failure.
>
> Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> Cc: <Stable@vger.kernel.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

I can confirm this fixes Gen2 PCIe on Xiaomi AX9000 (IPQ8072A) so:
Tested-by: Robert Marko <robimarko@gmail.com>

> ---
>   [v5] Fixed subject, commit log
>   [v4] Fix commit sub and added '<mani@kernel.org>' reviewed-by tag
>   [v3] Added reviewed-by tag, fixed subject, commit text
>   [v2] Fixed the 'fixes tag' correctly, subject, right macro usage
>
>   drivers/pci/controller/dwc/pcie-qcom.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..8418894b3de7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -43,7 +43,6 @@
>   #define PARF_PHY_REFCLK				0x4c
>   #define PARF_CONFIG_BITS			0x50
>   #define PARF_DBI_BASE_ADDR			0x168
> -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
>   #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>   #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> @@ -810,8 +809,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>   	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>   	u32 val;
>   
> -	writel(SLV_ADDR_SPACE_SZ,
> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
> +	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>   
>   	val = readl(pcie->parf + PARF_PHY_CTRL);
>   	val &= ~PHY_TEST_PWR_DOWN;
>
