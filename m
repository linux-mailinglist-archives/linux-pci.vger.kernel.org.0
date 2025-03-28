Return-Path: <linux-pci+bounces-24968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B79CA75194
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 21:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF753AF892
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A41E2616;
	Fri, 28 Mar 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+ceMpwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37A1E1E13
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194668; cv=none; b=IES/PEUnMLe65Uq7fw/8kvl6CTB/sVYMS+TyGBikAC/fVmZSHKYN/AnsM8lPtRhvjfF+U/pnfJzTxhl6lE+qK7MIoka4DeYFjBYlXFSlRmN9eOrtU55XsdjIwnzp/G7LoTMYUX2g/97kqSmO+vnQztxWclZtP/zkS0AQn2I0DfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194668; c=relaxed/simple;
	bh=6xG34knEseWKNz9saWS4s1ZPtAPMmFZrPoV7j2MQ3Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFHCL82alWXUbF+n63eT0nL4mpxSbfO0vDqmIvv8iUQAM/f3Ay9yWnM0XShTbFE+4wmbsZg5LquGLwpVpNZRL288JPAczrkc+OLuM8/bo15X4OGYjQJU7TAEUf1ik1dQm29uT3n/IMMFX+ol/Qva+9rBGFo8ihuTYHsYTCZZocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+ceMpwO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SDAOH7025664
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 20:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8yHDGP7/eVuTZLkMLBqQuH/oJ0/g2CL9JnCxVOVSt5s=; b=X+ceMpwOyuhWWY74
	qkpg++ZtPXA/Vq+8Jn1X1Xq4aYQooljKEkDYjfCpsXWUP+4rvSxx525ZZY1HJUrK
	kBg58IaC/jQpC0LX/e97zPtHzDAur7rQT/nhxY+C1B2sWKHcW1deQqG5OKjhPjV9
	P6BLCBNQcqyJlkrtv9fC/+8cOFQYV7x/LP4norMvMKDSQvdhHYmCf/9rPAAHcgwn
	l2FbmqN37vYwC2S5XzvlUA4FTfwlffmyYI3EMHfbOr0J75Xn+ORldfVjRMXy939X
	Al2j9q0SFIDI6Y/oq8IvJb/+CphgCEUL9SzsLYN0SwyQNJd9BP4QBnYUDmknPd9b
	ACl/Kg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45n0nux1wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 20:44:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8fd4ef023so5389206d6.2
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 13:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743194664; x=1743799464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yHDGP7/eVuTZLkMLBqQuH/oJ0/g2CL9JnCxVOVSt5s=;
        b=WKPvR5d8ZQREntZB56dfpCCOYDXmAa03KwUpLahHY72HTK+ZDevv1mPpMigtB4h3bE
         linrvw/+qrH/t58wYiv5fcmh6VuTX/8+5yzh2iM/i65Tn/6Ppkvmd8+33uCksEEtQ0zL
         w9Jj9f7vaSHm53MO5AFbYBmy7Ub46gQerHvcquL/IbwnTS4NTL/DAVRdj897d3lgu2KQ
         P/K9DW1vm6nak3kDQpan2qdkv3P6OSxPA4IRl9Wox75N+c//V5txQnRS+h/txpR+DVLW
         r4Ebs0wseoIPCKgVrMyqAn1PFYJ/boAGBsrYJ81/EXYZjt0z9yu3gpo+JIf8ZPrnQ6Tg
         8bCg==
X-Forwarded-Encrypted: i=1; AJvYcCXD6VKjHwSxLErlkMIwWTrej5SQ+9qT1JgewWTD+Ic0p9lAyi8CutO2OQRPLW9XOEXMono870icmfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+A+ZO6kOsyLWvc8kjj+3blF4lPDtDd2BMgcNlj4YnDF/Q4Ptj
	fokNtL6zB4qjf7vO7iBaOa7RUnr8rSDrzSeoXimU126KFw1bf1c1D/O92JeOQeP3IYZxJI4fzHB
	FqFl+sPE17mMKWL2oyxYfkQcM0HK2YosIhKg1ey8SuMdKgLoV1wyCwJvs/xA=
X-Gm-Gg: ASbGncuHJI0HFdN3sZprHHBSaVuQ/z7e2viuhCUbJUHV/z8PHw7rlSfywspkYDMnhiP
	aDJWFi26Ttrd8JbyPmbMVr8atmOd+NJbqvsnXdOlMhKFKCAcAm+U9Jpzhmfj0zPmPcisEXdUh1e
	POZqzBwROWzJCBoTURgTmDjjLmDhqWJOVIHdAYDGr0huFwtSEV5seYX1xbJMZRy4JhpDYTkmsqj
	Ii1xkTtRm6BSzp2z4P8Orjr/0gFWn/SttuYDvnJrCvn752J47pQnbLKtwmqDQF0ZjrrO8f5bHdO
	FOrosAVmRJgvDwSso6hW84ZxfKdZl+/I8kzUqKuYGPXIqCjl+7JZkwryk5J8HaNGPPFXQA==
X-Received: by 2002:a05:620a:44d0:b0:7c5:ba85:c66 with SMTP id af79cd13be357-7c6862ec401mr31641585a.2.1743194664463;
        Fri, 28 Mar 2025 13:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqujRiP7i0Omvp7do4h3yW4uLO0tTNKX1Nh389QWiCirHaopwa9oCC/P/3oCQfSQ9kZRLu7w==
X-Received: by 2002:a05:620a:44d0:b0:7c5:ba85:c66 with SMTP id af79cd13be357-7c6862ec401mr31637785a.2.1743194663895;
        Fri, 28 Mar 2025 13:44:23 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f9fbsm209770266b.111.2025.03.28.13.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 13:44:23 -0700 (PDT)
