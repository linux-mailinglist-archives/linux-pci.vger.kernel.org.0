Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7A471008
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 02:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhLKCCp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 21:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345551AbhLKCCo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 21:02:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E613EC0617A1
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 17:59:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d10so21144134lfg.6
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 17:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0ZLR7vdvYCSpPur+0nGzs/HpQNxbppV8SzSXDjS7TZA=;
        b=aMlfgGEWQpxRL5mkoGRUaha4Vu/NFuD7RIClX7UfoOOifE4qOJl2KPJsv7E7cUZaTt
         CsVERr7EEEbZDyxouYTUsCrXBXbalqRsTGXEWFQAnE1Jts9JzDzFFqjrz3qjx2hvAC9u
         kpfQ8as1fIbEphG87MSKgD0jnI0vOrelfjZnKOyY6R1TXqZ40UrhIAb8pZHQf/O49TI1
         W+h/igNfHS5Sttp6gXFHa99Aj1lj4hPv/Ce9GPuz0t6OWJfXMFNosbHakEAO1AuugEtt
         wfBxZquLQ9k+42ZtZcEnoH+MHj0zQzE7azYzNdINp8HUBWTggoUWCkU0Y0NHXnH7geEt
         N6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ZLR7vdvYCSpPur+0nGzs/HpQNxbppV8SzSXDjS7TZA=;
        b=3EB1No6qCowvGNc/8HQ0nAiDbrsoZvlOTGUyKEO5zImxVzkAtBA+5BpG9tfnwE+APc
         mfA3ZKFRHyY/huiwuNAFTnB6KNm/qqd+HOVtQmHvRKQ4wzyrbn8QzwcmBfM94AJAG4RP
         iwzA42dw+A7f/NoVeonsB1gqz8in7yU+Vn+6BwDkyrIJsfRHWfvKBm1mIM+EoNiRqzqr
         opberZ1soNYDxSg+zCmhRN+ImECeIEPp+nXvFGj17903r0jktcJgWdFzrvXWI9KfKNvC
         xDEOTQI9GA+BHIsQtwmJlD1nD4j/E43Qv90ILMPecLZlYlNCp7bPDe7ac+Z83Q0c5L/U
         nKHA==
X-Gm-Message-State: AOAM532XoIUhF1UIlpMBA9IxSJyHVlJtTaZvHBYG9KoLoWS8xGeC3KCg
        p8ZPQeg2MLyw42/2FKH6u+Yblw==
X-Google-Smtp-Source: ABdhPJwbahn5Rygfwp6D6UwAqoaZPjC+jdM29U6SoSmT0hNJxUjniF/5/m0GNpcI5DD3S2rCrZrp4Q==
X-Received: by 2002:a05:6512:16a8:: with SMTP id bu40mr15383225lfb.483.1639187947136;
        Fri, 10 Dec 2021 17:59:07 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v14sm468376lfb.264.2021.12.10.17.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 17:59:06 -0800 (PST)
Message-ID: <95401925-6e97-8fce-4fe6-4701c4fad301@linaro.org>
Date:   Sat, 11 Dec 2021 04:59:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 05/10] PCI: qcom: Add ddrss_sf_tbu flag
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
 <20211208171442.1327689-6-dmitry.baryshkov@linaro.org>
 <20211210112241.GE1734@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211210112241.GE1734@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2021 14:22, Manivannan Sadhasivam wrote:
> On Wed, Dec 08, 2021 at 08:14:37PM +0300, Dmitry Baryshkov wrote:
>> Qualcomm PCIe driver uses compatible string to check if the ddrss_sf_tbu
>> clock should be used. Since sc7280 support has added flags, switch to
>> the new mechanism to check if this clock should be used.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 51a0475173fb..803d3ac18c56 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -194,7 +194,9 @@ struct qcom_pcie_ops {
>>   
>>   struct qcom_pcie_cfg {
>>   	const struct qcom_pcie_ops *ops;
>> +	/* flags for ops 2.7.0 and 1.9.0 */
> 
> No need of this comment.

Dropping it

> 
>>   	unsigned int pipe_clk_need_muxing:1;
> 
> This should be added in the previous patch.

It exists already

> 
>> +	unsigned int has_ddrss_sf_tbu_clk:1;
> 
> Wondering if we could make both the flags "bool" as the values passed to it
> are of boolean type. I don't think we could save a significant amount of
> memory using bitfields.

I followed the existing pipe_clk_need_muxing. I have no strong 
preference here, so let's see what Bjorn will prefer.

> 
> Thanks,
> Mani
>>   };
>>   
>>   struct qcom_pcie {
>> @@ -1164,7 +1166,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>>   	res->clks[3].id = "bus_slave";
>>   	res->clks[4].id = "slave_q2a";
>>   	res->clks[5].id = "tbu";
>> -	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sm8250")) {
>> +	if (pcie->cfg->has_ddrss_sf_tbu_clk) {
>>   		res->clks[6].id = "ddrss_sf_tbu";
>>   		res->num_clks = 7;
>>   	} else {
>> @@ -1512,6 +1514,7 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
>>   
>>   static const struct qcom_pcie_cfg sm8250_cfg = {
>>   	.ops = &ops_1_9_0,
>> +	.has_ddrss_sf_tbu_clk = true,
>>   };
>>   
>>   static const struct qcom_pcie_cfg sc7280_cfg = {
>> -- 
>> 2.33.0
>>


-- 
With best wishes
Dmitry
