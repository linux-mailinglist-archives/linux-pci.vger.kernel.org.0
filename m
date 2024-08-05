Return-Path: <linux-pci+bounces-11323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F7947F76
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 18:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4D72838FC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562915B13B;
	Mon,  5 Aug 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PRF0WJdf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF517C64;
	Mon,  5 Aug 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875968; cv=none; b=YghtJNPaXpsL2uHQ++QXOPAdRTlYhocb7FR3xZ//RN6ElUkMLPk9TnWAeDPDMhXuTCct8dyxEi3HVC/a9doaKHH9Ge0Mf6ApzDPndWlhW+dNPEOIVk/ZIrkw6QW5pec/AGo583+7pFa+J01rAFwmqD2AagjSQdizgAh0/T321q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875968; c=relaxed/simple;
	bh=zqwsJogRsqtU3bUACFfX+/cmOYbVRTFNZ/0qrLgqpnc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAA9FDxD7+T+Mr4731ScfJFvGJ134FGzWzWA8LT6NOhCBV2I/zyT4ILKqw+Be29gkBpJkaJdRwt9+iRANNX79Js4N4BtufRdgkxwciE83q2Q4iaemsm6J5emDQTb1TXvqaeuVLCDqx+QKUpcCkzy55XuXXzuOf76HKbmJNIOfoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PRF0WJdf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758mut6031919;
	Mon, 5 Aug 2024 16:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Pa0Hm88WRNUmw6FmmUwguzrX
	XsAyfma1gR/YQ9GKDO0=; b=PRF0WJdfEU75M9Yhwcakh3lR9Q75MpiT5j3tBHPh
	HtDrQWkwhjIWncXO7/SLbbfGmVqjhBoLJX12+/In+36rnz5tS8pn1XVjWF/Qu1L3
	y3XjK6PxLb8bcockAQ2Qso5/cUyipn6LAPjkyLEpUa9RaIz9dL2dFSDFcvUtHHbx
	VIJXI0iahVyXA205nYBT18FhGhVMPGtm9nUGvL6bqY0oHhifcT34N+jniGwpXayO
	0pz0E8BZp7iltSknhxhuhxx0iho3BecXo3sXAJIzna+wz7AgJ+/BtfEODYXG0yuf
	QQ6VFc7yRTm1HSlcmH51HWftXMNRo+tJ82FkKuI0GlWLmQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40tuhvs9n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 16:39:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 475Gd8kf015419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 16:39:08 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 5 Aug 2024 09:39:08 -0700
Date: Mon, 5 Aug 2024 09:39:07 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
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
Message-ID: <ZrEAKxktYXFyxWXy@hu-bjorande-lv.qualcomm.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <0cdaa0b2-ae50-40a1-abbb-7a6702d54ad5@kernel.org>
 <027dc9f7-6e0d-e331-8f90-92a3d56350ab@quicinc.com>
 <132a0367-596b-4ff2-b35c-e81e77f14340@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <132a0367-596b-4ff2-b35c-e81e77f14340@kernel.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Az-LPWfLHA63KTrTTkCGo2iyQubvQKdf
X-Proofpoint-GUID: Az-LPWfLHA63KTrTTkCGo2iyQubvQKdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_05,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050119

On Mon, Aug 05, 2024 at 07:12:34AM +0200, Krzysztof Kozlowski wrote:
> On 05/08/2024 06:02, Krishna Chaitanya Chundru wrote:
> > 
> > 
> > On 8/4/2024 2:26 PM, Krzysztof Kozlowski wrote:
> >> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
> >>> Add binding describing the Qualcomm PCIe switch, QPS615,
> >>> which provides Ethernet MAC integrated to the 3rd downstream port
> >>> and two downstream PCIe ports.
> >>>
> >>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> >>> ---
> >>>   .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 +++++++++++++++++++++
> >>>   1 file changed, 191 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> >>> new file mode 100644
> >>> index 000000000000..ea0c953ee56f
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> >>> @@ -0,0 +1,191 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Qualcomm QPS615 PCIe switch
> >>> +
> >>> +maintainers:
> >>> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
> >>> +
> >>> +description: |
> >>> +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
> >>> +  ports. The 3rd downstream port has integrated endpoint device of
> >>> +  Ethernet MAC. Other two downstream ports are supposed to connect
> >>> +  to external device.
> >>> +
> >>> +  The QPS615 PCIe switch can be configured through I2C interface before
> >>> +  PCIe link is established to change FTS, ASPM related entry delays,
> >>> +  tx amplitude etc for better power efficiency and functionality.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - pci1179,0623
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  qcom,qps615-controller:
> >>
> >> and now I see that you totally ignored comments. Repeating the same over
> >> and over is a waste of time.
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It seems my or other reviewer's previous comments were not fully
> >> addressed. Maybe the feedback got lost between the quotes, maybe you
> >> just forgot to apply it. Please go back to the previous discussion and
> >> either implement all requested changes or keep discussing them.
> >>
> >> Thank you.

Well, thank you for the rant. Very helpful indeed.

> >> </form letter>
> >>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > Hi Krzysztof,
> > 
> > In patch1 we are trying to add reference of i2c-adapter, you suggested
> > to use i2c-bus for that. we got comments on the driver code not to use
> > adapter and instead use i2c client reference. I felt i2c-bus is not
> > ideal to represent i2c client device so used this name.
> 
> You did not respond to comment of using i2c-bus, just silently decided
> to implement other property.
> 

I guess you totally ignored my comment when you reviewed the previous
version, where I asked him to represent the device on said bus.

> Anyway, why i2c-bus is not suitable here? I am quite surprised...
> 

I was not aware that i2c-bus was an acceptable solution, sorry for my
bad suggestion and guidance here.

Regards,
Bjorn

> 
> 
> Best regards,
> Krzysztof
> 
> 

