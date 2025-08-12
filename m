Return-Path: <linux-pci+bounces-33846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBBBB22174
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 10:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA79501A96
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DD22C3265;
	Tue, 12 Aug 2025 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SgNbkgDq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C02E283A
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987500; cv=none; b=aPUOhINJZ/D/2OQJNVPgCAGZpFyb1eeBPbREs9VofVjgHtL3+vLABOdBe9PgRUTmEEMfIe4ZjkmAovvix15d/bRr0ZTwwfxZZIAjiDdf4c3A8PNWQbUH+wvyiFNNiESv0kmUjwNDMm7rgtmTE7syY+drXpePdWIy2dwji+8WDcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987500; c=relaxed/simple;
	bh=3FmUf3Hp30CS50cj34xwa1ruTjcKGUB3eCltwPgVm10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLPp8tXCCpmQMm13yo4vI60HjUXYEShIHmq1x4yJj5cTK+62cUH21+njMyXTb8gO0MKsriDmvuZ01mkbKAKRj4md1WMF6rdELH9qDyKsX9YMP4gRzRfq7Qlby9zKY9B1pXM6gksJUkc54y9HV9wcHuv2xeyBAy2y1E4VluK+xLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SgNbkgDq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4wtxt028828
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 08:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWWmZRGTBwubXompLpnOIPrbDAFgCGljYAqe2x5V7LM=; b=SgNbkgDqi7XDEWln
	RZr9DtJhRQpkMIQ5zjVNGLh+FVDF90W6U5RfWZPcG3/dBZuXr+V1Xevvyl5WYipg
	e6hc171zifFPw7sZ86EXhisHppXmm3jLNdFct3Mdi+jdT6w/1rpmJzh8uI2Emd5E
	xacGeF/n4bxZdd337sULWgy9EWhsygD7qe1CAzKB+K4HDU3HGDtufNjSOQPIPfA2
	8bMeRSz64+zHIsnnGwgU/rGdCQM1cnqdxlADMSFoFZPouj6JReE2LR7/MCIrf9P3
	mMigss7rehYm6kdb/kN9LbdhBJ/aG6EnycSBoVQhEqWFOZZe5DtKvXz2byxGD18K
	i/nEvg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sqjqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 08:31:38 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76c19d1e510so4963555b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 01:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987498; x=1755592298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWWmZRGTBwubXompLpnOIPrbDAFgCGljYAqe2x5V7LM=;
        b=K5PEtIx/R67SPDLb5Zep64ByNUKitnItCMVDr5XKL9F7UF6eESx+/EqWrf/zXgdkGv
         7CJG2uHe81CveZIDH2xMR5uN/zfyk0v8CVoR3YRnHPSAVMk2DmyzoI+oVfmzx/n9IPAK
         qc8tjrEjawRcKhC7G5yRWcutfmhl7gm7PIaHtcKNN+/BIsjOK60Np2t3FS+zWPhNmFCs
         zwKeJJlLJcfJJ/SgbbkAmbm5OGdSXc6k5L1Eh3HtjzHbDZeW4QdZ2qgKzIKH8xB9khGs
         HWE+eY99601FmkameFvIiWL18x1uKmYnxZGqH5M5dDvqxEbwxOmbyPxNRs4iuHbPqHDd
         PuVA==
X-Forwarded-Encrypted: i=1; AJvYcCWnvWgGzML5BYn23cvxrbygQD2kjgLS82nqkucTjGwWRzXJCGrkkrqZ66Wx6iQ81LMyf9QZmBw2yDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TJCIe3v1lo2d6pi+Ko39x2plfUuJNxakV3rhPy0lGzP9+4SB
	vtm07A1MpCQNrEGRROed1JXYIDdnQ3dYp4FXJnc4tt14Cs0eV3yWehtWD+PpX7xjEZNqQenujf8
	7YmfkCtocUEbu4n7BAsEkUNHWyJijPnl5Iv8Ecf72U1cOctbAPlEJhGxXpVtALXY=
