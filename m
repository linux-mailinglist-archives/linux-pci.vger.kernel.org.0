Return-Path: <linux-pci+bounces-23410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB52A5BAA2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 09:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5D33AB217
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC881F0998;
	Tue, 11 Mar 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hzEMiy7/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C093596F;
	Tue, 11 Mar 2025 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681007; cv=none; b=Sv0MPDGTBO+iIalaJlUgholoq/1RI0SEmFpAF9uFYiaJOg1wwirABZ9aXECWweI1qvFJJl1ulmQY5Ijmpd8GfN7+ylbH8h9/xtvLJIv+zLjHrA5Gj419L10GA+aiYVtq72AGYnEfO9L5+aX4pRVhyle0KVvJopX/LCedLh/qYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681007; c=relaxed/simple;
	bh=ng5wyALW6ld67NJv7B8d70Oqs+nbYll75WwrO2/hVM0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogmN/NEI47AzIKWFCqM/cjDCdMsKsqg35ZPHd8NXFCpz21Sxa/dWT7prvT3hznsXbiihq29ic8JLSczq+pfuYcE9vJR58gN94oV3qoAnLoiOyclznIipesci5H5hIVFX8Gkz2onyVV0OXSthQ+9yZJJqeKZdGFMTtK4EtB8/+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hzEMiy7/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7olEa028020;
	Tue, 11 Mar 2025 08:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MMrcpnZoinmghZmI4i1BjUQH
	1Z0qXqyC7ZdoR9tlrfE=; b=hzEMiy7/10ZQ7qFigHTz9CMpB7ojnOJ/n1YTlYSF
	fUIXssS10DWjzlfs/btsvJEDrJC/bsIxko7/jsuvh7q2WovK1g4hI99F0iAfVgK8
	8yR9VUcemYZ2rnZ0HpharVoo+TsrzHyRd5X5/fEjPGfDQXRbm7yBGdOEpx7yWN3Y
	tRof+UJqLd8Bdn7obduB9ktQarAo805LDmu+CgCRAGRlMVCSaT4fSAl9UZi3MkAz
	HlgAgwwLjOVz7BCtR1SPDpS1pdPjJeOuAFUAHzos9EN/c/uJ/af7k3BPx5PX48ah
	VGpsFyGWNPYYzFHQQWmfx9h39jQ4QW2tvnu13FhqBQIdyQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah5282nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:16:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B8GOsx032540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:16:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Mar 2025 01:16:17 -0700
Date: Tue, 11 Mar 2025 13:46:14 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v11 3/7] dt-bindings: PCI: qcom: Use sdx55 reg
 description for ipq9574
Message-ID: <Z8/xTotUg+2GN2+G@hu-varada-blr.qualcomm.com>
References: <20250220094251.230936-1-quic_varada@quicinc.com>
 <20250220094251.230936-4-quic_varada@quicinc.com>
 <41b400fe-5e08-42c0-9bc6-a238d25d155a@kernel.org>
 <33bb1cb2-0c5e-402b-a5c6-9604b1dd8d99@kernel.org>
 <Z86YReHsKeF165F6@hu-varada-blr.qualcomm.com>
 <84456c70-e933-469f-ac7a-7d899f85e777@linaro.org>
 <Z8/Dto1fZWvemiY5@hu-varada-blr.qualcomm.com>
 <01a7918b-dc4b-4ed3-8f74-bc59a9629ce9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <01a7918b-dc4b-4ed3-8f74-bc59a9629ce9@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hxN1VIELppKs3TXAf4Mcm4v-qBzweo7n
X-Proofpoint-ORIG-GUID: hxN1VIELppKs3TXAf4Mcm4v-qBzweo7n
X-Authority-Analysis: v=2.4 cv=DfTtqutW c=1 sm=1 tr=0 ts=67cff159 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=_r5JOhWGjcopMknOANcA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110055

