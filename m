Return-Path: <linux-pci+bounces-39044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFAEBFD707
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE7406B4C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271B327A129;
	Wed, 22 Oct 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JuYJQ8qD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF829AB05
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151069; cv=none; b=A/tdzc9x2E+hj5w/FM5S5Ldhmv8vH1Ud0fj3lBRK5MFssYLqSil5eLIa1cvLsn3b1WdedokKOEc6YGgvqHmKcms94yRyuVR3QuHm0iUpkiYwk1OurWVrPSI7PidmG3Ddo4eYg6fZuXdJKpj2fJISvezCFPcZ0odwpMLRGeFcZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151069; c=relaxed/simple;
	bh=Wp81GXNND1wh0U/9s1mWBF/bhNhNGUm8w8X0YEP7PN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE1TbNqHKh87jTeaLzmFtWxT49N7Ul8aL59Zi9Fo072O1fM3SIfVrvHcimZX5r5BeTCaZD7Cy/aZuwFFAL/Jl7/eIWAp2TsKDjOYud8xhFO5KYTy4P9ZkdJ7Im191qvAqeu4+Ojo/2QN08ZF0C6VTXI5Tbhjlla/ueY/bS3BML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JuYJQ8qD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAdS3V031052
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 16:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7pD8+/3i8mH4YAFD2vcdS7fmM7cM/hpU5EdelDxdTU=; b=JuYJQ8qD35fiYRZm
	UMIJfR+oFwFQsFqisGFDdPpfc8nvX8Wn11Ta9qiJmEfhKtMrjG/BBzkAQckpvMQN
	j67p+fSpkezld1rLvXZQz2unRg+UdSHOzkotJoCUN5HZ1g5Db8bDuhp5z+EpmZ54
	N7KCwVKZ7vgl05ciHFkt6P3O3R1OIXfTVBfCU0oeGGCkjGIhVnTewQzKYtSBPr33
	v19PYN3yciLpxIRBkSdJCJUTEUETZpQMZvKeSXOA/Se2eNVfGVMB667BHXo2FQVf
	rD4j3afLL70RBSDSCc7vLe2g+xisqJgkqjcyFrCYaRQkvMIUanJNgCAbFRcg6cD9
	J7joXg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kd6h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 16:37:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-873eac0465eso24574136d6.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 09:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151065; x=1761755865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7pD8+/3i8mH4YAFD2vcdS7fmM7cM/hpU5EdelDxdTU=;
        b=X/fFLZFr8MGEV9xs97xVFGeu0h6ApbwOnRauMtGqlF554iDh56rn8srXiIrCh6Oast
         +ry58DMY3S8lhCSrtAx5GRLEz6zg0Na7yPP271HOhE1eAfMrDapt8OueNkd1nunZNK+T
         0lDnEAjL+E7S6rY+k5tjOa+Hy6JtiB1lo7xHsFzwnabr+zrBh2iKg9KpAoOWclKNZNES
         PH4E5IWGMhHpNNrB1mlkSRMSR8P9afo9BXFELIwgNWPaoUOKLzBMy1p/cL1EdWjnwFHT
         v0CdkGJps9cUy3grsiWdBIqMWuiQaTrboY0LLMnF25smcgiWYCH5FlDl0WyC3ymRzhzj
         MvdA==
X-Forwarded-Encrypted: i=1; AJvYcCUM4SdVEGgUD3P4JWmSmElhqbkFmjEdl/NEtBpAmv5MX+/X95GrPgJQr49ZbqeYcVm82opDh1ZR6Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHgeEyIHPy3x5lusiuwhyesTQFTZDIMoy1xCNIJrocHOZDqGI
	0Zu4H70vnteUjYgazYvcP5X6qdhYqU6QCiSBKcEkeNuo1EYaYQPjqjybfUf+v5Yq/nWDRT6Evyh
	Oah0biHEwjYQ2TsH96ZXG3p5wWwtIh7adllxzibYS5xCTu+PvxnitLx/VRlGaPYo=
