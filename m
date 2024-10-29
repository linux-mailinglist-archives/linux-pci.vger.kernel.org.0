Return-Path: <linux-pci+bounces-15553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0039B4FDD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB5B1C20DCA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697971D5CDB;
	Tue, 29 Oct 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ORjacSq3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E419995A;
	Tue, 29 Oct 2024 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220927; cv=none; b=SYp4AwGpnkFBFDlwBaskPqa0JvliVJIzdfHTIJBt5xpb7VSMNvFsGhy8cCDcV6DLgwDddAQKoyHdc7Wqc0KpmudDR6qd8MDWFe6DPxXDuQDn36ZL3c6RNsjCDUUFSaxdu/S9PjNKo9UPryxatl9/DgAtm9QkLt01GdIh9+CVsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220927; c=relaxed/simple;
	bh=pkXIRdIs/jZR3TXb+O6bD4IKMKSCJczdWSHEHc96lSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mXBX5LKUNDC459q/VMha6pFJGguIIU6KgppzYx5c0gLl3vzqkpL5kv2WnmFy/WYn8L5jcAHpG+xeEmuMu5IxzJdWDUHqUdzMjGw8neQnAhdCtKVKE2ZMhS7RcnOfmmtycrYfMaEjoCJUz+qxA502L4hQnhS47GKX/E3YuR89kQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ORjacSq3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T909MB010250;
	Tue, 29 Oct 2024 16:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PDl2iRxwvVar6fxWCNmum7s4lN+Zxn4SBV0GVrlZ2VU=; b=ORjacSq3Vcelm5XJ
	P7cZha6rFAgWIhzhVNV8UzOMlXGDmkqud2mYF4/8MKEoG61z67ZV0OiWiFzQl7Jn
	NTJi7UViqa43vnDmRXO9ACszQOiuv/znGY9oW/Se+a62wbK5uUQ7pBcvCDnYyy4h
	m3Myhf8BFwGYtOg5FGHzdgw/ypOVdgtN/NYhldUUuxiy+DCNRGFay+sM2MIzdoCK
	qlZ61hi/jbqZMgZLMIp+9kqm3IaEZEcd3xKX/WY/sdi0ccp8S3tFWNgfhis8SK+Y
	CdD8DVtzfD9K/xChAKhj39tATyn7QJ++AQz7cLO56dGmbH7SWICaCykzg/1bOiBk
	tHUw5w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grn515u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:55:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TGt0qA006858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:55:00 GMT
