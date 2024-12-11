Return-Path: <linux-pci+bounces-18104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404659EC7B2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8B71658AF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A01E9B12;
	Wed, 11 Dec 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FOJv3Q6Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611BF1C5F12;
	Wed, 11 Dec 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907124; cv=none; b=lpKKFNqL9skBl3Bvwrju+2NyojslPRTUmGfa4PAYbCmwmU6PXUTl00HpXcPBIE64n6Mv3hJPTU6yUH88dFwbcxMwfKAAkW6URKBLqc4Z3NwA0pJ0i8CxkOOE2v1m6VswS2qpJspR4IPKdKLBRM+UkldZxEaH9e0sFB/lbE+3T3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907124; c=relaxed/simple;
	bh=OR8GK2qCpYkeFCoDWc0Yi9aA9fxuV+z2O5O/jlCHIJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIjJ4bLITs7R2Q9hGwPyIK+RW60J+NAmRGZzqB4UGt1cz1bxDcqe7uB7Xswy8pkHK5txo6V5Q+X/N0MRkvv92pbOg6EwRDz0w47ebgvq7V9qszNjJQlxmgDwVFFC4PBnvfkjqmUo+zRV+2lqSs5Sbl+4gi7Cb/5ilNDPlFFXV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FOJv3Q6Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB7vssq010224;
	Wed, 11 Dec 2024 08:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pT3aJLtYzwxFJMkqscc1jyxr
	QBDSZ2yr8Uk3IsegLgQ=; b=FOJv3Q6Y4zRt9LfTYlSxeNGEQVwWawQGuFgGBdgE
	5grG7rekFusQzCDrYNxBq2ihOTKlsVnVBdkeaKs2qV0XZxM718gcSTKV+fFPKcZD
	vpXi0fSVQ70P6ghRsMckrHyoTHDHao+ys6Cvd/gqVW3YVaqyxdQ4ODtWvDN5Xt3E
	mE0d7jWWQLq0Aq1f7V6Lk4ebUZPB3HzKhvbOe0cQ+KMiLEA/wLA0o5JYcntIXHgA
	lcU+NKsfd76JJJz/6tGqq6MYM1ZisV+/2wCcBpe918r0U/uk45eb97MFoTmOoJJa
	tf40XvTV9mTDmZSZDOepk54R69vM/ecmMOIs6fTf9cSsZg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tf84pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:51:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BB8pnDC018156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:51:49 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 00:51:43 -0800
Date: Wed, 11 Dec 2024 14:21:40 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <Z1lSnLyh6LSpk4z1@hu-varada-blr.qualcomm.com>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-2-quic_varada@quicinc.com>
 <7js7lswzde67izdradhuzgvlixwiblgf7aosdvavknbclbtjew@6w3y2e2k3mtk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7js7lswzde67izdradhuzgvlixwiblgf7aosdvavknbclbtjew@6w3y2e2k3mtk>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v3Oe2qP-ofqk72OOu_4Usb1Fc0-6LfOo
X-Proofpoint-ORIG-GUID: v3Oe2qP-ofqk72OOu_4Usb1Fc0-6LfOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110066

On Thu, Dec 05, 2024 at 10:38:05AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Dec 04, 2024 at 05:03:24PM +0530, Varadarajan Narayanan wrote:
> > From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> >
> > Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5332.
> >
> > Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v2: Rename the file to match the compatible
>
> Either I look at wrong v1 from your cover letter or there was no such
> file in v1, so how it can be a rename?
>
> What happened here?

This driver was pulled in from [1] "Enable IPQ5018 PCI support (Nitheesh Sekar)"

In that review, there was this feedback [4]

	-------------------------------
	> +++
	> b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml

	Filename should match compatibles and they do not use 28lp.
	-------------------------------

> >     Drop 'driver' from title
> >     Dropped 'clock-names'
> >     Fixed 'reset-names'
> > --
> >  .../bindings/phy/qcom,uniphy-pcie.yaml        | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml
> > new file mode 100644
> > index 000000000000..e0ad98a9f324
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml
>
> This does not match compatible, so I don't see how it even matches your
> changelog.

Since this phy has both single and dual line capabilities I used
the phy's name alone for the file name. Will rename this as

	qcom,ipq5332-uniphy-pcie-phy.yaml

If this is not suitable, can you please suggest one that would be
apt for this phy.

> > @@ -0,0 +1,82 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/qcom,uniphy-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm UNIPHY PCIe 28LP PHY
> > +
> > +maintainers:
> > +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
> > +  - Varadarajan Narayanan <quic_varada@quicinc.com>
> > +
> > +description:
> > +  PCIe and USB combo PHY found in Qualcomm IPQ5332 SoC
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,ipq5332-uniphy-pcie-gen3x1
>
> Odd naming. Did anyone suggest this? I would expect something matches
> like everything else recent (see X1 for example).

It was not suggested by anyone. Since [4] didn't comment on this
continued to use it. Will change it as follows (similar to
qcom,x1e80100-qmp-gen4x2-pcie-phy)

	qcom,ipq5332-uniphy-gen3x1-pcie-phy
	qcom,ipq5332-uniphy-gen3x2-pcie-phy
>
> > +      - qcom,ipq5332-uniphy-pcie-gen3x2
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 2
>
> What happened here? This cannot be minItems and it never was.

Will fix this.

> > +
> > +  resets:
> > +    minItems: 2
> > +    maxItems: 3
>
> Why this varies?
>
> This patch is odd. Confusing changelog, v1 entirely different and not
> matching what is here, unusual and incorrect code in the binding itself.
>
> Provide changelog explaining WHY you did such odd changes.

This series combines [1] and [2]. [1] introduces IPQ5018 PCIe
support and [2] depends on [1] to introduce IPQ5332 PCIe support.
Since the community was interested in [2] (please see [3]), tried
to revive IPQ5332's PCIe support with this patch. Apologies for
not expressing this in the cover letter.

> Open *LATEST* existing Qcom bindings and look how they do it. Do not
> implement things differently.

Sure.

Thanks
Varada

1. Enable IPQ5018 PCI support (Nitheesh Sekar) - https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
2. Add PCIe support for Qualcomm IPQ5332 (Praveenkumar I) - https://lore.kernel.org/linux-arm-msm/20231214062847.2215542-1-quic_ipkumar@quicinc.com/
3. Community interest - https://lore.kernel.org/linux-arm-msm/20240310132915.GE3390@thinkpad/
4. dt-bindings feedback - https://lore.kernel.org/all/4bc021c1-0198-41a4-aa73-bf0cf0c0420a@linaro.org/

