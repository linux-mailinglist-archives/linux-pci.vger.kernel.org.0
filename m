Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3633F4A9B1D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359364AbiBDOih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359353AbiBDOih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:38:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46DBC06173E
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:38:36 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a28so13006053lfl.7
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8zmIWe+6ZwBu7ElBid2Px0vQ+Pa6/XPVpcBYjuu3N/Y=;
        b=xEJAnONiEBCWTzLctXlczL2oH3jQiNS3rR/C6Rc9m6wOp/SfE2B3mCL4BOFn/bHPue
         hAnmhq92b4rL9aI/ZPX6bg4okODwroyBRmHC1p5BhoVH+sLpl21j3IKkD4ioNB5D/Kqh
         Z955KoEao68ecTtQ7Wv4ZDuatYnVij3yfE5+dv1TstDNHY3kV1Ynf9g2FuoArZdTFXqW
         oBczg/+ZDyAEfip6y24rWkJ2IvKKJHCWhFRft8llJSyFWf4SnCdlb47a6gpAiJSERVKS
         KBEJqS2UD+Ez/rh4MPyAJ8FeUp8Xyh+3IANXBNmbbTPRiu0Vz+xXbzSkbzU6RR/mupKj
         Uadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8zmIWe+6ZwBu7ElBid2Px0vQ+Pa6/XPVpcBYjuu3N/Y=;
        b=xQiEI+z9EEbVMtNKM/F5uhB0EjevyILCkrRcjBisMqQc4LjdT1N5GOnt/T1lRg+wMG
         kNxpyBm5z7ZiaVKkTy5iuyp4Xk4v9LO4TnX45EoeXyQm+T0GaTAMAkOGLA4VgvaJNd0M
         ELKuUFNJ28wIGsywaZ0XqeHl8+kMD98ot4yKsk6RQipWFQjk1OyswSai+hHLxeit3Qmu
         YwTefgzZeP/SlGjQMp3/HTQvKzKT4bEy+ElqFbf4rwuuZZY/qEkPjUcudn6/M0vzAGyV
         w9d9o11Nb+L8rTO2P8Cx55DKJlUwGNIB93+yvt2lblNYnUosWlzpLQSpa9DLjox2QukW
         ncwg==
X-Gm-Message-State: AOAM5330oauOdgKjz8lWxC2VvBJVvHfZm26zjtJaPWWja9Gap/2dYKQL
        z9RQLlkAj2oHDG1UX+AX+Dzoww==
X-Google-Smtp-Source: ABdhPJxaOed+hkjLmis4Oxp5ciR43zWuYlWqvxBvSM148L1K53n1haqeyQTUxW2xT8nTeLwmAePC/Q==
X-Received: by 2002:a05:6512:224f:: with SMTP id i15mr2506943lfu.446.1643985515153;
        Fri, 04 Feb 2022 06:38:35 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u4sm339972lfg.239.2022.02.04.06.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 06:38:34 -0800 (PST)
Message-ID: <527f0365-1544-ad73-cf49-b839ae629340@linaro.org>
Date:   Fri, 4 Feb 2022 17:38:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 4/5] PCI: qcom: Add interconnect support to 2.7.0/1.9.0
 ops
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
 <Yfv7gh8YycxH2Wtm@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yfv7gh8YycxH2Wtm@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/02/2022 18:57, Bjorn Andersson wrote:
> On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:
> 
>> Add optional interconnect support for the 2.7.0/1.9.0 hosts. Set the
>> bandwidth according to the values from the downstream driver.
>>
> 
> What memory transactions will travel this path? I would expect there to
> be two different paths involved, given the rather low bw numbers I
> presume this is the config path?

I think so. Downstream votes on this path for most of the known SoCs. 
Two spotted omissions are ipq8074 and qcs404.

> 
> Is there no vote for the data path?

CNSS devices can vote additionally on the MASTER_PCI to memory paths:
For sm845 (45 = MASTER_PCIE):
                 qcom,msm-bus,vectors-KBps =
                         <45 512 0 0>,
                         <45 512 600000 800000>; /* ~4.6Gbps (MCS12) */

On sm8150/sm8250 qca bindings do not contain a vote, but wil6210 does 
(100 = MASTER_PCIE_1):
                 qcom,msm-bus,vectors-KBps =
                         <100 512 0 0>,
                         <100 512 600000 800000>; /* ~4.6Gbps (MCS12) */

For sm8450 there are two paths used by cnss:
		<&pcie_noc MASTER_PCIE_0 &pcie_noc SLAVE_ANOC_PCIE_GEM_NOC>,
		<&gem_noc MASTER_ANOC_PCIE_GEM_NOC &mc_virt SLAVE_EBI1>;

with multiple entries per each path.

So, I'm not sure about these values.

> 
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index d8d400423a0a..55ac3caa6d7d 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/crc8.h>
>>   #include <linux/delay.h>
>>   #include <linux/gpio/consumer.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>>   #include <linux/iopoll.h>
>> @@ -167,6 +168,7 @@ struct qcom_pcie_resources_2_7_0 {
>>   	struct clk *pipe_clk_src;
>>   	struct clk *phy_pipe_clk;
>>   	struct clk *ref_clk_src;
>> +	struct icc_path *path;
>>   };
>>   
>>   union qcom_pcie_resources {
>> @@ -1121,6 +1123,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>>   	if (IS_ERR(res->pci_reset))
>>   		return PTR_ERR(res->pci_reset);
>>   
>> +	res->path = devm_of_icc_get(dev, "pci");
> 
> The paths are typically identified using a string of the form
> <source>-<destination>.
> 
> 
> I don't see the related update to the DT binding for the introduction of
> the interconnect.
> 
> Regards,
> Bjorn
> 
>> +	if (IS_ERR(res->path))
>> +		return PTR_ERR(res->path);
>> +
>>   	res->supplies[0].supply = "vdda";
>>   	res->supplies[1].supply = "vddpe-3v3";
>>   	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
>> @@ -1183,6 +1189,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>>   	if (pcie->cfg->pipe_clk_need_muxing)
>>   		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>>   
>> +	if (res->path)
>> +		icc_set_bw(res->path, 500, 800);
>> +
>>   	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>>   	if (ret < 0)
>>   		goto err_disable_regulators;
>> @@ -1241,6 +1250,8 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>>   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>>   
>>   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>> +	if (res->path)
>> +		icc_set_bw(res->path, 0, 0);
>>   
>>   	/* Set TCXO as clock source for pcie_pipe_clk_src */
>>   	if (pcie->cfg->pipe_clk_need_muxing)
>> -- 
>> 2.34.1
>>


-- 
With best wishes
Dmitry
