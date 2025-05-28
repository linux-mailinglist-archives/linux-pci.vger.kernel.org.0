Return-Path: <linux-pci+bounces-28484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506DAC60D7
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B753BF7B3
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215C139D0A;
	Wed, 28 May 2025 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hKj+9jHe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507A1C8604
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748407834; cv=none; b=Mlb2kWl+HTLX2EBgU51H1IGALjR0jfLf+I6kAqS6LR59UPbZaX5+KUSC+ZzgTs6FcF84R1qGRPovrGp3TYzOTJVhw0+8pi8hmG8nFN5pZmNe4Se4t9Xxc0jwWyo1alBECPMFMhHbfsbeRvxynD4XV8ZLaSyETSd71XTeqJTqvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748407834; c=relaxed/simple;
	bh=SZWThzxP/87c9R8Huv4SM4sfI7oqi1K0BFXylxM1JU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FB9ZkKE/XXJ4NQn4FRiqrMsEWH7nxcs/VFhWKfsPNFyOYMpIeQfVxHggh0FkA/w5U+bRFNKK9ClTIZtJ8ASNkgKc63vkeZ70NOmsR9J7O9Ds6/SsZTJ4daqKCtsr7X8xv0a1IjGeGriB17Ttz4KEc9caEodX4A0054Xwmlzj27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hKj+9jHe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RGebRM028066
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C371pGRBLlC9/Ts/1/jUakLqagSQGyt7TnsvkA6tdNk=; b=hKj+9jHeGOhW/Gks
	yXFQh9JQ/nI3lxr41HFcgwujHhEbY4VHaT5BN50hK4Paak/TjehifWN25MryCa5X
	EDWNK6aA5kIdiAAVQWoy+BgHq4m0LlGnUbLUfG7ypazFT19F0gdqeesUoFgQa3A1
	qmBCOqZIRPmIVBaTly8I/j0bS8T+S9IRLSeYNEq8H94llSluD0Xy9f/EO2uSQgMs
	+shH65aJyhTgowiW6MTPzOQ+QWzO8QlcHoq6Z0MDSCQi9TMcqVHw2VxvSqzjXJpC
	JCaJcXAZap1X3E0zDr4OfmziJfCOBOSCFC/HZpewM4EbU5IrgH58Uol2R3IqFZh2
	+KmVMw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w992k2vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:50:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-233e462f57fso46889625ad.1
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 21:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748407831; x=1749012631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C371pGRBLlC9/Ts/1/jUakLqagSQGyt7TnsvkA6tdNk=;
        b=Y4V9MDw8iV8UKnOgJmrdoAcJB8yqCNEhSeO8JKSZTaTmL055k4quo+RCUzQtfewl8V
         wNbxJpjng9E92e6Tzm4JR4tEQIasUs4+4lJulUmcVCwN+RoBqVxJRCXal2DmbsDZmd5M
         HD740EslSMDbryiT9dFJEbItW6kiMZbKeZCLFBcMub4tlUWLpV4pgyXhZy9mZOeKzYbe
         FZciw6yKst9qpoUVQhWSI2tO6RVNpsedYOZmd38Bd9GTGQZAGVfl3gtDxaMxquTtr6QX
         EPmBjLMMQkskFaGWCDM9wycyxkOqL7bgHJ/dH+bQyx6mGGyDIokAduvxYEB5pbyvtdJ1
         QFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtSvs7G6k6qNKXMvKEy4eZm9PeCQiah6N2mKlY8UWGz3BI4X3gD1r0Bb0sxA8I3wQVhBcP5QqbyZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67TX38esXATwOJvEFxVDnEcI+3Lasws3uj8CoRZj+oGdhuPHt
	TEoqL7FeM3LumT/jhzL1wtJhZ0pgvSGyM0gwYTeTXvqwmgRM7lQAsRU6VEJrw1Ra+9XYMUnURXE
	LEfZImuKEnydqMYyKKn4p0GBHVkmbU99OP70gvPd5/PRwJFlzyYD6kHV64Fb/wWM=
