Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921A070BEF8
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 15:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjEVNBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjEVNBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 09:01:05 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FD3C1
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 06:01:03 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-561c5b5e534so79487837b3.2
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684760463; x=1687352463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1zAQFPS/NOrDtHfh7us8IMqoHHNVCAtXqoz7Nsv+9RU=;
        b=PSG0oL8Evkzt9SV1hgwSpdY47gx0ABuMj1SfvlEV3s/SuIgt33liG7AlesoOiAtrJf
         mDGn5fqbKuWuuvKkUAE6VZGMLYjfJyeIh8i7C4gxikJPkQPAFNCatU/o8z4pvhF/cjB2
         YaQcUrZHM6kC6e/LKeZn9b8DTO7yvrBmAGXl1G0OehRTolbUSwaeJ7QcZE01beuiwhfs
         Ozj8MrQOIRCpsCOGTbe0YPF9wSwxQ8FtyJcO0cYmkwf5j+NPTa7VQDVJQ7BOcziSGp0N
         h4oI6b8i0mnRKHS77xbHpPtzVfEJYs9HHcE5M3JPCFnwiBnf4o+roQbgkmPw4XaHxYyk
         nMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684760463; x=1687352463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zAQFPS/NOrDtHfh7us8IMqoHHNVCAtXqoz7Nsv+9RU=;
        b=eGDnU5vTLWp+yFAqiJh7CzeMsdhgsmLoOmoyLfoPqEtg/UkPY2NFYoNyxq2lm4WiZD
         mvUGOCyTtUbku957dp6/XMSS9U/Nxh6FMNilPOdVHuqA84qhddZCQ/nzQMcJpMTnQx+I
         Xe1ddqrkkMSjow0VMETN5IdajBEvYYC6G1GqXlktThUeRqIDtHh58BT8/NfOsNLFgtuG
         gibPuNjYoD3ZJSeY6tmGeABM6RHX74UcSS7c/04kuNdYnegryeA8clSeqyMBWFueIhJi
         RGIho8OiSljGdjxreoZ7Ge7Fr4eSoNxZyY8A8KCQKRB1IFGtWoFo2Z6cm7JXrSOsRPS2
         n8/g==
X-Gm-Message-State: AC+VfDyxCvtD7AbOw/8AzOVhv3psHeoL7YOIFWwHgm7Lxc+u/LIRMp7a
        +iW8nLjLB9N56zLcxw95EBIC2dPPMPeQLaHnqFLh6Q==
X-Google-Smtp-Source: ACHHUZ6b85uKugyh4h+vMNoTPfsrEApe6Rixqynr0A+edX6/Mm3v6iJRXC3bk3Iw1YeKJSSRXiplW64K4VqfjioXPbc=
X-Received: by 2002:a0d:dd0b:0:b0:561:985c:1ecc with SMTP id
 g11-20020a0ddd0b000000b00561985c1eccmr12523627ywe.19.1684760462016; Mon, 22
 May 2023 06:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org> <20230519143117.23875-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20230519143117.23875-3-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 22 May 2023 16:00:51 +0300
Message-ID: <CAA8EJpoEPN9rAefZWxUSG50qsz-GZxtUsYS4xoVX4VUh2ig-og@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] PCI: qcom: Disable write access to read only
 registers for IP v2.9.0
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 May 2023 at 17:31, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> In the post init sequence of v2.9.0, write access to read only registers
> are not disabled after updating the registers. Fix it by disabling the
> access after register update.
>
> Fixes: 0cf7c2efe8ac ("PCI: qcom: Add IPQ60xx support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>

Could you please drop the @gmail R-B tags? I was mistaken when sending
them (I'm not even sure that this email exists).

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 01795ee7ce45..391a45d1e70a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1136,6 +1136,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>         writel(0, pcie->parf + PARF_Q2A_FLUSH);
>
>         dw_pcie_dbi_ro_wr_en(pci);
> +
>         writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>
>         val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> @@ -1145,6 +1146,8 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>         writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
>                         PCI_EXP_DEVCTL2);
>
> +       dw_pcie_dbi_ro_wr_dis(pci);
> +
>         for (i = 0; i < 256; i++)
>                 writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
