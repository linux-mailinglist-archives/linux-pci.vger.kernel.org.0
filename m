Return-Path: <linux-pci+bounces-7295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1818C1245
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9811C20FDF
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81816F26D;
	Thu,  9 May 2024 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OAIzkNm7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368363F8E2;
	Thu,  9 May 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269956; cv=none; b=Ju3JT7JohdqA3I2NxW9Zkw2SOCy3Ssjzl8h3QSWgUKxo/1ssdEOEiJ3wFBjCqR7pYNP6QHDCVt7NccuIZlY23LOtlN/sph5KNN3nvsnulBnxkyBIb8SC3i9q4f6oHe+yqGkN5uzprIIuHwmPRlOfXLk0lgdSSLqlOqo/DHzL6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269956; c=relaxed/simple;
	bh=y1b/BJ6+o2tx8onxvo2sdl0U/kfb+AndkI8eF0HOdWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YBGz6HdDpHQmqTXljyhRh7lz5BwiAhquuPIHiJJsGR24e1O5WzoMy4U/k8UMfBDGG8ltHY4Yu/hmoNuoRR5WNO/s3V+Rvzv0rFr5JsPo2RRzldsFTe88Of7awxwF/Efwu6QCHHnm84xeHU/CNk0Im4cWXhQKZHJlZGB/aHY21Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OAIzkNm7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449DtgZU002462;
	Thu, 9 May 2024 15:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4rFYxAwYD1tKxYEP9QReednAgW30V4VYCm02iCFO++A=; b=OA
	IzkNm7SIUvvs6gRyUaSjU9l/MSihdC9Q65De8GqFoQwogEZewIuzeWeOL7XfuVs2
	upIwMIuYPkX1n3UPc4Jr5mRj7I2wAT8Q7z/uINyE6w1pZjQQ923KDeke0ENvwBs0
	FqiAbP5ZXKLrpxxRQxiaA1oaNeoveVVV8nYF1iFOZ4cMNoZi4To3YHLcCY0fapBH
	OMSGiRA2OcFrPq6nVuWFTpFPWOxOuxZruMfoOiAGrwUae3/7MB6ix9pRH4CR/Hql
	Mk2QBD3TpVq5iD/0hNuUk99/AfDtcgzFyVCJ9lAPBBtuL9PS8YIP1MDVJ2vfo3n1
	Bf8r1DCrXMjIPa8kCmPg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y08ne34vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 15:52:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449Fq927012208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 15:52:09 GMT
Received: from [10.216.15.105] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 08:52:00 -0700
Message-ID: <8b213eba-7ab6-ae9c-7683-937a9d6aaf08@quicinc.com>
Date: Thu, 9 May 2024 21:21:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v12 6/6] PCI: qcom: Add OPP support to scale performance
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
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>
References: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
 <20240427-opp_support-v12-6-f6beb0a1f2fc@quicinc.com>
 <20240430052613.GD3301@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240430052613.GD3301@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e3kRQnlviW5VTpG8CYK6mD-swvONXwYd
X-Proofpoint-ORIG-GUID: e3kRQnlviW5VTpG8CYK6mD-swvONXwYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405090107



On 4/30/2024 10:56 AM, Manivannan Sadhasivam wrote:
> On Sat, Apr 27, 2024 at 07:22:39AM +0530, Krishna chaitanya chundru wrote:
>> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
>> maintains hardware state of a regulator by performing max aggregation of
>> the requests made by all of the clients.
>>
>> PCIe controller can operate on different RPMh performance state of power
>> domain based on the speed of the link. And this performance state varies
>> from target to target, like some controllers support GEN3 in NOM (Nominal)
>> voltage corner, while some other supports GEN3 in low SVS (static voltage
>> scaling).
>>
>> The SoC can be more power efficient if we scale the performance state
>> based on the aggregate PCIe link bandwidth.
>>
>> Add Operating Performance Points (OPP) support to vote for RPMh state based
>> on the aggregate link bandwidth.
>>
>> OPP can handle ICC bw voting also, so move ICC bw voting through OPP
>> framework if OPP entries are present.
>>
>> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
>> is supported.
>>
>> Before PCIe link is initialized vote for highest OPP in the OPP table,
>> so that we are voting for maximum voltage corner for the link to come up
>> in maximum supported speed.
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++------
>>   1 file changed, 67 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 465d63b4be1c..40c875c518d8 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> 
> [...]
> 
>> @@ -1661,6 +1711,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   		ret = icc_disable(pcie->icc_cpu);
>>   		if (ret)
>>   			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>> +
>> +		if (!pcie->icc_mem)
>> +			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
> 
> At the start of the suspend, there is a call to icc_set_bw() for PCIe-MEM path.
> Don't you want to update it too?
> 
> - Mani
>
if opp is supported we just need to call dev_pm_opp_set_opp() only once
which will take care for both PCIe-MEM & CPU-PCIe path.
so we are not adding explicitly there.
- Krishna Chaitanya.


