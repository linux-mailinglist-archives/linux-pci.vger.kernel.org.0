Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293471A1D96
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgDHIug (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 04:50:36 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:45587 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHIuf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 04:50:35 -0400
Received: from [192.168.1.4] (212-5-158-69.ip.btc-net.bg [212.5.158.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 4BBD8CFC0;
        Wed,  8 Apr 2020 11:50:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1586335833; bh=VUmYcFEO7NNN/MSIoiBKEvvOXuA+7rJ5pDAjZuR1kLA=;
        h=From:Subject:To:Cc:Date:From;
        b=ci40BPENwwbDsTVXirwhkCoHnfcqaECTX+P+T2Zo7BlWq3QtcDsyMpea8HgDqug3B
         0Oh02x0lgO2Km97tBsuHUFMc2CgKhjUys9jBhFbGciyt18Vcj0nb13W8qU13Pl+gW0
         KoGFEl+SZyR10R3YE5UzMjU3KYaQ9wrei75E2kPT+iPnvjKwPE+kcxf8jhFh7qnsWn
         lotLrB1xPkCVTOegQ8aQvIq047VckOLlxl9v37SLMS21K6oz5ckqZBjiRhi+DfsK8j
         uajRDM3gnncYuwjTxN06uP6ObcrFtR8RM+lcS2rbSe/O7XYKSZTFDIhZfiHrrOdiU0
         lIlUGza6Flyqw==
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v2 01/10] PCIe: qcom: add missing ipq806x clocks in PCIe
 driver
To:     Ansuel Smith <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
 <20200402121148.1767-2-ansuelsmth@gmail.com>
Message-ID: <b09627a8-d928-cf5d-c765-406959138a29@mm-sol.com>
Date:   Wed, 8 Apr 2020 11:50:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402121148.1767-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ansuel,

On 4/2/20 3:11 PM, Ansuel Smith wrote:
> Aux and Ref clk are missing in pcie qcom driver.
> Add support in the driver to fix pcie inizialization in ipq806x.
> 
> Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver

this should be:

Fixes: 82a823833f4e PCI: qcom: Add Qualcomm PCIe controller driver

and add:

Cc: stable@vger.kernel.org # v4.5+

But, I wonder, as apq8064 shares the same ops_2_1_0 how it worked until
now. Something more I cannot find such clocks for apq8064, which means
that this patch will break it.

One option is to use those new clocks only for ipq806x.

> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 5ea527a6bd9f..f958c535de6e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -88,6 +88,8 @@ struct qcom_pcie_resources_2_1_0 {
>  	struct clk *iface_clk;
>  	struct clk *core_clk;
>  	struct clk *phy_clk;
> +	struct clk *aux_clk;
> +	struct clk *ref_clk;
>  	struct reset_control *pci_reset;
>  	struct reset_control *axi_reset;
>  	struct reset_control *ahb_reset;
> @@ -246,6 +248,14 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->phy_clk))
>  		return PTR_ERR(res->phy_clk);
>  
> +	res->aux_clk = devm_clk_get(dev, "aux");
> +	if (IS_ERR(res->aux_clk))
> +		return PTR_ERR(res->aux_clk);
> +
> +	res->ref_clk = devm_clk_get(dev, "ref");
> +	if (IS_ERR(res->ref_clk))
> +		return PTR_ERR(res->ref_clk);
> +
>  	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
>  	if (IS_ERR(res->pci_reset))
>  		return PTR_ERR(res->pci_reset);
> @@ -278,6 +288,8 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
>  	clk_disable_unprepare(res->iface_clk);
>  	clk_disable_unprepare(res->core_clk);
>  	clk_disable_unprepare(res->phy_clk);
> +	clk_disable_unprepare(res->aux_clk);
> +	clk_disable_unprepare(res->ref_clk);
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>  
> @@ -307,16 +319,28 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  		goto err_assert_ahb;
>  	}
>  
> +	ret = clk_prepare_enable(res->core_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable core clock\n");
> +		goto err_clk_core;
> +	}
> +
>  	ret = clk_prepare_enable(res->phy_clk);
>  	if (ret) {
>  		dev_err(dev, "cannot prepare/enable phy clock\n");
>  		goto err_clk_phy;
>  	}
>  
> -	ret = clk_prepare_enable(res->core_clk);
> +	ret = clk_prepare_enable(res->aux_clk);
>  	if (ret) {
> -		dev_err(dev, "cannot prepare/enable core clock\n");
> -		goto err_clk_core;
> +		dev_err(dev, "cannot prepare/enable aux clock\n");
> +		goto err_clk_aux;
> +	}
> +
> +	ret = clk_prepare_enable(res->ref_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable ref clock\n");
> +		goto err_clk_ref;
>  	}
>  
>  	ret = reset_control_deassert(res->ahb_reset);
> @@ -372,10 +396,14 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
>  	return 0;
>  
>  err_deassert_ahb:
> -	clk_disable_unprepare(res->core_clk);
> -err_clk_core:
> +	clk_disable_unprepare(res->ref_clk);
> +err_clk_ref:
> +	clk_disable_unprepare(res->aux_clk);
> +err_clk_aux:
>  	clk_disable_unprepare(res->phy_clk);
>  err_clk_phy:
> +	clk_disable_unprepare(res->core_clk);
> +err_clk_core:
>  	clk_disable_unprepare(res->iface_clk);
>  err_assert_ahb:
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> 

-- 
regards,
Stan
