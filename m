Return-Path: <linux-pci+bounces-19395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC2A03D36
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1983A30B2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9319CC2E;
	Tue,  7 Jan 2025 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ICpfpPfG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E0219ED;
	Tue,  7 Jan 2025 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247944; cv=none; b=EsnB64eElVzgyDmtmeFe19SHtXLPilazp5sWe7dDYOlq+1ru/RjjwGj3AjTCDVG5Zz0IKUU8ZHL+di9H90LXSb4xHrRWr6nUhf+gKp3BmJcafvsmIuhG3hW1DwIMxm1IkBy+EQ+O0FyzMDRjjYXd4hC1mRVA58LllyHvmCEQw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247944; c=relaxed/simple;
	bh=ThRmP5SNmsjh2B0dSxhnd+9YAXIeaNOahsI6G66Q/74=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2Kg0kYDqqtXqIb54WaxFA2Qy+KsmfWSl6z9mw/h/2Quclm6gkvCPHvHSvYWHZCWt9sPkK+F1bkCRxwMPSq45GqaNbQC9GQSUBRJQ4ByEog7gncxuAF3TCPLRH4mosgSblyZT4wp/5sY2CYTO2vsYB5uYN8dLBV3PI+9lVhpObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ICpfpPfG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507A0T1J019736;
	Tue, 7 Jan 2025 11:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/yz6W5asShFN9pgFAwO5c5pG
	EwHieZL0RQw4bc3kmgQ=; b=ICpfpPfGS51AnQ8VIHw3sGv8lco2EJi+Epk2dojM
	Iwq1NYkeg7dfozpAMCc1f+k5kk99ukUAX9hXxDtGyvmi1s3ayqyDi+UNFeYeAUf5
	/IEHB7y/6iUXgK0TrhXPlDKhnPzSSsbCWLGAEmXaNBgespMjcHVQjH33MnilylJf
	PhBm+YmdtGwRqppiw53OBjR3cmz60bLPsrpJGw9JulI1qkwQ2sjBy1IpioZF2U09
	K/xzF0cwqTw39aRj/4duKB7t1DwIaqKBAtz0X8v/Id8OEemKd4QnynpSd3/PxMWZ
	dlUfa8C6RoXt4YMFRfB2z6JrNIPoP2EeX2DSlUhscgYLhQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44124xr5fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 11:05:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507B5HcW015952
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 11:05:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 03:05:11 -0800
Date: Tue, 7 Jan 2025 16:35:08 +0530
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
Subject: Re: [PATCH v5 3/5] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <Z30KZM1RGdFvB1dy@hu-varada-blr.qualcomm.com>
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
 <20250102113019.1347068-4-quic_varada@quicinc.com>
 <4hwclzotaowog6rzfejiixqvvg7iumg4udbvq3h72mmh42dbki@piphsf37vhpv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4hwclzotaowog6rzfejiixqvvg7iumg4udbvq3h72mmh42dbki@piphsf37vhpv>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rqs0Y1pnTmicV7r4h61kix2iYIbzCCBR
X-Proofpoint-GUID: Rqs0Y1pnTmicV7r4h61kix2iYIbzCCBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070092

On Fri, Jan 03, 2025 at 08:45:14AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Jan 02, 2025 at 05:00:17PM +0530, Varadarajan Narayanan wrote:
> > Document the PCIe controller on IPQ5332 platform.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts
>
> What? How this is related to commit msg?
>
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
> > index bd87f6b49d68..9f37eca1ce0d 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -26,7 +26,6 @@ properties:
> >            - qcom,pcie-ipq8064-v2
> >            - qcom,pcie-ipq8074
> >            - qcom,pcie-ipq8074-gen3
> > -          - qcom,pcie-ipq9574
>
> I don't understand this change at all and your commit msg explains
> here nothing.

All DT entries except "reg" is similar between ipq5332 and
ipq9574. ipq9574 has 5 registers while ipq5332 has 6. MHI is the
additional (i.e. sixth) entry for ipq5332.

If ipq9574 is not removed from here, dt_binding_check gives the
following errors

1.	/local/mnt/workspace/varada/upstream/pci-v6/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dtb: pcie@18000000: reg: [[557056, 12288], [402653184, 3869], [402657056, 168], [402657280, 4096], [403701760, 4096], [569344, 4096]] is too long

	Failed validating 'maxItems' in schema['allOf'][2]['then']['properties']['reg']:
	    {'maxItems': 5, 'minItems': 5}

2.	/local/mnt/workspace/varada/upstream/pci-v6/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dtb: pcie@18000000: reg-names: ['parf', 'dbi', 'elbi', 'atu', 'config', 'mhi'] is too long

	Failed validating 'maxItems' in schema['allOf'][2]['then']['properties']['reg-names']:
	    {'items': [{'const': 'dbi'},
		       {'const': 'elbi'},
		       {'const': 'atu'},
		       {'const': 'parf'},
		       {'const': 'config'}],
	     'maxItems': 5,
	     'minItems': 5,
	     'type': 'array'}

Hence had to remove it from here and add it to the sdx55 reg
definition.

Will capture this in the commit message.

Thanks
Varada

