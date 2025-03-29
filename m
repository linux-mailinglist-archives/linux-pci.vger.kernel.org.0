Return-Path: <linux-pci+bounces-24975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF26A75607
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 12:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEC11892AF0
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953391B4243;
	Sat, 29 Mar 2025 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C/vbrsxU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903E1AF0CA
	for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743248537; cv=none; b=H/vm4GZr2BYxrACi4Ah7meZfqB2PYOcWnoo567X2DCAdGqN29MUmVjoYAkI3iyw3JwzmNsKxrBCGx18WpxYddJvWBofRr+clP+NI/38hfx1inkp1WhqgyvcwcXTGdcXoh26tMf50qQN7FbVjbqi5i47sRkYI2GmZ0QzADEFpDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743248537; c=relaxed/simple;
	bh=/3fUFv9I1+6hyqB935Ue7MnXiU0wbFfGhPTCP5NZvdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi6Le4SSvbYakSSaPxn7WCgPMkqYivos12nKQN5IzMleXL49rwzrncPYrYCxowd0xxOO565nf+6ZeLu3SLaebk2ZMl/BCK54uhEAg2fr7seL3k0WHT54RYAEMhIeQCKLu/KMKgrqv2Uxgz+4Uom/hou01xwjInhW9ftBj35OBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C/vbrsxU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T7immf030579
	for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 11:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mmm54hP5tMFj63YRNzC7S/gSA1WThy35TAoW/ZFfd30=; b=C/vbrsxU9RKNWNvY
	PAo6sqUhnvDrdDvQG1F+uEFcNNfr6OV/1cVvP1w2MtpZqljllvTTmcyFecwB1u+s
	tycfWw3fAKs9/CDFnQPri7xaXY7OPt76tszYznMnKIvS8g47H96JcK6FWycwcov9
	PKPsprgkMpeFV1xNy60ccevdFFwMdq+f5iqQ3ctCSG5njnFtZwtwR6gm46LU+vjj
	vD0ccxta+SjlDqnuj6GX5boEZMc7TICVXbb15pj1sKF/6gmuOhiiyoeBBazATet9
	bsUMJ96d9cgkja+vD9L1Rc7gjeZlQ8M4+LmCIxomidYWpnObsHG+0jj0ez0sF6cb
	3n4Tdw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p6jhgtvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 11:42:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8ff8c9dcfso4834806d6.3
        for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 04:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743248526; x=1743853326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmm54hP5tMFj63YRNzC7S/gSA1WThy35TAoW/ZFfd30=;
        b=wWhXDasHKpICe3tYvtlzrGyK95/qc9br5oD6hQ695cu+Wz1p72IbvbStm9lcd0CFwR
         fBn83zkJKrzNde6jChywxUlun3+hc9UYRcrrHGCanwZIYjPZhMrUUhBIfixnY33ymq+Q
         FSGgO+cQkBM7Y8ruVEyYoOeYRkToBct2yfbHD+TepyAqPZFX2svyCna4b/mHszX+l1v7
         BYVg9nQ5dSvOBGb5j723cFhMFOk9DA6bkJd0rqDGXOhl2ApNu9iMBmlBdJm7sHF/aRPf
         fRDq55DuyzX/+DXvUrcKsLiDqAkwD5tZEPDEi+6gL4Yto82weVJxnbWkKpeV+ApfFNKh
         1SNA==
X-Forwarded-Encrypted: i=1; AJvYcCVBjxcqjD/ruFx/QYFAqeshsMHvTuooUqDXcYc/6MU+2nA/ZcStV/AssBK2BCPz3eDd2eAQozGtnbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6vqxPDfV0xQko2D2+7mw/P/dDQVqTWSkPL0/5L8mID9jl96G
	q1ntNzELFZuvJiCSFpL1wVCnHuKGaZ1E2mC7ep7EPXquglr+X8pGfEP3iIEUoXYrQ4OO3+Wiwnm
	0xda2ZrYUUPJA2ZTecbi9Cd4A3hs+3WEfsCddaytEXHBDTBMndpRGkkEq0xs=
