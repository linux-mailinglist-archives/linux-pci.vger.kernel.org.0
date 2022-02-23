Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751824C0E55
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 09:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiBWIh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 03:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiBWIhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 03:37:51 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FBE4CD49
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 00:37:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m14so29700624lfu.4
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 00:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7aam5YfDTtzKqW+RU4i9t+Ff/OzNlL8RHjfqDGKPduU=;
        b=i2z5ptG4cEoiiyyMoFo9//TXkqK0UQ7tzZ/eETsasWmk42qM/8DUiI4M9IsVyszUV4
         ENh+EiDuqEDU6rcUQdL3CTEIPH+fZ5XUYrzqRfI2UnxbJrvjd2z4dMEiXT8YVQ2SYUa7
         wXgElGSt8UkfQER+UAv+P5KBi/pXrBejOAxO7LrKy08/UAxV7UIb2mDFTuOAnhB0khTz
         Ivk3hxKuQsDQczDsQR9BeXcGX0Om/A09q9HTbZhfMr0ru2Bl4sOFCRSmpN/WWk6plEZE
         szLM/mww/fqXoMtU1l79MXdA/QAMazeA3/XnxPjAW/GaALB5nkc+Aqcr4ZTo157mIn9L
         2CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7aam5YfDTtzKqW+RU4i9t+Ff/OzNlL8RHjfqDGKPduU=;
        b=Ez4Pll2Big3h9g/F8I31l6ekvkHukiuzSOcsIjoEG96Gd0jtgPEcPQ37sLAs8zur/9
         vEuG8tth+Hu6qxoyuAkU2v0Zdb8/ZIvx7GnaZGmEOeRMoFJ/nr61zZWP4xFxzN75ebCM
         tAhArUD8BiubeMxCrZgj6xlyr6qY8hoLdQfQve9yDVTu5QV+r9zdYauDmJNhPU9MS222
         20ftnv5UorF3ng8K1kyi8sp69/d2CbfDWnOHZhha3PzTbJTwez/AYdh70wi235fGD+p/
         Sn/ka3duzjfB6xWn3GE5iQPT+sXVs0i896KiIQUd4P+9K94p1Dq+q3LtAT6GBvV/N4TK
         VjUA==
X-Gm-Message-State: AOAM532IiFt2lNUsF2gqv1AMYo5sa3LRXg53Hp7/7cQqkQbIiwOc4H9E
        YXoCkMLGciyco9YC4Cq9RTRjLA==
X-Google-Smtp-Source: ABdhPJxjEWnUczmWx6GjeuXfax9jOKwSaN/bCTptwChsDhP7savmiuOXqX4YdJDYUzVzS9n7DZpN4g==
X-Received: by 2002:ac2:5389:0:b0:443:5b76:d59a with SMTP id g9-20020ac25389000000b004435b76d59amr20142839lfh.206.1645605442784;
        Wed, 23 Feb 2022 00:37:22 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n17sm1129516lfu.193.2022.02.23.00.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 00:37:22 -0800 (PST)
Message-ID: <08868773-1819-6bdb-355b-3ad61314977e@linaro.org>
Date:   Wed, 23 Feb 2022 11:37:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
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
 <YhV2nemA+t0cCdlP@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YhV2nemA+t0cCdlP@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/02/2022 02:49, Bjorn Andersson wrote:
> On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:
> 
>> Add optional interconnect support for the 2.7.0/1.9.0 hosts. Set the
>> bandwidth according to the values from the downstream driver.
>>
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
> 
> I think it's fair to assume that pretty much all platforms will have a
> data path to reach the config registers and for the PCI to reach DDR.
> 
> So how about we place this in the common struct qcom_pcie instead?

Sounds logical. I'll think about it.

> 
> Regards,
> Bjorn
> 
>>   };
>>   
>>   union qcom_pcie_resources {
>> @@ -1121,6 +1123,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>>   	if (IS_ERR(res->pci_reset))
>>   		return PTR_ERR(res->pci_reset);
>>   
>> +	res->path = devm_of_icc_get(dev, "pci");
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
