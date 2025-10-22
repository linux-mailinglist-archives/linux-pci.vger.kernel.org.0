Return-Path: <linux-pci+bounces-38969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B207BBFB078
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899FA3A6DAD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B038223ABA1;
	Wed, 22 Oct 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sueq6TsG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50130F52B
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123686; cv=none; b=iHd1tnz005WVtigXwNju3FPzse5p5umK+c2JPwxsWvgEtzLn2qLwz2kw3XcakcSUNuB30FuWOkrnKT17gyswYMirHSLuzSiHnfCLjwaw2z8UdvFTIWaz0P8JSILCl4m+Hn1kaEFFkcgaO6putT309sQrbI+f2jDkYnPyE3SeS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123686; c=relaxed/simple;
	bh=5sCwvusLGqime2/Jy9aXr2cPI9fkv2LkkGeuCX9BmbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1VvOvFZCH742zzheCq06A+EjRGgeyvuAlpPcv2khL4nK2lWHFWTxl245k8jRbz5njLX57Pg8YMJwTCbBdDmyHiT9gRxaihNSOX6Owy66nssHJiYyXvfJOXluWdc325w8jg80A/kjJxl2H4D57fWS+CkPU62SoYsn6qss8+yHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sueq6TsG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2j8JM002360
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 09:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ivByTKhSESO0VcSxSaiYVhLG
	ISoDBO/7JhIXLIxz05I=; b=Sueq6TsGpWeoJOGBcFLsAoEpnNOT5Zb3CGY8mvZv
	gfOPV7k9z6T2f0I4pY5ky6HGf1X3WfGCpYKcwdW3b0oju+29JAlCw7rCH/ZHTvNc
	GeVIh467mrIM7SQThMhMtAX+diha7PqnQq7lzfhdLl6RGLU77jbfu2Y9MNsH3bKK
	LFX+P6QG/ANcyg7YTtLA5ArjjNVXGKIEC7q8sMLP5O6GbCI86mnLZBUG/x7qoxYU
	aO9HyHXoKSu6vOQYriUK4f7K3tzly/Pm+GspcFlmtPu6EgPDS2MzxP5x/t+/6j3F
	WSOJl/FYYfUlSJzXQCAikJHggiJmwnvoV9ZRJj6q2gum8A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w9ky1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 09:01:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-792722e4ebeso6136226b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 02:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761123682; x=1761728482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivByTKhSESO0VcSxSaiYVhLGISoDBO/7JhIXLIxz05I=;
        b=Qs2fY1YqxdeKQQehpZz+ksSOiPPLyfay3s44mXRkTyFdHlP9EYqnAvQx4JDbPVgzNo
         bDjAQIufBd/WJs/EOiaWVI4VB7ShddUqmjXnZB9awypxnOW1nx7bYAzye6oiActO/Kld
         WTR/9wzq+jry/h/MjFJwtmM4MikrO2tyqSpdZwsjxmQ2e9Sy8ozZ7HX6bwgPqV30SgD2
         J3bC2fvR4W1FQeqH6IoaVL1Dcc+xTyKlEhRy7TqOTtcpWNkrqIf0GlH6EuM7j/6NhYq0
         BQPrT0tsol1bNOXnU+kSBnMByAzJS7zX8w+RMqxVqW1Qk8kkKAPEWiy9rM5Sw0BRFrXl
         nK1w==
X-Forwarded-Encrypted: i=1; AJvYcCWffgwH2utgKvTVWAo57jOVaQtnNpMNSl4tpY8VMdLi0r8byzLb1QpqrrdkIHLG7ogNZPLczdK4b6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4viejz7KWXGcvU8o3CFAGO/ryYytIjqdQEVF7Z/78f/L/cOT
	SiTSzeER+/kjtq6eCH/wx/DA4czQbeTto6KF8aJl/T5dU5ARCyHWx0gimYAHY5BOXpjiIeAWRs4
	HylVx3+OlgADNBNjdWa+x7TNAxLW2TIPk08oxUNotak4RccRSQiixDhYFKrSoxIM=
X-Gm-Gg: ASbGnct0rOImEE90Fpe+0ODyShh59fHUrz9exsugi3MDJhQoxTSTNdibuu2GfMGVdMd
	zzESFqmtO90RRVvpz7HE3DKCmp5mhm+WOz03kOAIHoBFlp63Fh3AqWjbp/FxJeYbT7VTvikzvWk
	aFbpvLf8+V6R4htWM+ji8uBLXCIO5IQRtBf2n4TxUMOlSrT9ke9ibL0aMi+U8tIm3TvWire57nS
	Zv7z9SDGF92Xzsc9ACOVN38dvAYbFHNklS8yg73KJWOkMXORXrzZ5Mv1pHDtZSTYrMMsLJGFJIp
	ZJl1drAccZJsbdI1V0YS6RQfL6ii0VvFJLhNprUPqytOqNnmma2bmtbyYRgZ3sVwmJPxMFi26wU
	oRQ8AY6oXBhtxvHyJ/Irn/yf1IKCCV9/ORSZhRunO1yWVOg==