X-Gm-Gg: ASbGncuEb4F5U90veTIhC8iWeeoo3xJI78JkpDG2wgattYHvuUXRhVTFq1hNcUXhLKR
	WMTRLA2JijmS5G0q+dS0uLHxmuazMX9GRLeoQGmgLFda2ZPBcyfs4bFmIpwVtRkbLpAjK1Qheuu
	T7EUmOCdvD+cdQ5q6rsnHBnmNEzzGxfipqR0KUQ9+DLXs08iuaCrHxedjsTaAH5khyh5g9AX1tf
	rt0nanz29hVzpMItFDbz+i4SzMsAI+pTnmPiSpyw1yaFpjiyUZ5p1Pk13rJvFM9Ig6oPhcevCrD
	ueq6iHAZ67VUzJnmDF/ujshrtlcub4hlM12G73wUKLkFJuuLZJ2sw7srnBPqz5vfqkGVNA==
X-Received: by 2002:a05:6214:19e3:b0:6e8:98ce:dd75 with SMTP id 6a1803df08f44-6eed6240a60mr13440576d6.9.1743248526288;
        Sat, 29 Mar 2025 04:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyNtCjF7eZFHg5e8sgPfDmRiZq6NbJYI+bCAjDsmzT1x0V+Z5zGALW3AuIi5S1IGq561tZRQ==
X-Received: by 2002:a05:6214:19e3:b0:6e8:98ce:dd75 with SMTP id 6a1803df08f44-6eed6240a60mr13440496d6.9.1743248525880;
        Sat, 29 Mar 2025 04:42:05 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f3c7sm320820566b.94.2025.03.29.04.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 04:42:05 -0700 (PDT)
Message-ID: <ed8a59ce-0527-4514-91f8-c27972d799d4@oss.qualcomm.com>
Date: Sat, 29 Mar 2025 12:42:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
 <20250316-preset_v6-v8-4-0703a78cb355@oss.qualcomm.com>
 <3sbflmznjfqpcja52v6bso74vhouv7ncuikrba5zlb74tqqb5u@ovndmib3kgqf>
 <92c4854d-033e-c7b5-ca92-cf44a1a8c0cc@oss.qualcomm.com>
 <mslh75np4tytzzk3dvwj5a3ulqmwn73zkj5cq4qmld5adkkldj@ad3bt3drffbn>
 <5fece4ac-2899-4e7d-8205-3b1ebba4b56b@oss.qualcomm.com>
 <abgqh3suczj2fckmt4m2bkqazfgwsfj43762ddzrpznr4xvftg@n5dkemffktyv>
 <622788fa-a067-49ac-b5b1-e4ec339e026f@oss.qualcomm.com>
 <4rep2gvymazkk7pgve36cw7moppozaju7h6aqc3gflxrvkskig@62ykri6v4trs>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4rep2gvymazkk7pgve36cw7moppozaju7h6aqc3gflxrvkskig@62ykri6v4trs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nwStqE2qBQAmx9dmMaLy0Z2RywUMoWb-
X-Proofpoint-ORIG-GUID: nwStqE2qBQAmx9dmMaLy0Z2RywUMoWb-
X-Authority-Analysis: v=2.4 cv=bZZrUPPB c=1 sm=1 tr=0 ts=67e7dc8f cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=jKyjlexm6IKzr5l-IOMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503290083

