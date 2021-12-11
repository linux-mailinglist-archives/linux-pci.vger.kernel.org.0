Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D8471001
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 02:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhLKB7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 20:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241105AbhLKB7v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 20:59:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6339C0617A1
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 17:56:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id cf39so9028194lfb.8
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 17:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WRjOyjdU++vZzJyPE3S61Z0gYV1Whs2PzLmzy5FdXJg=;
        b=ZaxWZeXWVTwZbvlqCJwFZBJhWZveUZlzT842tLSzv48iFtLKRg+b5D6Fx4LqAm48C3
         HoIyon/LG5uLTUy5oqKIIAGnyY8SjfMIbWdskSAR++WSgowWlPZoOQJbbfP6YyKEuH8w
         S9YM06aZhl6X29tp1tsovavbR/AVQQzXfcZgzisAHeFkoja0lY0ENlL3FGEwvAK0wN6J
         Wbr0ePqsSLNlzOSCiaZYBWpoQTTFHyXeWYO2Qk48i9n51NtC1gxyXZa9f20m+OF2Mkjv
         DbBdxtDeNBzJ2cdQFYZNUxFdRPzdq1HU/JtAgyL/Q8Tj0iMDKu6J+ekMM8n9rVAof+kC
         B+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WRjOyjdU++vZzJyPE3S61Z0gYV1Whs2PzLmzy5FdXJg=;
        b=ZBAPqrFdhy5TibcmUziAxiAvcHxvSKbBvltmxZ4tYAUeLUlfm+hExLOAKJUl35EgO9
         SYOmmRgKfpGl1V7mM+YhfhDeeJC25X2PygOXNCxKA91Grm39TV6z3gttx4LPHuee06Qy
         F1bHlpSxopHLrbLDeeaj0jYeKEXgaYckG5zb4Y9TAQSW7OxbF5M7RlXC3SKcCeSjjJOL
         P6OkUDXkRSpETRVjwbH2Z+jxrxtAo0y7/9rhPKc47LOdv3RgrgXbB6JcEuT1osYWgr/U
         4sQlmtrMXyp9aEqDmubOaVkmZaJ4drM//3fvMxNzWji3+Z0RHdXYPsVO4UWj7RUpM+Xj
         RPWA==
X-Gm-Message-State: AOAM533rhnwvonYuFsKu5AG2lBnY5BXJ7ZsyiOu/tSRsdj8WMpT/Vhry
        HJfzyik/HebalGEDZ3spizFUHrpDWjMq7Zwc
X-Google-Smtp-Source: ABdhPJwfOp7OXGZI/vDNdRclH1f+rwGeKRcQE06pGa3xs3MT1bopg4iV+Mc8Rg82dc6o1JLXLUTAHQ==
X-Received: by 2002:ac2:4281:: with SMTP id m1mr15222537lfh.168.1639187773888;
        Fri, 10 Dec 2021 17:56:13 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a21sm468867lfk.172.2021.12.10.17.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 17:56:13 -0800 (PST)
Message-ID: <14387e8c-c014-852d-c664-ad92d415a004@linaro.org>
Date:   Sat, 11 Dec 2021 04:56:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 04/10] PCI: qcom: Remove redundancy between qcom_pcie
 and qcom_pcie_cfg
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
 <20211208171442.1327689-5-dmitry.baryshkov@linaro.org>
 <20211210111541.GD1734@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211210111541.GD1734@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2021 14:15, Manivannan Sadhasivam wrote:
