Return-Path: <linux-pci+bounces-25733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108BEA872A0
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726207A98CD
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AB439FCE;
	Sun, 13 Apr 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MikeDy2o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95277BAEC
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562148; cv=none; b=RWq/q5z8V9IkJePkCNGcC9d8Msso7uHo+7rmkSpFVVkZQzW9Fy2my/ic2TySMc8zVDzdAc+UnZv8aZoyq5pK/P2bej6hviX8ONLHlQlt8lR/+oghvj9FVdUkfcfNlPDBmIUYZ0rXbgvG30bgvGx36m3McpQmYxz9s2WPFu7tRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562148; c=relaxed/simple;
	bh=RB0Is3RsXE4ayIze9bhVA06wlRHIFRumqGpp63ItTVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgeD/s0yT7nfeM7iVlzSLps2f4pY+w9e3F0vCQwqHPVWh6fF9L2gKziq4MosxJI1KRxNUseE5PVfKxJaRHLP2Vo4H0x6LDIxpv9JPGOpCZpT6bEEmG+KgaMboRAQPgxRWSVEd7BZDjkR4Xi9jU2LCWPFdacE+ttpR9Br3wF419U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MikeDy2o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DD9UYQ022548
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 16:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HHDGRlqVtQyxh83zlwnFTMpQ
	Jn3llTrejkQ0QtY9TUg=; b=MikeDy2oM6IDwZvBeICfrVy6g2JuSn1wycCTDOJy
	ewpYcbNKm1lkqdvXr3OCB4shtXjbWN+TBdYtBVgcPSAIi6/zQM4I56WAMY5FjJ4h
	dn7FDu0fQaDrk9cbqdTUNneHMfwnhGAHMRgtP9+qGg0YI2MiVtKSWjj7orm7QRUX
	ZGYJvM8W3c972lOf/HW79X8durgIMCEro9e2RyIRBJM4dT+kPhHllv31StHI1gpl
	YVcdKhNbB2lQZ4txeZXjvuvtLb2NNGTae32ixYaZr6rsvoaJahePKgP/MXwS8FxG
	TttBkWSNZP1X/DghyQqyFoUQgRtCXFdMHmN7mxebRRJ+EQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs12eas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 16:35:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5d608e703so634791685a.3
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 09:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744562125; x=1745166925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHDGRlqVtQyxh83zlwnFTMpQJn3llTrejkQ0QtY9TUg=;
        b=H35D7dpQD7WxoCGhSEYah4nsfd1ld6a7TCA+6mUq0FWDnA6os8GuZbFffre5w2xDNZ
         sDHKk2KH/mEf90MyqVqmOIynfpv23mQQ1OGYqOL9vLBRSIJx9SIxxv0frcJ821RTL2qA
         aETiNMy7wKEoH4S7VuF8pfAhc8hIPd6zYSO8/YsPBZ05Lf15/jFLJfxrQUWGuuiygPlT
         65PJIhNKYb6sHtbixDUDYqlWG6gcokdXBuFjUp9KWiCYZyaAv7NHgsU3i5XSUGgt6D5v
         eYnGFkNDE3axgzspxamyFqkdKPnLkUWsA9XMFHdndwlmgyI14Kk7ZbPQeY2Ynp4m1naO
         jESw==
X-Forwarded-Encrypted: i=1; AJvYcCVrorluVPiisVinVlbgLvIgfmBxwmIMTFDKTTEAwP5HeOTuo+iRRJqPHXo3q2mJfNzJFZ+dnVrJXzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymhtKWRWuqzkJ3BpK/JlEH3sbU0RmNpPYqLjRDPjQBrhC043PY
	Zj5iYDxjbjiJvML0Cy1V0tm1YCTjyZMeLUaFmpZatxOCHCijBEPop4qTrFqbSoegmnIV2KvxE4K
	FCpKVP2hFQ9xl4bs40BcI0qb8Unja1a77cblDUJRyYu9F2b3mvJGDFgOVTO8=
X-Gm-Gg: ASbGncuNwi+lOiBrM8V77wrsZrIPd5UzTh0iWad8QajC2pvTuqqYhV2j1cODd+1upp5
	UBxtEreiBEglV+qJ19O6mnoSPnV0FAN8kEK9HrxPAzG0WoEiVyCExCi+xWV/ZB6BukBrnYA7E0n
	h4fCa0I7UCtmmGQiTAEtgvdN6T8HSYE1U4Hb+9z7eMDBvYfLrUSQOA+6RHoh5bDmYXNSneFdput
	bWvKGCejfgga4P51CalJtUmrt+ISMg0ayWIFyWhkZNx+eht+DpmOM6KEWzj0ardzISx01UCrGVo
	O8wHM0MBRF7Pu0+QMSvJgWLR2qDMqR/mc0sYg6XmMxvnUOAXGyc9e4/yL1KKqRopFE373iNTwSQ
	=
X-Received: by 2002:a05:620a:2684:b0:7c5:50ab:ddf7 with SMTP id af79cd13be357-7c7af20babcmr1365619885a.52.1744562125103;
        Sun, 13 Apr 2025 09:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ2SmFOwzSyR099QmLh/foSM29GY2hyA1aduFy1joD+oyH331vhHReKlrLXjjTN89o+aPFZg==
X-Received: by 2002:a05:620a:2684:b0:7c5:50ab:ddf7 with SMTP id af79cd13be357-7c7af20babcmr1365615385a.52.1744562124627;
        Sun, 13 Apr 2025 09:35:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d23c8afsm888868e87.101.2025.04.13.09.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 09:35:22 -0700 (PDT)
Date: Sun, 13 Apr 2025 19:35:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v5 2/9] arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563
 PCIe switch node
Message-ID: <ethalrlraf4lnaefcmks4buffqfsuxasmfjmajhlz66zoqtzvi@37hh57nbfrmd>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <20250412-qps615_v4_1-v5-2-5b6a06132fec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-2-5b6a06132fec@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=67fbe7e1 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=2cuD_6P_uzM7HzBj738A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: oW2zr1VAbphhttwUgjy3OMUYTQt9jv_M
X-Proofpoint-ORIG-GUID: oW2zr1VAbphhttwUgjy3OMUYTQt9jv_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504130128

On Sat, Apr 12, 2025 at 07:19:51AM +0530, Krishna Chaitanya Chundru wrote:
> Add a node for the TC9563 PCIe switch, which has three downstream ports.
> Two embedded Ethernet devices are present on one of the downstream ports.
> As all these ports are present in the node represent the downstream
> ports and embedded endpoints.
> 
> Power to the TC9563 is supplied through two LDO regulators, controlled by
> two GPIOs, which are added as fixed regulators. Configure the TC9563
> through I2C.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 129 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>  2 files changed, 130 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