Message-ID: <71a60727-0dc8-4117-82a5-f9ecae1ce967@oss.qualcomm.com>
Date: Fri, 28 Mar 2025 21:44:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
 <20250309-ecam_v4-v5-1-8eff4b59790d@oss.qualcomm.com>
 <3332fe69-dddb-439d-884f-2b97845c14e1@oss.qualcomm.com>
 <0cc247a4-d857-4fb1-8f87-0d52d641eced@oss.qualcomm.com>
 <h6bnt7ti3yy3welkzqwia7kieunspfqtxf6k46t4j4d5tathls@hra2gbpzazep>
 <090572fa-7c4c-798d-26e9-39570215b2b7@oss.qualcomm.com>
 <f44tte5b3hlm7ir6lyp65fnl6ylq4og5wrvllwr47xdvnhqscg@t3tsy3c6jypw>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f44tte5b3hlm7ir6lyp65fnl6ylq4og5wrvllwr47xdvnhqscg@t3tsy3c6jypw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T7dZ6cUFg6PwA64uDD37QVHTSfJGw6dn
X-Authority-Analysis: v=2.4 cv=AcaxH2XG c=1 sm=1 tr=0 ts=67e70a29 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=j8DWiabEr3BJiYCl9dcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: T7dZ6cUFg6PwA64uDD37QVHTSfJGw6dn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_10,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280138

On 3/28/25 4:29 PM, Manivannan Sadhasivam wrote:
> On Fri, Mar 28, 2025 at 06:24:23PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 3/28/2025 5:14 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Mar 26, 2025 at 06:56:02PM +0100, Konrad Dybcio wrote:
>>>> On 3/11/25 12:13 PM, Konrad Dybcio wrote:
>>>>> On 3/9/25 6:45 AM, Krishna Chaitanya Chundru wrote:
>>>>>> PCIe ECAM(Enhanced Configuration Access Mechanism) feature requires
>>>>>> maximum of 256MB configuration space.
>>>>>>
>>>>>> To enable this feature increase configuration space size to 256MB. If
>>>>>> the config space is increased, the BAR space needs to be truncated as
>>>>>> it resides in the same location. To avoid the bar space truncation move
>>>>>> config space, DBI, ELBI, iATU to upper PCIe region and use lower PCIe
>>>>>> iregion entirely for BAR region.
>>>>>>
>>>>>> This depends on the commit: '10ba0854c5e6 ("PCI: qcom: Disable mirroring
>>>>>> of DBI and iATU register space in BAR region")'
>>>>>>
>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>>> ---
>>>>>
>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> I took a second look - why are dbi and config regions overlapping?
>>>>
>>>
>>> Not just DBI, ELBI too.
>>>
>>>> I would imagine the latter to be at a certain offset
>>>>
>>>
>>> The problem is that for ECAM, we need config space region to be big enough to
>>> cover all 256 buses. For that reason Krishna overlapped the config region and
>>> DBI/ELBI. Initially I also questioned this and somehow convinced that there is
>>> no other way (no other memory). But looking at the internal documentation now,
>>> I realized that atleast 512MiB of PCIe space is available for each controller
>>> instance.
>>>
>> DBI is the config space of the root port0,  ecam expects all the config
>> space is continuous i.e 256MB and this 256MB config space is ioremaped
>> in ecam driver[1]. This 256 MB should contain the dbi memory too and
>> elbi always with dbi region we can't move it other locations. We are
>> keeping overlap region because once ecam driver io remaped all 256MB
>> including dbi and elbi memory dwc memory can't ioremap the dbi and elbi
>> region again. That is the reason for having this overlap region.
>>> So I just quickly tried this series on SA8775p and by moving the config space
>>> after the iATU region, I was able to have ECAM working without overlapping
>>> addresses in DT. Here is the change I did:
>>>
>> I am sure ecam is not enabled with this below change
> 
> ECAM is indeed enabled. But...
> 
>> because ecam block
>> have the address alignment requirement that address should be aligned to
>> the base address of the range is aligned to a 2(n+20)-byte memory address
>> boundary from pcie spec 6.0.1, sec 7.2.2 (PCI Express Enhanced
>> Configuration Access Mechanism (ECAM)), with out that address alignment
>> ecam will not work since ecam driver gets bus number function number
>> by shifting the address internally.
>>
> 
> You are right, but the ECAM driver doesn't have a check for the config space
> address alignment, so it didn't catch it (I will add the check now). But with
> the unaligned address, endpoint is not getting enumerated (though bridge is
> enumerated as it lives under root port, so I got misleaded).
> 
>> If this is not acceptable we have mimic the ecam driver in dwc driver
>> which is also not recommended.
>>
> 
> You can still move the config space in the upper region to satisfy alignment.
> Like,
> 
> +                     <0x4 0x00000000 0x0 0xf20>,
> +                     <0x4 0x00000f20 0x0 0xa8>,
> +                     <0x4 0x10000000 0x0 0x4000>,
> +                     <0x4 0x20000000 0x0 0x10000000>,
> 
> With this change, ECAM works fine and I can enumerate endpoint on the host. I
> believe this requires more PCIe space on the SoC. Not sure if SC7280 could
> support it or not. But IMO, we should enable ECAM for SoCs that satisfy this
> requirement. This will avoid overlapping and also simplify the code (w.r.t
> DBI/ELBI).

FWIW it seems like most recent SoCs have a <32b space, a _LOWER space which ACPI
describes as QWordMemory, and another _UPPER space that is way way above them.

Not sure about the prefetchability and other nuances of the last region though.

Konrad

