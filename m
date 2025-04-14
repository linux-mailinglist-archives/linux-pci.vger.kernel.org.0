Return-Path: <linux-pci+bounces-25797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1083A879AF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943EC3ABF7C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2EE1ACECD;
	Mon, 14 Apr 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBHAiRM7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5261B424A
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617795; cv=none; b=JYf//bBhBLK2E6YvIM2TgHnOwNsLExW1bRqfgnlIplOcPfYc4ohgxbIPCnnRk5/2a2lGaxd3eHJ1BoIMfgS/bDuCtQwjBp6kJHv1+rVL8beUvDWvexE21vVyeJsuNCXSGlQt2vQTR9F+BvzkKuLZFR1OnWAIxZeRCcJb1rC/jts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617795; c=relaxed/simple;
	bh=uph4zHoLG9oMayUKP51V7Ui3CVrfNf+hdd0i3wJU+DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZBSyO8bp8VOuarS6X/h4hIzzr1F9uE+8IPzepWYl8Bs/hGXsI9obGxRiWC5igcJO/b1XN4B2udQqIx7FAhaVh0xuoLPSmxFojOOyDN4fJptRZO5+ST3sIKOO5AYuBpgkRrrhFl4SgIsz74FRme78UMuetlOGPi6EDqPl9tgSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aBHAiRM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DNwnIN019504
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 08:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EiwHhk5vFVCbL/7IZb2Z7mJo
	tSciivUHSnNHCf6n2sg=; b=aBHAiRM7Q1VfL1y0K6s3z+x/5ZKAsAY9QlbSd8aC
	iSd30+jetXyNpi/691BqB/PwLpKDQN+bfF5wqA0zU3pLQpj1rmoS2IZXDFBxA/Bd
	eauPqAO1Pe/YZDPATzcvLVY5Bl9SpJqgsN6YmNVhugyyJi/jFkZeVXZaPuSjW5sx
	oHMMDsDWKytXXloFN2OALp80xj9Wj8NX06CYtrU9IV7IgT+oNmw7QJlqgFPwnPmB
	BpvFDqpuEPRF5giNDnF1yrxE3+174py2MJfShAcEKKtvvzdXVa8fDvqVj3mBzheM
	vhlOjbTq9n3qvzgP1t9jE/SXcd2hxZlJtLi/HIpN7SZveg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6bsjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 08:03:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5d9d8890fso900605385a.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 01:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744617792; x=1745222592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiwHhk5vFVCbL/7IZb2Z7mJotSciivUHSnNHCf6n2sg=;
        b=G1ekbXlhWxJ/XfsbfHQ5d3IlfjsLaFFI34+deH99aj/B4qjVu5A3hV3tBZ564WTuGV
         +y15D2o4LwAtxvnvAy1Ks2oqwbgCUKXhwPQdPHerVkrPfU+jUJP/xzuonT1Rpy+jnefh
         TXNAq9J5ubYPH4euGlBuZktuZw850oRZipV9qyqL3Ukm45C1fIkpnzcbPcKFsOWCyw/X
         4ops8pueMFFHBUumIZ30EglHgJu3NR2+roZlZSOu6xWmQeRlISEKAHOmjM8K76kgVlpw
         Zvfy8UJIaZkGwLEyDdA4H/LbJOQDYRC3O2m/O5kNA98UOZdontZ5xDy7YQmG4YbzGoFH
         gVGg==
X-Forwarded-Encrypted: i=1; AJvYcCUT3nSkWZ0ZwSssIEivvKf+9zgaOjwh1wQ1b++x7xKWgrNGoFZS4ww26T8thcTkqB2YqA7M+lb/R6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Uv442XNx6EKDGzXtWBwpVpeqf5QuhilgXl0WDqzhl5Y4Svr5
	f12tVseeWjXIjdypMDTKQn6lapCkv3B/8+EwofSjrtpmpohsRByn8PL6UDZN6ydhI3ql1fHhP90
	Sv675BCI5a83r3Zj4Gn+aDh13f6m9wI8FYDpjY6GXJ7L6QwSJd9EE+5T8Jac=
