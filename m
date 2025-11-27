Return-Path: <linux-pci+bounces-42226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C825C8FEE9
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 19:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2602134DE58
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D12ED15F;
	Thu, 27 Nov 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ezx5v5T7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SpgFZMvj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA112773DE
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764268925; cv=none; b=DyW2CuflkN32PaX7TqjSMPCqzUlIl4l3UPtMTzUOCz9CIadIojpNMudFy6bEbZGaOOEyTulf0akeio1jaMXqyPUyfQwrY3/kborggyW6ZiXNIzL/gj1vxyeRwFOMZ3sjJDogigWVlxOCi0T1Q9CY7oYU8t0SE+oDJP+J0GAq6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764268925; c=relaxed/simple;
	bh=ZsGbQVcS26VTwSvSnGlyFKtXU0OolouKxBBV1FeIQDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWvtVRfxSQKx75UThaNbe7I55adT2jubIkwY6Yp7YCnWCPNe6rTQ7PjazlhaqzPUgTfG58XzR7AIvfre+fp3ZCqCoK6wQnZtdk+iLWi5h9oiU9wdZn5l12Xrsv77gE1svM+S740f7C8BsEnGbH6PjSPUY+ATkTUpsnnBE/HHo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ezx5v5T7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SpgFZMvj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARBVXLi721976
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 18:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bc7ZTn1qkuWTcAJu1RFCx05g1Ppub4MaJlxQKXGqiro=; b=ezx5v5T7e1UTNMlq
	V7SetDafvvgfnyyyJVgvJQnDtyKALvR8XmskUNP1dmt2SOe0lNCIvOVZ8fRYlKNA
	lcLdp8MbEI8azD7FPXggqslIbUsS9R0B1aM48+PBNwSaWdEe9aB4wmat4bHspo6Q
	zWdIquKfTKidhAxPq8IZo3dFHn3Ou2PYUrEkU/iqjUg1xQleSqlCq5v6xECdSBdl
	+yoK3uMKOo+JHqnyUSyRc7g5w+QU0SdkyIJDO/j6xKyznBZCuMUp8zxaFBYzZQVR
	WamnOhZNXWljyDvhaw/Kym8Q532zYGBhTRcr2aN0HP3JM27ICPAt3DXW9RFMMatb
	49y/Qw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apnud8xv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 18:42:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b29f90f9fdso29416385a.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764268922; x=1764873722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bc7ZTn1qkuWTcAJu1RFCx05g1Ppub4MaJlxQKXGqiro=;
        b=SpgFZMvjaK7vgRPzmdv7uJOR5fwSenu8LKTJwkFHF5O3cvE6UE2s1oRgskCJlD4E2q
         nhc3mZyItAaTqQ94ba72qGIT7FNpg/RrXEWFxdBrzgOdgLKmGdyMdDyTvZYc11tlANJX
         8MV5j1d3p5tJgHjoQyGMcdQgeE+32+PQpAh8ij0e4srGA+A8uqMEUf+J81+lh34wmg0F
         8KesgB3iJCQ7GKUjKcN5uKM3fgX8CxRtqs3MK70PB+dMlmdOExio91bjaJ31aYzP5pw7
         fa+nO5sfQHhTuN//yr8i6zTWW1FRNANkVQTfcjXdRNj88qspKZ1VPpfLAt+Y5R4sDEO6
         Bv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764268922; x=1764873722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bc7ZTn1qkuWTcAJu1RFCx05g1Ppub4MaJlxQKXGqiro=;
        b=CsI6mkCoNZftu2nu0dR1KicC61CcJ/XX/yq1zaRBmYmedJp6EJF8+Eo5ccSrrgXqz8
         YZn3MazSD4rPa7x3VycXP/1/oVMk3WQFd2nj4IxMG6XqWsIwUOYg9d6b8Qiw14Lv9g/E
         rzbicw0NYKymw0JXGeeND8F4sj+sx+AJbaSzXdB0RzGskS6GrjzkEMCX1MbnhuQI/sdz
         WlrXnbqCDszXHkDn1BWtsWNeRz0H/XiD9/ElVruEjoHNJH2oYo751bNt7//nm+CL8nPq
         d7+VtVa4gAKhO5v5IWZKCmhOZZn7C855Nt3mK4FGabAVruUnZo+T8ODMw73Z7WnEQZih
         YCZw==
X-Forwarded-Encrypted: i=1; AJvYcCWpUP34J7ySv1u6cZf9O1VKOVtd0oFGIeWlLSLjlJHiephKr1XbMZHPKMNTkf7ZSIXGjK5C1tc/Kqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNwE3VEKQiMqMKMTj8HAGj6DikSfL86zVMTEAE9GnUHApb1LK
	MRazX9guP2vjI9uWUD1YCB4I639BvrtVp3lP7JNlh2l63Y2LzpizfSPgApcOcOy+H2UuEd5vvz2
	mYdFSMCbezdrx8XqgczIDftvfRzhKOhh+FNg6igkk0IxG3pfH1v9K2YeZIiFpO1E=
X-Gm-Gg: ASbGncvOsnGy70Kg2XkjL8EvaMCCbPY4ejrtP/Lsv5VRrYMkyUrrc2dM8Lth4aVBg/x
	sWhKegSwfyfKkxn6tgZgEY/djIg0U4M+GnaThOm6ELsEjMopd0IoD8m6ptgIjZ7gwbxVBkpKMGg
	gPrPelJcm7cH6otSAQAAKirgcb3hhPLvs9YEjiff9n3fWpdtqbEhhYdjy4zdMgzR+GnnKzcrn0m
	RHzBLHCndEjLc3tc8hbp754ItntLdRICsDYa1a/rX2LaaKe8XdLyxpcp3OCpc2qei4tws7M7QFp
	zskOpQZzhY8RnUmLOvtPLo+AnG0UPEHqzTgzyXvsOHiII2EOz0hSFtNoVJ/wB8fUbb7GPFQWJEq
	IRtvMHZX6PSUPmgg6ks0Lneju+wJpa6+jSWiqfYXYYFQKKXSCvUswrEhmBKpsmtj/DBQ=
