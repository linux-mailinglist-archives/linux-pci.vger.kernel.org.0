Return-Path: <linux-pci+bounces-19420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E95A04252
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288841662A2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F98D1EF0A5;
	Tue,  7 Jan 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OXv3NdYv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D5208AD;
	Tue,  7 Jan 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259738; cv=none; b=VFeOq9Wf7xXUQ8t5ofKqilXMpDSdEY/GWuzn8e/awwl392PgBplVE60J9IVOCg4myFEvi35T+BKL6+xcPY8RPd5LsCuu3gW1qJSsp6BwxsOBfiduHjqnDHyQ5sMAFEtXBroPpKnKOPxmN4AvDoKeCzBRhma25tICJFuIY0NRvos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259738; c=relaxed/simple;
	bh=+q9jsS9IUsAH9ZfRSJOGGC1xKnrTfs3ck9U49KV6JAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p/NDlhsdpQp7bjSon7XMaNtYm82NXqC11lBwwWE6OarBlxZwnUSkfGWQq488qXHJhuzilqkja8kVAqmYlOYZLw5mPv0ZeS5K7MJUvGKbHAdj7CnYyuoX4j+FSfuw0E3By12BGNKSW3oQagUMQEyRo3ehnaMC0Z1J7QrvfTTnjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OXv3NdYv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507C0gUv018240;
	Tue, 7 Jan 2025 14:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VC1d2ycgqshJVj5AQTRvhaYmKvvZMCFknpmeM7lb7k0=; b=OXv3NdYvList/grJ
	zTLgSyC0lstWJBvn/g+M0gLOYjl0APsb62Sjz2flLatWkPsye6ex6DLJfL6bzKne
	xMXggC3uka9YYtpvfzRkd5wIUZR9DagejSqkOCfi5WjZyUfJFed8l7Cdn3hZ1vI3
	GWh8hl41YQf2t7LyvqntSBWzUWn47EIr3ZsFGJgkWi9jZ+p+Ov0Qje1FUEHumSPW
	cidgVKf9beiqS/mHl4GmnV7x7mg9AcgS02L7vrKwQ/fD77kb18VKuErnaijbkMmv
	ZyymbatuU4XZEYRhssF/t91299H6WqMq6Js7mcKXsdLoBmNwUHa18kdPzJffaJQc
	nYRwWg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4413w98a8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:22:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507EM6f3011753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 14:22:06 GMT
Received: from [10.216.0.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 Jan 2025
 06:22:00 -0800
Message-ID: <16ba024e-1e51-be4a-8c6a-e8752abf7b49@quicinc.com>
Date: Tue, 7 Jan 2025 19:51:56 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>
CC: <andersson@kernel.org>, <robh@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <conor+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree-spec@vger.kernel.org>, <quic_vbadigan@quicinc.com>
References: <20250106233246.GA116572@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20250106233246.GA116572@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FM56DRBTfKLP7jdKNJAq0BAhkuWce70l
X-Proofpoint-GUID: FM56DRBTfKLP7jdKNJAq0BAhkuWce70l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070121



On 1/7/2025 5:02 AM, Bjorn Helgaas wrote:
> On Mon, Jan 06, 2025 at 03:03:04PM +0530, Krishna Chaitanya Chundru wrote:
>> Some controllers and endpoints provide provision to program the entry
>> delays of L0s & L1 which will allow the link to enter L0s & L1 more
>> aggressively to save power.
> 
> Although these are sort of related because FTS is used during L0s->L1
> transitions, I think these are subtle enough that it's worth splitting
> this into two patches.
>
Ack I will split the patches as suggested in next series.

>> As per PCIe spec 6 sec 4.2.5.6, the number of Fast Training Sequence (FTS)
>> can be programmed by the controllers or endpoints that is used for bit and
>> Symbol lock when transitioning from L0s to L0 based upon the PCIe data rate
>> FTS value can vary. So define a array for each data rate for nfts.
>>
>> These values needs to be programmed before link training.
> 
> IIUC, the point of this is to program the N_FTS value ("number of Fast
> Training Sequences required by the Receiver" as described in PCIe
> r6.0, sec 4.2.5.1, tables 4-25, 4-26, 4-27 for TS1, TS2, and Modified
> TS1/TS2 Ordered Sets).
> 
> During Link training, all PCIe components transmit the N_FTS value
> they require.  Sec 4.2.5.6 only describes the Fast Training Sequence
> from a protocol perspective.  The fact that the N_FTS value of a
> device may be programmable is device-specific.
> 
> Possible text:
> 
>    Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
>    captures the N_FTS value it receives.  Per 4.2.5.6, when
>    transitioning the Link from L0s to L0, it must transmit N_FTS Fast
>    Training Sequences to enable the receiver to obtain bit and Symbol
>    lock.
> 
>    Components may have device-specific ways to configure N_FTS values
>    to advertise during Link training.  Define an n_fts array with an
>    entry for each supported data rate.
> 
Ack
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> - This change was suggested in this patch: https://lore.kernel.org/all/20241211060000.3vn3iumouggjcbva@thinkpad/
>> ---
>>   dtschema/schemas/pci/pci-bus-common.yaml | 16 ++++++++++++++++
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
>> +    description:
>> +      Number of Fast Training Sequence (FTS) used during L0s to L0 exit for bit
>> +      and Symbol lock.
> 
> I think it's worth using the "number of Fast Training Sequences
> required by the Receiver" language from the spec to hint that these
> values will be used to program a component with the number of FTSs
> that it requires as a Receiver, and the component will advertise this
> number as N_FTS during Link training.
> 
>    n_fts:
>      description:
>        The number of Fast Training Sequences (N_FTS) required by the
>        Receiver (this component) when transitioning the Link from L0s
>        to L0; advertised during initial Link training
>
Ack

>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 5
>> +    items:
>> +      maximum: 255
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
> 
> s/Aspm/ASPM/
> s/l0s/L0s/
> s/l1/L1/
> 
Ack
> (I mentioned these earlier in the conversation you pointed to above,
> but they got missed)
> 
Sorry I missed these to update I will update these in the next patch.
and thanks for reviewing and suggestions for the descriptions and commit
text.

- Krishna Chaitanya.
> Also, to match surrounding items:
> s/\.$//
> 
>>     vpcie12v-supply:
>>       description: 12v regulator phandle for the slot
>>   
>> -- 
>> 2.34.1
>>
> 

