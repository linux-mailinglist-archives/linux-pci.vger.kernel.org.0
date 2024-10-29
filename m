Return-Path: <linux-pci+bounces-15537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76CD9B4DAC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D8CB25989
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB001940AA;
	Tue, 29 Oct 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bXlk88oR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8418C936;
	Tue, 29 Oct 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215366; cv=none; b=NW9WjQY/8PQ2tKZLonfJBHJ2Ya+HK1TEtSHPq3Y8S6Du1Bp+vazeuwDCHncwwzlnj202TZ3YfXueYWZcM74ex2QrxNuxr8eN8HDi2kmHncVL/T62QhUHl7QsJc49Hzlc5UmkzT11wBkJbtJmKrYfmi9BvMxCRKhCf7a5D0os5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215366; c=relaxed/simple;
	bh=ag2xWZP52xjYz29agzB2MiuQCeirfJXkM8NWHJTwoI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YOeyL4E+oZMFp9qngbfKqKRDInsNcxMT+AvRmDepNDw4TgEs/VdmkVaW51JyHGmV8JWlk78oDMflHjdDdBsKCGb1vlYLTAa/5JJ8lovHaPJVgNYthL0jnUdcBaj1TqgDh/K0Fws4KsIltMrAFl/6aam6q5XG6qK9o2kW454rvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bXlk88oR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T9f4YZ022992;
	Tue, 29 Oct 2024 15:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oTSuyvA/VwRe9Ir8gE1iZB5B1RSVX/+RxkHQsl7p5Jk=; b=bXlk88oR8qX+3FI4
	xfLd/AYj1NfaUE2qxGhVjJEN+sA/Iv3gvP5Fn0uIBiY8Sxk9CcR5mg7C4lGO/RVe
	Zv6D5tQ8u/P+DUEjbVihE29cXnwiAopFO8jdKWS42DlJNoqLBiCc35m/JE9QLcc2
	yAx11YU7bqIGRLDw9Klqv7kXgNIQTbFPia6K2UlDLFF2gVX4VdRkxP+TOOSyrv99
	X1YmStvJDIOJm0IbqGPthEEcRsoolugHx0OUWWZeCdp7qX4z211JqH7p13zrbwKV
	qX2qN/oCFE2cfX2B9z4doDGj9wkeicK75wVyDc5Q23lCYOHradauPOEvAPyvr93T
	0rJJVg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt70skm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 15:22:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TFMRei028795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 15:22:27 GMT
