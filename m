Return-Path: <linux-pci+bounces-19419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FECA04242
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952701682B9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F301F37C8;
	Tue,  7 Jan 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jV+oKrol"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C71F2C40;
	Tue,  7 Jan 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259570; cv=none; b=uByGFuAJ8wsG0Msvhf7aceiHvTWH5fBdLYzDje7bI9Ay01FtgvnsTR8s1MhVV3WeEJrfmJZtxPO3dJ3ZIBk9eLCH0RzdilrDTfM9gUroc2gvxHYTw5URaLTBqWbax49g5Nx9KfA8UeRo5CJUUBE+4lGhISj90UE0o/DbPGXWtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259570; c=relaxed/simple;
	bh=Q6MQDHNRFKm2sOpuRD1mFw1ZawQQ014ZZApZqBmyNAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UBIyuX/KsSwQSV9JIAKYHivObgt0papQoFWgh1iW48mGsmQn2WYEylybGj5Nty0llDwkLZA6ept+Ekyp3lLdxQ4TBqYZnYxTLHdecfc3LbiB7tTLy3T18BVaGazjYclFv1avmOoxBpyI0Md7KeZd0Cdf/NfIMERe94ytkDzmpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jV+oKrol; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507A8Pbe023187;
	Tue, 7 Jan 2025 14:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kdUcPs4cnRbG4X/cME+w/iNc+oPWaYkwkn8rqB4yEWM=; b=jV+oKrol3mWJ+rhb
	TUQCXfCh6Mn1iIMMebj3cCmWkM7FZ3FENG6pmFlMAom0jU/2E8v17rHUWhYj+laM
	EZ+NAMsvsL5Pkzx2U72VzTYrEVpx2TSqaZWG7DWiI0f8RymF3LnI9RxcjZZFDFfc
	WL0wmLdR9WvWYKixl7a4fkVw6WbvfG/WRIyG5Q4ultHdL5hv1mKC82Y2ioCWsnju
	YC2D4NVdML43QaIc89ERNDlAhda2N9A+YbtUdwjx6qp3Lx99VUiPjZa7jHw+tEdc
	Q5odytN8ggXLdxt6q8dlU3PWagpyJ96lwBh6QrCEIIzQzLLz509xeOi4zc985dA3
	ePSDkA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44128nrjuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:19:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507EJAwU024293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 14:19:10 GMT
Received: from [10.216.0.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 Jan 2025
 06:19:04 -0800
Message-ID: <6d75827d-5285-35ff-bf9b-aec77cd8304e@quicinc.com>
Date: Tue, 7 Jan 2025 19:49:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V1] schemas: pci: bridge: Document PCI L0s & L1 entry
 delay and nfts
Content-Language: en-US
To: Rob Herring <robh@kernel.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>
CC: <andersson@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <krzk@kernel.org>,
        <helgaas@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree-spec@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>
References: <20250106093304.604829-1-krishna.chundru@oss.qualcomm.com>
 <CAL_JsqJXGUmzE+tPccDmdi5r0YvQ5kOL2mh3e6KtEvTnsexnyg@mail.gmail.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAL_JsqJXGUmzE+tPccDmdi5r0YvQ5kOL2mh3e6KtEvTnsexnyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YtVJhBZfzPH_hrZe9NfpqH6sKmuy8ESH
X-Proofpoint-ORIG-GUID: YtVJhBZfzPH_hrZe9NfpqH6sKmuy8ESH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=0 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070120



On 1/6/2025 8:37 PM, Rob Herring wrote:
> On Mon, Jan 6, 2025 at 3:33 AM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>>
>> Some controllers and endpoints provide provision to program the entry
>> delays of L0s & L1 which will allow the link to enter L0s & L1 more
>> aggressively to save power.
>>
>> As per PCIe spec 6 sec 4.2.5.6, the number of Fast Training Sequence (FTS)
>> can be programmed by the controllers or endpoints that is used for bit and
>> Symbol lock when transitioning from L0s to L0 based upon the PCIe data rate
>> FTS value can vary. So define a array for each data rate for nfts.
>>
>> These values needs to be programmed before link training.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> - This change was suggested in this patch: https://lore.kernel.org/all/20241211060000.3vn3iumouggjcbva@thinkpad/
>> ---
>>   dtschema/schemas/pci/pci-bus-common.yaml | 16 ++++++++++++++++
> 
> Do these properties apply to any link like downstream ports on a PCIe switch?
> 
These applies to downstream ports also on a switch.
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
>> index 94b648f..f0655ba 100644
>> --- a/dtschema/schemas/pci/pci-bus-common.yaml
>> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
>> @@ -128,6 +128,16 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       enum: [ 1, 2, 4, 8, 16, 32 ]
>>
>> +  nfts:
> 
> Kind of short. How about num-fts? Or is "NFTS" a PCI term?
> 
yes, nfts is the PCIe spec term.
>> +    description:
>> +      Number of Fast Training Sequence (FTS) used during L0s to L0 exit for bit
>> +      and Symbol lock.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 5
> 
> Need to define what is each entry? Gen 1 to 5?
> 
yes there are from Gen1 to Gen 5, I will update this in next patch these
details.
>> +    items:
>> +      maximum: 255
> 
> Why not use uint8 array then?
>
In the previous commits it was suggested to use u32 by the reviewers to
make it uniform withall the properties,it makes sense to use it as uint8
as we are moving to generic properties.

- Krishna Chaitanya.

>> +
>>     reset-gpios:
>>       description: GPIO controlled connection to PERST# signal
>>       maxItems: 1
>> @@ -150,6 +160,12 @@ properties:
>>       description: Disables ASPM L0s capability
>>       type: boolean
>>
>> +  aspm-l0s-entry-delay-ns:
>> +    description: Aspm l0s entry delay.
>> +
>> +  aspm-l1-entry-delay-ns:
>> +    description: Aspm l1 entry delay.
>> +
>>     vpcie12v-supply:
>>       description: 12v regulator phandle for the slot
>>
>> --
>> 2.34.1
>>
>>
> 

