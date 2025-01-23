Return-Path: <linux-pci+bounces-20273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7343A19F87
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 09:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8899C188D470
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A320B21F;
	Thu, 23 Jan 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dkxeSSpZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075926AF5;
	Thu, 23 Jan 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737619569; cv=none; b=pZSoUofq7ZN1iI96MeK0oTNeh0GyZK/bujndLjz2yibNTkUSoqEouF2ELijkEiblW+uafeupalvUCmCzobGvUvj8CDABr8KAqVtEqQ4I+X6TpzqTy7fl3qMtSSMl5/WyZTr3kKgy2KUedVKBaElH9E+VyzBAkXCdZeVIwTqCksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737619569; c=relaxed/simple;
	bh=LUVaTOmLZiPeHbD1k5TO8WMvPK4IHXHrOfz+sB4FcZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYIf44yRm71vcNMRgqCs4i5HjDZvA76CRMfgBbB2CQnFmGe3Ubjm0Ak3Im6fU946WSd9rlR8izBi68gdxjzVktRxrFc5KKbnQiVjieGrn+QpvElY/rVvghJxmhHJ0kFabaH066PDuO/EYuXjZ14fvlBSiG2FJ15OxgcajPR4+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dkxeSSpZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N4s44N024068;
	Thu, 23 Jan 2025 08:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2Qh1iaWoE1NnCNORx74pe70l
	w6fshfbRLO+R3ckU8qA=; b=dkxeSSpZ/rPdD3BVtYXle5LNYKJL6pdhfl9nzuD2
	0VzpekAQF7ejcTLfMyMpmngqmtoyasBDPc3WwzTfcaPMc9cG9Jd0pUHWKqn3SMu5
	6sZLjwM123vWCILOzJXYiytlEVmpsHlioiOKKvEDYDPVAA8HI//5+1zB2y9r3n+1
	aF5m8u4knm1Ftj+FgWUiKkRLvMUi6VgoGJ1P73v0ItjgKx65p3RPMuQC/ALhlxUT
	NIhM8FGJmTTJ6MRX6vmVSZAvGmSZ4tIxoJA+0SlN4Uq3JfR0h3URH57H9Hhi2V3I
	KDimDz/OJbEXnLjeifdLcPEmQLL38VFgJYlTDIZ2eplowQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bf518crs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 08:05:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50N85kJN001745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 08:05:46 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 00:05:40 -0800
Date: Thu, 23 Jan 2025 13:35:36 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v7 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <Z5H4UPhRjKhbbP9/@hu-varada-blr.qualcomm.com>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
 <20250122063411.3503097-6-quic_varada@quicinc.com>
 <20250123-red-unicorn-of-piety-3c7de5@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123-red-unicorn-of-piety-3c7de5@krzk-bin>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qmOH5iK4QdRqheY4B3Byp9BchFam-3cb
X-Proofpoint-GUID: qmOH5iK4QdRqheY4B3Byp9BchFam-3cb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230060

On Thu, Jan 23, 2025 at 08:58:29AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Jan 22, 2025 at 12:04:09PM +0530, Varadarajan Narayanan wrote:
> > Document the PCIe controller on IPQ5332 platform. IPQ5332 will
> > use IPQ9574 as the fall back compatible.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v7: Moved ipq9574 related changes to a separate patch
> >     Add 'global' interrupt
> >
> > v6: Commit message update only. Add info regarding the moving of
> >     ipq9574 from 5 "reg" definition to 5 or 6 reg definition.
> >
> > v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts
> >
> > v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
> >     * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
> >       to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
> >       and dt_binding_check flag errors.
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.yaml          | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index 413c6b76c26c..ead97286fd41 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -34,6 +34,10 @@ properties:
> >        - items:
> >            - const: qcom,pcie-msm8998
> >            - const: qcom,pcie-msm8996
> > +      - items:
> > +          - enum:
> > +              - qcom,pcie-ipq5332
> > +          - const: qcom,pcie-ipq9574
>
> Repeated many times on reviews to qcom: don't add to the end of the
> lists. In case of multiple items, these are ordered by fallback, so this
> goes next to other ipq entry... wait, that's already qcom,pcie-ipq9574,
> so why are you duplicating?
>
> On what tree are you working?

Looks like ipq5424 changes got merged between the time I cloned
linux-next, tested and posted the patch. Will fix this and post
a new one.

Thanks
Varada

