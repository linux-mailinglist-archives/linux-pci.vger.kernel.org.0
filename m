Return-Path: <linux-pci+bounces-41205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57754C5B282
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 04:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC0D3AD9EE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCFE267B02;
	Fri, 14 Nov 2025 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipZxZjBl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RASdTFfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F9224AED
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091378; cv=none; b=UDrFQ4+gcFQKyXGmGuhNhjyise/RgSvrBBZFy2LwyVsCiT4UKqqaBe18pl0hjne/6wI+9bH7cPGKzfvYEcnwP5Dq2JHUFYO163KyRrDBfPnHKVdNT6jqfU1XsC9mi3Co7EkkYqdlVKcgs4/DFcNNdMRfKEqzvCYllYsy37bLVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091378; c=relaxed/simple;
	bh=IprDe4qrgEnbzgwl5fo+9gFxfBlcWMJLzda+fR8+/jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByE+bAxjArPv29l3AdFbHplLE0bFZVz1CyQljTwx/eUZ9UG3EQiKIWQpAFdG3adIMivo0srBXoHbM6Xm0KMIPoGqsSRTSK7+HwXIN65UDdt9HLFlrefZy5ouJFDQJlaHXSyG8rr3bYDZ+HkcOyS3DWttqJ0sSOKZEzlVMksyjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipZxZjBl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RASdTFfy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADManK71745336
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 03:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNxNrJsDy0YUjFlR7ksRiU45D5obzg7cc4C20QxDE/Y=; b=ipZxZjBlpn94HSAs
	7nAYreD7sc9lb1a5s64/C1gL+YDaZU1kYqnZ0JefMAeevn4XEfyGOEevoXn8PTzm
	l+Zi7KwMtSlJIa9ULgHzo4S50n1R7wd/VOudQn6+tSEA3J3NffTbyyUUopW5rmgF
	D26O2PkfGWzf/fDVxRRiAhq07Bj0t2+7pNRh/iptzndjLk5H0f2uRuDa8FOuRg9q
	0RejwoVvmXZKqZUxObHqDAAzxqjTVU5qJzOjI/zjDG/8I2FDv7rSEuXaheFl/Tjs
	cbth19/AW3mEA/L1L5MHrvgXFdQQ9w3k26+p/a7fAjVRHULX24MCVuEc79Zp03sM
	evxg+A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9egpt7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 03:36:11 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5597b3fbabfso3726564e0c.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 19:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763091371; x=1763696171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNxNrJsDy0YUjFlR7ksRiU45D5obzg7cc4C20QxDE/Y=;
        b=RASdTFfyvCJveIyTLAwlD3hPiTbXqSgPJpq5Wf2jFHZU9nk3o0wfwP0eThhS3hoXxN
         0C+qfvN9RPcOXUa39PCpcpoDtMDjw2PSW+dgxSAJhomwA57HJh84d3fRFvuWXDFwiiAb
         9c6yoGozGkXzIVzPbpK8/UfY42F6/Vbn/qnUf9CPlJqddVfgLdCcAk6+ZRkp2lefYxGD
         c56rKckDO/HyGRRUAwzRZtvB5IimVcN2VVXaGeje4lT9kOD42Kco8H+U+f+MBAudxabt
         VElYLJI9pbC6HaqYqGfC0ZecBaEsVWhrAVfpDXJPh0JAIGE/VzlC9kBGQNhFar/wtG3M
         TEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091371; x=1763696171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNxNrJsDy0YUjFlR7ksRiU45D5obzg7cc4C20QxDE/Y=;
        b=HeMyUDG7IH8t0nE+wvrZg4u7RBYWD5M8KssZoT7cM5VjPSx3W0rXGZvNCl8Liu8z/i
         EG54vQb+/yny5vEnoxaPfqdVhyrYzC+SGxC4SA+OjiI88aaWQQtbvU9gfluyjWi2hIeo
         1x+7VSrjIX7bgrOKxQzj0TesmUASCwZ07xrWKjL89VpaWNMBR+KjP3DTW95oHODOAdRq
         VdvSPAiWO6nvkyVAM7+1tKiQTyWvNejcvap779jAGv1DqItQRgkuzT2w6aFiYqRa2IBV
         CLtjTBCMeVf6hlNFO8D0wTPc7vqxshRDeJVYcpyEq1odd4AHzeiNxIF65eDJLcGEjhvA
         ShhA==
