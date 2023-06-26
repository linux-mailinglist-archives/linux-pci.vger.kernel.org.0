Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB873E0FF
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 15:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFZNtG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZNtF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 09:49:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE30C97;
        Mon, 26 Jun 2023 06:49:04 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QDj0DM002113;
        Mon, 26 Jun 2023 13:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6+8OkCZArvWYY6PhcQbzx178eTb3rVs046GAiayFmOU=;
 b=Uv2zscYYo9wfGgq89yDjx56OjQB+Hd7H1njVHbIwCEzWMw0aesNn4wiU0amJWeGBhCYA
 GYlgOjv5uRZ4LkoS7ZOBn10mytRiNvzjkSUP+UvEva+n+mw0xaM5vhVw9r71sE5j+37p
 AZrZBplYrF+0Wo1TbS+/tdidEHQbbPO3WrRmrPbJVmaVObICvw5QxqGaVcSJmXYGLaul
 9tKrMIRbSOeOoexHEbQntfgEieDiKLjUI30Ho8l0gAU1t/UoGYKD4La0U31YVFcybBg2
 9yz9I3oeiTccONz4LpvEw+XB5QjObbFvkXNz8fVVRTcvGPt1LCeGWhrlSMFQMJ60F62Q MQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfarq85km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 13:48:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QDmv1n032139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 13:48:57 GMT
Received: from [10.216.43.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 06:48:53 -0700
Message-ID: <1b41ba64-51e2-7c66-104d-bc60ac131a0f@quicinc.com>
Date:   Mon, 26 Jun 2023 19:18:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH RFC v1 3/3] PCI: qcom: ep: Add wake up host op to
 dw_pcie_ep_ops
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
 <1686754850-29817-4-git-send-email-quic_krichai@quicinc.com>
 <20230623061839.GC5611@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230623061839.GC5611@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cN8LgCwLLlNyvNwXqGPg8g7u7iu9bXxj
X-Proofpoint-GUID: cN8LgCwLLlNyvNwXqGPg8g7u7iu9bXxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_11,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260123
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/23/2023 11:48 AM, Manivannan Sadhasivam wrote:
> On Wed, Jun 14, 2023 at 08:30:49PM +0530, Krishna chaitanya chundru wrote:
>> Add wakeup host op to dw_pcie_ep_ops to wake up host from D3cold
>> or D3hot.
>>
> Commit message should describe how the wakeup is implemented in the driver.
I will correct this in next series.
>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 34 +++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 5d146ec..916a138 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -91,6 +91,7 @@
>>   /* PARF_PM_CTRL register fields */
>>   #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
>>   #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
>> +#define PARF_PM_CTRL_XMT_PME			BIT(4)
>>   #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
>>   
>>   /* PARF_MHI_CLOCK_RESET_CTRL fields */
>> @@ -794,10 +795,43 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>>   		dw_pcie_ep_reset_bar(pci, bar);
>>   }
>>   
>> +static int qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
>> +	struct device *dev = pci->dev;
>> +	u32 perst, dstate, val;
>> +
>> +	perst = gpiod_get_value(pcie_ep->reset);
>> +	/* Toggle wake GPIO when device is in D3 cold */
>> +	if (perst) {
>> +		dev_info(dev, "Device is in D3 cold toggling wake\n");
> dev_dbg(). "Waking up the host by toggling WAKE#"
>
>> +		gpiod_set_value_cansleep(pcie_ep->wake, 1);
> Waking a device from D3cold requires power-on sequence by the host and in the
> presence of Vaux, the EPF should be prepared for that. In that case, the mode of
> wakeup should be decided by the EPF driver. So the wakeup API should have an
> argument to decide whether the wakeup is through PME or sideband WAKE#.
>
> Also note that as per PCIe Spec 3.0, the devices can support PME generation from
> D3cold provided that the Vaux is supplied to the device. I do not know if that
> is supported by Qcom devices but API should honor the spec. So the wakeup
> control should come from EPF driver as I suggested above.

I aggre with you, but how will EPF know the PCI device state is in 
D3cold or D3hot.

And how the EPF knows whether Vaux is supported or not in D3cold?

If there is any existing mechanism can you please point me that.

FYI Qcom does not support vaux power in D3 cold.

>> +		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
>> +		gpiod_set_value_cansleep(pcie_ep->wake, 0);
>> +		return 0;
>> +	}
>> +
>> +	dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>> +				   DBI_CON_STATUS_POWER_STATE_MASK;
>> +	if (dstate == 3) {
>> +		dev_info(dev, "Device is in D3 hot sending inband PME\n");
> dev_dbg(). As I said, the device can sent PME from D3cold also. So the log could
> be "Waking up the host using PME".
>
>> +		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>> +		val |= PARF_PM_CTRL_XMT_PME;
>> +		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
>> +	} else {
>> +		dev_err(dev, "Device is not in D3 state wakeup is not supported\n");
>> +		return -EPERM;
> -ENOTSUPP
>
> - Mani
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