Received: from [10.216.61.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 08:22:19 -0700
Message-ID: <648d12f6-85d4-971a-b46d-d0e8f9db9091@quicinc.com>
Date: Tue, 29 Oct 2024 20:52:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan
	<james.quinlan@broadcom.com>
CC: Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        "Nicolas Saenz
 Julienne" <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <jim2101024@gmail.com>,
        "Florian
 Fainelli" <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM
 BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
        Mayank Rana
	<quic_mrana@quicinc.com>
References: <20241029144850.GA1152694@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241029144850.GA1152694@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7p8bR0FlgV4dE3YY8FOrnvmSRd9xV-hc
X-Proofpoint-GUID: 7p8bR0FlgV4dE3YY8FOrnvmSRd9xV-hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290117



On 10/29/2024 8:18 PM, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2024 at 10:22:36AM -0400, Jim Quinlan wrote:
>> On Tue, Oct 29, 2024 at 1:17 AM Krishna Chaitanya Chundru
>> <quic_krichai@quicinc.com> wrote:
>>> On 10/29/2024 12:21 AM, James Quinlan wrote:
>>>> On 10/24/24 21:08, Krishna Chaitanya Chundru wrote:
>>>>> On 10/22/2024 12:33 AM, Rob Herring wrote:
>>>>>> On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
>>>>>>> Support configuration of the GEN3 preset equalization settings, aka the
>>>>>>> Lane Equalization Control Register(s) of the Secondary PCI Express
>>>>>>> Extended Capability.  These registers are of type HwInit/RsvdP and
>>>>>>> typically set by FW.  In our case they are set by our RC host bridge
>>>>>>> driver using internal registers.
>>>>>>>
>>>>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>>>>> ---
>>>>>>>    .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12
>>>>>>> ++++++++++++
>>>>>>>    1 file changed, 12 insertions(+)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>>>> b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>>>> index 0925c520195a..f965ad57f32f 100644
>>>>>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>>>> @@ -104,6 +104,18 @@ properties:
>>>>>>>        minItems: 1
>>>>>>>        maxItems: 3
>>>>>>>    +  brcm,gen3-eq-presets:
>>>>>>> +    description: |
>>>>>>> +      A u16 array giving the GEN3 equilization presets, one for
>>>>>>> each lane.
>>>>>>> +      These values are destined for the 16bit registers known as the
>>>>>>> +      Lane Equalization Control Register(s) of the Secondary PCI
>>>>>>> Express
>>>>>>> +      Extended Capability.  In the array, lane 0 is first term,
>>>>>>> lane 1 next,
>>>>>>> +      etc. The contents of the entries reflect what is necessary for
>>>>>>> +      the current board and SoC, and the details of each preset are
>>>>>>> +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.
>>>>>>
>>>>>> If these are defined by the PCIe spec, then why is it Broadcom specific
>>>>>> property?
>>>> Yes, I will remove the "brcm," prefix.
>>>>>>
>>>>> Hi Rob,
>>>>>
>>>>> qcom pcie driver also needs to program these presets as you suggested
>>>>> this can go to common pci bridge binding.
>>>>>
>>>>> from PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4.2 for data rates
>>>>> of  8.0 GT/s, 16.0 GT/s, and 32.0 GT/s uses one class of preset (P0
>>>>> through P10) and where as data rates of 64.0 GT/s use different class of
>>>>> presets (Q0 through Q10) (Table 4-23). And data rates of 8.0 GT/s also
>>>>> have optional preset hints (Table 4-24).
>>>>>
>>>>> And there is possibility that for each data rate we may require
>>>>> different preset configuration.
>>>>>
>>>>> Can we have a dt binding for each data rate of 16 byte array.
>>>>> like gen3-eq-preset array, gen4-eq-preset array etc.
>>>>
>>>> Yes, that was the idea when using "genX-eq-preset", for X in {3,4...}.
>>>>
>>>> Keep in mind that this is an RFC; I have a backlog of commit submissions
>>>> before I can submit the code that uses this DT property.  If you
>>>> (Krishna) want to submit something now I'd be quite happy to go with
>>>> that.  I don't believe it is acceptable to submit a bindings commit w/o
>>>> code that uses it (if I'm incorrect I'll be glad to do a V2).
>>>>
>>> I submitted a pull request for this. if you have any other suggestions
>>> or if we need to have any other details we can update this pull request.
>>> https://github.com/devicetree-org/dt-schema/pull/146
>>
>> Thanks for doing this.   However, why a u8 array?  The registers are
>> defined as u16 so it would be more natural to use a u16 array, each
>> entry giving
>> all of the data for a single lane.  In our implementation we read a
>> u16 and we write it to the register -- what advantage is there by
>> using a u8 array?
>>
>> Also if there are 16 lanes, you will need 32 maxItems, correct?
> 
> I added these questions to the github PR.
> 
> Also, why does it define gen3-eq-presets, gen4-eq-presets,
> gen5-eq-presets, and gen6-eq-presets?  I think there's only a single
> place to write these values (the Lane Equalization Control registers,
> PCIe r6.0, sec 7.7.3.4), isn't here?  How would software choose the
> correct values to use?
> 
Hi Jim & Bjorn,

7.7.3.4 Lane Equalization Control Register is for gen3 speed, for gen4
we had a new capability register 7.7.5.9 16.0 GT/s Lane Equalization 
Control Register for gen5 we have 7.7.6.9 32.0 GT/s Lane Equalization 
Control Register.

for gen3 we should not use uint8 as gen3 as transmitter preset and
receiver preset hint thus for each lane we need to have uint16 instead
of uint8 as we are defining per lane property in driver where we use
each uint16 value of array needs to be mapped correctly in the register.
If we have only support for single lane then last 16 bits becomes
invalid. so for 16 lanes we need to uint16 array each of uint16 instead
of uint8. ( I will modify it to uint16 instead of uint16)

for remaining gen speeds we don't have receiver preset hint, and it
requires only 8 bits to represent a lane only. so i will use only uint8
for remaining gen speeds.

Bjorn,

from PCIe spec 8.3.3.3 Tx Equalization Presets for 8.0, 16.0, 32.0, and
64.0 GT/ tells which preset value we neeed to use based upon different
parameters. Based upon the type of the board hardware one has to
calculate the preset value and provide them using these properties.

- Krishna Chaitanya.

>>>>> - Krishna Chaitanya
>>>>>>> +
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint16-array
>>>>>>
>>>>>> minItems: 1
>>>>>> maxItems: 16
>>>>>>
>>>>>> Last I saw, you can only have up to 16 lanes.
>>>>>>
>>>>>> Rob
>>>>>>
>>>>
> 
> 

