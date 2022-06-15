Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049BC54C985
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346898AbiFONPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 09:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbiFONPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 09:15:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCB42A412;
        Wed, 15 Jun 2022 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655298904; x=1686834904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V3owAe/rTj5bBi4Ay+1ouIXLoJUGwUWPXJjfOAIYZu8=;
  b=Sg2EgbDQUsSmyRTsSoi0CiIDsfa7irUOQbRW8r+R1OyX+43ZaS+2VenS
   /JtgFAl+VXX9SN2vC6TWCko9H88Gw1YxBpF+0WMX+L6xLC3A/lOWqBE32
   UmSiuq4bmpb1KCNZn5qrODZToXEJcJQR1KSv2W7Cgw/JHh1BkomvCa7ZQ
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2022 06:15:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 06:15:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 15 Jun 2022 06:15:03 -0700
Received: from [10.216.37.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 15 Jun
 2022 06:14:58 -0700
Message-ID: <3b8371b1-8b09-dc4b-bb8f-231a6ed53288@quicinc.com>
Date:   Wed, 15 Jun 2022 18:44:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1] PCI: qcom: Allow L1 and its sub states on qcom dwc
 wrapper
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_ramkri@quicinc.com>, <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stanimir Varbanov" <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
 <20220609112630.GG2758@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220609112630.GG2758@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/9/2022 4:56 PM, Manivannan Sadhasivam wrote:
> On Fri, Jun 03, 2022 at 12:48:50PM +0530, Krishna chaitanya chundru wrote:
>> Allow L1 and its sub-states in the qcom dwc pcie wrapper.
> s/wrapper/driver
>
> Also there is no need to use "qcom dwc" in subject. Prefix makes it explicit.
Sure will update in the next patch.
>> By default its disabled. So enable it explicitly.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 6ab9089..f60645c 100644
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
>> +	/* Clear PARF PM REQ_NOT_ENTR_L1 bit to allow L1 states */
> Mentioning the field in comment is redundant. Just say "Enable L1 and L1ss"
sure will update in the next patch.
> Thanks,
> Mani
>
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