X-Received: by 2002:a05:6a20:72a4:b0:246:354:e0ff with SMTP id adf61e73a8af0-334a85242b0mr26308733637.8.1761123682252;
        Wed, 22 Oct 2025 02:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrlAYEvjmvObgyZJEcggou/JfliOLpgFt5Kg0VJQSp8IlUPjr3+XSTnue892eZTAwBzkWAUA==
X-Received: by 2002:a05:6a20:72a4:b0:246:354:e0ff with SMTP id adf61e73a8af0-334a85242b0mr26308680637.8.1761123681758;
        Wed, 22 Oct 2025 02:01:21 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cd9005e2dsm2273885a12.9.2025.10.22.02.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:01:21 -0700 (PDT)
Date: Wed, 22 Oct 2025 02:01:19 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH v5 6/6] phy: qcom: qmp-pcie: Add support for glymur PCIe
 Gen4 x2 PHY
Message-ID: <aPidX8h5z7/A059s@hu-qianyu-lv.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
 <20251017-glymur_pcie-v5-6-82d0c4bd402b@oss.qualcomm.com>
 <rxju35izazp7zrzs6vyy2cxuynzc6k4i4iot5pjahwl2bfoka5@cutpfodvixmp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxju35izazp7zrzs6vyy2cxuynzc6k4i4iot5pjahwl2bfoka5@cutpfodvixmp>
X-Proofpoint-ORIG-GUID: xTxPTUUzW9WbPS6fT39SjlzBOpyYF7dI
X-Proofpoint-GUID: xTxPTUUzW9WbPS6fT39SjlzBOpyYF7dI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX6EHmLMOpEHI7
 e68pdo5YmBoBrHsnGRIlaJQhImyu3NAAo4Uq1ey4MKjRjXYMBJsYrk9qy7Xc2EGaUpRc5TrgTAw
 rCy+Ilp5zPi+OrfnF5mnWRxinZSs9skRZJQ6keEIY17IkrVrMiPqI0fVmFyLbOqFRYmuNLK717Y
 3xxbtqAysDnUp8djvne3xqODVCnYJyN36OoQcBoUaXHUO0kleFEflQs1aQy8795/O8Zs4evMiB1
 9Zg3ZpKmYxLJqQd02oAPHLkenUb7ua+KZqYXPAkr6RApY3GG0F0ojhhAdnfc1GEnRRmnb0ZjbGC
 UZxF7dVYes2V4GjZIEznv2mHhFYA0u6QS7CE6rgqh/pLe5IxZVJOlg0ax/vbA1YD4G2XUD79J/k
 qtd//l9S8c4lKMYUKdDR0o7pE1v4ig==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f89d63 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=YTQ-dMB4pklsVi_CFI8A:9 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On Wed, Oct 22, 2025 at 11:53:01AM +0300, Abel Vesa wrote:
> On 25-10-17 18:33:43, Qiang Yu wrote:
> > From: Qiang Yu <quic_qianyu@quicinc.com>
> > 
> > Add support for Gen4 x2 PCIe QMP PHY found on Glymur platform.
> > 
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Since this is something I already sent upstream here and it is more correct:
> 
> https://lore.kernel.org/all/20251015-phy-qcom-pcie-add-glymur-v1-2-1af8fd14f033@linaro.org/
> 
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..2747e71bf865907f139422a9ed33709c4a7ae7ea 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -3363,6 +3363,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
> >  	.ln_shrd	= 0x8000,
> >  };
> >  
> > +static const struct qmp_pcie_offsets qmp_pcie_offsets_v8 = {
> > +	.serdes     = 0x1000,
> > +	.pcs        = 0x1400,
> > +	.pcs_misc	= 0x1800,
> > +	.tx		= 0x0000,
> > +	.rx		= 0x0200,
> > +	.tx2		= 0x0800,
> > +	.rx2		= 0x0a00,
> > +};
> > +
> >  static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
> >  	.serdes     = 0x8000,
> >  	.pcs        = 0x9000,
> > @@ -4441,6 +4451,21 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
> >  	.phy_status		= PHYSTATUS_4_20,
> >  };
> >  
> > +static const struct qmp_phy_cfg glymur_qmp_gen4x2_pciephy_cfg = {
> > +	.lanes = 2,
> > +
> > +	.offsets		= &qmp_pcie_offsets_v8,
> > +
> > +	.reset_list		= sdm845_pciephy_reset_l,
> > +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> > +	.vreg_list		= qmp_phy_vreg_l,
> > +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> > +	.regs			= pciephy_v6_regs_layout,
> 
> Definitely not v6 regs here. Needs to be v8.
> 

Hey Abel, please ignore this phy patch and dt binding patch for gen4x2,
Krzysztof reminded me you have posted patches for it.

- Qiang Yu
> NAK.

