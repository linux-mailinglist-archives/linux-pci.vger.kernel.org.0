Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9305C47101A
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 03:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhLKCEk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 21:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhLKCEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 21:04:40 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EFC061714
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:01:04 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id v15so16226374ljc.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9jHmyjMoEySIWxkaCeQD1nqxGbsc9d82jgbi3dOgkLQ=;
        b=vvLSm6+aZ8kFU+jE8U9R8jYADPXT2dmJAE0/psYxaDV1+aCer2XvOz7XQH8cLjD5CO
         EQtoTjVJmgMfhPosRVXDQ5WovoPWfXxlpxMWS2BjKreWSVg4nF8H49XvQ151p7+S/hkY
         mPoGXtvEqYlxq4i4rm0PYOEjKUQqi6WmOA7RA81jlayVRFDiEq7+FezulDSSFuMYbzs4
         0zQ1vEKCzDYC0H4O8mlng194Nj+7QOq6fLbOhiuLYzpR1ejB2kiwsisJU9s2v2Zt9smY
         RQHKZ2hRC3P7mI5OF654HJhkwlPZqWoiurmFQB5jYQHIPRL0K7nzGOkVJutFCAn8nvod
         v7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9jHmyjMoEySIWxkaCeQD1nqxGbsc9d82jgbi3dOgkLQ=;
        b=MoDwMRKwTqYXD3vVMrUzoFhltKAEM2t5FTMkewjQ/hudDh5KlzzwFZChS/xAFPYXM6
         kGXqOZnqvazyujDdZTffmdoOuLjW4xT6C+mozNJ3elvQpL3cgfpxsHd9H5+Bpjt4hdjr
         Lz+wAHiKxujYJPv/qqexPsADuX5VHnPmepb3yI+DI9suiVo0eHQ0Xo3qI9/S9hww53Ye
         JDCYEJ07UzLMQl7R0BJIgMIbXx7J3wyqY2+uvDVAKaqWZwsUNGNXtdlOeZxfqwseFUem
         b7vMB1OJCdRVpELS0yE3OzmqtGkLNB4G8adWvG1HLlq8frXkMzt06QOIIJFVgnTWolQb
         idzQ==
X-Gm-Message-State: AOAM531iBFEHkHodN3pRvcSqAKWAgfLWcjT9ZicnqX4dghiKcn/VtVgF
        YcW3xZbPkNXt8yXwEPWpqhtSKA==
X-Google-Smtp-Source: ABdhPJzOi3KSboh7lwJaeW1Dqjm/9Vbu1m0++HbH9LpEqx2VzOAnlpX/AiztoHJl0nTsQZ4h7Pes8Q==
X-Received: by 2002:a2e:7310:: with SMTP id o16mr16621310ljc.394.1639188062470;
        Fri, 10 Dec 2021 18:01:02 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g27sm470959lfe.55.2021.12.10.18.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 18:01:01 -0800 (PST)
Message-ID: <8d6c224b-b854-8d0e-8437-366b72dd4a83@linaro.org>
Date:   Sat, 11 Dec 2021 05:01:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 06/10] PCI: qcom: Add SM8450 PCIe support
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
 <20211208171442.1327689-7-dmitry.baryshkov@linaro.org>
 <20211210113031.GF1734@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211210113031.GF1734@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2021 14:30, Manivannan Sadhasivam wrote:
