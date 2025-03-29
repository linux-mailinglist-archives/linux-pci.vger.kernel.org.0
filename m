Return-Path: <linux-pci+bounces-24973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB380A75548
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 10:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF619188DABC
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6411ACECB;
	Sat, 29 Mar 2025 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LmqL8gTd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F31AAE01
	for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743238801; cv=none; b=P8iFr1wbxtenyNPEni290NLZsryeHdpirZrt5M7oI1U5UrJUQRWU3jeOrBSb3L1B6hg9bJ8dITGrhDL1OEOfDAHwt9gyuMQJWnK9m/LGrL1W/BBI9WzVJjOmHeXY5SrKO4Qf5BOBCvgZjDx7RDDBJ9HKW/WRuuQgTHHqNZLzkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743238801; c=relaxed/simple;
	bh=P43UgQWtBugO4yRa9AP1UE8y4mvRbi7MD/UbP3JyaSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTVQSqxU7F/waaJxT3PV8yFx2qE3SP1HV6Ebk0N0hOhDlgP6lWiCihEvNs28zH5mb3DwVsv6nptQj117sMsr/Uq3Wr3V/rJeeQfw02AxPt/+cr7f9GTCUtv308Ip9Lxu9wZ9ioG2aI6oFx2Oty8fVsyfP/VqiZ+as8MeDxwVF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LmqL8gTd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T7iwfZ018943
	for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 08:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	37x3gXvWIZO0z5ax79P5XurFvsK6woppiUhnedErM2g=; b=LmqL8gTdUd0Bu9AF
	6QOw6p6dL3yY60z8waGf1yxCMThOsM//qAHS7dflxVgP/iZx8K0HP0ELZeCTYgra
	nzWLz/fnWwWvkZYzIM15G6bYEcakTvcKD4nBcO/q4xsA9qSXKkF23KPDe1DrnyRC
	99k4rQp/67FznM1tjNvyvobVhJbwyzHjM2ZcuMFRp0HkOOg4tbvUl5o7/Q6Mai38
	BNzQKotGelBXu9yYFwEV6JGHHaakUrXlRy7ABB4BXYpWXwKGoDXW/cn7NoVX7kl/
	du1HRgny/FLtKrajUvNLP5slu0z4LYQ5Ey/zHAQ8Y4dXj+mOSQJuTwTiNGRJVnX9
	L0raMw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7v88g7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 08:59:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ece59c3108so5854446d6.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 01:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743238792; x=1743843592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37x3gXvWIZO0z5ax79P5XurFvsK6woppiUhnedErM2g=;
        b=V9PWEeS6b/OVEXl42Z5gZZqKWXu5HiZTPn2TafqatEetC5wf+Ze3HqwujmbyUj8jgt
         cd8pozBt/QuEvFp0vrfbb++104FLywNt1yQyy95ISCaRkZ7fGHweOKxSHCAiXGZYuqge
         mzhDII1QRmPiCF9YisrxuPsqFlNzGjH6lrMbQeCjnpObZse+OfkW2sr6DT7H1NvaAoI9
         IWDS8RlrtwT8Nq5eXQLz3PjQ9FKipW8bXehDNd0uQQ/qGbBukvS3TlESTYPBOwZ0R0GB
         rfq0bJqNotJA4liSaRPc1EALL9vI/p6P1o8HBENSjIcHq/ayGCThnawvxzgHavUOgJ8Z
         lqAg==
X-Forwarded-Encrypted: i=1; AJvYcCUGZ/PwoIq7ontE7rkQcCpHq0paupYF9ge/QVGb1AxOaHB+mRIRQScaxrI/i5FnR+KnwlvguxXuWbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bYzVyh0FL9v7kPUcGOszISbnwxx84JdQsI51neeGz1PyfP5E
	pIww7gqi/qFMzzjMn7qNglg6RgtkcYC70cgT7g3K9c4inmC2ByQJ4PqVaDrqgEpyyP8qiX+G/es
	rskFPc8ESvnNfpVA740qE5JmigjCHi2CYbr0E5wrK/PJ4zMG6lfXEo7tSwtE=
X-Gm-Gg: ASbGncvZAgKqFUpY/61Z/3HDfvwBM6vI2fHpvIBYpdtWaoRnT8weZYO7v8eSFFedKlK
	Bc7kqnPXwkoBWxg/a+UJpBLluKciZnfTr1NXnYFjE0V+jEf75OlK5hKOX38C9A5W2Wbc/5LuVUa
	AWyH6Pr4odYX3Nl4yIQGAPCZ+MJIy+EKADh1xN+mSbmNrBFunz72m5FPyfnL4Kri+LTlvSShT+p
	tsGd9wnvHTW9/HoUa4nw6bWxPl+4XS4j81p9+pNgSw2Dp+WX8ZCrGE2D4DDcl0ko/W/13BrSPSb
	EiXikUkU2kBgAugpLqTT5UfrFzuSIOZ1g0vjAd9FYhZLDYuI1Zt/8/cCUUUqYvHHf2mY2A==
