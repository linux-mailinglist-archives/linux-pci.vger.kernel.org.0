Return-Path: <linux-pci+bounces-20427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F486A20412
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 06:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D093A6882
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E76176AC5;
	Tue, 28 Jan 2025 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BFsLrZJ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21F42A92;
	Tue, 28 Jan 2025 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042769; cv=none; b=RSfi8Os/1kqU2CLX+WIUXX5A85BRMLqYR4W/JliJC3Usr2/4gugf1jA+UWtJgnfmfDf0ht0tPGvieM1hXHGmoQVHxFqGrdDO/KLq3KELYIsF6GhfishDLOwf6DM36k2YrT90k11Cf8ECy1s3+Bjt/Nu/fzKKjl9D5f77Ixo3Aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042769; c=relaxed/simple;
	bh=q5VbNiYniAyocxLb4WlfBoyQ3vWcnr3+cjSoYXr1REw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7GVwcKCv0ucI/WvYYmDqe5ZFSBiy7mksAiPeITc/D9ynv/F/RmZ4j63eLIdai/9n6xIOYFR6hhgvC1CqeI+vJ3Mg+mtj6VTbUZ1l2rzAmT8CPPq0a91XS6X5D6auNIqOFpcpijVlf964uZtS5P8dtIiNJeQWTFHMXtNIT2TBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BFsLrZJ4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S0VoIn002950;
	Tue, 28 Jan 2025 05:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QtmlH3he5Hz0YMa0hWZk9aST
	OVC+O4uUxZXVfQjHohQ=; b=BFsLrZJ4s+488gGSvOoE1quIyGJ0lWYnZzh6DGf9
	neJEiTkE3g0gaVlZ7RD/3oMPEHzzCymhcymKORHL+j4lh112YXSIJcH8CQluWzf1
	3h++F9Sfr+MI1mX3Au80KS494kFW2ruxdsy5qORaEuzM+F3diyLXSBcg7gBd8K/J
	NVtOCP53oGjcJowzePLEoWESadrbs1ZYF2OTKnDFJnOmRUCSQBDoS363DNkKM5JJ
	9+TxZkfdfs1RW1Jm4jQDDyN9/f9uSXz5gnVeSNgSy30Vb8gDDdJ/WQgUvgDCsGEe
	EOn15YN8OG/N7wSqZkETCADKQr7t7v1RMmSTePTls/a+hg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44emry0des-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 05:39:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S5d6hj000381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 05:39:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 21:39:01 -0800
Date: Tue, 28 Jan 2025 11:08:57 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Rob Herring <robh@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <bhelgaas@google.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v8 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <Z5htccTM8BKoAbJH@hu-varada-blr.qualcomm.com>
References: <20250127072850.3777975-1-quic_varada@quicinc.com>
 <20250127072850.3777975-6-quic_varada@quicinc.com>
 <20250127191906.GA704182-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250127191906.GA704182-robh@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3W-wP9GiqaJIaZ8zNvtJpAn5IZ6Qzx8I
X-Proofpoint-GUID: 3W-wP9GiqaJIaZ8zNvtJpAn5IZ6Qzx8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=987 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280040

On Mon, Jan 27, 2025 at 01:19:06PM -0600, Rob Herring wrote:
> On Mon, Jan 27, 2025 at 12:58:48PM +0530, Varadarajan Narayanan wrote:
> > Document the PCIe controller on IPQ5332 platform. IPQ5332 will
> > use IPQ9574 as the fall back compatible.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v8: Use ipq9574 as fallback compatible for ipq5332 along with ipq5424
> >
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
> >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index 4b4927178abc..2ffa8480a665 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -33,6 +33,7 @@ properties:
> >            - qcom,pcie-sdx55
> >        - items:
> >            - enum:
> > +              - qcom,pcie-ipq5332
> >                - qcom,pcie-ipq5424
> >            - const: qcom,pcie-ipq9574
> >        - items:
> > @@ -49,11 +50,11 @@ properties:
> >
> >    interrupts:
> >      minItems: 1
> > -    maxItems: 8
> > +    maxItems: 9
> >
> >    interrupt-names:
> >      minItems: 1
> > -    maxItems: 8
> > +    maxItems: 9
> >
> >    iommu-map:
> >      minItems: 1
> > @@ -209,6 +210,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,pcie-ipq5332
> >                - qcom,pcie-ipq9574
>
> As both of these compatibles will be present, you don't need to add
> ipq5332 here.

Ok.

> >                - qcom,pcie-sdx55
> >      then:
> > @@ -411,6 +413,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,pcie-ipq5332
> >                - qcom,pcie-ipq9574
>
> Same here.

Ok.

Thanks
Varada

> >      then:
> >        properties:
> > @@ -443,6 +446,7 @@ allOf:
> >          interrupts:
> >            minItems: 8
> >          interrupt-names:
> > +          minItems: 8
> >            items:
> >              - const: msi0
> >              - const: msi1
> > @@ -452,6 +456,7 @@ allOf:
> >              - const: msi5
> >              - const: msi6
> >              - const: msi7
> > +            - const: global
> >
> >    - if:
> >        properties:
> > @@ -559,6 +564,7 @@ allOf:
> >                enum:
> >                  - qcom,pcie-apq8064
> >                  - qcom,pcie-ipq4019
> > +                - qcom,pcie-ipq5332
> >                  - qcom,pcie-ipq8064
> >                  - qcom,pcie-ipq8064v2
> >                  - qcom,pcie-ipq8074
> > --
> > 2.34.1
> >