Received: from [10.216.61.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 09:54:53 -0700
Message-ID: <d63f16ac-c5ed-35cd-ec75-0bf6d7dab9ca@quicinc.com>
Date: Tue, 29 Oct 2024 22:24:48 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jim Quinlan <james.quinlan@broadcom.com>, Rob Herring <robh@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <jim2101024@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "moderated
 list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        Veerabhadrarao Badiganti
	<quic_vbadigan@quicinc.com>,
        Mayank Rana <quic_mrana@quicinc.com>
References: <20241029155538.GA1157681@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241029155538.GA1157681@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fTatBQxwIDrKlTzbenOJYgld54KnJrsF
X-Proofpoint-ORIG-GUID: fTatBQxwIDrKlTzbenOJYgld54KnJrsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290129



On 10/29/2024 9:25 PM, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2024 at 10:40:32AM -0500, Bjorn Helgaas wrote:
>> On Tue, Oct 29, 2024 at 08:52:15PM +0530, Krishna Chaitanya Chundru wrote:
>>> On 10/29/2024 8:18 PM, Bjorn Helgaas wrote:
>>>> On Tue, Oct 29, 2024 at 10:22:36AM -0400, Jim Quinlan wrote:
>>>>> On Tue, Oct 29, 2024 at 1:17 AM Krishna Chaitanya Chundru
>>>>> <quic_krichai@quicinc.com> wrote:
>>>>>> On 10/29/2024 12:21 AM, James Quinlan wrote:
>>>>>>> On 10/24/24 21:08, Krishna Chaitanya Chundru wrote:
>>>>>>>> On 10/22/2024 12:33 AM, Rob Herring wrote:
>>>>>>>>> On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
>>>>>>>>>> Support configuration of the GEN3 preset equalization settings, aka the
>>>>>>>>>> Lane Equalization Control Register(s) of the Secondary PCI Express
>>>>>>>>>> Extended Capability.  These registers are of type HwInit/RsvdP and
>>>>>>>>>> typically set by FW.  In our case they are set by our RC host bridge
>>>>>>>>>> driver using internal registers.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>>>>>>>> ---
>>>>>>>>>>     .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12
>>>>>>>>>> ++++++++++++
>>>>>>>>>>     1 file changed, 12 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git
>>>>>>>>>> a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>>>>>>> b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>>>>>>> index 0925c520195a..f965ad57f32f 100644
>>>>>>>>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>>>>>>>> @@ -104,6 +104,18 @@ properties:
>>>>>>>>>>         minItems: 1
>>>>>>>>>>         maxItems: 3
>>>>>>>>>>     +  brcm,gen3-eq-presets:
>>>>>>>>>> +    description: |
>>>>>>>>>> +      A u16 array giving the GEN3 equilization presets, one for
>>>>>>>>>> each lane.
>>>>>>>>>> +      These values are destined for the 16bit registers known as the
>>>>>>>>>> +      Lane Equalization Control Register(s) of the Secondary PCI
>>>>>>>>>> Express
>>>>>>>>>> +      Extended Capability.  In the array, lane 0 is first term,
>>>>>>>>>> lane 1 next,
>>>>>>>>>> +      etc. The contents of the entries reflect what is necessary for
>>>>>>>>>> +      the current board and SoC, and the details of each preset are
>>>>>>>>>> +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.
>>>>>>>>>
>>>>>>>>> If these are defined by the PCIe spec, then why is it Broadcom specific
>>>>>>>>> property?
>>>>>>> Yes, I will remove the "brcm," prefix.
>>>>>>>>>
>>>>>>>> Hi Rob,
>>>>>>>>
>>>>>>>> qcom pcie driver also needs to program these presets as you suggested
>>>>>>>> this can go to common pci bridge binding.
>>>>>>>>
>>>>>>>> from PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4.2 for data rates
>>>>>>>> of  8.0 GT/s, 16.0 GT/s, and 32.0 GT/s uses one class of preset (P0
>>>>>>>> through P10) and where as data rates of 64.0 GT/s use different class of
>>>>>>>> presets (Q0 through Q10) (Table 4-23). And data rates of 8.0 GT/s also
>>>>>>>> have optional preset hints (Table 4-24).
>>>>>>>>
>>>>>>>> And there is possibility that for each data rate we may require
>>>>>>>> different preset configuration.
>>>>>>>>
>>>>>>>> Can we have a dt binding for each data rate of 16 byte array.
>>>>>>>> like gen3-eq-preset array, gen4-eq-preset array etc.
>>>>>>>
>>>>>>> Yes, that was the idea when using "genX-eq-preset", for X in {3,4...}.
>>>>>>>
>>>>>>> Keep in mind that this is an RFC; I have a backlog of commit submissions
>>>>>>> before I can submit the code that uses this DT property.  If you
>>>>>>> (Krishna) want to submit something now I'd be quite happy to go with
>>>>>>> that.  I don't believe it is acceptable to submit a bindings commit w/o
>>>>>>> code that uses it (if I'm incorrect I'll be glad to do a V2).
>>>>>>>
>>>>>> I submitted a pull request for this. if you have any other suggestions
>>>>>> or if we need to have any other details we can update this pull request.
>>>>>> https://github.com/devicetree-org/dt-schema/pull/146
>>>>>
>>>>> Thanks for doing this.   However, why a u8 array?  The registers are
>>>>> defined as u16 so it would be more natural to use a u16 array, each
>>>>> entry giving
>>>>> all of the data for a single lane.  In our implementation we read a
>>>>> u16 and we write it to the register -- what advantage is there by
>>>>> using a u8 array?
>>>>>
>>>>> Also if there are 16 lanes, you will need 32 maxItems, correct?
>>>>
>>>> I added these questions to the github PR.
>>>>
>>>> Also, why does it define gen3-eq-presets, gen4-eq-presets,
>>>> gen5-eq-presets, and gen6-eq-presets?  I think there's only a single
>>>> place to write these values (the Lane Equalization Control registers,
>>>> PCIe r6.0, sec 7.7.3.4), isn't here?  How would software choose the
>>>> correct values to use?
>> ...
> 
> Oh, one more thing: I guess "gen3", "gen4", etc. are well-entrenched
> terms in the industry, and they're probably fine in marketing
> materials.
> 
> But I really don't like them in device trees or drivers because the
> spec doesn't use those terms.  In fact, the spec specifically advises
> *avoiding* them (PCIe r6.0, sec 1.2 footnote):
> 
>    Terms like “PCIe Gen3” are ambiguous and should be avoided. For
>    example, “gen3” could mean (1) compliant with Base 3.0, (2)
>    compliant with Base 3.1 (last revision of 3.x), (3) compliant with
>    Base 3.0 and supporting 8.0 GT/s, (4) compliant with Base 3.0 or
>    later and supporting 8.0 GT/s, ....
> 
> As a practical matter, those terms make it hard to use the spec: where
> do I go to learn how to use "gen4-eq-presets"?  There's no instance of
> "gen4" in the PCIe spec.  AFAICT, all I can do is look up the PCIe
> r4.0 spec and try to figure out what was added in that revision, which
> is a real hassle.
> 
is it fine if I change names from gen3-eq-presets, gen4-eq-presets etc
to 8gts-eq-presets, 16gts-eq-presets  etc.

If above names are fine I will update the patch.

- Krishna Chaitanya.
> Bjorn

