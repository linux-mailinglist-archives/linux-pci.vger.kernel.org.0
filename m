Return-Path: <linux-pci+bounces-25264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91414A7B09C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 23:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93097175178
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF477205E35;
	Thu,  3 Apr 2025 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gggvwUVG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564951F4626
	for <linux-pci@vger.kernel.org>; Thu,  3 Apr 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743713557; cv=none; b=TqEt4Wk4yqNpzE9wKWMAYeW60W0dYuV1KNlGWuuKB0RkBVl5AySfWEgVpY3d/TnDIygfdFln8/9FLBi2tc9HtzeibLwpifAi9IMNAgpYfwyswyjKtM7JiXD4yxNMT5114YpDNPYULP+AfHRlYMSvevJN9G5xqCWkqWLTnn8Bo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743713557; c=relaxed/simple;
	bh=tUE21kp5Y2Ha6PPB2grCo0cVpZSG6e2ekaq4gDZt+HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laqlKqdeZRSbznYGDflFS+ctaCbEkjw7ArF+Aq3jQAhpNbZ2qLOIBb1duIz6XEveP8tOKUbx5icx1dAeTwoJY5Ok8cLwDw96E92zo9tl9O1QINu222sEq9rZfzzRfq0+lmuG5j+eVzFQ3q9caaIaEOjpi2gvnkAde5HEglTh7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gggvwUVG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533JhlBF019460
	for <linux-pci@vger.kernel.org>; Thu, 3 Apr 2025 20:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+of49W00ZvZSV6VdrBbed6Uq20VFhTrt4WWUZuWJagI=; b=gggvwUVGrfFp+OAJ
	9TlQVozwtUF30ZSnxqe7wG7NU1Yj2qoxmtKxVyk21RpgBtLhN2LZnr6dB+ft6Y4e
	aDnq/uGUYzwHG6gWtaAAMLm2RB0A4pIyqMceXmOkURRlHSzYVozBPfEbfTuT6+8+
	bwpF+B1B6Jbf1Nl/0FWWshW+ZnoEZpzafvfUC/f1rxD4vxCibI26SqGb8FxIPlYM
	t4Gh409WmUVIllVPdnOsODL45Yj1HfGi1OrZuc2s9aJgHoAarIIkQ2nZVgZCTkH+
	P6QrVKqBS/UftkBq1sVyjbLOjmBnbA3PiQ0BxZw3Q8DxBdKbbmdJWALHJb+Db2o4
	wGuyDQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45sc2yu8kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2025 20:52:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5ad42d6bcso33124285a.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2025 13:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743713553; x=1744318353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+of49W00ZvZSV6VdrBbed6Uq20VFhTrt4WWUZuWJagI=;
        b=ClWrhiwBUKreZVBwJzQWVzVIzhfRH0yOf6nurC2/HHnKrdeNrGWkgZxzu81F8/+VWz
         3rTbwv0ev72N6z/jQKpeHhuAvvIHvizmXPRkDehd0TjZca6FX4BwP9a98NbM4Xfr91l4
         tDovfqFQiWnwG4mztQ4pr21DJ35CTQbwv1oGvmKnUle6Uf1S+73FgIx97sX+G8MMME6N
         yZODotmqWJXVvvomN52D4ECAzbURJeFkD0DAorKxUUPa2rm+i4Q2dYa8lrfxeLTzlhXQ
         ZU87Bk8hp+hjJslJZGHPWoJivDr2Vfi24EqiA/vrITQjkTzPZjWu0IW6xpawm69drPlP
         vuiw==
X-Forwarded-Encrypted: i=1; AJvYcCXh7v3PPESp1FRQFkYI2azFqXCzLejkv/iJwPXLNKNW1H/+B5bEdIVwZp8lnZTIX1Zz1YcO+fI5vUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeg9f8WnuzMBnYsBLMK4mNieHUEuAWkZuOYdmacwJQQHa/FD7
	S+JdSGfFMfizyLsdOp2POm6ZFECGVVGfaoO8P1AW2uwmBwhcbWppdhRS2vZHy5VL2LfFJqqFDV2
	eKW+xJI5vxMA8Ftw4pUVao3XtM1WOUYH8PTHOrxvLI/nSMiUdDDcfWjOMSb4=
