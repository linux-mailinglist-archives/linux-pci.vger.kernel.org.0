Return-Path: <linux-pci+bounces-25670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E888A85B41
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 13:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AD21BC573D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA47238C08;
	Fri, 11 Apr 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ci17F/Bw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865D238C1A
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369721; cv=none; b=UkKHagXg+80i2j3nAwKXA+GiVZ0uia/tyLBlswv08FPDfDkPCiuXeOeLgiIdpkZ3XsKqRf255iCgta1Na+GaXrvDMWljFddRK9hcCcbtb8vfb8PuIWmzL9XzDdLy3PoZq0lmiJoI6rtIHaSsK+fB8EjIx2vi8lVJbx3HzZmj6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369721; c=relaxed/simple;
	bh=jUMLJ1eCvjknua9RRmRhB2m3mbtVGyEUSu411bXGwYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D2p2VTwWl8IaE/xgYI5kTQ3CEuDsTuxhAEvzn5RbcgdEAT6ZEYRufPvkw4OYBFE5rJcFczHhLH4pgqk9PZymoOA2ZsngAvrrtYkA7sA4nWwVeirE7wJFFNWiw+Yghlq6LnnuLZWABO8SlRa7kHuLU5O48Gvgfak76j9qWMrRvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ci17F/Bw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5UGAQ018319
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 11:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o79Kq++JkZecfr1axtLkeLEVdcWYqekrcVToRZ72dP4=; b=Ci17F/BwT1aKdOvv
	wq6EajrQHGkgpJ7FvWMcLg8GakqxkYzGyw9715c3DXRH+TugoPLGcvpzEkHpesOG
	0Fw+7LeHbZend0HtcHLBmrXaYsVFcy+xwk+AW7+lGnWlOEaSR7DsybrgnHbL3rcl
	ftwYQGfkTm3n8+Q+V628a0XsiaZP2MmWCJt/tEn7VB4ky4eQ+R9U+F7VxsAxN0DU
	sMMkOK5XSYOpuGZb/guZlS9dRZ00DGpG4zvpnBORtQxBUNa7F0FGEMZOyXbmKCG2
	T8FAmkJu1IzIOUP62qpmlSm5wcfRAKTJAW0Z15ygsMyJtiBNV2tjF6yPUQWjffsS
	KQhXvQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtba9t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 11:08:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5841ae28eso48679185a.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 04:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369717; x=1744974517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o79Kq++JkZecfr1axtLkeLEVdcWYqekrcVToRZ72dP4=;
        b=SFVv+1xhylSYr2gJF3Fggm9pB7XaQIYDvQBIvKifWXifzGHFvCm/mZzGxHhp5Wt53K
         CWP4tzMb8kv6atPS6rClZI3Go616jeDFvCSyVhefhfpKHeOXNhKRYPQWt2iIkK/JKhqC
         wIkSw7HsXQsOK9TqDDojSXrn1E2NYJUGoxAgk5clhZz2DyYJbs06EST3+nQJdESWobEO
         8LKVkKZOKb8Chgj3sm5EBeygijOm4DrnpZTAlVY4Pnd9n1pD3fUHhUs0PCOw2mRN+5b1
         bkNtPRj+z594Da+7VUb+E2bHjcDPAjnq9rW8Z0ofL1thlT4hpLvtLI+MWJ1QDo38E264
         2EHA==
X-Forwarded-Encrypted: i=1; AJvYcCXXtASwPTlEdz3UAnQ7gq1cmSXhEw7q61EoWvhtCCxiY1PEx18mvBxjsGJNVqGI5UlRuX6Wd5B8BZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOX8LZ+IW9ZRnUL7yh+qYamHBFwVn/cwJe3j774ywGHNm2aPf+
	fTx0wYenUkZ/vRS1xwa4K57QrBpmC4qkz70PHfTOZ6rBEpO8JyRx9OLWXvKrC+n0vbqqd3E/fc5
	rG72A+grUp34gM6faZYqzKLvdnpc7P2jitlNuEdkxKW9CzJ2B+XXhOE7KR8lYceUUyoY=
X-Gm-Gg: ASbGnctFLV+SoDKkAaiBMWkoxxFdkp8Cxacg3G9M/q2DuHkro/f4ZaT9yrn5l2Ry3JW
	xbpq/MBcKvDUkSOeotYymN74NR4g8M6hUFep0eFlSCq08+SkS6ql1P3Ekx6vtEvrtmdv3PWoCCL
	YlEQe1jEPYnemdGtNhnhqYwcAnJOo9j/fFCrMqFlJnmmdZrTyDFy2sff3Bq8MOSPRamInO4B+vw
	QSqrbN8FwIXuL+W4HvaL2cKhfK5jvwTz9N5E5thq7+NLBVCmbGBrSBn/JtUPgPfoZKcSMIdjCVA
	Sme+DBSjziHxS7kmdopawgbZh2yACFF7IpwQ7DsOYswFaLb+RjoKWdc8OeltSjwPow==
X-Received: by 2002:a05:620a:270f:b0:7c7:9d87:9e2 with SMTP id af79cd13be357-7c7b1aea28emr58809785a.12.1744369717356;
        Fri, 11 Apr 2025 04:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjdXPyj+Dlz7MJrd4wV5Jmd512Lms/G0laHJzFzKIthM1oQjkGEBydvrhqVbYRgd7fDl+WIA==
X-Received: by 2002:a05:620a:270f:b0:7c7:9d87:9e2 with SMTP id af79cd13be357-7c7b1aea28emr58807385a.12.1744369716971;
        Fri, 11 Apr 2025 04:08:36 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee55388sm802149a12.3.2025.04.11.04.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 04:08:36 -0700 (PDT)
Message-ID: <608c57f8-4f28-4e68-9c14-07b280126d9f@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 13:08:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/4] arm64: dts: qcom: ipq9574: Add MHI to pcie nodes
To: Varadarajan Narayanan <quic_varada@quicinc.com>, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250317100029.881286-1-quic_varada@quicinc.com>
 <20250317100029.881286-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250317100029.881286-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: niO7M8Ur2xq8nPiQZHwC0OojpIqR75un
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f8f836 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=87Z6qAKMJr3GWNWwxrsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: niO7M8Ur2xq8nPiQZHwC0OojpIqR75un
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=765 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110070

On 3/17/25 11:00 AM, Varadarajan Narayanan wrote:
> Append the MHI range to the pcie nodes. Append the MHI register range to
> IPQ9574. This is an optional range used by the dwc controller driver to
> print debug stats via the debugfs file 'link_transition_count'.
> 
> Convert reg-names to vertical list.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

