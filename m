Return-Path: <linux-pci+bounces-5872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD1089BAE7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49359282912
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88163A1C7;
	Mon,  8 Apr 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OZ4NGTNt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F3182C5;
	Mon,  8 Apr 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566411; cv=none; b=giXQndhyptJHGd/81Cna3dXKY99JqzHLQRiV2YBR6zT3X0osH4L0e+XsiAilyz1Zxuvh+vD2WEZ6J/2etTexwK1Ze3pSCRVLxIPY40E1w9U45TYZ/jeffTKssbCC0+pPaLET6/sOnRCuVELvIXXDepIQFV8t4RZ5QyBVCoPvQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566411; c=relaxed/simple;
	bh=Zm3C8Itqr02oqSTrLD1Iv8KQvlmAaIOYfUbODHNva0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tI7efYdOTA5DkNgsPqfPhlWMK9cADIWvbUcDFapWRVkHFqnF5sFOStv8D/jS5g/A5LCHZD3UprmEJIOqYuR88DmWgaH0xw8CuUWAxHVdQYQl2cqDuGOAiy9Pt8z6nFJsgntaHj4g61DHFX3h2tI5FhIf5uCvJAuHMgI1tAVTtn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OZ4NGTNt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4386bxOi013039;
	Mon, 8 Apr 2024 08:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kRN8Nj/uvppEFI2sdEgCwCdpQRdOJ/akCEAzT9NJIm4=; b=OZ
	4NGTNtz+YRyJuA3b2WFpZAWSyoY5jj/y3CI9cYAvIu3quicAbzZ1dE3uy+FNyYYG
	4DUoLRoswC2Gt5RlOBz6wAWS9hRZZHzxhsW0ihYL/n0OlJROdP/+1C/toGg+ALd+
	u2qQHLRD+lLZ2mJB3AhkZp+jwwmwDcNdwYftzvCvqnuNn3ZJHzExhvRMiZ39hQmn
	9jsLZ1miyINruGCuhZ0MY4C1jy5dJuNaHIa0dd6pXn0bQRa2Sd3yPOQplKE27RCT
	UB5lAqbohAfJCoerRm8Gv5FsH7XhYy/OcSJ3a6oMT+flZQziYtzGHrJIdcuXjBYf
	HnPZrJHC79zt1ogutPqw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbfyg898-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 08:53:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4388rJBD003787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 08:53:19 GMT
Received: from [10.216.26.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 01:53:11 -0700
Message-ID: <66320cc1-614e-ef50-2c0b-12b027c7fa18@quicinc.com>
Date: Mon, 8 Apr 2024 14:23:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9 2/6] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
 <20240407-opp_support-v9-2-496184dc45d7@quicinc.com>
 <20240407143902.GB2679@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240407143902.GB2679@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WGv1IFRQHFHFpj3VM7yaBv4pdlrOYyLr
X-Proofpoint-GUID: WGv1IFRQHFHFpj3VM7yaBv4pdlrOYyLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080067



On 4/7/2024 8:09 PM, Manivannan Sadhasivam wrote:
> On Sun, Apr 07, 2024 at 10:07:35AM +0530, Krishna chaitanya chundru wrote:
>> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
> 
> Please specify whether you are referencing PCIe host controller or endpoint
> device or both.
> 
>> ICC (interconnect consumers) path should be voted otherwise it may
> 
> ICC is just 'Interconnect' unless I misunderstood.
> 
>> lead to NoC (Network on chip) timeout. We are surviving because of
>> other driver vote for this path.
>>
> 
> s/vote/voting
> 
>> As there is less access on this path compared to PCIe to mem path
>> add minimum vote i.e 1KBps bandwidth always which is recommended
>> by HW team.
>>
> 
> 'which is sufficient enough to keep the path active.'
> 
>> When suspending, disable this path after register space access
>> is done.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++++++++++----
>>   1 file changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 14772edcf0d3..b4893214b2d3 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -245,6 +245,7 @@ struct qcom_pcie {
>>   	struct phy *phy;
>>   	struct gpio_desc *reset;
>>   	struct icc_path *icc_mem;
>> +	struct icc_path *icc_cpu;
>>   	const struct qcom_pcie_cfg *cfg;
>>   	struct dentry *debugfs;
>>   	bool suspended;
>> @@ -1409,6 +1410,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	if (IS_ERR(pcie->icc_mem))
>>   		return PTR_ERR(pcie->icc_mem);
>>   
>> +	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
>> +	if (IS_ERR(pcie->icc_cpu))
>> +		return PTR_ERR(pcie->icc_cpu);
>>   	/*
>>   	 * Some Qualcomm platforms require interconnect bandwidth constraints
>>   	 * to be set before enabling interconnect clocks.
>> @@ -1418,7 +1422,19 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	 */
>>   	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>>   	if (ret) {
>> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Since the CPU-PCIe path is only used for activities like register
> 
> Again, differentiate PCIe controller and endpoint device access.
> 
Ack to all comments. I will modify in next patch.
>> +	 * access, Config/BAR space access, HW team has recommended to use a
>> +	 * minimal bandwidth of 1KBps just to keep the link active.
>> +	 */
>> +	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth for CPU-PCIe: %d\n",
>>   			ret);
>>   		return ret;
>>   	}
>> @@ -1448,7 +1464,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>   
>>   	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>>   	if (ret) {
>> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
>>   			ret);
>>   	}
>>   }
>> @@ -1610,7 +1626,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   	 */
>>   	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>>   	if (ret) {
>> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
>> +		dev_err(dev, "Failed to set interconnect bandwidth for PCIe-MEM: %d\n", ret);
>>   		return ret;
>>   	}
>>   
>> @@ -1634,7 +1650,15 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   		pcie->suspended = true;
>>   	}
>>   
>> -	return 0;
>> +	/*
>> +	 * Remove the vote for CPU-PCIe path now, since at this point onwards,
>> +	 * no register access will be done.
>> +	 */
> 
> Are you sure? Didn't we see late access to DBI registers on sc7280?
>
yeah you are correct I will add a check to disable icc only in suspend
to idle case. only in suspend to ram case we see the DBI access in sc7280

-Krishna Chaitanya
>> +	ret = icc_disable(pcie->icc_cpu);
>> +	if (ret)
>> +		dev_err(dev, "failed to disable icc path of CPU-PCIe: %d\n", ret);
> 
> s/failed to disable icc path/Failed to disable Interconnect path between CPU-PCIe
> 
>> +
>> +	return ret;
>>   }
>>   
>>   static int qcom_pcie_resume_noirq(struct device *dev)
>> @@ -1642,6 +1666,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>   	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> +	ret = icc_enable(pcie->icc_cpu);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable icc path of CPU-PCIe: %d\n", ret);
> 
> Same as above.
> 
> - Mani
> 

