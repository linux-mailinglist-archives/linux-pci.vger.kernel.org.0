Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C415595F4
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiFXJCb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiFXJC3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 05:02:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48247AE0
        for <linux-pci@vger.kernel.org>; Fri, 24 Jun 2022 02:02:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g186so1849065pgc.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Jun 2022 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=etgD3mQYX8lafc70ATrNso8/a4xF9dGvX9boel3rDF8=;
        b=xXkjo/pcL+djF7cpvAo54CLDp7p+8tLxoK0mQKGHxUzu0JzINPgpt+ClGllGrZ3745
         dC7kNkrSBZbaUI9HpE2dWMFcDQFW+ZoVRo42V00HUC2S6ZtZCmPzUNAj5HKba9b+4Xcq
         oCfDgAOupZanJ0VCVmYTt0FhUQVxESKHGN4g5Lte5Dz1MTDsCZ2amZyL26I3c4nrSsyS
         Euq161M8Uo2CWwWUFwgnlUDoaRpKC51VeKtMSS2OEQMCD/wockR5Gh+OgBrMXrnA4p7U
         H8s4DFTmV8K9zxN0gT7vel38NR0Vzc2aypwRea2lGNd63iCtWCSXIptV6OqXUeUhRHe5
         ugVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=etgD3mQYX8lafc70ATrNso8/a4xF9dGvX9boel3rDF8=;
        b=PffNtMJJpBH8vHI1BowJPLeY4qHu8IZqYBOSaYn155N6owDLSz2Ydcr654NQTz1ScN
         69bH2R6BMiL6mgepUbth6/Wimm8MZpqfkI2/QlV3cyOZ5rzh/7QWUrVyhJFJFD14lTtH
         o4MbPIzQSQUG98ZRqrIlKyQAj0GykU6Q+cH/DyDucRLqbtzislg8g27wUU/fvKvbu32N
         cHy4bf6A7zM3Bnsal5Mz8l5hcpVyTp24e+OjSZniIIXRNmnL0e6yRvYjOjT6Un4fySg/
         96jjDQY53p7iDa74UmM+GXxLW2UDCvExIf0M0afSkQFUa/tsFjhpVXned9xrZ0J9s0AD
         6Nzg==
X-Gm-Message-State: AJIora8qKK4A7eKgHIvfwMc2gFnadQ48P0x0mbxearm4O58BfSwa7ARR
        EJCVagz1HODBsREHORI+ysGU
X-Google-Smtp-Source: AGRyM1sRNbw996u1ohZkOPv+3fE8vM1jY/vEjUIR4F/wMySKOZyPIS9yYErOYWnPOlec6tWKncqzHw==
X-Received: by 2002:a05:6a00:8cb:b0:510:9ec4:8f85 with SMTP id s11-20020a056a0008cb00b005109ec48f85mr44884354pfu.24.1656061347407;
        Fri, 24 Jun 2022 02:02:27 -0700 (PDT)
Received: from thinkpad ([220.158.158.183])
        by smtp.gmail.com with ESMTPSA id w17-20020aa78591000000b0051b9ac5a377sm1106757pfn.213.2022.06.24.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 02:02:27 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:32:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: qcom: Allow L1 and its sub states
Message-ID: <20220624090217.GC12171@thinkpad>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
 <1655298939-392-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655298939-392-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 06:45:39PM +0530, Krishna chaitanya chundru wrote:
> Allow L1 and its sub-states in the qcom pcie driver.
> By default this is disabled in the hardware. So enabling it explicitly.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab9089..0d8efcc 100644
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
> +	/* Enable L1 and L1ss */
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
