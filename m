Return-Path: <linux-pci+bounces-23489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7DAA5D9B1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 10:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF4616F48E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4723A9AF;
	Wed, 12 Mar 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cJTCQbsz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078715820C;
	Wed, 12 Mar 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772392; cv=none; b=Sqaj/JzH9ournj+2viVHkI5y3OswCcgkg2FwtDosuDZXH3kh/RvbXObfChghCGgHpb4ybOYtIPtCEwmEf23RrMseE7RPVVzDnHdnrlesp3Q0dD/ris/Riq7NHpjK7KujALOCKEuLvILPLXni0ao12wf7U6Jc4lnz/d3OB49wGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772392; c=relaxed/simple;
	bh=Zl07tU7+p0PpzqbFzUpsduh+7Da4qFqCRGZ9W6ReZ3c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAca6+Hz87Wn5HWCqUDOR4qvg9vkFEj+vmstQJTD6SKdYf61OTYM9F87UfDt4bKHZuLtS2Z2z0yhTk4GqtROyzjzchiqNjiNEGmM8lxZVXy/pFYCMz8GSEFpLetFdn2/dD1LfUxJ8iDEtnv6QZPPQz4lNdHcqLGgKAs2OyB+SSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cJTCQbsz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHCTq030286;
	Wed, 12 Mar 2025 09:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Bs/d2yOM5HvoJ3Fs/iubFgUi
	IpZVkkeRuPDobV4RML8=; b=cJTCQbszIqE+5ZPqvW7Rrr12sRHj8DY2cnE45VKh
	RrGIZ/yUNYsGX69iIatS7laqc67K9qBKLGNZGhshJPBdC4DbVFCtRcBGHF4eFzQJ
	8FiprT0AZH06+TnvJyJ7eTW59XUZur1EKKIcU0KOfP28EOLJJ3iqdwBCe1uDf7BJ
	U00K5pu9rMBxcd7/wwLYr4dMNCxaQmHajLrvMXqe271Eh7iHbeFwXaEC3+bkXIt+
	dRPICHETXUJPektCMRcQvuE4+RSDdM+PLTPUHpyVo5LY1U3hGZYkRmfaSWTMznWg
	Gx0SUSEEJbRur3+HNh0SuGxdlVezmgP2kgP0A1ypcrbK/w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2qhw07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 09:39:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C9dgkR020391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 09:39:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 02:39:38 -0700
Date: Wed, 12 Mar 2025 15:09:34 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <quic_srichara@quicinc.com>,
        <quic_devipriy@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 1/4] dt-bindings: PCI: qcom: Add MHI registers for
 IPQ9574
Message-ID: <Z9FWVh1NinKOsRNq@hu-varada-blr.qualcomm.com>
References: <20250312084330.873994-1-quic_varada@quicinc.com>
 <20250312084330.873994-2-quic_varada@quicinc.com>
 <7b2d7f14-4274-4ff0-87a6-ac3dd649df4e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b2d7f14-4274-4ff0-87a6-ac3dd649df4e@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VLZnR-Gwgi09wzAZYhOChL3XibPlTXpM
X-Proofpoint-GUID: VLZnR-Gwgi09wzAZYhOChL3XibPlTXpM
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=67d15660 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=FAg4eJUAi5izC7YpO0UA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=970 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120065

On Wed, Mar 12, 2025 at 09:46:41AM +0100, Krzysztof Kozlowski wrote:
> On 12/03/2025 09:43, Varadarajan Narayanan wrote:
> > Append the MHI register range to IPQ9574.
>
> Why?

This is needed for ipq5332 to use ipq9574 as fallback compatible.

> > Fixes: e0662dae178d ("dt-bindings: PCI: qcom: Document the IPQ9574 PCIe controller")
>
> What is being fixed here?

Ok, will remove this.

> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > New patch introduced in this patchset. MHI range was missed in the
> > initial post
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index 8f628939209e..77e66ab8764f 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -175,7 +175,7 @@ allOf:
> >        properties:
> >          reg:
> >            minItems: 5
> > -          maxItems: 5
> > +          maxItems: 6
>
> Why qcom,pcie-ipq6018 gets mhi? Nothing in commit msg mentions ipq6018.

Didn't mention ipq6018 as I was under the impression that 'minItems: 5' would
apply for ipq6018.

> >          reg-names:
> >            items:
> >              - const: dbi # DesignWare PCIe registers
> > @@ -183,6 +183,7 @@ allOf:
> >              - const: atu # ATU address space
> >              - const: parf # Qualcomm specific registers
> >              - const: config # PCIe configuration space
> > +            - const: mhi # MHI registers
>
> Never tested - you introduce new warnings. AGAIN.
>
> Properties xxx and xxx-names must have always the same constraints.

Ok, will add 'minItems: 5' here.

Thanks
Varada

