Return-Path: <linux-pci+bounces-11327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77111947FE6
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 19:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71051C219E5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A715D5B3;
	Mon,  5 Aug 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TetueUjq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7713A3F7;
	Mon,  5 Aug 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877655; cv=none; b=HDnI2ocu+BJmZLWe8ctJQP3C+K1p0Nz7Yu/qQll+sjQlmxxPFZxgAmJkkYhi9D31SO+aS7SQTR886yAyVkuE1IyIG1kbvQipEeJC6OK9gQU18ESojkSIyK8+mUhXcS9xSSOvKyVz/Yscyb4sbnaC5zTM8KfW8VL1Fa51j1V0MLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877655; c=relaxed/simple;
	bh=JfZxCg6OCYN626PmQwPupS1uhH3QJn9QIngyl3urQQg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT1LBFHCKXLTdeFV7AYJUoPkDEcr+/sGSIHEATJbt/+zkSlIq9vbC1Cn1bRNWR/61NvxttqJeJ9SEzsxKvkLgYB9OHQxJfiaPkrhAyAezrNspHt9o1jRFLkBY+YRDeXZQ79WG5ltsYe6ze5F1WsFJ5TMKEEgxXgC2LCWwcx1RPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TetueUjq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475B6lut019966;
	Mon, 5 Aug 2024 17:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iTIE/RWlHBp/IG7QNXkrBTPg
	IxQudmXaah/9Ww2wKtM=; b=TetueUjqkU5VEIX5Npoif1Qa4yT3cDTjcnCY0usv
	BxTDZ3yb4yWhLOO3texo+dqejRUzjwzr12tFoQJDD/6gNLjfr478MXiFn3sRc5Z7
	Cwo6rrjN2x5a85T3v9mi8m9tMm/y7UKri61I2IRZHNiE7/tqHoCWj6GmTjNa0eR6
	7qYeCAKloJJO+wfxYQAfFzokVSgZBu5ObbdISABZm1M+AXpXc7E/au2hue6B2Jvz
	jquxUCsOxuBA4wqiQFPEiGBqx0mnETXOlWMrJQw/3rbt89eBLfONVH3fssiUMcku
	d4yi51WN2N9n41E4zsDE1t5TLYOzKMosYvS71HvLb6exJg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scs2vnb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 17:07:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 475H7NrA017406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 17:07:23 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 5 Aug 2024 10:07:23 -0700
Date: Mon, 5 Aug 2024 10:07:22 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
Message-ID: <ZrEGypbL85buXEsO@hu-bjorande-lv.qualcomm.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <5f65905c-f1e4-4f52-ba7c-10c1a4892e30@kernel.org>
 <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vgtHegpDuIEmucgfpT0ed6Su4_jIHp7M
X-Proofpoint-GUID: vgtHegpDuIEmucgfpT0ed6Su4_jIHp7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_05,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=668 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050123

On Mon, Aug 05, 2024 at 09:41:26AM +0530, Krishna Chaitanya Chundru wrote:
> On 8/4/2024 2:23 PM, Krzysztof Kozlowski wrote:
> > On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
[..]
> > > +  qps615,axi-clk-freq-hz:
> > > +    description:
> > > +      AXI clock which internal bus of the switch.
> > 
> > No need, use CCF.
> > 
> ack

This is a clock that's internal to the QPS615, so there's no clock
controller involved and hence I don't think CCF is applicable.

Regards,
Bjorn