X-Forwarded-Encrypted: i=1; AJvYcCVl7g67NZUbPJiiY7OgJ0BjoVt5ZzXav8Ia1kbQejVwJgS4XYhdIAkGn4z19QSlLwjb5JjJFA3anjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLUKtA8exIiCH80W3iDxDM3dWmlP8xgTaTNTv2CQSiLbw5OyS
	zfuqEu2IhGsUlV6esu1CJ3E3L/Nu5SUae6AM5Icssd0Fau44s6e8JybmTcKKkRXr/+3e066LUOn
	+XJ5U0y7hsyxT/V+E/7kQtlfCeTzb8uYTePCCipwRuv0OgEYu0sqUDBUY9TrJoIE=
X-Gm-Gg: ASbGnculxWlUoYBIuonIsBbw94BrUCyFALZbkPBAcbQ5yVhPFsMiybI5Upg26oBgeX4
	VHBWYUqL0NtQP4ILidugLdVqdD6ZxciQhLVAvuZim99G39MQDhKKNDGPV1M+lXiT7ujPHkZSuIm
	BLMjKPsucwCjCuzX8rFr6VJZpZenM5F6nsINxSrpUCuXngLQe2DxiRRTHKhedeXUHyS7iigvsm8
	rZcDsr5t98Af9t/yd8R9QKZtPH3YSIhZINjbtqCRlKuwkVPwa9mgneqPZi88kYvUo+lyvT/U79g
	StoAExPTtZtQFWGxjp44gNiYjJ7sCdxmQK30kfYqM7mxvYG/y/vSIpUkgVDaZ4TZk2LYDPEgOZi
	3xjoZrDjhlK6SOHEeZYap4KA06vJfj4w=
X-Received: by 2002:a17:90b:3c4a:b0:32e:4924:6902 with SMTP id 98e67ed59e1d1-343f9e92a0dmr1838127a91.3.1763090647813;
        Thu, 13 Nov 2025 19:24:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2wHiv0drfPBC8W6GDpnf3DWvEzoDK4Gwj95uis+UUMkgLElPlSZP1kdkqV4QZv7KhWHUe/A==
X-Received: by 2002:a17:90b:3c4a:b0:32e:4924:6902 with SMTP id 98e67ed59e1d1-343f9e92a0dmr1838093a91.3.1763090647306;
        Thu, 13 Nov 2025 19:24:07 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba611682cfsm666067b3a.26.2025.11.13.19.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 19:24:06 -0800 (PST)
Message-ID: <0b019df0-f874-4218-a7fc-222b0e35727a@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 08:53:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v8 0/5] PCI: dwc: Add ECAM support with iATU
 configuration