> On Wed, Dec 08, 2021 at 08:14:38PM +0300, Dmitry Baryshkov wrote:
>> On SM8450 platform PCIe hosts do not use all the clocks (and add several
>> additional clocks), so expand the driver to handle these requirements.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 47 +++++++++++++++++++-------
>>   1 file changed, 34 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 803d3ac18c56..ada9c816395d 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -161,7 +161,7 @@ struct qcom_pcie_resources_2_3_3 {
>>   
>>   /* 6 clocks typically, 7 for sm8250 */
>>   struct qcom_pcie_resources_2_7_0 {
>> -	struct clk_bulk_data clks[7];
>> +	struct clk_bulk_data clks[9];
>>   	int num_clks;
>>   	struct regulator_bulk_data supplies[2];
>>   	struct reset_control *pci_reset;
>> @@ -196,7 +196,10 @@ struct qcom_pcie_cfg {
>>   	const struct qcom_pcie_ops *ops;
>>   	/* flags for ops 2.7.0 and 1.9.0 */
>>   	unsigned int pipe_clk_need_muxing:1;
>> +	unsigned int has_tbu_clk:1;
>>   	unsigned int has_ddrss_sf_tbu_clk:1;
>> +	unsigned int has_aggre0_clk:1;
>> +	unsigned int has_aggre1_clk:1;
>>   };
>>   
>>   struct qcom_pcie {
>> @@ -1147,6 +1150,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>>   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>>   	struct dw_pcie *pci = pcie->pci;
>>   	struct device *dev = pci->dev;
>> +	unsigned int idx;
> 
> u32?

Why? it's just a counter.

> 
>>   	int ret;
>>   
>>   	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
>> @@ -1160,18 +1164,22 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>>   	if (ret)
>>   		return ret;
>>   
>> -	res->clks[0].id = "aux";
>> -	res->clks[1].id = "cfg";
>> -	res->clks[2].id = "bus_master";
>> -	res->clks[3].id = "bus_slave";
>> -	res->clks[4].id = "slave_q2a";
>> -	res->clks[5].id = "tbu";
>> -	if (pcie->cfg->has_ddrss_sf_tbu_clk) {
>> -		res->clks[6].id = "ddrss_sf_tbu";
>> -		res->num_clks = 7;
>> -	} else {
>> -		res->num_clks = 6;
>> -	}
>> +	idx = 0;
>> +	res->clks[idx++].id = "aux";
>> +	res->clks[idx++].id = "cfg";
>> +	res->clks[idx++].id = "bus_master";
>> +	res->clks[idx++].id = "bus_slave";
>> +	res->clks[idx++].id = "slave_q2a";
>> +	if (pcie->cfg->has_tbu_clk)
>> +		res->clks[idx++].id = "tbu";
>> +	if (pcie->cfg->has_ddrss_sf_tbu_clk)
>> +		res->clks[idx++].id = "ddrss_sf_tbu";
>> +	if (pcie->cfg->has_aggre0_clk)
>> +		res->clks[idx++].id = "aggre0";
>> +	if (pcie->cfg->has_aggre1_clk)
>> +		res->clks[idx++].id = "aggre1";
>> +
>> +	res->num_clks = idx;
> 
> res->num_clks = idx + 1?

No. the idx is equal to the amount of clocks we added to the array, so 
this is correct.

> 
> Thanks,
> Mani
> 
>>   
>>   	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
>>   	if (ret < 0)
>> @@ -1510,15 +1518,27 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
>>   
>>   static const struct qcom_pcie_cfg sdm845_cfg = {
>>   	.ops = &ops_2_7_0,
>> +	.has_tbu_clk = true,
>>   };
>>   
>>   static const struct qcom_pcie_cfg sm8250_cfg = {
>>   	.ops = &ops_1_9_0,
>> +	.has_tbu_clk = true,
>>   	.has_ddrss_sf_tbu_clk = true,
>>   };
>>   
>> +/* Only for the PCIe0! */
>> +static const struct qcom_pcie_cfg sm8450_cfg = {
>> +	.ops = &ops_1_9_0,
>> +	.has_ddrss_sf_tbu_clk = true,
>> +	.pipe_clk_need_muxing = true,
>> +	.has_aggre0_clk = true,
>> +	.has_aggre1_clk = true,
>> +};
>> +
>>   static const struct qcom_pcie_cfg sc7280_cfg = {
>>   	.ops = &ops_1_9_0,
>> +	.has_tbu_clk = true,
>>   	.pipe_clk_need_muxing = true,
>>   };
>>   
>> @@ -1626,6 +1646,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>   	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
>>   	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
>>   	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
>> +	{ .compatible = "qcom,pcie-sm8450", .data = &sm8450_cfg },
>>   	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>>   	{ }
>>   };
>> -- 
>> 2.33.0
>>


-- 
With best wishes
Dmitry
