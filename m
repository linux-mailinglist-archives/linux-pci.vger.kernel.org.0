Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1314275C9E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 17:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIWP6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 11:58:23 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33248 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWP6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 11:58:23 -0400
Received: by mail-il1-f193.google.com with SMTP id y2so129829ila.0;
        Wed, 23 Sep 2020 08:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=za4dzsCtkhhKE2qSFREMD9TZL8grdfoNBNEF/t9aU8I=;
        b=UiIpb7zkzy3hC34kGdvgNSm21JzyjFaRoBANmvV2kslflNYStlvC7HHSBcomTvP33h
         GeSHQJkW4VZ9QgKoitulS/3qv31gApblKpd+JhCo0+C9hvYhpsbe3KNq2hAAKc7mxS/8
         XUZlAbEiTWVdJSc+ecEj9V+svzvEOyosz4U6hLn751IHnlVEWAzZf9UClQPFb6O1mPqq
         lqWseA4bKD+cbBH64n5Yh+nkpcQbJljFoZN+BAPy2s4AAEn91/LSowN0E60bx7w+CQik
         r54dT/2RjnMyisQB2qhEnmsp/gDXzsFIXukDF4Sm1VcSn27JcjY9hnjfaeeC/HEYAO7W
         g8Gg==
X-Gm-Message-State: AOAM531XA1UjjAJ3LrViohPi9z6OyK2g+ywOH8bdaLyTrUwLQ5wAA1Ma
        YKC5xJXoZf+RLGcln1eYJQ==
X-Google-Smtp-Source: ABdhPJyIjRvQdWuwtq80W4I2hGjILoCUSMd5IE/qDYtsXFBJbCq6Bzodcgk1lvY+nbjDTvEaZmEQLw==
X-Received: by 2002:a92:6b04:: with SMTP id g4mr423262ilc.192.1600876701801;
        Wed, 23 Sep 2020 08:58:21 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s23sm127845iol.23.2020.09.23.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:58:20 -0700 (PDT)
Received: (nullmailer pid 827972 invoked by uid 1000);
        Wed, 23 Sep 2020 15:58:18 -0000
Date:   Wed, 23 Sep 2020 09:58:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] pci: controller: dwc: qcom: Add PCIe support for
 SM8250 SoC
Message-ID: <20200923155817.GA811543@bogus>
References: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
 <20200916132000.1850-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916132000.1850-5-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 06:49:59PM +0530, Manivannan Sadhasivam wrote:
> The PCIe IP on SM8250 SoC is similar to the one used on SDM845. Hence
> the support is added reusing the 2.7.0 ops. Only difference is the need
> of ATU base, which will be fetched opionally if provided by DT/ACPI.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3aac77a295ba..ca8ad354e09d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1370,6 +1370,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	struct pcie_port *pp;
>  	struct dw_pcie *pci;
>  	struct qcom_pcie *pcie;
> +	void __iomem *atu_base;
>  	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -1422,6 +1423,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	/* Get the optional ATU region if provided */
> +	atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
> +	if (!IS_ERR(atu_base))
> +		pci->atu_base = atu_base;
> +

This is getting moved to the DWC common code[1].

Rob

[1] https://lore.kernel.org/r/1599814203-14441-3-git-send-email-hayashi.kunihiko@socionext.com

>  	pcie->phy = devm_phy_optional_get(dev, "pciephy");
>  	if (IS_ERR(pcie->phy)) {
>  		ret = PTR_ERR(pcie->phy);
> @@ -1476,6 +1482,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
> +	{ .compatible = "qcom,pcie-sm8250", .data = &ops_2_7_0 },
>  	{ }
>  };
>  
> -- 
> 2.17.1
> 