X-Received: by 2002:a05:620a:404e:b0:8b2:e704:55fe with SMTP id af79cd13be357-8b33d4a1be5mr2446319985a.10.1764268922417;
        Thu, 27 Nov 2025 10:42:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy9tWdsztrijXycv5GZobtK94WUmjhNKC+reMeWq2COGJIUarj58EUVr9t6Y6xmo95jQhwPA==
X-Received: by 2002:a05:620a:404e:b0:8b2:e704:55fe with SMTP id af79cd13be357-8b33d4a1be5mr2446316185a.10.1764268921883;
        Thu, 27 Nov 2025 10:42:01 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d26sm238403266b.3.2025.11.27.10.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 10:42:00 -0800 (PST)
Message-ID: <a35eb89e-fcd0-4af1-a0d0-655362a2b0d1@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 19:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
To: Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeffrey Lien <Jeff.Lien@sandisk.com>,
        Avinash M N <Avinash.M.N@sandisk.com>
References: <20251120161253.189580-1-mani@kernel.org>
 <20251124235307.GA2725632@bhelgaas>
 <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
 <BY5PR16MB339612035106C16822855A5A92D1A@BY5PR16MB3396.namprd16.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <BY5PR16MB339612035106C16822855A5A92D1A@BY5PR16MB3396.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EZBIFXiZhMl0NVK1dKDo3rkj6ZjQoLS5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDE0MCBTYWx0ZWRfX2vQzFlLSYzSp
 KEO8keiWLBCqFzf3r/Ae8I1sFqsQePvsrqFUJ9wG9f8obJt80zfP3Eb6FqivhhZP4n+B8CFlw2m
 Tody5kwfX5NOntaeeHgrTwBl1jlEzswVUZ5WB55c9sQjqmBjhgmEO+IjYMvyr6DwVeABQB5IGyr
 oQCbDm0KyMtDveZ6abH/EgsZihVBXiV2g/fMhOlV5ugB1Cz+u0qIsP0Aa40uhU2CBWrFKqu8jvX
 jCL8bWon6iWVEwMjAwtQL08cCV/JVXyg0Xorq43ROkcwLKgb1AiKiMpkszDm9euyE1o68ngEZ3D
 DYWwgoV0LSTybS2Xuk6yynqXdq8VC8ehxQ0up7Vm98VW2wNT0slbUzRMXEJ9pGDm5fxD2C3a8MC
 Cq9cIXl4RM72Il/gA22JSdxEXcULng==
X-Proofpoint-ORIG-GUID: EZBIFXiZhMl0NVK1dKDo3rkj6ZjQoLS5
X-Authority-Analysis: v=2.4 cv=MKNtWcZl c=1 sm=1 tr=0 ts=69289b7b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Kae-gO-dM5og4_8gfLYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270140

On 11/25/25 4:30 PM, Alexey Bogoslavsky wrote:
> On Mon, Nov 24, 2025 at 05:53:07PM -0600, Bjorn Helgaas wrote:
>>> [+cc Alexey, Jeffrey, Avinash]
>>>
>>> On Thu, Nov 20, 2025 at 09:42:53PM +0530, Manivannan Sadhasivam wrote:
>>>> The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream 
>>>> Root Port of PCIe controller in Microsoft Surface Laptop 7, when 
>>>> ASPM L1 is
>>>> enabled:
>>>>
>>>>   pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
>>>>   nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>>>>   nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
>>>>   nvme 0006:01:00.0:    [ 0] RxErr
>>>
>>> Do we have any information about whether this error happens with the
>>> SN740 on platforms other than the Surface Laptop 7?  Or whether it 
>>> happens on the Surface with other endpoints?
>>>
> 
>> This device comes pre installed with the Surface Laptop 7 I believe. It is not very convenient to replace the NVMe in a laptop for testing.
> 
>>> I'm a little hesitant about quirking devices and claiming they are 
>>> defective without a solid root cause.
>>>
> 
>> There are a couple of points that made me convince myself:
> 
>> * Other X1E laptops are working fine with ASPM L1.
>> * This laptop has WCN785x WiFi/BT combo card connected to the other controller instance and L1 is working fine for it.
>> * There is no known issue with ASPM L1 in X1E chipsets.
> 
>> Because of these, I was so certain that the NVMe is the fault here.
> 
>>> Sandisk folks, do you have any insight into this?  Any known errata or 
>>> possibility of looking into this with an analyzer?
>>>
> 
>> I don't think Konrad has access to the analyzer, neither any of us.
> 
>> If you are still hesitant, I'd suggest adding the platform check so that this quirk is only limited to the Surface Laptop 7:
> 
> We at Sandisk are currently checking and double-checking the issue on several platforms and with several devices.
> We haven't reached final conclusions yet, but what's clear is that quirking out SN740 unconditionally, for all platforms,
> is definitely an overkill. The device performs normally on vast majority of platforms. Applying the quirk for the combination
> of SN740 and Surface Laptop 7, as you suggested, is definitely a better choice. Still, we'd like to check a few more
> platform / device combinations so we cover everything that needs to be covered while sparing the rest of combinations.

Can we interpret that as "SN740 doesn't have L1 issues on at least one
other platform"?

In that case Mani, is there a chance we omitted some related tunable in
pci-qcom that only seems to matter for some PCI devices and not others?

Konrad