X-Gm-Gg: ASbGnctgodNulGw4jQoMXMlnJww6REYwOC2a1xehl6YyxVOx54HV5MYZHOYmssO+hOO
	TWyxEK5xkTYUsJR0PU1W+fcaqb05h5MZO+ZvUd+Ze2BOgGL/zuNnnD4UNKMex9yK0BeT1eiliJq
	X9T2Jt318X8GRYuWEDkepa+sGpJr0K9+GhGJqRU/sRcDf9rmzdSl06bi8egFlAkJ3p2xZ3KHFyu
	Vc7BzREOtxVlZl7qLa+S56G/DA74/Yr0V+wrXNBGoMKfjL3O7Gxy7C9AuEdGdSCCCOWMu+CenOU
	KHC1WODV696wzauFZPB+IBIH5+gA4AUfKISlr6M7BRI0KTbEjTejrGwdPAuwG9WZzN/fueImziA
	=
X-Received: by 2002:a05:620a:d87:b0:7c3:b7c2:acf6 with SMTP id af79cd13be357-7c7a7675c27mr2162278785a.15.1744617791952;
        Mon, 14 Apr 2025 01:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESZN07wYmkacvSwp8lFk2vRdDEFr2/a3rzDrW2cfKAF3hpIHMbwXYQcEMnw4snP4Wfu7vADQ==
X-Received: by 2002:a05:620a:d87:b0:7c3:b7c2:acf6 with SMTP id af79cd13be357-7c7a7675c27mr2162273685a.15.1744617791394;
        Mon, 14 Apr 2025 01:03:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d521931sm1022102e87.257.2025.04.14.01.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 01:03:10 -0700 (PDT)
Date: Mon, 14 Apr 2025 11:03:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
Subject: Re: [PATCH v2 0/3] PCI: qcom: Move PERST# GPIO & phy retrieval from
 controller to PCIe bridge node
Message-ID: <b5ucd2ypwk3qv3pl7cij5geg6e2bt72xqb4hx3yvpei44wdc7c@ub5cujnfvz3d>
References: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Dz8PVaciflJp3NcJmk-v0NVSHjrcVbyh
X-Proofpoint-GUID: Dz8PVaciflJp3NcJmk-v0NVSHjrcVbyh
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67fcc141 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1xens5CjvSCak2KtytIA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140057

On Mon, Apr 14, 2025 at 11:09:11AM +0530, Krishna Chaitanya Chundru wrote:
> There are many places we agreed to move the wake and perst gpio's
> and phy etc to the pcie root port node instead of bridge node[1].

Which problem are you trying to solve?

> 
> So move the phy, phy-names, wake-gpio's in the root port.

Is there a reason why you've selected only these properties? Is there a
plan to 

> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
> start using that property instead of perst-gpio.
> 
> For backward compatibility, not removing any existing properties in the
> bridge node.

'don't remove', rather than 'not removing'.

> There are some other properties like num-lanes, max-link-speed which
> needs to be moved to the root port nodes, but in this series we are
> excluding them for now as this requires more changes in dwc layer and
> can complicate the things.
> 
> The main intention of this series is to move wake# to the root port node.
> After this series we wil come up with a patch which regiters for wake IRQ
> from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
> the host from D3cold.

This should have been in the beginning of the series. In the next run
please include the functional change to prove that this is enough and
that you won't have to restrucutre DT bindings again.

Please include the note about merging order. You have to mention
explicitly that DT bits must go after the driver changes. Ask
maintainers to provide the immutable branch with the PCIe changes.

> 
> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v2:
> - Remove phy-names property and change the driver, dtsi accordingly (Rob)
> - Link to v1: https://lore.kernel.org/r/20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (3):
>       dt-bindings: PCI: qcom: Move phy, wake & reset gpio's to root port
>       arm64: qcom: sc7280: Move phy, perst to root port node
>       PCI: qcom: Add support for multi-root port

This order of patches suggests that one can merge DT bits before the
driver changes and that it will still work. Is that the case?

> 
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  18 +++
>  .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  17 ++-
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   5 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |   5 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |   5 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |   6 +-
>  drivers/pci/controller/dwc/pcie-qcom.c             | 149 +++++++++++++++++----
>  7 files changed, 168 insertions(+), 37 deletions(-)
> ---
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> change-id: 20250101-perst-cb885b5a6129
> 
> Best regards,
> -- 
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

