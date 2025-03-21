Return-Path: <linux-pci+bounces-24357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBBDA6BC9F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AED3A71F4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50268F6B;
	Fri, 21 Mar 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lO/PJpCl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DF78F51
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566216; cv=none; b=AaxPyEn/RvTqG+KUgyTNET76NrnTwqzXR8tJHj1YrccL2Tnb7cgWmwPtghJtkEPEKFe6OZRZMjUdU3IKUhgYgNMDVZIsV8BZ6HkJnyQa7JmuFiDOLqJYgbzQmTnLJ61ZcRE8VFkh+pSIEv9Swh4q97q8OlqDPfnCP2Gp40sXbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566216; c=relaxed/simple;
	bh=ne4NB3gZ6I1uUrWFR8M4TAie5xGzGfHf5c25p2bb9fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Drhw71mg7L8UE3/800uD2yxRZgrfPIYbcIpeLT5jO/BYQItB0sJQ9X8WPyPI9mG2I2An95QkJK7DGP7tgXBNVvcUFV+C49C5b62yFbaEuyv324CgTv7kMGjlug31UF/q7MOrOSlY4lDazhYm7ZQxkwqK52Mk3oQg5l1gTQAF4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lO/PJpCl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATEvf001617
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 14:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rABlXrO/d+EA/FemZvTG4T8Y
	szCxU8QYVwj9/zb8Fxg=; b=lO/PJpClRKjsCCzvlj+u5eNER+cRh1Cj6kCZY9r7
	X5a3SMYE/apIkt0wf6i1Zoaiuz1RuQYaguqLI/dOTTobkjx7PXdEFNLx8ieJ3XQe
	4KiMFpgjse3rzo9Rw/pFz3GDhNVwp4C1uybWSC4PmnUFKaS2ZT3d2FrmaFSp2hv5
	0zacoC8bwVY5mN82bN9Nv/ORT9/PTgnZqcignIQYh05bO5ADTOpB/qv5eZjIDkSm
	RiRSFJfwAnvJibzTxlY26J26TCyid8kY2HQxlzIynacl36ddqJCfSEVrjxdo3Ptj
	EserzgTJosPCUxjuR+0K77EE0kdVPyh8Qe+mV13EKkXH5Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g3sf66yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 14:10:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0b3cd4cbcso211787385a.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 07:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566213; x=1743171013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rABlXrO/d+EA/FemZvTG4T8YszCxU8QYVwj9/zb8Fxg=;
        b=J72kyoJOwEMr2msVdToIgpGyreq9FM9dW6OGMBIRHqAm7eRGmdMwpDSKq67uYDSiwv
         SV81zF8sQTS0yh/VaDVwTEBgkAnWSk8OA8mbx78RX20hMsKW/CahdoObHo+o7lAMMeVo
         EW2TlRwMCV0+EUrEQPtYIjJtKmSLH6ca8M59tcwt9GWUi2WCUo4m9l0VuESsEd2AX3WQ
         H5FJPJ6FDROgoVomWEN7RHcy5k8E/YOD2o+tbAcYJNYAkBcLJ/SRbD6wojST9CKG2nB8
         X/cl9w7Eym+TKMh1Z/itNhZdV6NqCEJmJt18r2k+IEHhnloUF2sQk/RRwmko2TnYYvWX
         PRkw==
X-Forwarded-Encrypted: i=1; AJvYcCWPO8lE1pKShaYxJcKp+H+MMXX61K5xArBKQvSZeKC8/hSvQ7NpQ121y5kNMsIaJ01jLRrc80+qlbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+8aeu8xTBUn2Tl925bW/+23k3jKseLR0lE0cCj28YMtSC5GC
	zB33hlojitlEM0laGkAR0XlJJwLBb4Ontl8tw/mlJlf84IWUKXKffG8ArQ86ezNTfEPfOXXTwUc
	PBb5OgMcLmbh+CHJoHBxwhTXM7DUkzGcjfTVzf0XZw/bZRemkLElZmfzghkw=
X-Gm-Gg: ASbGnctyL5kLteRdJho9XcCx5+sjxMvVVC1j57p2PjQyMhepB/zX/iHotEP9nxuvCVs
	cIpLBGP6HLGRYn/aPi9vdDF1v1NTfOEdkMQG1BCkYn5TRcWXZJ49qzt0qbtbwj0GeE7W6CpyPcB
	jHSJwu6ttIVnXqWTJTIGTIWe1b444tLp6mS9zAfUOAqs2+CGBsQkhuKiQeTTWd/LKXPbO2G6/S1
	SDpK+Lx2P2dfVT3vtStcRSCcYrQRn5hR6MPtVPoadM9ZcNe0W961qt1xfZ+AtP+QpDgvl1rDDaM
	Xe2pflVVnns3oPpej+WpdRG2lEaaqmnHkXDDw7W+/kiarI6nZBej3Pmlg/KKVq8TrXGeAkJXmpX
	+WFQ=
X-Received: by 2002:a05:620a:d8c:b0:7c5:467f:d131 with SMTP id af79cd13be357-7c5ba20fdcamr622376085a.36.1742566213073;
        Fri, 21 Mar 2025 07:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEawjUzzoOOPdXrB4GX6jW7PuG5YFKtC8HWJqSmrI1KdldomofdQxJXVLISONgTpppCxQmwwQ==
X-Received: by 2002:a05:620a:d8c:b0:7c5:467f:d131 with SMTP id af79cd13be357-7c5ba20fdcamr622370685a.36.1742566212608;
        Fri, 21 Mar 2025 07:10:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6510635sm188980e87.211.2025.03.21.07.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:10:10 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:10:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        20250317100029.881286-2-quic_varada@quicinc.com,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support
 for IPQ5018
Message-ID: <ch7lwxgenn6hkvkvejns4buignew7k3fzpxx4zjtqcdrmvsahb@pkg53i5mqke7>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-2-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-ipq5018-pcie-v6-2-b7d659a76205@outlook.com>
X-Proofpoint-GUID: bOAEEe2wfjF8Oy1whz9SDnTkzG3z3IPX
X-Proofpoint-ORIG-GUID: bOAEEe2wfjF8Oy1whz9SDnTkzG3z3IPX
X-Authority-Analysis: v=2.4 cv=R9IDGcRX c=1 sm=1 tr=0 ts=67dd7345 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=rOOs_Go3RH9W65nELVkA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=793 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210102

On Fri, Mar 21, 2025 at 04:14:40PM +0400, George Moussalem via B4 Relay wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> The Qualcomm UNIPHY PCIe PHY 28LP is found on both IPQ5332 and IPQ5018.
> Adding the PHY init sequence, pipe clock rate, and compatible for IPQ5018.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c | 45 ++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

