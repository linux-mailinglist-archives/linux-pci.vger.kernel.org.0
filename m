Return-Path: <linux-pci+bounces-23282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA711A58D2C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3197A3938
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 07:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849C221F20;
	Mon, 10 Mar 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ePnHMrmY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08453221F24;
	Mon, 10 Mar 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592704; cv=none; b=sNfdzBPPzO9L78wbesW65abtuPtzOKNwpMF10K4A8jvYtQSr9/FSoo11hMsHNDkySwvJjs4akxGy9MYRSb6j+Fn4SbVS/vl6ws5qD6m65v2nBGzKP8s/6zS9sr7HHK1h7XX7Y70BylML9lyT/tcbWNUt0hEBfHx5WxpVhEZ4MvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592704; c=relaxed/simple;
	bh=i1ZR9sGKO7nVQ2pJs+9N75lDoKQYGSjRkjYZ3oqofx0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPDnkGTZfBaDIdP+nBJRvtagKMXeI8ffB0eUnWFgkTYQAmfwMeSGJ+47u0jlxqayx0xOxpuyDJy6Q3nxLDvyKfPck+TkjeeHCxRDg/WxCtpR3S4vJsSUV4w8nGxR8Nk0AJsG0yQ1omLq/srZIutCnAPXVQg5x1cY8Jr3YEWxz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ePnHMrmY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529MgpOc026525;
	Mon, 10 Mar 2025 07:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Kj+FcVSY+eBJxVSNZlJRNzZJ
	m+ebTIDlOJzCtE3EAtM=; b=ePnHMrmY+dGNZTh/jYCIa6BvA8CPNu+5Tc2CSWC8
	bM4E54AmLJAXC6pJLjwk9gR9PWiW0tmdWswWPdQnK2x4tqnOMRxeOrtBxiEc2hsw
	4GJ7ZNK6VEKCfTKs7B+EDj+3IicOlrGmZklG8J+i8oLXev9J09+Ya7b5Tq9ASolB
	uNZavBoLW4SXlWrfXRQQQw8AX5CgXPAV80DMM/v9Dtsqk6IXsj0o4LTw1XEjKY8e
	GbJ/awRoxkb0NPasADPfjBPH5kk4Vxe07fZMcHAEwEglpSrQTDjQVKgKQfNo1cLb
	GcdvHDr9s5QB7yXj4nhOHGEoohpGYUyvd2GZGkRXGIUSQQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f2mbwxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:44:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A7ikPs025363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:44:46 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 00:44:09 -0700
Date: Mon, 10 Mar 2025 13:14:05 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 3/7] dt-bindings: PCI: qcom: Use sdx55 reg
 description for ipq9574
Message-ID: <Z86YReHsKeF165F6@hu-varada-blr.qualcomm.com>
References: <20250220094251.230936-1-quic_varada@quicinc.com>
 <20250220094251.230936-4-quic_varada@quicinc.com>
 <41b400fe-5e08-42c0-9bc6-a238d25d155a@kernel.org>
 <33bb1cb2-0c5e-402b-a5c6-9604b1dd8d99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33bb1cb2-0c5e-402b-a5c6-9604b1dd8d99@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 13Znxcki_patImFqJYtxtGVAtEB8lGJl
X-Proofpoint-ORIG-GUID: 13Znxcki_patImFqJYtxtGVAtEB8lGJl
X-Authority-Analysis: v=2.4 cv=ab+bnQot c=1 sm=1 tr=0 ts=67ce986f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=dj0ERmanKLZXDvYKl08A:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100059

On Thu, Mar 06, 2025 at 01:06:13PM +0100, Krzysztof Kozlowski wrote:
> On 06/03/2025 12:52, Krzysztof Kozlowski wrote:
> > On 20/02/2025 10:42, Varadarajan Narayanan wrote:
> >> All DT entries except "reg" is similar between ipq5332 and ipq9574. ipq9574
> >> has 5 registers while ipq5332 has 6. MHI is the additional (i.e. sixth
> >> entry). Since this matches with the sdx55's "reg" definition which allows
> >> for 5 or 6 registers, combine ipq9574 with sdx55.
> >>
> >> This change is to prepare ipq9574 to be used as ipq5332's fallback
> >> compatible.
> >>
> >> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Unreviewed.
> >
> >> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >> ---
> >> v8: Add 'Reviewed-by: Krzysztof Kozlowski'
> >> ---
> >>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> index 7235d6554cfb..4b4927178abc 100644
> >> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> @@ -169,7 +169,6 @@ allOf:
> >>              enum:
> >>                - qcom,pcie-ipq6018
> >>                - qcom,pcie-ipq8074-gen3
> >> -              - qcom,pcie-ipq9574
> >
> > Why you did not explain that you are going to affect users of DTS?
> >
> > NAK

Sorry for not explicitly calling this out. I thought that would be seen from the
following DTS related patches.

> I did not connect the dots, but I pointed out that you break users and
> your DTS is wrong:
> https://lore.kernel.org/all/f7551daa-cce5-47b3-873f-21b9c5026ed2@kernel.org/
>
> so you should come back with questions to clarify what to do, not keep
> pushing this incorrect patchset.
>
> My bad, I should really have zero trust.

It looks like it is not possible to have ipq9574 as fallback (for ipq5332)
without making changes to ipq9574 since the "reg" constraint is different
between the two. And this in turn would break the ABI w.r.t. ipq9574.

To overcome this, two approaches seem to be availabe

	1. Document that ipq9574 is impacted and rework these patches to
	   minimize the impact as much as possible

		(or)

	2. Handle ipq5332 as a separate compatible (without fallback) and reuse
	   the constraints of sdx55 for "reg" and ipq9574 for the others (like
	   clock etc.). This approach will also have to revert [1], as it
	   assumes ipq9574 as fallback.

Please advice which of the above would be appropriate. If there is a better 3rd
alternative please let me know, will align with that approach.

Thanks
Varada

1 - https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/pci/qcom,pcie.yaml?id=f67d04b18337249b0faa5cab6223c0bb203f6333