> On Wed, Dec 08, 2021 at 08:14:36PM +0300, Dmitry Baryshkov wrote:
>> In preparation to adding more flags to configuration data, use struct
>> qcom_pcie_cfg directly inside struct qcom_pcie, rather than duplicating
>> all its fields. This would save us from the boilerplate code that just
>> copies flags values from one sruct to another one.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 39 +++++++++++---------------
>>   1 file changed, 17 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 1c3d1116bb60..51a0475173fb 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -204,8 +204,7 @@ struct qcom_pcie {
>>   	union qcom_pcie_resources res;
>>   	struct phy *phy;
>>   	struct gpio_desc *reset;
>> -	const struct qcom_pcie_ops *ops;
>> -	unsigned int pipe_clk_need_muxing:1;
>> +	const struct qcom_pcie_cfg *cfg;
> 
> There is no change in this patch that adds "pipe_clk_need_muxing" to
> qcom_pcie_cfg.

pipe_clk_need_muxing is already a part of the qcom_pcie_cfg structure.


> Thanks,
> Mani
> 
>>   };
>>   
>>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>> @@ -229,8 +228,8 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>   
>>   	/* Enable Link Training state machine */
>> -	if (pcie->ops->ltssm_enable)
>> -		pcie->ops->ltssm_enable(pcie);
>> +	if (pcie->cfg->ops->ltssm_enable)
>> +		pcie->cfg->ops->ltssm_enable(pcie);
>>   
>>   	return 0;
>>   }
>> @@ -1176,7 +1175,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	if (pcie->pipe_clk_need_muxing) {
>> +	if (pcie->cfg->pipe_clk_need_muxing) {
>>   		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
>>   		if (IS_ERR(res->pipe_clk_src))
>>   			return PTR_ERR(res->pipe_clk_src);
>> @@ -1209,7 +1208,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>>   	}
>>   
>>   	/* Set TCXO as clock source for pcie_pipe_clk_src */
>> -	if (pcie->pipe_clk_need_muxing)
>> +	if (pcie->cfg->pipe_clk_need_muxing)
>>   		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
>>   
>>   	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>> @@ -1284,7 +1283,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>>   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>>   
>>   	/* Set pipe clock as clock source for pcie_pipe_clk_src */
>> -	if (pcie->pipe_clk_need_muxing)
>> +	if (pcie->cfg->pipe_clk_need_muxing)
>>   		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>>   
>>   	return clk_prepare_enable(res->pipe_clk);
>> @@ -1384,7 +1383,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>>   
>>   	qcom_ep_reset_assert(pcie);
>>   
>> -	ret = pcie->ops->init(pcie);
>> +	ret = pcie->cfg->ops->init(pcie);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -1392,16 +1391,16 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>>   	if (ret)
>>   		goto err_deinit;
>>   
>> -	if (pcie->ops->post_init) {
>> -		ret = pcie->ops->post_init(pcie);
>> +	if (pcie->cfg->ops->post_init) {
>> +		ret = pcie->cfg->ops->post_init(pcie);
>>   		if (ret)
>>   			goto err_disable_phy;
>>   	}
>>   
>>   	qcom_ep_reset_deassert(pcie);
>>   
>> -	if (pcie->ops->config_sid) {
>> -		ret = pcie->ops->config_sid(pcie);
>> +	if (pcie->cfg->ops->config_sid) {
>> +		ret = pcie->cfg->ops->config_sid(pcie);
>>   		if (ret)
>>   			goto err;
>>   	}
>> @@ -1410,12 +1409,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>>   
>>   err:
>>   	qcom_ep_reset_assert(pcie);
>> -	if (pcie->ops->post_deinit)
>> -		pcie->ops->post_deinit(pcie);
>> +	if (pcie->cfg->ops->post_deinit)
>> +		pcie->cfg->ops->post_deinit(pcie);
>>   err_disable_phy:
>>   	phy_power_off(pcie->phy);
>>   err_deinit:
>> -	pcie->ops->deinit(pcie);
>> +	pcie->cfg->ops->deinit(pcie);
>>   
>>   	return ret;
>>   }
>> @@ -1531,7 +1530,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	struct pcie_port *pp;
>>   	struct dw_pcie *pci;
>>   	struct qcom_pcie *pcie;
>> -	const struct qcom_pcie_cfg *pcie_cfg;
>>   	int ret;
>>   
>>   	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> @@ -1553,15 +1551,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   
>>   	pcie->pci = pci;
>>   
>> -	pcie_cfg = of_device_get_match_data(dev);
>> -	if (!pcie_cfg || !pcie_cfg->ops) {
>> +	pcie->cfg = of_device_get_match_data(dev);
>> +	if (!pcie->cfg || !pcie->cfg->ops) {
>>   		dev_err(dev, "Invalid platform data\n");
>>   		return -EINVAL;
>>   	}
>>   
>> -	pcie->ops = pcie_cfg->ops;
>> -	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
>> -
>>   	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(pcie->reset)) {
>>   		ret = PTR_ERR(pcie->reset);
>> @@ -1586,7 +1581,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   		goto err_pm_runtime_put;
>>   	}
>>   
>> -	ret = pcie->ops->get_resources(pcie);
>> +	ret = pcie->cfg->ops->get_resources(pcie);
>>   	if (ret)
>>   		goto err_pm_runtime_put;
>>   
>> -- 
>> 2.33.0
>>


-- 
With best wishes
Dmitry
