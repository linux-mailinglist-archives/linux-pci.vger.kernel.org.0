Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC62C57607F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 13:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiGOLbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 07:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiGOLax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 07:30:53 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21838CD;
        Fri, 15 Jul 2022 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657884587; x=1689420587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wFVftC7QX89NOiFaLZt38n3lJn0gHUE9x/Z2wU+8L90=;
  b=Rn63xdFtx6piCvn9R/U20abDQXxWKnVE4RP4Xe/GIhetZGsVwJIczovz
   JFHVKrjXAjRQKsEYOVSdF/rwvXkEhRa9DjG0mNmZEDI91MSWFdtwizsIF
   zID2YuNQ5TGqvMLDUzQB2jAic3drk4LDIu7nFKwgU9OttwtfPYjqUdvwP
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Jul 2022 04:29:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 04:29:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 04:29:41 -0700
Received: from [10.216.15.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 04:29:30 -0700
Message-ID: <84c5bc3a-bbab-d37f-5993-44ef36a750c5@quicinc.com>
Date:   Fri, 15 Jul 2022 16:59:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] PCI: qcom: Allow L1 and its sub states
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stanimir Varbanov" <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
 <1655298939-392-1-git-send-email-quic_krichai@quicinc.com>
 <20220715082440.GB12197@workstation>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220715082440.GB12197@workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/15/2022 1:54 PM, Manivannan Sadhasivam wrote:
> On Wed, Jun 15, 2022 at 06:45:39PM +0530, Krishna chaitanya chundru wrote:
>> Allow L1 and its sub-states in the qcom pcie driver.
>> By default this is disabled in the hardware. So enabling it explicitly.
>>
> You are enabling L1ss for controllers belonging to 2_7_0, so this should
> be mentioned in the commit message. Otherwise, it will imply that the
> L1ss is added for all controller versions.
>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
> Change log should be added here for versions > 1.
>
> Thanks,
> Mani

I will update new patch with your inputs.


Thanks,

Krishna Chaitanya.

>
>>   drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 6ab9089..0d8efcc 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -41,6 +41,9 @@
>>   #define L23_CLK_RMV_DIS				BIT(2)
>>   #define L1_CLK_RMV_DIS				BIT(1)
>>   
>> +#define PCIE20_PARF_PM_CTRL			0x20
>> +#define REQ_NOT_ENTR_L1				BIT(5)
>> +
>>   #define PCIE20_PARF_PHY_CTRL			0x40
>>   #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>>   #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
>> @@ -1267,6 +1270,11 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>>   	val |= BIT(4);
>>   	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>>   
>> +	/* Enable L1 and L1ss */
>> +	val = readl(pcie->parf + PCIE20_PARF_PM_CTRL);
>> +	val &= ~REQ_NOT_ENTR_L1;
>> +	writel(val, pcie->parf + PCIE20_PARF_PM_CTRL);
>> +
>>   	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>   		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
>>   		val |= BIT(31);
>> -- 
>> 2.7.4
>>