On 3/29/25 10:39 AM, Manivannan Sadhasivam wrote:
> On Sat, Mar 29, 2025 at 09:59:46AM +0100, Konrad Dybcio wrote:
>> On 3/29/25 7:30 AM, Manivannan Sadhasivam wrote:
>>> On Fri, Mar 28, 2025 at 10:53:19PM +0100, Konrad Dybcio wrote:
>>>> On 3/28/25 7:45 AM, Manivannan Sadhasivam wrote:
>>>>> On Fri, Mar 28, 2025 at 11:04:11AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>>
>>>>>> On 3/28/2025 10:23 AM, Manivannan Sadhasivam wrote:
>>>>>>> On Sun, Mar 16, 2025 at 09:39:04AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>> PCIe equalization presets are predefined settings used to optimize
>>>>>>>> signal integrity by compensating for signal loss and distortion in
>>>>>>>> high-speed data transmission.
>>>>>>>>
>>>>>>>> Based upon the number of lanes and the data rate supported, write
>>>>>>>> the preset data read from the device tree in to the lane equalization
>>>>>>>> control registers.
>>>>>>>>
>>>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 60 +++++++++++++++++++++++
>>>>>>>>   drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
>>>>>>>>   include/uapi/linux/pci_regs.h                     |  3 ++
>>>>>>>>   3 files changed, 66 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>> index dd56cc02f4ef..7c6e6a74383b 100644
>>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>> @@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>>>>>>   	if (pci->num_lanes < 1)
>>>>>>>>   		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
>>>>>>>> +	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
>>>>>>>> +	if (ret)
>>>>>>>> +		goto err_free_msi;
>>>>>>>> +
>>>>>>>>   	/*
>>>>>>>>   	 * Allocate the resource for MSG TLP before programming the iATU
>>>>>>>>   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
>>>>>>>> @@ -808,6 +812,61 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>>>>>>>>   	return 0;
>>>>>>>>   }
>>>>>>>> +static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
>>>>>>>> +{
>>>>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>>>> +	u8 lane_eq_offset, lane_reg_size, cap_id;
>>>>>>>> +	u8 *presets;
>>>>>>>> +	u32 cap;
>>>>>>>> +	int i;
>>>>>>>> +
>>>>>>>> +	if (speed == PCIE_SPEED_8_0GT) {
>>>>>>>> +		presets = (u8 *)pp->presets.eq_presets_8gts;
>>>>>>>> +		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
>>>>>>>> +		cap_id = PCI_EXT_CAP_ID_SECPCI;
>>>>>>>> +		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
>>>>>>>> +		lane_reg_size = 0x2;
>>>>>>>> +	} else if (speed == PCIE_SPEED_16_0GT) {
>>>>>>>> +		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
>>>>>>>> +		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
>>>>>>>> +		cap_id = PCI_EXT_CAP_ID_PL_16GT;
>>>>>>>> +		lane_reg_size = 0x1;
>>>>>>>> +	} else {
>>>>>>>
>>>>>>> Can you add conditions for other data rates also? Like 32, 64 GT/s. If
>>>>>>> controller supports them and if the presets property is defined in DT, then you
>>>>>>> should apply the preset values.
>>>>>>>
>>>>>>> If the presets property is not present in DT, then below 'PCI_EQ_RESV' will
>>>>>>> safely return.
>>>>>>>
>>>>>> I am fine to add it, but there is no GEN5 or GEN6 controller support
>>>>>> added in dwc, isn't it best to add when that support is added and
>>>>>> tested.
>>>>>>
>>>>>
>>>>> What is the guarantee that this part of the code will be updated once the
>>>>> capable controllers start showing up? I don't think there will be any issue in
>>>>> writing to these registers.
>>>>
>>>> Let's not make assumptions about the spec of a cross-vendor mass-deployed IP
>>>>
>>>
>>> I have seen the worse... The problem is, if those controllers start to show up
>>> and define preset properties in DT, there will be no errors whatsoever to
>>> indicate that the preset values were not applied, resulting in hard to debug
>>> errors.
>>
>> else {
>> 	dev_warn(pci->dev, "Missing equalization presets programming sequence\n");
>> }
>>
> 
> Then we'd warn for controllers supporting GEN5 or more if they do not pass the
> presets property (which is optional).

Ohh, I didn't think about that - and I can only think about solutions that are
rather janky.. with perhaps the least janky one being changing the else case I
proposed above into:

else if (speed >= PCIE_SPEED_32_0GT && eq_presets_Ngts[speed - PCIE_SPEED_16_0GT][0] != PCI_EQ_RESV) {
	...
}> 
>>>
>>> I'm not forseeing any issue in this part of the code to support higher GEN
>>> speeds though.
>>
>> I would hope so as well, but both not programming and misprogramming are
>> equally hard to detect
>>
> 
> I don't disagree. I wanted to have it since there is no sensible way of warning
> users that this part of the code needs to be updated in the future.

I understand, however I'm worried that the programming sequence or register
may change for higher speeds in a way that would be incompatible with what
we assume here

Konrad