To: Bjorn Andersson <andersson@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <176160465177.73268.9869510926279916233.b4-ty@kernel.org>
 <e9306983-e2df-4235-a58b-e0b451380b52@oss.qualcomm.com>
 <zovd3p46jmyitqyr5obsvvmxj3sa3lcaczmnv4iskhos44klhk@gk6c55ndeklr>
 <d6a33801-d4fe-40fc-ae19-6a2ce83e5773@oss.qualcomm.com>
 <d5byixqmmka3wm5jo7stfmbydit5dnqpxcczgwc2zu7ge3dc4n@47ukwyvj4oqk>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <d5byixqmmka3wm5jo7stfmbydit5dnqpxcczgwc2zu7ge3dc4n@47ukwyvj4oqk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDAyNyBTYWx0ZWRfX/Eg0WtvTt0mM
 tpdYeItkX4jw04+haO1SXfrcr/tgYuzRrwb6TKLjrCpgFeVC80xd70LZmRtDzkBi9qfd/NQXgp6
 hsYENYA1lF6o9XAjDGCmSBKc7Vk1j+4kjMIXEROw/a/EKNGd4boVRpgqvxlev3kZjV61eKAk3Y+
 dDDmrRIREkWzDBSxzGTHQKXG3Hv6a4+IIhpTYGipL2dBo5QVvx4noCfobOdJf3bHqTkf9fAxp/f
 TsbEkiUAxweor6OG6xaeZ7ExSusvBQgFJJjmvWv7bxMRfI0AhLo5WMaC/TI1qQ8pdAwqgaCmKa0
 hIbUcMzTevPPIpuGxd5rj3M+Em7Bq7ZIZuz0oFaBwurxpXHmIsw9tLR99hI+2zQJeYQX4jKhtpn
 fsqYnWJ2abVJXuJl293BcLuJgqRCVA==
X-Proofpoint-ORIG-GUID: mQJC10uNORh7vkqOSL_d-q3pZec71hpd
X-Authority-Analysis: v=2.4 cv=Afu83nXG c=1 sm=1 tr=0 ts=6916a3ac cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=I0CpK0KROK7xELUHsJQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: mQJC10uNORh7vkqOSL_d-q3pZec71hpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140027



On 11/13/2025 11:03 PM, Bjorn Andersson wrote:
> On Thu, Nov 13, 2025 at 09:27:36AM +0530, Krishna Chaitanya Chundru wrote:
>> On 11/10/2025 11:51 PM, Bjorn Andersson wrote:
>>> On Tue, Oct 28, 2025 at 11:12:23PM +0530, Krishna Chaitanya Chundru wrote:
>>>> On 10/28/2025 4:07 AM, Bjorn Andersson wrote:
>>>>> On Thu, 28 Aug 2025 13:04:21 +0530, Krishna Chaitanya Chundru wrote:
>>>>>> The current implementation requires iATU for every configuration
>>>>>> space access which increases latency & cpu utilization.
>>>>>>
>>>>>> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
>>>>>> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
>>>>>> would be matched against the Base and Limit addresses) of the incoming
>>>>>> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
>>>>>>
>>>>>> [...]
>>>>> Applied, thanks!
>>>>>
>>>>> [1/5] arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
>>>>>          commit: 03e928442d469f7d8dafc549638730647202d9ce
>>>> Hi Bjorn,
>>>>
>>>> Can you revert this change, this is regression due to this series due to
>>>> that we have change the logic,
>>> How is that possible? This is patch 1 in the series, by definition it
>>> doesn't have any outstanding dependencies.
>> The regression is due to the drivers changes on non qcom platforms.
>>
> Please be specific when you're answering, this way of saying "go fish"
> isn't helpful.
>
> By investing a little bit more time and writing a single sentence to
> share what you know, you could have enlightened me and other readers of
> this email list.
Sorry, for not being clear in the previous reply.
The driver is implemented in a assumption that config space start 
address will
be the dbi address. The driver is using config space start address as 
dbi address
and ignoring the dbi address provided in the device tree.  This 
assumption is
breaking other vendor driver i.e SiFive driver. To fix this regression 
we have removed
this assumption keeping dbi and config space as separate entity.

Due to these driver changes, we have to move DBI to different location 
(controller driver
has ability to move the dbi space) for this reason we need to revert this.

- Krishna Chaitanya.
> Regards,
> Bjorn
>
>> - Krishna Chaitanya.
>>> I've reverted the change.
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> we need to update the dtsi accordingly, I will send a separate for all
>>>> controllers to enable this ECAM feature.
>>>>
>>>> - Krishna Chaitanya.
>>>>
>>>>
>>>>> Best regards,


