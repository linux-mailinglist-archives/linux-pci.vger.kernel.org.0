Return-Path: <linux-pci+bounces-24564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D892A6E327
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 20:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015F07A37BB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84884D08;
	Mon, 24 Mar 2025 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3l8S/Ag"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C215E96
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843752; cv=none; b=lYZA7aR1qsQSNWpjXPtqv8ScjR/DP8DTKWTzmZsYZt9PjpQYp4mAp+KUhXTqyWMFNf5kbwwRmlxSCNik5S1/NdXi5VQ080Ia0mW4uJbqhTntyt5Vb+AqA8skA8Owcoymq/PRD4FfmGd1ezA6HP4h0MkYF0L4pkZJ9f5Hhc6By/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843752; c=relaxed/simple;
	bh=fBNjGhw6eywjKM4CPjTagVCVi48iAj00DoDAQIEtcVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7z73SALHa6WeKDfI4n4zQ/EtNtk6SPFgYDeeemWmORWEnSScSU7AJgCgzxBc9bAEkVmNYNEe+3j7ISraNsVjUZCDO3vKyKMpQvu/4taTRzToHFweDbgSov+YuD+iJakmRLx5QNpa4GtZkss0+d+bOEOnKM/0Yv0TmCcMSfyMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3l8S/Ag; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OIk4mR002624
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 19:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g3WlA5imHAbR+jao8j3DyOpD0bdaiCLBhc5RaKXj5z4=; b=Z3l8S/Ag79s1WMv7
	hGqHRFCxtFF/PTWnSmWTp2wvAP/2/2T1BzfZ9SDFxkX8OSNyeUYmPw1KDsJ0EhB+
	PGY2Gh7fpOXeA6xrxJC4G0U5WI3QlM1FziRzPvsZHMxt7dp2tK+ouX8+ZKXSriQ2
	lLvH/MelqWNHgrwuNyjVxV2EzizsAd2Uce14/a2eYBLlDTzhT8DXjZdYqDl8Lh+f
	sJ/DNZcmT9yfyG/BlFMtFZOWYrt9wHIC0ASwCehN2npqq34GHlFCJnVB8Pw5Pv/4
	LTKI2jkaLNzpN7hOdGVpVBK+gO/mZrSntgnQrWMYhoGyEMQ1GQvRs4lcwGmM+NJr
	pBswtA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hmhk5eph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 19:15:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47708fd6446so2504141cf.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 12:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742843748; x=1743448548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3WlA5imHAbR+jao8j3DyOpD0bdaiCLBhc5RaKXj5z4=;
        b=wnbEw2iRyRTCexzjrKWiYC3rQlRjAxUWpy59s2tjM945tOpYns1LzKBZLVdJDRlrS5
         XuzKIBN6KkCmQNA8IqE+Vs80Tmol+CCbIcPuXJTD+DwtFzR+5dietgngcnnM+VlYyZEM
         +8cX+ExHq7n/XthaWWk71pXU0gJLyHhxxc9CjefsdOSKSWf/LuRqdN8YTno0hGELPlRP
         OfjDD9UfMPdcqs5i/k0ULxWmpDm+8UphXMLC8EdH++8gsbTD9VXAPUFRkueFW7oSHdi+
         nwLlbjsC7Heo7OANAhJRVlXc8tcHN95uiGpqsOlz4lqeM0lZvGMq3PD887/5IZqNqzbt
         0fOw==
X-Forwarded-Encrypted: i=1; AJvYcCW6+XLxBz9+6rNC7tmXiTTYiuliberxJtCebrlgMEurDxQm9GV11mllGfAKvKaq+MG2Uid4LJAUTYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tu4vIS0sj5SoKMs/nJljqbY8pQKWiw+NV8mDoxhVbaPKt1Vh
	TX3YfILfwQCduB+3HWb40yFDnueXO95v0v4ajoglJw62jTmbRxLdqvIVM/uFr0g8UvqFmJVd79h
	E+m1S7adr72QGkYEg21mbppL5fOv/az9m9yys7KeWlNBQ7DdgqBqA52SOX8o=
X-Gm-Gg: ASbGncsO848nuaRoszqvOlvnAzSuvXBAVRjW9kIrDWiTIVmegBMzjgcl0/mPDSs6e5d
	LfhQeZejbcqyd+rX6Ou9uVMZllop+Ksbq9vVwRkyuvxLcdwpPwUxNFo+SqU5J2eLzAlIGq5Wmso
	uUCcYqS+SnhXJjwqkpCs0areVQEh8H3368v/Cb10xp1FCpIqQwv/EgpOwvyG6CqWIpmloDIaYPU
	DcDrXNe6Yi/yK5l0+v/JxFkujBzQMuXZZXc14P2ygo5nfml9BUxrPyftAjF7AjUpHWv1nRLCle4
	ZYau/UVr53O9PWrQXje7XkX06tzOSAG4n3JR9lSQFowfGqRRJz/NRkZ3K8TqpBI0doxufg==
X-Received: by 2002:a05:622a:8b:b0:474:efa8:3607 with SMTP id d75a77b69052e-4771dd591camr75030551cf.1.1742843748417;
        Mon, 24 Mar 2025 12:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtmaP6yOrhxO/q6iKc0oEvHBuaQJo1z8Kot1OeZWFMeia/4semGeZRZf9taq7A7UDWKD4wzA==
X-Received: by 2002:a05:622a:8b:b0:474:efa8:3607 with SMTP id d75a77b69052e-4771dd591camr75030291cf.1.1742843747870;
        Mon, 24 Mar 2025 12:15:47 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb658e4sm719173166b.87.2025.03.24.12.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 12:15:47 -0700 (PDT)
Message-ID: <2b038454-8994-490c-9d59-9bd03f52e337@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 20:15:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
 <20250322-perst-v1-2-e5e4da74a204@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250322-perst-v1-2-e5e4da74a204@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C4PpyRP+ c=1 sm=1 tr=0 ts=67e1af65 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=bSnlr1PQR7FYCNIf-OoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: x-uGRF2gflPL4cka4g-mx9B6ofMYI6Jo
X-Proofpoint-ORIG-GUID: x-uGRF2gflPL4cka4g-mx9B6ofMYI6Jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240137

On 3/22/25 4:00 AM, Krishna Chaitanya Chundru wrote:
> Move phy, perst, to root port from the controller node.
> 
> Rename perst-gpios to reset-gpios to align with the expected naming
> convention of pci-bus-common.yaml.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0f2caf36910b..6c21c320a2b5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2271,9 +2271,6 @@ pcie1: pcie@1c08000 {
>  
>  			power-domains = <&gcc GCC_PCIE_1_GDSC>;
>  
> -			phys = <&pcie1_phy>;
> -			phy-names = "pciephy";
> -
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie1_clkreq_n>;
>  
> @@ -2284,7 +2281,7 @@ pcie1: pcie@1c08000 {
>  
>  			status = "disabled";
>  
> -			pcie@0 {
> +			pcieport1: pcie@0 {

pcie1_port0 (or pcie1_port), please

Konrad

