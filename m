Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7574AF3E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjGGK7Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjGGK7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 06:59:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19249131;
        Fri,  7 Jul 2023 03:59:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3678o5Hd018455;
        Fri, 7 Jul 2023 10:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8gJJ5IU6P+MtTUiYIYbXH9/E0H1QNkTncEMxYSppcfI=;
 b=N88nk4jz6N+3e3sJ3bJWSnKVU/cfWDqOHdPO12joYAqLy6OeW0/3hC6FZwxVeIAkqoGn
 ybD+CuJiG1kvbHJ/yWhn4xMLaZICS7mgPMVzCUOqQznae84NaHAtgTiTySwy+r10hLWc
 U1Ft8Wx/sDsQ5rJH+ZG6jjo8qCnr1XNe1KjDpOUpOXPznM4bWnVsZZFZFXnnPNGyL0UW
 KDfQdd4X2Rg4sAk6ddy//cEBYMi8tF5BRxJmozOECbMIpXsL9Vo3MldVsK5PGGtteCv5
 jotAd76UlTaVNFo8c3C5dxK60ggakqScrEVuYNHdtPciakPYmmrv2ibYxNWInHLx52Ct Pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpenqrh33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:59:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367Ax3VN017982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 10:59:03 GMT
Received: from [10.216.29.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 03:58:57 -0700
Message-ID: <9b8c0bcb-dcaf-ffe2-f2a2-1fa2da0f2f18@quicinc.com>
Date:   Fri, 7 Jul 2023 16:28:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 6/8] PCI: qcom: ep: Add wake up host op to
 dw_pcie_ep_ops
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
 <1688122331-25478-7-git-send-email-quic_krichai@quicinc.com>
 <20230707061005.GE6001@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230707061005.GE6001@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vuASJkkl2ceKytvUWJJbYZNbNHPP18Fx
X-Proofpoint-GUID: vuASJkkl2ceKytvUWJJbYZNbNHPP18Fx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070102
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/7/2023 11:40 AM, Manivannan Sadhasivam wrote:
> On Fri, Jun 30, 2023 at 04:22:09PM +0530, Krishna chaitanya chundru wrote:
>
> Subject prefix should be "PCI: qcom-ep:"
>
>> Add wakeup host op to dw_pcie_ep_ops to wake up host.
>> If the EPF asks to send PME trigger the inband PME by writing
>> into the parf registers otherwise toggle wake signal.
>>
> If the wakeup type is PME, then trigger inband PME by writing to the PARF
> PARF_PM_CTRL register, otherwise toggle #WAKE.
>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index e75aec4..e382b4b 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -89,6 +89,7 @@
>>   /* PARF_PM_CTRL register fields */
>>   #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
>>   #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
>> +#define PARF_PM_CTRL_XMT_PME			BIT(4)
>>   #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
>>   
>>   /* PARF_MHI_CLOCK_RESET_CTRL fields */
>> @@ -729,10 +730,40 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>>   		dw_pcie_ep_reset_bar(pci, bar);
>>   }
>>   
>> +static int qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no,
>> +					enum pci_epc_wakeup_host_type type)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
>> +	struct device *dev = pci->dev;
>> +	u32 val;
>> +
>> +	if (type == PCI_WAKEUP_TOGGLE_WAKE) {
>> +		dev_dbg(dev, "Waking up the host by toggling WAKE#\n");
>> +		gpiod_set_value_cansleep(pcie_ep->wake, 1);
>> +		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
>> +		gpiod_set_value_cansleep(pcie_ep->wake, 0);
>> +		return 0;
>> +
>> +	} else if (type == PCI_WAKEUP_SEND_PME) {
>> +		dev_dbg(dev, "Waking up the host using PME\n");
>> +		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>> +		val |= PARF_PM_CTRL_XMT_PME;
>> +		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
>> +
>> +	} else {
>> +		dev_err(dev, "Device is not in D3 state wakeup is not supported\n");
>> +		return -EOPNOTSUPP;
> This is not needed if you use bool. And this debug message is wrong btw since
> you are not checking whether the device is in D3 state or not.
>
> - Mani

I will change it bool and will remove these.

- KC

>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct dw_pcie_ep_ops pci_ep_ops = {
>>   	.ep_init = qcom_pcie_ep_init,
>>   	.raise_irq = qcom_pcie_ep_raise_irq,
>>   	.get_features = qcom_pcie_epc_get_features,
>> +	.wakeup_host = qcom_pcie_ep_wakeup_host,
>>   };
>>   
>>   static int qcom_pcie_ep_probe(struct platform_device *pdev)
>> -- 
>> 2.7.4
>>
