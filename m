Return-Path: <linux-pci+bounces-33267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4506B17CFE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 08:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423671AA4F77
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FFA1F4628;
	Fri,  1 Aug 2025 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ahhFo5Oc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F41F3BA2
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754030154; cv=none; b=CVm5FU/cA8qE445OTEF8C/no+tTZ5LX25oh9UFLfFAYAOxarjhRihWMouJrVWTNvNbPeVyVSf6YZVkF/WvSbKeIwqWXiuNGIjKjqOKuZAP5e65N9peTbd2D7xL0Ir83ANlUEpuecZ0z+1YfqI1Qu+tK9XF0gJYQWGnxWqfBO+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754030154; c=relaxed/simple;
	bh=Y+BztVPzZLppNQnoFJrQr/MAk7o3bTjHPtyxPE/UvPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf/+l+ftLSmqIeV7T304NmIA2zVW8rUEGbadclvrAQdp4kYvKSLswKjV9HHP0qvsxWcvZVbFf+Vhilt755XK+MJY4h8ZPfi83hU/hunkZXTLtxS4zeINsjmbxBs11q5jijRMWll6BH3DT8sjWpnfYlhx+/ExNfQwFXrZj+5akFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ahhFo5Oc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5710PG90021187
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2025 06:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDaOrDWwXzPaCCV3E6MSXbRpVt2vbjIVpkSmk2gQwM8=; b=ahhFo5Ocu02X+EDX
	2dOZJJIH8fCWuMACi+BDhKbmT4CBvIwjgibUKWQAo2ZXKa9IbIwZg2QBykmt88iD
	XmQJQBPcXostdW+vzaQZl6Ps6uF+SLzd/gA2c89ToOXmIM732a3/XV0D47gYCPDG
	pZhuMoSKEBqiwBMRa7zlxPNZwGauLVxQmzICUvFsCE5hWF6NS3GOf+OvFzv8tt2a
	oMimohYt3khQXQQtWCzZuPnIIOrj6gr7pHjceyqvvLpC0sM0v2BX/+5D8gD5FBlD
	BTi7MOZeRKKmWb4CsanB48UhmBPvbC7TsLfN8SjcPT/6ONvY1B6svvWzMItg7zLd
	h/A+Pw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1atjtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 06:35:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-237e6963f70so34166185ad.2
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 23:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754030150; x=1754634950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDaOrDWwXzPaCCV3E6MSXbRpVt2vbjIVpkSmk2gQwM8=;
        b=Pa1GP1hEtzpgYSBW67AeAd18SARARFzIZB0bkXWLq+GmjrCrFVXWaTIKzOohdZt54u
         E0dpxt38SQWrNNA0DOGkwUV6bvIUcit0LdIX+qr9GFED3pY1MvqesLNxdqAWsf01CVBh
         r8n8khs5/gxi4oZ5gewciRe1qI8UeCkAv5B5ns0Z1GDTWo4MWLthtbG7hVa0CRs6j4Rc
         xZyioWEyEX28n7P28s7ak+ZsTqBKQe923+VuRgRh2SryKSwAMrTTxij01xdDcZgxAQqZ
         vtG8vEI7sVKTkz+qQVHewt9/zBEAbCUNFbQxRyeXNzwrTGMIZGYtBjPGyFdBh9jt7hYM
         GF/g==
X-Forwarded-Encrypted: i=1; AJvYcCVMnYfqd6XhyxOL8mjUBhCQFRDWVVtsNTdiprtSi1Vdd6qsEI4XcZf5Usvy8aJH4qQMui3g2FOzPek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBY7cAyMHafWs7SgJDY3KNtENp6km3ba00d14iIpZEp4CA0rRX
	K1bpHviWxAmie+1qToO/v27un3vLDaBb7rilKvCRW/ksiK3b/sfsjBzK4g6KXndL2y0aHWB4uwH
	gmxwnu1Wmh6vnW5kJrZurbmp/utsVlWReet2EQONusvlsKKI+W0sxbh71/K3zlTQ=