X-Gm-Gg: ASbGnctBaIU0UBOhWOxxlZG4BA9g6/7LwrFX8WJ4ydJ+1LeXG277KHmHZaOkfmB0Nyk
	h/UaIYEVsnaqVOHrVX3glYKBHExTnNfK/Rz0I+mhBeanh9UVym/L44Hs4JA2CWdVkQR1G9u6Raa
	vXYLfEPiASsts51pBgJkFSM5h7BR44dAoQ4lvqdp/rQCWAZRMcmrKGa/xlvc6b5VtGsWmJzMCqj
	xZbzT/EsvhkdhRfomzHuAxlxm5LDe70glOnUJPAglR9aisOMPksT9YvXSPQWyovbqXqCNjRwiFk
	mTp6nUHdP1bRulqSNkQCq2BsVkqVkV8UHvwNs8otHg==
X-Received: by 2002:a17:902:f54e:b0:234:8ac5:3f31 with SMTP id d9443c01a7336-2348ac53fd2mr99050895ad.23.1748407831008;
        Tue, 27 May 2025 21:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN9b4dZ+vQIgVSTiIeC0tbTS9PKLkg/kjNaPF3ZRn8W94d6lAt9Br08fffh0W92jG9c6SL4A==
X-Received: by 2002:a17:902:f54e:b0:234:8ac5:3f31 with SMTP id d9443c01a7336-2348ac53fd2mr99050685ad.23.1748407830642;
        Tue, 27 May 2025 21:50:30 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fd229dsm3131465ad.34.2025.05.27.21.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 21:50:30 -0700 (PDT)
Message-ID: <e840e6b6-f2c1-9e85-bfb3-fba1471dad32@oss.qualcomm.com>
Date: Wed, 28 May 2025 10:20:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] schemas: PCI: Add standard PCIe WAKE# signal
To: robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, helgaas@kernel.org, krzk@kernel.org,
        manivannan.sadhasivam@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        conor+dt@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
        quic_vbadigan@quicinc.com, andersson@kernel.org, sherry.sun@nxp.com
References: <20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0MCBTYWx0ZWRfX4B4vE/cn874K
 Ic22S8jY9jewnRGXO6zXefJdy3VHUxsViuj47Dz6TpJpPjlyqdJ4JJaPbXgb3tC5FLYA8TI0Hic
 i0F3FPXdCVslRHohkQNuwBrw5+QVQoPGwFlNeG40JBG1oC2Ru2RdisJyhsbXcpGGctgHGRYY4pZ
 EkwKDl2npBW27Br4VdLxivLh/NTRdmz/AdfFS7UOM4eGQO39QDQZUEP60euQRVzwzys26JzhTMB
 5OBSNTfNb9dTQjXwMhe7ilaWX9BHjLwZhI2bQ3bTA3NQend8FsRqytN3ZTUD+4d7Mnu66cwt/5R
 0BgqoZ/gT16mzw5mAv5ruUXO3jy0c+xYn9XoYavmzP9Dqr2JF56Dt8LbNowIqDXQ9bJXisjX/Tc
 iJBuRKxuFeKBnllZI4JRkIrqoEOQSkSo1NaVce3rt8kQu35F+qIvbiehKbzxE8YQ3D/EUSPa
X-Authority-Analysis: v=2.4 cv=Fes3xI+6 c=1 sm=1 tr=0 ts=68369617 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=8Attb8s4RaY3mnNPeTUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Op9LbfnXsbpCwzq3LzcOrLFyCwNsTEjb
X-Proofpoint-ORIG-GUID: Op9LbfnXsbpCwzq3LzcOrLFyCwNsTEjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_02,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=820 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280040


On 5/15/2025 2:35 PM, Krishna Chaitanya Chundru wrote:
> As per PCIe spec 6, sec 5.3.3.2 document PCI standard WAKE# signal,
> which is used to re-establish power and reference clocks to the
> components within its domain.
> 
Hi Rob,

can you check this patch once.

- Krishna Chaitanya.
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   dtschema/schemas/pci/pci-bus-common.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> index ca97a00..a39fafc 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -142,6 +142,10 @@ properties:
>       description: GPIO controlled connection to PERST# signal
>       maxItems: 1
>   
> +  wake-gpios:
> +    description: GPIO controlled connection to WAKE# signal
> +    maxItems: 1
> +
>     slot-power-limit-milliwatt:
>       description:
>         If present, specifies slot power limit in milliwatts.

