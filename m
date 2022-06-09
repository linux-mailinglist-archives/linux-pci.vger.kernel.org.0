Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD850544A08
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 13:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiFIL0n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 07:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243531AbiFIL0m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 07:26:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07CE11E1FE
        for <linux-pci@vger.kernel.org>; Thu,  9 Jun 2022 04:26:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u2so20840457pfc.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Jun 2022 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V4IYMDqP7Q3RRyht9p4c+8sPxp25evrg3IFf8iyBHM0=;
        b=A6GJjzlSq+ZIMpBaEppi0DLytXW7CwNtB9jJEKfRFg8tpuFUhWIpExRT8yGgP1Twe3
         UEXH4I86hWsKAmY1Rlet8GqXh6hAnQOtcR82ojJd6WC+Dte6mXJ5pbXX421Z74Jl8WEK
         8M1lx85EMJ8swfR2r9mVStZP7PuRQaAGvVb5vETjIXEEdUeEVvA12h8JYi/CGrQu8JYB
         +ihQPHEBbc/Ie4N3pXAgTOjMq5H7rxXWlePd3bHhO+SdTJWwjC0UOIgnFe8MDNGAFwZT
         QweViCG63wXK+f+cwj2QKDoNLI71TJeWXd37e7zVkMn1B6ApPPrvpGtjEtV8qx7GoIyN
         J4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V4IYMDqP7Q3RRyht9p4c+8sPxp25evrg3IFf8iyBHM0=;
        b=xOm6MbBL0RXA/ErUxV80Zmph8fYH2UVAj44Z3yPG+PlPY58AYCdGwQIyAedqf7QDzD
         PNZ6G0cx6+Bcr+ilBTmQwJu/PrfMNsegVu8zA6aSImQXnwzE+x8A8MlIVZPeLkmbGfdN
         gwp/J/3QQseupt2Cs2ja2ZxsD8FfLdMS7z5+XXByt4CNyHqaaQWPeIzFt/gck3FMgd6z
         4rPZVsbO0bfy7qs73N+PhGFcF6T8aGJxnkXkr7J7rCXZnIjDv+AfsEZowAx4u5LSg/RC
         8cmaOpGn0z5/ylzpT1pqrZYWCuxtTRsNpppYRNZmRWgeMuLlZ4cMr/qvBw9yoAT2dvqb
         1EDQ==
X-Gm-Message-State: AOAM531bgbZybnpAkf6moEV14eXRlRabMSH6aB+ZszAYFVqxhPZEhDqI
        LvsDZ7EldeJJcz1949+Xx6vX
X-Google-Smtp-Source: ABdhPJw42NUzFVmYVWRCmMNT8kSTjxDpaoLNjchqNA909Y8IVWjVRVzfRaaTUOCzma9ZVewl0DRXgw==
X-Received: by 2002:aa7:8d11:0:b0:51c:4f6d:1562 with SMTP id j17-20020aa78d11000000b0051c4f6d1562mr9721191pfe.14.1654774000221;
        Thu, 09 Jun 2022 04:26:40 -0700 (PDT)
Received: from thinkpad ([117.217.188.216])
        by smtp.gmail.com with ESMTPSA id r8-20020a638f48000000b00401a9bc0f33sm376191pgn.85.2022.06.09.04.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:26:39 -0700 (PDT)
Date:   Thu, 9 Jun 2022 16:56:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: qcom: Allow L1 and its sub states on qcom dwc
 wrapper
Message-ID: <20220609112630.GG2758@thinkpad>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 12:48:50PM +0530, Krishna chaitanya chundru wrote:
> Allow L1 and its sub-states in the qcom dwc pcie wrapper.

s/wrapper/driver

Also there is no need to use "qcom dwc" in subject. Prefix makes it explicit.

> By default its disabled. So enable it explicitly.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab9089..f60645c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -41,6 +41,9 @@
>  #define L23_CLK_RMV_DIS				BIT(2)
>  #define L1_CLK_RMV_DIS				BIT(1)
>  
> +#define PCIE20_PARF_PM_CTRL			0x20
> +#define REQ_NOT_ENTR_L1				BIT(5)
> +
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> @@ -1267,6 +1270,11 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	val |= BIT(4);
>  	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>  
> +	/* Clear PARF PM REQ_NOT_ENTR_L1 bit to allow L1 states */

Mentioning the field in comment is redundant. Just say "Enable L1 and L1ss"

Thanks,
Mani

> +	val = readl(pcie->parf + PCIE20_PARF_PM_CTRL);
> +	val &= ~REQ_NOT_ENTR_L1;
> +	writel(val, pcie->parf + PCIE20_PARF_PM_CTRL);
> +
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
>  		val |= BIT(31);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
