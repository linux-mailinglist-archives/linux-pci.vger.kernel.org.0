Return-Path: <linux-pci+bounces-23284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA9DA58D98
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4050B188C46C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44032222578;
	Mon, 10 Mar 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O+JhHgCm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4884E1C;
	Mon, 10 Mar 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593901; cv=none; b=UmIicC0pOtA6EDga3tQbBIo0fcecYp9DqlbkRZbjHEuLwB2QtSiy4/AIhWIq6dt64RtZ0RJ3pDm7cj/0de3R8AF+SGL5yjn2uPJpUX8b+HU+ODwX6+0BBD4e4+tJsFsevi7p9RGT11eA2p8M0zuLQm4R2Gww9prtDdOffiKv6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593901; c=relaxed/simple;
	bh=4mna9gx6YJNHD8io2U/X0fGSjiIJ8v0rGRez3OnksDw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjwF7oqiFm7v10VRhhjXD6BrV/n08ywwlC2rcijejJSOPXMkb19Gl4jQ+jOs7tX8BxnjmeZCJx0Z3uEy5kxlbU0MJ3sQI8eXiNXbFyuxdzgRSP5hGE/tEFb+Vv0PrZGSB3f4DG9g4JvbQDvxNUuGE7dCEM7FkJ27uAvxlfYQYvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O+JhHgCm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529LpadC006993;
	Mon, 10 Mar 2025 08:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cxXyU/CPeeLRRBEPGXldrDGG
	Lm0McpIWpdorCRx1eXc=; b=O+JhHgCmruwm7qdKT+oHryqG3/JmAmyLJtLo/pV6
	yaonT8eoEN8Azqf3gADtqOYzqrDpnBIUruauuSMRZILKuMz3kUsZ6h+gPjIGJUnG
	/J/EzOL8u/0ji1xX7pKEQSpCz1JGeUhfF3JJG9jDtDuU41EVU0TnF6izA+53HTJF
	Qq1FxcNwIeOXLVKfK0Dy1QIjXvCTr1bV0Uo8yodQlsxa3PeTdedJ+JhYjyoWyjg6
	7KSXK54PttD5ju/A6nh64vKTN9CDd66VoYit2g6/Q8Bl4//KLHvMWvpX1srXSFNf
	QFg7TiwV2ltywiioK0hg5kXqFjAS5rLaqb2eMtGmSCqejA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eypbxsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 08:04:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A84dwF009403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 08:04:39 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 01:04:33 -0700
Date: Mon, 10 Mar 2025 13:34:30 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v11 4/7] arm64: dts: qcom: ipq9574: Reorder reg and
 reg-names
Message-ID: <Z86dDutB1NnGTjRt@hu-varada-blr.qualcomm.com>
References: <20250220094251.230936-1-quic_varada@quicinc.com>
 <20250220094251.230936-5-quic_varada@quicinc.com>
 <b3d7374e-b144-4b0a-96f8-0538f9cd1a39@kernel.org>
 <d21a6d94-d2bc-44fd-bf40-097bccc11930@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d21a6d94-d2bc-44fd-bf40-097bccc11930@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=A9yWP7WG c=1 sm=1 tr=0 ts=67ce9d17 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=5j2EdkbW8jc13NUVTY0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: RrqEkNB2PdSXsQz5f1uve-Gotl7HL6Fb
X-Proofpoint-GUID: RrqEkNB2PdSXsQz5f1uve-Gotl7HL6Fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=695
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100062

On Thu, Mar 06, 2025 at 12:56:02PM +0100, Krzysztof Kozlowski wrote:
> On 06/03/2025 12:49, Krzysztof Kozlowski wrote:
> > On 20/02/2025 10:42, Varadarajan Narayanan wrote:
> >> The 'reg' & 'reg-names' constraints used in the bindings and dtsi are
> >> different resulting in dt_bindings_check errors. Re-order the reg entries,
> >
> > Why?

Initially ipq9574 had 5 reg entries. ipq5332 has 6. To be able to use ipq9574 as
fallback for ipq5332 had to add the sixth entry to ipq9574. Then it becomes
similar to sdx55. Hence to avoid duplication, changed ipq9574 to use sdx55 reg
definition. Because of this the erg entries' order changed.

> >
> >> fix the node names and move the nodes to maintain sort order to address the
> >
> > Fixing (how?) node name looks like separate problem.

Because the reg entries order changed, the "parf" register became the first
entry. This resulted in the address in pcie@xxx to not match with the first reg
entry and this was changed. Since the nodes have to be located per address sort
order, had to move the node to an appropriate slot per the address sort order.

> >> following errors/warnings.
> >>
> >> 	arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pcie@20000000: reg-names:0: 'parf' was expected
>
> How can I reproduce this error?
>
> Isn't this error which you intentionally added and now you claim you
> fix? In the same patchset?
>
> This really looks like breaking things just to call it "look, I fixed
> something" two patches later in the same set.

True. But had to do these to have ipq9574 as fallback compatible. Have asked for
suggestions to handle this better. Will follow the approach that is acceptable
to the community.

Thanks
Varada

