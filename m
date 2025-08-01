Return-Path: <linux-pci+bounces-33276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD351B17F69
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F045E17BBB3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC822A4DA;
	Fri,  1 Aug 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HlpmpxAX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275BC228C9D
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040942; cv=none; b=Uu0ITiGX5UCCmHL8ByUjemvV/O9mLxO13t3nyZF5iyuEiP49J9O8yl/9MOs4ZKTf9Rpvgg9ZN2drXiw7DAVbx0lRhYjBKkw3juY2tSlrZgNLAOjergODwF+wPvcZon7ClIsw3IJPCm3y/amx0Deu494HrFjrQvjjm0kD5N5SACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040942; c=relaxed/simple;
	bh=RereaYefPMJ+AN1G/WR2ZPJ7Q/9VsGyrmIOo6U3bInI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnMTRm6JjW9ocX2y/iEN+SCUDUXyk2LzB+Y9qna/r8NaMqTUr2yZA9BTLljvNa1Po0yT8acOE0w6REY3DoZOmmrWcP8LiCQqI/l9l25Wlo2uueYxQYYrOrCeP9SxyQEP9BxXEBfLXZp5CK/22HV2XYRHcu0Vwn5zhq/k42L1JaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlpmpxAX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57199tpT004906
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2025 09:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FTE8Tu8b1amkpQAae9PG0gDF8STmsmRt79+CR3F5UKg=; b=HlpmpxAXKwE/hM1u
	Vvr45SBbJSsOe208L9fPmhGEtdQ7zzm59J2Sp07WRhzO7rBeZaXdlrIwqqYH+6nn
	7a5yeh6hOwgvw1qKBjhmTekG2uiDf9OrPOetBdNKvf2aD5X31PAR031EJXZ0ftte
	RiHFgnWyPtj6oI0O0dA6yOLjurfsNDi3LOe4jvlHCjpbLkit+g29lMYwNoEyNZXK
	JxPPajHIsUlwQCMSX0jrcQBeYKhG4BUrfNO/UATglbrCWS3fYvM6/SrPhUahdauM
	Mno8z7oA/gKNWhCB1NsYffFz4V/47S2lWdD69jVy4nlMbhIrJMCgjQXRuJGCMWPx
	4l/vfQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86bm6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 09:35:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4226c60a38so985785a12.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 02:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754040939; x=1754645739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTE8Tu8b1amkpQAae9PG0gDF8STmsmRt79+CR3F5UKg=;
        b=PTU/gM2xJXYKDNBw8zewKTV8N4yhfuVO0bk55FCiwfaDpzRBbqwt5H65w2FMtXgPUb
         VRm4Wb5+D7vknl+dxqhNtcb5n+kKk2pG0cDuaBNOxnSZXuS01EWiOX3t87TlXORq9olX
         99flF6Je319DBzP14hHEFstn/kBq40T3HDXMIxvYtmyKojN7v55kexiEehmO/rPZ3aRr
         Ds0SLqz5iORiU0+VbKJSv6BINL8TphGQ/yufL7yP3TsWkl5/kZHmWHhafV50PdZ/umcT
         s1OxAeQeqK5G0J1NH8gmvtiJv98t7HEKebFLtt5lBrMXTBPE9stj5xs1LJAMb1odlNqu
         A4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJCalbpeehn8IVfbQ/ZUGiC9DbaX+vmh3+PCajQdNNMbixfL5Yt+Kp1/Sl3Zh33xXhDLMrybnbxXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuhQok92W1H4GFajFPnFddUR6Jttt1/a6NVQWjgVHQhHnL4bP
	vgXaq1GtaubfSxIHVm2/jFfcamMhgAA/cZXTVvi2bcuE/rO0sNmgExD3TFQKVhubNRdzMI7GWmR
	Z6UDmjeCaUHtfwLjQRabGj4STHrSQzOVepdKyGb+5ihCJ1oFbowwCpwwY6zUdSJY=