X-Gm-Gg: ASbGncsndz6/3P9ItvhS2CzOw0TOouyaNiBYzDDqbt9dxnUMdnUp3IE1YybfRvQJWpt
	W0ItBnwMJQThjl841YVnsCJFn9EXtXih2Y0WbvZgG8j0EQer3uwUDJOAFGY5o9M1g+MpbH+xhk0
	QT7YTZRhqtDvOrz5NuesLqdFi8rc11qLbTTBnayn/2Ire7oBVxtq3OZ4O0AzG51l9JTgMH+GcrN
	6xYtncnH3S6gZxwfteRFN4T5cd8BCnIEAoajbQsYFsOejBqbdfOo/rFK6X8nL9EF7XyBGmSvJYK
	xvJJFvqXH4sHInLWX/VMuTf0taoKPgl2e1SgaGkpNr+/9u7d/kBINnTtLRYZL5gLsLg2MfrCMw=
	=
X-Received: by 2002:a17:903:1b6e:b0:240:79d5:8772 with SMTP id d9443c01a7336-24096b31ed0mr152945125ad.46.1754030150111;
        Thu, 31 Jul 2025 23:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC8ggFWew8fx0Y0149oLd84SpnYbaKhSyeI9yLySGHjuqLPclWYwhq160/UUOByeO0hKrc3w==
X-Received: by 2002:a17:903:1b6e:b0:240:79d5:8772 with SMTP id d9443c01a7336-24096b31ed0mr152944685ad.46.1754030149702;
        Thu, 31 Jul 2025 23:35:49 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef75bdsm34394445ad.11.2025.07.31.23.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 23:35:49 -0700 (PDT)
Message-ID: <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 12:05:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oQC80gt7wy4gRBtlV7efQ51iKCiS56gz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA0NCBTYWx0ZWRfX+SLaRb0n7mAO
 aqoZvM8VfE4VO3GT8BvINcSMW2+0HGk9WBtGVFazgKcjLB+9222/cA4lx7y3g4G+k3kpCMj1GbD
 rqS/eFUluLVE0R8F2jPLEgd3bcJL8i+548/vIK+7XW+oAFZ99UPXLdNP31V/uNEMN2mJC45tAp1
 Gahqd9D8DKR08xBDG7HpTU53A1GFCXM8t+ydPeq1qjW40ENJzyZFCeRppQoXulRyDlK2WOdthMF
 1Q+9s73SVYVMWk7dT0QbbBhJZQRuOaYH5xTRknhOHqhk+ermgoHxdo9CrTqKPMPTvvHeuO1VDM/
 f0fsxvthGdiKZKI7jL0iKfQUD1RbnIR0Ofk1AB/Z9XuZThXAggKEY5nMgaTjVQw0e5cxCZ//YCT
 /LEEadrTdWxWRh8C/paLlCDFXoobcoTWhq1IOoS7knIefTJcGi9H7yiX5RVW9aoBIhwvg2BS
X-Proofpoint-GUID: oQC80gt7wy4gRBtlV7efQ51iKCiS56gz
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688c6047 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IBex7tjcYQtJ9Xp6WB0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_01,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010044

Hi Viresh,

Can you please review this once.

Thanks & Regards,
Krishna Chaitanya.

On 7/17/2025 7:31 PM, Krishna Chaitanya Chundru wrote:
> The existing OPP table in the device tree for PCIe is shared across
> different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
> These configurations often operate at the same frequency, allowing them
> to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
> different characteristics beyond frequency—such as RPMh votes in QCOM
> case, which cannot be represented accurately when sharing a single OPP.
> 
> To avoid conflicts and duplication in the device tree, we now define only
> one set of OPP entries per table and introduce a new mechanism to adjust
> bandwidth dynamically using a `bw_factor`.
> 
> The `bw_factor` is a multiplier applied to the average and peak bandwidth
> values of an OPP entry. This allows PCIe drivers to modify the effective
> bandwidth at runtime based on the actual link width without needing
> separate OPP entries for each configuration.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Krishna Chaitanya Chundru (3):
>        opp: Add bw_factor support to adjust bandwidth dynamically
>        PCI: qcom: Use bw_factor to adjust bandwidth based on link width
>        arm64: dts: qcom: sm8450: Keep only x1 lane PCIe OPP entries
> 
>   arch/arm64/boot/dts/qcom/sm8450.dtsi   | 17 ++--------------
>   drivers/opp/core.c                     | 37 ++++++++++++++++++++++++++++++++--
>   drivers/opp/opp.h                      |  2 ++
>   drivers/pci/controller/dwc/pcie-qcom.c |  8 ++++++--
>   include/linux/pm_opp.h                 |  7 +++++++
>   5 files changed, 52 insertions(+), 19 deletions(-)
> ---
> base-commit: e2291551827fe5d2d3758c435c191d32b6d1350e
> change-id: 20250717-opp_pcie-793160b2b113
> 
> Best regards,

