Return-Path: <linux-pci+bounces-4072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B98687A0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 04:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE781C218CE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 03:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDAD1B7E9;
	Tue, 27 Feb 2024 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g1HFiLex"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FA1F947;
	Tue, 27 Feb 2024 03:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003715; cv=none; b=Kvt5S6vNTC3Npzq+92zNGR8qyiq84GUmNeepuwShETO6b/TOENANqDP+ItXRGuHPiOhN01C5t7FSD6whLBDXGZnsqlumkqJ37dKbbh2VW/5l/QTbFi5pHJdGE9t3Ni1D09PyS/7zlzooXXApE2rS4oqn0Thwk9QoXZZ2hlmL7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003715; c=relaxed/simple;
	bh=zvPm5PzDdLsLLfyUhF6DNmti8ozkQ94Jv6QvBNkp2wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XJCQKsGOeDnzCTKjIR9RGENx3ZHQo5zKKiTQU/+mqonwXYak0iHD7RHGGqUIczuFgWESlZ9JiyQUiZthwNQ68M+6aOhMSxs3F4nUvG7+RU5gAvqyrcQkun+/zk2ztnekw0K1sn0wzUPg3G+bv7R+m+SdGjBcFFINH/UL7OKyUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g1HFiLex; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R2T0eR032284;
	Tue, 27 Feb 2024 03:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6KBaG3igfsBnKJhPA45En8jYeIyXoOOVGsO8fBNA/HU=; b=g1
	HFiLexIJmYPiXOFpbBspBe+ex45h+7FHUVlKm4u15Ni9mFoepDW/8jIoEt79WWbX
	Zho0PO/IhtwdHGyuEcdMK0aY0HXpg8C++0bxy6gWtrtwL1sitoFQRlPbCbuNMy3S
	ivRNNwjQWJt2H+nB3EMnmzLOrkNqtqY68vapMDcPI952WaIyZgo1Y/VNDvH5rL8m
	h8uW12uwkBeFMnYWBdj3wWGdEKwu6hY7vhdWOXfpeyEIMaY0GGBMPQ9ElUmXZUWZ
	PiPTIKPUmrw806wsvIUUkgppYAYnaFeikuJrz3+V1O07Xbu2G6RpkjVQfoVHPXtq
	LDphH+n0c4gj6A4+A7iQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh50789ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 03:15:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R3F3ag025064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 03:15:03 GMT
Received: from [10.216.14.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 19:14:56 -0800
Message-ID: <c5e041dc-42b0-86f2-aba3-28d4db305c38@quicinc.com>
Date: Tue, 27 Feb 2024 08:44:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v7 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240223-opp_support-v7-0-10b4363d7e71@quicinc.com>
 <20240223-opp_support-v7-3-10b4363d7e71@quicinc.com>
 <53f486d1-94c7-4dd9-89fc-d80a92301700@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <53f486d1-94c7-4dd9-89fc-d80a92301700@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NagUTDU7pvt2aIge6frUEj6VXHrP0rNI
X-Proofpoint-GUID: NagUTDU7pvt2aIge6frUEj6VXHrP0rNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270024



On 2/24/2024 5:32 AM, Konrad Dybcio wrote:
> On 23.02.2024 15:48, Krishna chaitanya chundru wrote:
>> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
>> ICC(interconnect consumers) path should be voted otherwise it may
>> lead to NoC(Network on chip) timeout. We are surviving because of
>> other driver vote for this path.
>> As there is less access on this path compared to PCIe to mem path
>> add minimum vote i.e 1KBps bandwidth always.
>>
>> In suspend remove the disable this path after register space access
>> is done.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
> 
> [...]
> 
>>   
>> +	/* Remove cpu path vote after all the register access is done */
>> +	ret = icc_disable(pcie->icc_cpu);
>> +	if (ret) {
>> +		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);
>> +		if (pcie->suspended) {
>> +			qcom_pcie_host_init(&pcie->pci->pp);
>> +			pcie->suspended = false;
>> +		}
>> +		qcom_pcie_icc_opp_update(pcie);
> 
> This doesn't compile (you rename it in patch 6, this is patch 3)
> 
> Konrad
> 
I will fix this in my next series.

- Krishna Chaitanya.