X-Gm-Gg: ASbGncvpJIhcLbBV4cgXlYyufowqq9+IACGn9NjynnOXjUIJxwbyTHs3uZxqt0Wk036
	VSlDqNPHDqDKM/ou06iXEUr8Zv8Ff6pwgd531hDjLjscU8duk3LQrw9PBotkXkvziuXvFci/oa2
	oa02ROhwaABWmOoG24TSBDpLOj/PrdpHwHunNg6xayQxvznyOS/eag3gKEFaNrhQFgJpL3Ij41Q
	MDEcU7yCp7OzVfeP2Hgi0e2XH9AcJW6JdJxOwqXk2KQiY80jahl0x1rS8zECV+cigSH51/M2uFL
	gw8m5BvP29jDPDGY7hxzlKQtk2oU6mMnOOLVIzfiTxfcZTo6OOoTaoxFM3Y8pH0umOY8/S1SmA=
	=
X-Received: by 2002:a17:903:22d0:b0:240:1850:cb18 with SMTP id d9443c01a7336-24096bcc7a9mr150191695ad.53.1754040939352;
        Fri, 01 Aug 2025 02:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbZdxiptvpigi7eLXKhWCFOZQbYGfK+h+OEAOD3ELNf+6iC45wP9TbESkBH3N8d372w+JIbg==
X-Received: by 2002:a17:903:22d0:b0:240:1850:cb18 with SMTP id d9443c01a7336-24096bcc7a9mr150191225ad.53.1754040938913;
        Fri, 01 Aug 2025 02:35:38 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc3266sm4196042a91.13.2025.08.01.02.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 02:35:38 -0700 (PDT)
Message-ID: <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 15:05:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA2OSBTYWx0ZWRfX+QBFj1IpGOts
 ctUm6Ad7lNqHPgGaavLQ6V1gVdgQrrf5ZX0XySQ4N157g9dW37vh7DB3fab2T5tWAsTLxjsPj1s
 q32ewv8/AG9yY6EWQ6RDlLBdtJjpVAn5ruaQaZXtNPXwk/GitaOGhXX50eva3ncDFoJWrbhxNzh
 jVZJbMHr1MG76DC+TsYNSQIxhRhTfVywK24wlocZj+1pXVncqv0whIlucbBF6ryepHNRWxGfk3/
 wyQmwffTDdobGn86Q26+kp+Uo1tglQ+PTIixbEcg00om9xqILmoSvaqHDTKAuiKAJBgT+0c8NKm
 8RAW4c26dIvH2b0CWMqdly+JtLfjSmcSN4OAh8vC/pnVwjDaozIgTQMj1nmqecbT/jfbiQPUHdx
 /uYFNpYWmXgzTsrH+VlMspXFVfKRfexiIaQV81Y0PbUZHAujCwrvv/hxDbpdDUuuV/ePt8bL
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688c8a6c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=lAXUmMm_w8SOBygwRYEA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: RBia33ozR0UcBlGu2cf889p0nTHHEvfK
X-Proofpoint-GUID: RBia33ozR0UcBlGu2cf889p0nTHHEvfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010069



On 8/1/2025 2:26 PM, Viresh Kumar wrote:
> On 01-08-25, 13:58, Krishna Chaitanya Chundru wrote:
>> When ever PCIe link speed/width changes we need to update the OPP votes,
>> If we use named properties approach we might not be able to change it
>> dynamically without removing the OPP table first. For that reason only
>> we haven't used that approach.
> 
> I am not sure I understand it fully. I thought this was a one time configuration
> you were required to do at boot time based on platform's configuration.
>
I am not fully familiar with OPP here.

> If you need to change the performance at runtime, won't you switch to a
> different OPP ?
> 
yes we do set different OPP when we change it.

Currently we are fetching the OPP based on the frequency and setting
that OPP using dev_pm_opp_set_opp().

As you are suggesting to use dev_pm_opp_set_prop_name() here.
This what I understood

First set prop name using dev_pm_opp_set_prop_name then
set opp dev_pm_opp_set_opp()

if you want to change above one we need to first clear using
dev_pm_opp_put_prop_name() then again call dev_pm_opp_set_prop_name
& dev_pm_opp_set_opp()

I was in a impression that once you call dev_pm_opp_put_prop_name()
the previous votes will be removed. we don't want that to happen.
if this is not correct we can use this approach.

If this is not correct assumption can you point me any reference to this
I was not able to find any reference on this.

- Krishna Chaitanya.

> I don't have much knowledge of how PCIe works, maybe that's why the confusion.
> 

