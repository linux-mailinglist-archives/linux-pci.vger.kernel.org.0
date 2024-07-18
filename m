Return-Path: <linux-pci+bounces-10486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206C993482C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 08:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955051F2366F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185A42078;
	Thu, 18 Jul 2024 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JinHSecY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0E273FD;
	Thu, 18 Jul 2024 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284801; cv=none; b=CL6HMmecOGUiHxHPUnI1n4PJQvrA4iM0YZS2fNBpthyytIu01mWCb6TnVJ1BXDY8YqqzEUL/QGs6ouOmZp/p+57oPwcTtUDAsXwzoepQS4ldovU9yo3wRuThHBig1XxsQ/uPQ3hpdAjYxqD0MFz+GqeLVpf+scsovAPpDZjpj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284801; c=relaxed/simple;
	bh=o89AGorTf23IgzPfJaytCNoM57GTR1/i487FcdWHjDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cf4rElYEjpB3dFip4Cx6VkFkNRNGX9v3gz3WW+4JnRBnrIyGeEndKvFZCrvikjPse2pgZyFMTO1bg/z40SuCwB0GazkL4l39ewwT3/vOUuYZDn78fmKMdKoav/0lLHuv1wntj5MpOvm58GVIsvhrRww+BxB1rrHz+2ckW/3Z6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JinHSecY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I20oT1002489;
	Thu, 18 Jul 2024 06:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PpRraKb5qMJnMbM32gBiIJu+HGLUV+zSLXSxhQycvVM=; b=JinHSecYS1+JZEYp
	eM35Kut17tjDH3YjUJgg0lPA2xSQhD+D7hWedG3bYjB8gf7kRAO3PJIZhWvPQPeY
	RlvkoMwKszzzE10Z9oWprI/pXRQjOHGHDvkHEHp8ju4PsCpV0JEUOu/2USm7JzaX
	qyDPoZ2SPGSSCE7HBBdQNb3t4789NPzkSQcfRKOrKBKLQmXjyGbjUO+j1eSBq2xJ
	JUZA/Yb8GgB9w1/wJ5gVsBHml1znpR1RXyiSPmg2AWzW/QM9MP83PiPY03wR4A9C
	arfXgV2ND0TELddJAt/VCIUNhS2SNb7qBZUpb7qxk2LQT9nEiwCqfeslEl6rZPMq
	oQrugw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs4hw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:39:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I6dl4Q031186
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:39:47 GMT
Received: from [10.151.37.100] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 23:39:42 -0700
Message-ID: <927af089-ecd0-4175-ab13-e6086aac9ce3@quicinc.com>
Date: Thu, 18 Jul 2024 12:09:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 2/4] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: devi priya <quic_devipriy@quicinc.com>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
 <20240716092347.2177153-3-quic_srichara@quicinc.com>
 <dbd172e0-d7c6-4ecc-b8cd-1329a4b03374@linaro.org>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <dbd172e0-d7c6-4ecc-b8cd-1329a4b03374@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8Zj3ozB_gM5C32iOdVbV2Kt30I2fnot6
X-Proofpoint-GUID: 8Zj3ozB_gM5C32iOdVbV2Kt30I2fnot6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_03,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=859 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180043



On 7/16/2024 5:33 PM, Konrad Dybcio wrote:
> On 16.07.2024 11:23 AM, Sricharan R wrote:
>> From: devi priya <quic_devipriy@quicinc.com>
>>
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
> [...]
>
>> +
>> +			ranges = <0x01000000 0x0 0x00000000 0x10200000 0x0 0x100000>,  /* I/O */
>> +				 <0x02000000 0x0 0x10300000 0x10300000 0x0 0x7d00000>; /* MEM */
> Drop these comments, please
ok
>> +
>> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> +
> Inconsistent newline
ok, will fix
>> +			interrupt-names = "msi0",
>> +					  "msi1",
>> +					  "msi2",
>> +					  "msi3",
>> +					  "msi4",
>> +					  "msi5",
>> +					  "msi6",
>> +					  "msi7";
>> +
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 0 35 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 0 49 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 0 84 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 0 85 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> Drop these comments, please
>
> (all these comments apply to all the similar nodes)
ok
> [...]
>
>> +
>> +		pcie3: pcie@18000000 {
>> +			compatible = "qcom,pcie-ipq9574";
>> +			reg =  <0x18000000 0xf1d>,
>> +			       <0x18000f20 0xa8>,
>> +			       <0x18001000 0x1000>,
>> +			       <0x000f0000 0x4000>,
>> +			       <0x18100000 0x1000>;
>> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <4>;
> Any reason the PCI domain for PCIeN is N+1? You can start at 0
ok, will fix

Regards,
  Sricharan