On Tue, Mar 11, 2025 at 08:54:55AM +0100, Krzysztof Kozlowski wrote:
> On 11/03/2025 06:01, Varadarajan Narayanan wrote:
> > On Mon, Mar 10, 2025 at 12:37:28PM +0100, Krzysztof Kozlowski wrote:
> >> On 10/03/2025 08:44, Varadarajan Narayanan wrote:
> >>> On Thu, Mar 06, 2025 at 01:06:13PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 06/03/2025 12:52, Krzysztof Kozlowski wrote:
> >>>>> On 20/02/2025 10:42, Varadarajan Narayanan wrote:
> >>>>>> All DT entries except "reg" is similar between ipq5332 and ipq9574. ipq9574
> >>>>>> has 5 registers while ipq5332 has 6. MHI is the additional (i.e. sixth
> >>>>>> entry). Since this matches with the sdx55's "reg" definition which allows
> >>>>>> for 5 or 6 registers, combine ipq9574 with sdx55.
> >>>>>>
> >>>>>> This change is to prepare ipq9574 to be used as ipq5332's fallback
> >>>>>> compatible.
> >>>>>>
> >>>>>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>>
> >>>>> Unreviewed.
> >>>>>
> >>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>>>> ---
> >>>>>> v8: Add 'Reviewed-by: Krzysztof Kozlowski'
> >>>>>> ---
> >>>>>>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
> >>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>> index 7235d6554cfb..4b4927178abc 100644
> >>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>> @@ -169,7 +169,6 @@ allOf:
> >>>>>>              enum:
> >>>>>>                - qcom,pcie-ipq6018
> >>>>>>                - qcom,pcie-ipq8074-gen3
> >>>>>> -              - qcom,pcie-ipq9574
> >>>>>
> >>>>> Why you did not explain that you are going to affect users of DTS?
> >>>>>
> >>>>> NAK
> >>>
> >>> Sorry for not explicitly calling this out. I thought that would be seen from the
> >>> following DTS related patches.
> >>>
> >>>> I did not connect the dots, but I pointed out that you break users and
> >>>> your DTS is wrong:
> >>>> https://lore.kernel.org/all/f7551daa-cce5-47b3-873f-21b9c5026ed2@kernel.org/
> >>>>
> >>>> so you should come back with questions to clarify what to do, not keep
> >>>> pushing this incorrect patchset.
> >>>>
> >>>> My bad, I should really have zero trust.
> >>>
> >>> It looks like it is not possible to have ipq9574 as fallback (for ipq5332)
> >>> without making changes to ipq9574 since the "reg" constraint is different
> >>> between the two. And this in turn would break the ABI w.r.t. ipq9574.
> >>
> >> I don't get why this is not possible. You have one list for ipq9574 and
> >> existing compatible devices, and you add second list for new device.
> >>
> >> ... or you just keep existing order. Why you need to keep changing order
> >> every time you add new device?
> >
> > Presently, sdx55 and ipq9574 have the following reg/reg-names constraints.
> >
> > 	compatible	| qcom,pcie-sdx55	| qcom,pcie-ipq9574
> > 	----------------+-----------------------+------------------
> >         reg	minItems| 5			| 5
> > 		maxItems| 6			| 5
> > 	----------------+-----------------------+------------------
> >         reg-names	|			|
> > 		minItems| 5			| 5
> > 	----------------+-----------------------+------------------
> > 		maxItems|			| 5 (6 for ipq5332)
> > 	----------------+-----------------------+------------------
> > 		items	|			|
> > 			| parf			| dbi
> > 			| dbi			| elbi
> > 			| elbi			| atu
> > 			| atu			| parf
> > 			| config		| config
> > 			| mhi			| (add mhi for ipq5332)
> > 	----------------+-----------------------+------------------
> >
> > To make ipq9574 as fallback for ipq5332, have to add "mhi" to reg-names of
> > ipq9574.
>
> only ipq5332 gets additional item, not ipq9574. Your sentence is not
> correct. You do not have to add mhi to ipq9574. Neither we, nor schema
> asked you to do this.
>
>
> > Once I add that, the sdx55 and ipq9574 is the same list but in
> > different order.
> >
>
> You cannot change the order in existing devices.

Ok.

> > If this would not be considered as duplication of the same constraint, then I
> > can club ipq5332 with ipq9574.
> >
> > If this would be considered as duplication, then sdx55 and ipq9574 would have to
> > use the same reg-names list and sdx55 or ipq9574 reg-names order would change.
> >
> >>> To overcome this, two approaches seem to be availabe
> >>>
> >>> 	1. Document that ipq9574 is impacted and rework these patches to
> >>> 	   minimize the impact as much as possible
> >>
> >> What impact? What is the reason to impact ipq9574? What is the actual issue?
> >
> > By impact, I meant the change in the reg-names order as mentioned above (for
> > considered as duplication).
>
> Then you must eliminate the impact, not minimize it.

Ok.

> >>> 		(or)
> >>>
> >>> 	2. Handle ipq5332 as a separate compatible (without fallback) and reuse
> >>> 	   the constraints of sdx55 for "reg" and ipq9574 for the others (like
> >>> 	   clock etc.). This approach will also have to revert [1], as it
> >>> 	   assumes ipq9574 as fallback.
> >>>
> >>> Please advice which of the above would be appropriate. If there is a better 3rd
> >>> alternative please let me know, will align with that approach.
> >>
> >> Keep existing order. Why every time we see new device, it comes up with
> >> a different order?
> >
> > Will be able to do that based on the answer to 'duplication' question and how to
> > handle that.
>
> I don't understand what is duplication of something here.

By duplication, I meant the same set of reg-names (in different order).

> > 	if (adding mhi to ipq9574 reg-names != duplication)
> >
> > 		/* Keep existing order */
> >
> > 		* Append "mhi" to ipq9574
>
> ipq9574 does not have mhi, does it?

ipq9574 also has it.

> If it has, it should be separate patch with its own explanation of the
> hardware.

Will discard these patches from the patchset -

	dt-bindings: PCI: qcom: Use sdx55 reg description for ipq9574 Varadarajan Narayanan
	arm64: dts: qcom: ipq9574: Reorder reg and reg-names Varadarajan Narayanan

Will add mhi for ipq9574 and post the next version. Is that ok?

Thanks
Varada

