Return-Path: <linux-pci+bounces-14484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C2499D47A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5836281DE7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F21B4F1C;
	Mon, 14 Oct 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N0c+9iEV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFC1AE01F;
	Mon, 14 Oct 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922720; cv=none; b=vD24zrCAVLk97boo6CJOwCnHfOrc/KeFQMewsx6S9huGbT9sDVMY0OTg5IHaK7QS4uLaPtciVA7E6/wJetAYB9y2/bI92zulEgqYMDbVhB+z5yJxVScgcLZxNTECi/0UT9++RXC8H/v1kncIdqZpH0bbdFYvUnNZm4c5wnsjskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922720; c=relaxed/simple;
	bh=1jhByJa0RId5+9oefBRXhvHGT0313f49JFTVuh7YgNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ghuj10S5DaoCD94E02re/X+AQqu7x6MUxVKULi1ZEBCWIL747OVeYD8pTDnHar67A1uDahXR9y29BtkeTIIT9DuxFxBV5NOsd2jHzz3X6NKSOW824/9lDQU5m+P5Vwa1+lgRz8UjMeZvAHKhiqIRPSqpE80uJ1CLqnTrcl/TWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N0c+9iEV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAvqvs029535;
	Mon, 14 Oct 2024 16:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxNRdhGjV+7le31u9qIRKMQJRSp2xH0nnignDwL39xY=; b=N0c+9iEVHYptLYXn
	GzoAvgIaNnr7qRXZZv15sZ4qhNqRwsIpzK9zfGVLbRK9J2dFAGLKMCRCzT8YfVEQ
	JI88Pf9M5WOPbS8/H7ALfl1/lICsnsTGiPhWAyQW4Pd9NHilE1if0VMEk6JwEC07
	8L4Q1bLMwowasso7UI9S/QRxwedGDmEzCCuQq1kA4ez/+JsBxU1iFT1gwHGQ+Sl7
	9gfg8x7V+kn9N0AD70sQ0dCNdYf35dwoZa6GzFTXvbmI8H7l4xFrg2mYhRcoEnQf
	l9DZ6wTA6mLTcAgo5eOIpre+8JXs62zFv0gGM0VM86MB5UwIqZOZ00hA3nwh5U/E
	L4P89Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427hg74y1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 16:18:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49EGIMcD010632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 16:18:22 GMT
Received: from [10.110.64.87] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 09:18:22 -0700
Message-ID: <c7f3f850-dd48-4024-ac7a-a05669d0a809@quicinc.com>
Date: Mon, 14 Oct 2024 09:18:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <kevin.xie@starfivetech.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>
References: <20241011235530.3919347-1-quic_mrana@quicinc.com>
 <20241012035022.tvcffmnqzpqb7e6q@thinkpad>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20241012035022.tvcffmnqzpqb7e6q@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: So_iHp6aeIzg0xF5_aG1fZwZ8XzUQgYm
X-Proofpoint-GUID: So_iHp6aeIzg0xF5_aG1fZwZ8XzUQgYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140118



On 10/11/2024 8:50 PM, Manivannan Sadhasivam wrote:
> On Fri, Oct 11, 2024 at 04:55:30PM -0700, Mayank Rana wrote:
>> PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
>> bridge device. To enable runtime PM of PCIe host bridge device (child
>> device), it is must to enable parent device's runtime PM to avoid seeing
>> WARN_ON as "Enabling runtime PM for inactive device with active children".
> 
> "to avoid seeing the below warning from PM core:
> pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
> with active children"
ACK

>> Fix this issue by enabling starfive pcie controller device's runtime PM
>> before calling into pci_host_probe() through plda_pcie_host_init().
> 
> "before calling pci_host_probe() in plda_pcie_host_init()"
ACK
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
>> ---
>> v1->v2: Updated commit description based on Bjorn's feedback
>> Link to v1: https://patchwork.kernel.org/project/linux-pci/patch/20241010202950.3263899-1-quic_mrana@quicinc.com/
>>   
>>   drivers/pci/controller/plda/pcie-starfive.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
>> index 0567ec373a3e..e73c1b7bc8ef 100644
>> --- a/drivers/pci/controller/plda/pcie-starfive.c
>> +++ b/drivers/pci/controller/plda/pcie-starfive.c
>> @@ -404,6 +404,9 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	pm_runtime_enable(&pdev->dev);
>> +	pm_runtime_get_sync(&pdev->dev);
>> +
>>   	plda->host_ops = &sf_host_ops;
>>   	plda->num_events = PLDA_MAX_EVENT_NUM;
>>   	/* mask doorbell event */
>> @@ -413,11 +416,12 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>>   	plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
>>   	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
>>   				  &stf_pcie_event);
>> -	if (ret)
>> +	if (ret) {
>> +		pm_runtime_put_sync(&pdev->dev);
>> +		pm_runtime_disable(&pdev->dev);
>>   		return ret;
>> +	}
>>   
>> -	pm_runtime_enable(&pdev->dev);
>> -	pm_runtime_get_sync(&pdev->dev);
>>   	platform_set_drvdata(pdev, pcie);
>>   
>>   	return 0;
>> -- 
>> 2.25.1
>>
> 
Regards,
Mayank