X-Gm-Gg: ASbGnctYToNqj36b4LJNM+UUm5JpAlFnKz/kd5SMJSigdV5sNGAhyTomk8oD6Rkx/mH
	/Lj6wiqk3Sevf6wbAIlGyGRBeSleXdquzkJJqq8cLnbnD/+XWDPrziV3rghXhxMvbb7fIgCxiad
	ftQQvFN3o/mjjCCSVUKlkZEVNc7sci6ZH0dW/JGdRwtn6FAiHV7gm3OCebe9u4Yqp2ek65xnz4T
	wOS6weICVBTEAhZzVDg17cHPb7dpFyH13OQ5nhVqzkeUNd7Wic6lpTlVwnHBMyS21dAy226QXo+
	Bp7dlluAZGFAXH8uOo1gRUC3ZMrIC9K5bZpVePp75q3kSz1VhOKsopgL4TCJUH0YyGDWcIHA38y
	FV+6wJDVBtnGj7BQFSWcfoRcpmWDCyvRirP69FNW8Ekx3dlB6dd4hwl9r
X-Received: by 2002:a05:6214:f04:b0:789:e48a:fc05 with SMTP id 6a1803df08f44-87de71558bcmr59531136d6.6.1761151065483;
        Wed, 22 Oct 2025 09:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERyQqnqCN17TiFnnIPLzVxcq0nEWVQWZk7kbvp4BBdWHyCyaz+jWM4LC9xAGgeQALkVVWWcw==
X-Received: by 2002:a05:6214:f04:b0:789:e48a:fc05 with SMTP id 6a1803df08f44-87de71558bcmr59530626d6.6.1761151064778;
        Wed, 22 Oct 2025 09:37:44 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab560esm12216643a12.12.2025.10.22.09.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:37:44 -0700 (PDT)
Message-ID: <f0f1219b-672e-4793-8501-ea31e7cc9575@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 18:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] PCI: qcom: Use frequency and level based OPP
 lookup
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
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
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
 <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: v3wY3X3g5blic5ROtSHAg0cUXkQLTLue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX3Ozp7xzuXP/U
 7ZwIMc/7soOOQxQ9PgesdbUyhyixKsIOk17t9mUye63K+lCr+KWNQPMBbhso0BM0sa29i9j5D9F
 ZoGwfb546Hjv112rIbq9K4/q4AoAf6Cel/Pbcw5z+BlH4WfgG1RCjfZ6nZEI7c9d93KVZfPJKhW
 EQyf5ZNvOAzBdFubDV80UP2JraDdHDR72eiEyzmre0tTf5B1UuiyAlFWNn1HVlCn4nw9kJMxL3p
 q2YxUJJZ/QiW9JGOafncR4AVQaEocPg3osBhMOxWoJmH3CLjr+X2P+MgCigABB1pIMimcrT57YH
 r03LzdmtWKQ4iKbPtQsG6S38KLK6v6EsM9UcCJGAU9WqM+HQPQ8w7SFZG1jYYnbUSrjFVQGk7fW
 4IaghjlBfRpHH4M2nFVNylzOsy/x4A==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f9085a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=M-jGJTmE-ygQmRKCDXMA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: v3wY3X3g5blic5ROtSHAg0cUXkQLTLue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On 10/13/25 12:53 PM, Krishna Chaitanya Chundru wrote:
> PCIe link configurations such as 8GT/s x2 and 16GT/s x1 may operate at
> the same frequency but differ in other characteristics like RPMh votes.
> The existing OPP selection based solely on frequency cannot distinguish
> between such cases.
> 
> In such cases, frequency alone is insufficient to identify the correct OPP.
> Use the newly introduced dev_pm_opp_find_key_exact() API to match both
> frequency and level when selecting an OPP, here level indicates PCIe
> data rate.
> 
> To support older device tree's where opp-level is not defined, check if
> opp-level is present or not using dev_pm_opp_find_level_exact(). if
> not present fallback to frequency only match.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eba496bc99ca82051dee43d240f359..03b3a1d3a40359a0c70704873b72539ffa43e722 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1565,6 +1565,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
>  	u32 offset, status, width, speed;
>  	struct dw_pcie *pci = pcie->pci;
> +	struct dev_pm_opp_key key;

You need to zero-initialize this, or it'll explode the second
struct dev_pm_opp_key {} grows

Konrad


