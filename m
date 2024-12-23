Return-Path: <linux-pci+bounces-18958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D7E9FAB4A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 08:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F397A1DFA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9953118BC19;
	Mon, 23 Dec 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dCBOF2Y9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1621189520;
	Mon, 23 Dec 2024 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734940226; cv=none; b=TsWdYcY2/C6QsV5r4CpCkWw3simd9QPCkniJCVfpgXZYz+o0QuwCCfe/WUaUJggy2qo7Vxml/xbUvg18gPJ9VUMrbuOCNx69PYjzS/zzotK0cGudv6zAq1qIifkQeUgLqMvx+db5QScgI7h4QzGjAWDRmQjJ4uuyJo/92d4dYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734940226; c=relaxed/simple;
	bh=KluvoRVs50gNq7a5yFRrEJBBDOWuB3gtzpqMMaQxMhA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4fGhUvUpfUcxUt4DRxaq55Vgm9j/GWmzsyiMjMMK4n0RWSKw3zVKFQvqUTF9IAVF6par0uDWJHOB52pc6NI8HqYldbgvTupUP+1ng+fMUxy+7LxEVGidYQDFPR6FDfVUZkj+1KY/V5VzPKmNnjbPZATRbbr0GHMs57nap1qGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dCBOF2Y9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN6mbwA004776;
	Mon, 23 Dec 2024 07:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o0ylRwCleiLePsy/R7nCCMSI
	zCh9GGBByF9fUZV3WJo=; b=dCBOF2Y9bcfzYzkpPCbsZTO47lTzNynhM+D9tR5A
	JCH/AJ4yl215RyWRNHdXxFz9EL5kw92yCTmgZNwuiNeRY5wVywF/GkwTFNUkU2NN
	jdhqEzp19eWYbxw7PGm6NJD2VNJJ6bnzFwB+sGpQSi/SzlZ/XyGv02qKzER7WV/+
	jv4jAVZxV4U+15PEuqPq/487WS7BDLQK1xtlMjVurjObYl49hXRuCv0iTDhD5cGP
	6A8qSUsxa7WWiF2PBaA/4tqpeKXoDU1WIJsdD9kjs0bdcBJoB6x96BOQtUH8Pvyt
	AAuDYkZgQVcjB2FS9X6PFJAXiVA8HkQZQW6gAM7Zv4yvcw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q2ww88bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 07:50:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN7o6Nm027292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 07:50:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Dec 2024 23:50:00 -0800
Date: Mon, 23 Dec 2024 13:19:57 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <Z2kWJb/77vunIPDg@hu-varada-blr.qualcomm.com>
References: <20241217100359.4017214-1-quic_varada@quicinc.com>
 <20241217100359.4017214-2-quic_varada@quicinc.com>
 <nhzbr4knneo5k3zxvjy2ozx6ciqg2hivwyr2qxdld2x63vlzeb@mjrlqeqiykzp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <nhzbr4knneo5k3zxvjy2ozx6ciqg2hivwyr2qxdld2x63vlzeb@mjrlqeqiykzp>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G7LY8sYViYMibK_Ix7Wj0HgbzslH0iz9
X-Proofpoint-GUID: G7LY8sYViYMibK_Ix7Wj0HgbzslH0iz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230068

On Wed, Dec 18, 2024 at 11:28:18AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 17, 2024 at 03:33:55PM +0530, Varadarajan Narayanan wrote:
> > From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> >
> > Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5332.
> >
> > Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v3: Fix compatible string to be similar to other phys and rename file accordingly
> >     Fix clocks minItems -> maxItems
>
> I think there was just one clock, so you increased it to two.

IPQ5018 patch series had one clock. IPQ5332 introduced additional
clocks and it became four. Of the four clocks, two were NoC
related clocks. Since the NoC clocks are handled in icc-clk based
interconnect driver, have dropped those two and have incldued the
two here.

> >     Change one of the maintainer from Sricharan to Varadarajan
> >
> > v2: Rename the file to match the compatible
> >     Drop 'driver' from title
> >     Dropped 'clock-names'
> >     Fixed 'reset-names'
> > --
> >  .../phy/qcom,ipq5332-uniphy-pcie-phy.yaml     | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
> > new file mode 100644
> > index 000000000000..0634d4fb85d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
> > @@ -0,0 +1,82 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/qcom,ipq5332-uniphy-pcie-phy.yaml#
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
> > +      - qcom,ipq5332-uniphy-gen3x1-pcie-phy
> > +      - qcom,ipq5332-uniphy-gen3x2-pcie-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 2
>
> I should have been more specific last time, but I assumed you will take
> other bindings as example.  well, so now proper review: you need to list
> tiems.

Sure.

> > +
> > +  resets:
> > +    minItems: 2
> > +    maxItems: 3
>
> No answer to my previous question. Question stands.

I assume this question:- "So where are three items?" [1]
Will remove this and list the items.

> > +
> > +  reset-names:
> > +    minItems: 2
> > +    items:
> > +      - const: phy
> > +      - const: phy_ahb
> > +      - const: phy_cfg
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  "#clock-cells":
> > +    const: 0
> > +
> > +  clock-output-names:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - resets
> > +  - reset-names
> > +  - clocks
>
> Keep the same order as in properties block.

Ok.

Thanks
Varada

1. https://lore.kernel.org/linux-arm-msm/c685ca4e-3992-4deb-adfb-da3bbcb59685@linaro.org/

