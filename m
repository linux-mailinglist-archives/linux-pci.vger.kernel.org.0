Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5B74AF20
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGGKya (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 06:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGGKy3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 06:54:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB019172B;
        Fri,  7 Jul 2023 03:54:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3678AWXF026972;
        Fri, 7 Jul 2023 10:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=33xgh8fWOc2o6p45YDZ7DF1WRb8Q5GJzh8uGUWDJ72w=;
 b=a5pXZbFZUtzwyWCnpKxa9qKSH5n5BCfI5L24tay1w/ppgyyNNetxTZ84CeMaKyt3weBg
 0To6ldvrrj2nwVV1VduWNSCyUnuEgIsLTRbBUUGAQHa/Tu4t2qQ0ATPvQ51k4iJkJbqZ
 ksX0X+csWCY4yKt7XUZJujHr5h5A8kwxeEyOQyLrhV3qTveyQNXal3XiIEv61M4jTdjR
 NpP9mWR44PwmEUiaOTiH5mKEOTdHhr2H/KzXQ7L9tOZXEMAAIM11nY3ik3xhHfx86XOZ
 dor0+J9zNdCJsMjYj3Dwpa4tq/4wW2COqmME5mZ4/Kky9fW05YdJFFoev+8rtCH0AGZV Og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp8a61a99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:54:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367AsIfc012004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 10:54:18 GMT
Received: from [10.216.29.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 03:54:12 -0700
Message-ID: <afd48178-fa6d-a2ac-7a50-cf558be6aa01@quicinc.com>
Date:   Fri, 7 Jul 2023 16:24:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/8] PCI: qcom-ep: Add support for D-state change
 notification
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-3-git-send-email-quic_krichai@quicinc.com>
 <20230707055121.GB6001@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230707055121.GB6001@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kqf_3dYBNtcdpNEdMb-CvSvgkQ6KXKcl
X-Proofpoint-GUID: kqf_3dYBNtcdpNEdMb-CvSvgkQ6KXKcl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070099
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/7/2023 11:21 AM, Manivannan Sadhasivam wrote:
> On Fri, Jun 30, 2023 at 04:22:05PM +0530, Krishna chaitanya chundru wrote:
>> Add support to pass D-state change notification to Endpoint
>> function driver.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Few comments below.
>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 1435f51..e75aec4 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -561,6 +561,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   	struct device *dev = pci->dev;
>>   	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
>>   	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
>> +	pci_power_t state;
>>   	u32 dstate, val;
>>   
>>   	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
>> @@ -583,11 +584,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>>   					   DBI_CON_STATUS_POWER_STATE_MASK;
>>   		dev_dbg(dev, "Received D%d state event\n", dstate);
> We should also change this debug output to make use of pci_power_name() based on
> the "state" variable and move it just above pci_epc_dstate_change(). But this
> should be a separate patch.
I will add a seperate patch in the same series
>
>> +		state = dstate;
>>   		if (dstate == 3) {
>>   			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>>   			val |= PARF_PM_CTRL_REQ_EXIT_L1;
>>   			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
>> +			state = PCI_D3hot;
>> +			if (gpiod_get_value(pcie_ep->reset))
>> +				state = PCI_D3cold;
>>   		}
>> +		pci_epc_dstate_change(pci->ep.epc, state);
> Need to change this API as per my comment on patch 1.
>
> - Mani

sure will change it as you suggested.

- KC

>
>>   	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>>   		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>>   		dw_pcie_ep_linkup(&pci->ep);
>> -- 
>> 2.7.4
>>