X-Gm-Gg: ASbGnct8lRUsJoPbiXVYUg1qCe2VQwM9DtAXc/8ZR6XWjwf+XNApl15ebJYczaa2qnf
	uzQThgc3EK5aWUa3RWEWkHUFnUOSZ4aaFobk8CmWiJgFMt+qwyx4EKwSrZcfMhlhwPBRi2jQBvp
	9xwRvR3w/LPuGJix8BplwGn2p2nEku/Dx5AiGV1CLFK4C3L/MVpqIGKBRcLKviL653khFwmawSt
	dlaWW3V1IpgT5m7Cmtlk6t4Z+my/tSRbTs1q9ZHvwRAeKKQ695vuvSNqnnu0YjUVaKdLQpp7jk8
	Bi5Go1yzI7YbmHbtvuDdG1tgAlMGULMwTTSPUhyambgTFy8cuu5WAi6Xoyv9T+iSGQI0/zv+y1n
	3G2evR6by/KsP7NUqZnfwCAyWfCzg
X-Received: by 2002:a05:6a00:b86:b0:76b:f318:2d41 with SMTP id d2e1a72fcca58-76e0de53d0bmr3499988b3a.7.1754987497659;
        Tue, 12 Aug 2025 01:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMlyo0ZIuqdKYZz9q+kCc6x7EFMtEPl2fYK55x280gUgeOGPCcKX8cqv6uh3bg01xS6rsZvQ==
X-Received: by 2002:a05:6a00:b86:b0:76b:f318:2d41 with SMTP id d2e1a72fcca58-76e0de53d0bmr3499949b3a.7.1754987497144;
        Tue, 12 Aug 2025 01:31:37 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm28833238b3a.18.2025.08.12.01.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:31:36 -0700 (PDT)
Message-ID: <e9c9005f-dab3-4bed-999d-9a7563f5f2cd@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 16:31:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
 <20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689afbea cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=FKzoDJ5KnSRyQqape44A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Ri1HTwFH59Qkd7KPDI5WpmTd1SEwsqZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX1I7u+7lbca8L
 M6Xi5KyNiwoXWJHc0XpCp83SPAteC4aFRRj7dsRXXLSVDXCfR3UY9GIHG3q6s8981t+AitsA/Mn
 UulKPRJRiU70u7Q/tqCHq34lmMZhq2SXOIpGuFtgWCrFUy4mDXn9tRrM1f/HKoiNUP7SX7zk8DQ
 D6/GJ8QmZ5NP9IUimYHwvwRw36Lynj2BdQbuf+ivm3c8lPSPL7WwA7tgIJIFkKEzDV30K9aEEqL
 MFDwcjtjKiiEYhaobGUNoylHt1ciVTnonEmHMEueJl2ieWtNw33kgJLC7YVB+HKOdtf76LWKTPm
 9C6mfDSTkDZIY1wWT1iNxuMUihc9deQZqCSWw9zjvsl9Nfvef0GhPwQm7eW75vhthk+ts5eyVk+
 EptgTTQ5
X-Proofpoint-GUID: Ri1HTwFH59Qkd7KPDI5WpmTd1SEwsqZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015


On 7/25/2025 6:22 PM, Ziyue Zhang wrote:
> The gcc_aux_clk is required by the PCIe controller but not by the PCIe
> PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
> be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
> gcc_phy_aux_clk.
>
> Fixes: fd2d4e4c1986 ("dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index a1ae8c7988c8..b6f140bf5b3b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -176,6 +176,8 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>                 - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>                 - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                 - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> @@ -197,8 +199,6 @@ allOf:
>             contains:
>               enum:
>                 - qcom,qcs8300-qmp-gen4x2-pcie-phy
> -              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> -              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>       then:
>         properties:
>           clocks:
Hi Maintainers,

It seems the patche get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue

