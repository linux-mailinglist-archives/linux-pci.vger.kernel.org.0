Return-Path: <linux-pci+bounces-20218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CADEA18B32
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 06:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A91E166129
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07A16D9AF;
	Wed, 22 Jan 2025 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iARnmKZL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52A145FE0;
	Wed, 22 Jan 2025 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737522369; cv=none; b=aUJ+68oAjwvxygAcGhoFueQk0UZdYnxkAXkkMVA3/r8viX3uF5ZD2JWiZKmG74JG4sky4V0B1e51tkrIkX1JKNp20CeRSbgR2zl1uR16E8e4M5TopbABgwr+szh4dFovBNWWWcnphVIX30oRVaDFQF7JxorpNv/8QjaBrlI0H0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737522369; c=relaxed/simple;
	bh=nb22825QFNEkhOCsR1NR/Ib2yPm9c3o3bPSvGpyZNCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8A8GIuebUSz/HYMX/eQjL3Q0hrFpGoQyReCdtMwGcKs7cieeNt9hXHUrV6oHLPbZqiNTFZY+v2OR83WcZMPj0O+k3/V/2fBdyyl3jQwCei7KiiTvv6oZ1gfU3XYSfHYiyMdfEjh5FXs/OdXgH1IA++dxIt84liGF2Yvig0ZuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iARnmKZL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M0Qc5I020788;
	Wed, 22 Jan 2025 05:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zYIHAH5R1aSelCOAD4hlVuK9
	eFznxUklk2/oBlWIOFY=; b=iARnmKZL3UeDHZLZe36jcw+NOYpfExuePqfpYgMF
	AHS+mCOgRiFac+pQMo5aGxjgn3R+X/x3eYtGe33TG5q/FGKgx4VTXxyQXUrO0Nhf
	R3CRU5IjsbvobHYdadAGSrr10B3RwZJumEj+0CBHurREWiMe+l+oGnhl6gvR5Zwz
	3ldEZhkDsHPhhM/TL0kNS1GaPB+QlsSFNMrqiDnU8l8Hh184/uyyAQqdJsZrATdC
	9aIJsUKq0NbFgH8xV+PV5jv020JcDuZ9naJ87UqM8nlP2NeuJwSewstpmxUvOGQk
	xO9ySVvIZCfyBEqORsz25qdOpihQGwbmkVxvc4VAkQK7Ig==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ap4x0h58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 05:05:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M55oUB014124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 05:05:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 21:05:44 -0800
Date: Wed, 22 Jan 2025 10:35:40 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <Z5B8pGD/h0h79ykb@hu-varada-blr.qualcomm.com>
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
 <20250102113019.1347068-5-quic_varada@quicinc.com>
 <20250108132235.gh6p5d6t7wklzpm7@thinkpad>
 <Z4Cjzc5nyOv0R9tS@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z4Cjzc5nyOv0R9tS@hu-varada-blr.qualcomm.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0AXiHTq6cbtqOThPNwBcaD_A5SDBYw5C
X-Proofpoint-GUID: 0AXiHTq6cbtqOThPNwBcaD_A5SDBYw5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_01,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=733
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220035

Manivannan,

	[ . . . ]
> > > +			phys = <&pcie1_phy>;
> > > +			phy-names = "pciephy";
> > > +
> > > +			interconnects = <&gcc MASTER_SNOC_PCIE3_2_M &gcc SLAVE_SNOC_PCIE3_2_M>,
> > > +					<&gcc MASTER_ANOC_PCIE3_2_S &gcc SLAVE_ANOC_PCIE3_2_S>;
> > > +			interconnect-names = "pcie-mem", "cpu-pcie";
> >
> > Can you check if the controller supports cache coherency? If so, you need to add
> > 'dma-coherent'.
>
> Ok.

Confirmed with h/w person. The controller doesn't support cache coherance.

Thanks
Varada

