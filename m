Return-Path: <linux-pci+bounces-17381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D459DA080
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 02:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8B92852B7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 01:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A61F1BC3C;
	Wed, 27 Nov 2024 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IDPNF800"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AFF14F90;
	Wed, 27 Nov 2024 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732672713; cv=none; b=rnbvkRiso/PuOkMwdz5nFhwvZq3dIFWfvtZ8nPXn6HtsxShNU3oSDaQnYUV78i026/KNPhYt+zXLL1toU4fge2FShcmiq7Ss+5VwVQLvTJEFOmM/CeZtlp0kZM7yrTLYZq6DC9fgCo4KbbKRjpP+2X0PTAhlg8N+dL+ERM9KHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732672713; c=relaxed/simple;
	bh=CvGs68H2xkIajgyJcmTQLagTvM0yJHf0yGkXqMt0NUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jtEMAf1kVuqIGeWmAP+zswy+ziToD6h8+l8/vxRSr0BiPXtG9M7uwC5uCCKy+4jvBU3k5OMLpf97lJNNukARAth9uTMNR8yOZ4Rm7b0e7IwqRfj+sDDbre3BEU6glqO6vden7ubz4rx/lChyVtuEF/H5iw+uA2EafCJIjUG89so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IDPNF800; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQKL4ud005672;
	Wed, 27 Nov 2024 01:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EmZqD7ocn3WRNDRezaNH3t2EaAWioA15EVm251HzGhE=; b=IDPNF800PH80Hch6
	k8m5Iz6cS3qJUBsCcv3HNOkrZNik/VmLQjZdlCLSP6+wLtR7kiLHfqckvhRgY9z/
	q905+EWwytRovJ9xfpYke/H7/Kf1mvWuZytARBs7sRfiUhO0ihPGkXIA9g1X8OU7
	Pxtx2GhNn32qQTEcFzG2kiVw6s/aI7uqYVu97f7FZnzeOcKDcZxoeTdv+MZ0uuSp
	64filq85ZiPXEr+4/NV214zwP9C7iB3I1Wryw9jkAUQm9FA84L/CjHtCd0KmobXF
	yMeBbVljB8M+V3NLVPq3jcxhQjycDyF7Zjx4dvaynpbXqREviXx0I2ioBpndOGjU
	mwH4WA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434ts1mty7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 01:58:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AR1wNEJ003150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 01:58:23 GMT
Received: from [10.216.8.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 26 Nov
 2024 17:58:14 -0800
Message-ID: <7d905563-137d-5c0e-42a1-8b93f4d630ce@quicinc.com>
Date: Wed, 27 Nov 2024 07:28:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <kernel@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20241116-presets-v1-0-878a837a4fee@quicinc.com>
 <20241116-presets-v1-2-878a837a4fee@quicinc.com>
 <7dd7ecd2-c8a1-4800-8746-2b6166d3ae1c@oss.qualcomm.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <7dd7ecd2-c8a1-4800-8746-2b6166d3ae1c@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nvfwKvwjtjIuIw0O7P0xaRYojphJAjJp
X-Proofpoint-ORIG-GUID: nvfwKvwjtjIuIw0O7P0xaRYojphJAjJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270015



On 11/16/2024 4:29 PM, Konrad Dybcio wrote:
> On 16.11.2024 2:37 AM, Krishna chaitanya chundru wrote:
>> PCIe equalization presets are predefined settings used to optimize
>> signal integrity by compensating for signal loss and distortion in
>> high-speed data transmission.
>>
>> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
>> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
>> configure lane equalization presets for each lane to enhance the PCIe
>> link reliability. Each preset value represents a different combination
>> of pre-shoot and de-emphasis values. For each data rate, different
>> registers are defined: for 8.0 GT/s, registers are defined in section
>> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
>> an extra receiver preset hint, requiring 16 bits per lane, while the
>> remaining data rates use 8 bits per lane.
>>
>> Based on the number of lanes and the supported data rate, this function
>> reads the device tree property and stores in the presets structure.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/of.c  | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h | 17 +++++++++++++--
>>   2 files changed, 77 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index dacea3fc5128..0d37bc231956 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -826,3 +826,65 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>>   	return slot_power_limit_mw;
>>   }
>>   EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
>> +
>> +int of_pci_get_equalization_presets(struct device *dev,
>> +				    struct pci_eq_presets *presets,
>> +				    int num_lanes)
>> +{
>> +	int ret;
>> +
>> +	if (of_property_present(dev->of_node, "eq-presets-8gts")) {
>> +		presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
>> +		if (!presets->eq_presets_8gts)
> 
> If you make this an array with enum indices, you can make a for loop and
> read "eq-presets-%ugts", (8 << i)
> 
> Konrad
as "eq-presets-8gts" is u16 array and other properties are u8 array.
I will use as it is for "eq-presets-8gts", but for remaining properties
I will use for loop as suggested by you.

- Krishna Chaitanya.

