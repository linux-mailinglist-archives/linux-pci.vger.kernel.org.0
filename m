Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8475B27F48E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgI3V4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:56:35 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:43596 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbgI3V4f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 17:56:35 -0400
Received: from [192.168.1.7] (unknown [195.24.90.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id DC0AAD02C;
        Thu,  1 Oct 2020 00:56:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1601502992; bh=68306tD5YsLAUj9ja2C1ptuKKgPEa+UuaTIaQDbVT2s=;
        h=Subject:To:Cc:From:Date:From;
        b=aDkrizEokwM7XC4UymK132wXDpetASonhfo+m6Zr7vuJDWMGap2VG9ZekNCX9+amf
         2hrFtWUZSO9KghaB7t9rmYCJgGiULzfIx8/DY7RcYMAZdsRCGk8XUeStur6BpWOJ0S
         z9hgZ8F77eeMA7cAHlLt3mS8q/qADNtQsq5zO0Z2BX2h++dVTZ4SINoKhz6HkPuxVP
         m2OJ4+Atvw9Z+mXfGDBktDKYKnh2iVShGzL9Si4szaIjRjpsLEUgR+tc25YcFMvVCL
         yeZINPUhPptQ1hKtcKt/AFLHFHA6Uki1UZsR4VxDvOFmRJtDUAfvawVX/10YKpgGyQ
         UUCd1L17tDSWA==
Subject: Re: [PATCH v2 4/5] PCI: qcom: Add SM8250 SoC support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        devicetree@vger.kernel.org
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
 <20200930150925.31921-5-manivannan.sadhasivam@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <0a6a765d-1b80-9d1b-f881-b75f13bd5b02@mm-sol.com>
Date:   Thu, 1 Oct 2020 00:56:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930150925.31921-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

On 9/30/20 6:09 PM, Manivannan Sadhasivam wrote:
> The PCIe IP on SM8250 SoC is similar to the one used on SDM845. Hence
> the support is added reusing the members of ops_2_7_0. The key
> difference between ops_2_7_0 and ops_sm8250 is the config_sid callback,
> which will be added in successive commit.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3aac77a295ba..44db91861b47 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1359,6 +1359,16 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
>  	.post_deinit = qcom_pcie_post_deinit_2_7_0,
>  };
>  
> +/* Qcom IP rev.: 1.9.0 */
> +static const struct qcom_pcie_ops ops_sm8250 = {

This breaks the policy compatible -> ops_X_Y_Z. Could you introduce new
method config_sid and check into for compatible qcom,pcie-sm8250 string
there?

> +	.get_resources = qcom_pcie_get_resources_2_7_0,
> +	.init = qcom_pcie_init_2_7_0,
> +	.deinit = qcom_pcie_deinit_2_7_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +	.post_init = qcom_pcie_post_init_2_7_0,
> +	.post_deinit = qcom_pcie_post_deinit_2_7_0,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  };
> @@ -1476,6 +1486,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
> +	{ .compatible = "qcom,pcie-sm8250", .data = &ops_sm8250 },
>  	{ }
>  };
>  
> 

-- 
regards,
Stan
