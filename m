Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA29C4A880A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 16:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351984AbiBCPwM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 10:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349441AbiBCPwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 10:52:11 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7100EC06173B
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 07:52:11 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id v67so4665853oie.9
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IyxXGrc+iIhiZuNi9X8+t5WRE74q00AdoMGIm2j9O3o=;
        b=iB0JsbPNF8EjQ9Pdapq9paPYO939BEI5+1vY/0kUKGtG+yHHCGUFI8DHmQ98BYGVxd
         90U85PWPBhRf7DxtPwkN+3+O/1nBspkpnJ3pyt3yn0kUXdozTr2k0WEcKrm/24gUy632
         Do19qYlWRhP1aaio1gi9jXwK4mZpNjJiOKRfbqKS9IdhxqovwnkgFBodeWG9ln5TVl7b
         oT+XRl0+ZNTlDwO0TBrubxGgeqOKoxYNmtV7R5yPscu3dB7t5mBmHtjliCmfxzq6rLIn
         kM9dHq6dPd3cqUQXdxnLDQl+sbtK2mI7cUOcKeeKwr+2VasFJrtdiV8vB3Xlod6NDwSZ
         9Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IyxXGrc+iIhiZuNi9X8+t5WRE74q00AdoMGIm2j9O3o=;
        b=EArkCzU1SpdugFAEIPWu4hIMwuAk2C2xCLjwuOQIwZ4EfnyaIsyScnEJPMtw434SW+
         TTlTtCUmLkCKunBsAp5QA5qE9cSk44KYbThd8xxL25XkoedmZiZZajyVn155zIv+QMyY
         8GBOOgYBvLPMW+N+YZMocFIRy1kJjD4NxXMua+0WdBNaUUX37ZFr+PRYUJ6qZdsvJ8Vo
         +8ZUVvkMxE4A1xrbBmt/f6X9Cix5yf9IaB7xZGJpdSyYNtKQ3F18anLOpcPlpocIzU4d
         tHPr2OyQEMgz7MkCkNlAEbw8P73/j+rk8G95X8toXSy9Vtx2Gv7QFP6ut2yPRq+p+QlB
         CJbw==
X-Gm-Message-State: AOAM533zMHXX7kqSNnecaMPAIgIS1X2mJHL0SBV4dUqauqHsIJG5G7QP
        u9IL9i6jMP5TlD4pC1A5ck6flQiTWZqcCw==
X-Google-Smtp-Source: ABdhPJzNNI9M8bwSEXYi9IuzmJMsfZ1cvFl8/Fe/mZngkR5s0GI7zU7B5eLyfjJ5JfzdmCbnKPga/g==
X-Received: by 2002:a05:6808:17a0:: with SMTP id bg32mr7766245oib.37.1643903530781;
        Thu, 03 Feb 2022 07:52:10 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id p9sm203949oaq.42.2022.02.03.07.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:52:10 -0800 (PST)
Date:   Thu, 3 Feb 2022 07:52:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 3/5] PCI: qcom: Add ddrss_sf_tbu flag
Message-ID: <Yfv6Oyk19xonWX33@ripper>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141024.500952-4-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:

> Qualcomm PCIe driver uses compatible string to check if the ddrss_sf_tbu
> clock should be used. Since sc7280 support has added flags, switch to
> the new mechanism to check if this clock should be used.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1204011c96ee..d8d400423a0a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -191,6 +191,7 @@ struct qcom_pcie_ops {
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  	unsigned int pipe_clk_need_muxing:1;
> +	unsigned int has_ddrss_sf_tbu_clk:1;
>  };
>  
>  struct qcom_pcie {
> @@ -1133,7 +1134,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	res->clks[3].id = "bus_slave";
>  	res->clks[4].id = "slave_q2a";
>  	res->clks[5].id = "tbu";
> -	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sm8250")) {
> +	if (pcie->cfg->has_ddrss_sf_tbu_clk) {
>  		res->clks[6].id = "ddrss_sf_tbu";
>  		res->num_clks = 7;
>  	} else {
> @@ -1449,6 +1450,7 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
>  
>  static const struct qcom_pcie_cfg sm8250_cfg = {
>  	.ops = &ops_1_9_0,
> +	.has_ddrss_sf_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc7280_cfg = {
> -- 
> 2.34.1
> 