X-Gm-Gg: ASbGnctZTaidzPqOfyhOeKlYk6eRf9nqyJ2xozGvAx2hEN+y1Uwxk8rWtKhaR9J3SEU
	oRtRddqg9LsU5ddZI1X1ksxJsOIvzJ7yzyek21qO/op3RZK29cLUV4vB3Jb4uScn3hA3dQ0EqSf
	Cex7plZuuDH3gL7rLuaV4MC/FV4Du/9s5MFa4cngTSSkVOnl1VANZAZxQ16S9TQ89k7ZPeTf2p5
	1fxR1kN2MCqhVF2OSyBKZ2MZJisGh09DgJ6xPCCNbnUoJ5gupEHSOIdqKEnWH3G84OmnToQCjJp
	3r6q1z5VxsJESANNDGGI6edSXVLf39PDCPpT5IOwBkAM+PP7sXyqhbIePhGdAKKTD79JZw==
X-Received: by 2002:a05:620a:d86:b0:7c3:d752:f256 with SMTP id af79cd13be357-7c774d52b1fmr37586185a.7.1743713552880;
        Thu, 03 Apr 2025 13:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW9VVgHZdVpymWLYQ76D50xpMzwHkQtShiUWmBOzkY0o7BLLMB1tDc8bRnl4Fm8Wny63ZmKw==
X-Received: by 2002:a05:620a:d86:b0:7c3:d752:f256 with SMTP id af79cd13be357-7c774d52b1fmr37584485a.7.1743713552456;
        Thu, 03 Apr 2025 13:52:32 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c018aeadsm144626866b.153.2025.04.03.13.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 13:52:31 -0700 (PDT)
Message-ID: <c1f145b7-501d-4d73-a5bc-a1844e17a289@oss.qualcomm.com>
Date: Thu, 3 Apr 2025 22:52:28 +0200
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
 <ed8a59ce-0527-4514-91f8-c27972d799d4@oss.qualcomm.com>
 <utswwqjgfy3iybt54ilyqnfss77vzit7kegctjp3tef636hc3p@724xe3dzlpip>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <utswwqjgfy3iybt54ilyqnfss77vzit7kegctjp3tef636hc3p@724xe3dzlpip>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AMoviu7M c=1 sm=1 tr=0 ts=67eef511 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=8zO8dPC1Pt-TAjq7ZcgA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 1hVqXSRQyY43wjMFHE0xud9NkqvLxbEc
X-Proofpoint-ORIG-GUID: 1hVqXSRQyY43wjMFHE0xud9NkqvLxbEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030110

On 4/2/25 8:02 AM, Manivannan Sadhasivam wrote:
> On Sat, Mar 29, 2025 at 12:42:02PM +0100, Konrad Dybcio wrote:
>> On 3/29/25 10:39 AM, Manivannan Sadhasivam wrote:
>>> On Sat, Mar 29, 2025 at 09:59:46AM +0100, Konrad Dybcio wrote:
>>>> On 3/29/25 7:30 AM, Manivannan Sadhasivam wrote:
>>>>> On Fri, Mar 28, 2025 at 10:53:19PM +0100, Konrad Dybcio wrote:
>>>>>> On 3/28/25 7:45 AM, Manivannan Sadhasivam wrote:
>>>>>>> On Fri, Mar 28, 2025 at 11:04:11AM +0530, Krishna Chaitanya Chundru wrote:

[...]

>> Ohh, I didn't think about that - and I can only think about solutions that are
>> rather janky.. with perhaps the least janky one being changing the else case I
>> proposed above into:
>>
>> else if (speed >= PCIE_SPEED_32_0GT && eq_presets_Ngts[speed - PCIE_SPEED_16_0GT][0] != PCI_EQ_RESV) {
> 
> s/PCIE_SPEED_16_0GT/PCIE_SPEED_32_0GT
> 
>> 	...
> 
> So this I read as: Oh, your controller supports 32 GT/s and you firmware also
> wanted to apply the custom preset offsets, but sorry we didn't do it because we
> don't know if it would work or not. So please let us know so that we can work
> with you test it and then finally we can apply the presets.

Good, because that was exactly what I had in mind :)

>>>>> I'm not forseeing any issue in this part of the code to support higher GEN
>>>>> speeds though.
>>>>
>>>> I would hope so as well, but both not programming and misprogramming are
>>>> equally hard to detect
>>>>
>>>
>>> I don't disagree. I wanted to have it since there is no sensible way of warning
>>> users that this part of the code needs to be updated in the future.
>>
>> I understand, however I'm worried that the programming sequence or register
>> may change for higher speeds in a way that would be incompatible with what
>> we assume here
>>
> 
> Honestly, I don't know why you are having this opinion. This piece of code is
> not in Qcom driver and the registers are the same for 8 GT/s, 16 GT/s as per the
> PCIe spec. So the hardware programming sequence and other arguments doesn't
> apply here (atleast to me).

I'm not familiar with the spec, but if you think it's a good idea to extend
the sequence for 32+ GT/s, I won't object anymore

Konrad