X-Received: by 2002:a05:620a:1792:b0:7c0:bc63:7b73 with SMTP id af79cd13be357-7c6908ca335mr102809885a.13.1743238791846;
        Sat, 29 Mar 2025 01:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWgQ8bGtNGe0Vk1ZyjZA5f1jd7EgL+yhTvduuo9qldDJH4f2p/S8qqOhgDV+CWnBCyVhZeiQ==
X-Received: by 2002:a05:620a:1792:b0:7c0:bc63:7b73 with SMTP id af79cd13be357-7c6908ca335mr102808485a.13.1743238791339;
        Sat, 29 Mar 2025 01:59:51 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac725c71e95sm219562766b.76.2025.03.29.01.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 01:59:50 -0700 (PDT)
Message-ID: <622788fa-a067-49ac-b5b1-e4ec339e026f@oss.qualcomm.com>
Date: Sat, 29 Mar 2025 09:59:46 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <abgqh3suczj2fckmt4m2bkqazfgwsfj43762ddzrpznr4xvftg@n5dkemffktyv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Gbkrua0YfIH8oQ6zN4TsvhuHyjQ2ETjO
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=67e7b688 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=124JrzZUfrG38n11_fAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: Gbkrua0YfIH8oQ6zN4TsvhuHyjQ2ETjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503290062

On 3/29/25 7:30 AM, Manivannan Sadhasivam wrote:
> On Fri, Mar 28, 2025 at 10:53:19PM +0100, Konrad Dybcio wrote:
>> On 3/28/25 7:45 AM, Manivannan Sadhasivam wrote:
>>> On Fri, Mar 28, 2025 at 11:04:11AM +0530, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 3/28/2025 10:23 AM, Manivannan Sadhasivam wrote:
>>>>> On Sun, Mar 16, 2025 at 09:39:04AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> PCIe equalization presets are predefined settings used to optimize
>>>>>> signal integrity by compensating for signal loss and distortion in
>>>>>> high-speed data transmission.
>>>>>>
>>>>>> Based upon the number of lanes and the data rate supported, write
>>>>>> the preset data read from the device tree in to the lane equalization
>>>>>> control registers.
>>>>>>
>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>> ---
>>>>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 60 +++++++++++++++++++++++
>>>>>>   drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
>>>>>>   include/uapi/linux/pci_regs.h                     |  3 ++
>>>>>>   3 files changed, 66 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>> index dd56cc02f4ef..7c6e6a74383b 100644
>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>> @@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>>>>   	if (pci->num_lanes < 1)
>>>>>>   		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
>>>>>> +	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
>>>>>> +	if (ret)
>>>>>> +		goto err_free_msi;
>>>>>> +
>>>>>>   	/*
>>>>>>   	 * Allocate the resource for MSG TLP before programming the iATU
>>>>>>   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
>>>>>> @@ -808,6 +812,61 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>>>>>>   	return 0;
>>>>>>   }
>>>>>> +static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
>>>>>> +{
>>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>> +	u8 lane_eq_offset, lane_reg_size, cap_id;
>>>>>> +	u8 *presets;
>>>>>> +	u32 cap;
>>>>>> +	int i;
>>>>>> +
>>>>>> +	if (speed == PCIE_SPEED_8_0GT) {
>>>>>> +		presets = (u8 *)pp->presets.eq_presets_8gts;
>>>>>> +		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
>>>>>> +		cap_id = PCI_EXT_CAP_ID_SECPCI;
>>>>>> +		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
>>>>>> +		lane_reg_size = 0x2;
>>>>>> +	} else if (speed == PCIE_SPEED_16_0GT) {
>>>>>> +		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
>>>>>> +		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
>>>>>> +		cap_id = PCI_EXT_CAP_ID_PL_16GT;
>>>>>> +		lane_reg_size = 0x1;
>>>>>> +	} else {
>>>>>
>>>>> Can you add conditions for other data rates also? Like 32, 64 GT/s. If
>>>>> controller supports them and if the presets property is defined in DT, then you
>>>>> should apply the preset values.
>>>>>
>>>>> If the presets property is not present in DT, then below 'PCI_EQ_RESV' will
>>>>> safely return.
>>>>>
>>>> I am fine to add it, but there is no GEN5 or GEN6 controller support
>>>> added in dwc, isn't it best to add when that support is added and
>>>> tested.
>>>>
>>>
>>> What is the guarantee that this part of the code will be updated once the
>>> capable controllers start showing up? I don't think there will be any issue in
>>> writing to these registers.
>>
>> Let's not make assumptions about the spec of a cross-vendor mass-deployed IP
>>
> 
> I have seen the worse... The problem is, if those controllers start to show up
> and define preset properties in DT, there will be no errors whatsoever to
> indicate that the preset values were not applied, resulting in hard to debug
> errors.

else {
	dev_warn(pci->dev, "Missing equalization presets programming sequence\n");
}

> 
> I'm not forseeing any issue in this part of the code to support higher GEN
> speeds though.

I would hope so as well, but both not programming and misprogramming are
equally hard to detect

Konrad

