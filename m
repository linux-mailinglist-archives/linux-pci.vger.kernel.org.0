Return-Path: <linux-pci+bounces-19423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1DDA04292
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CCF3A21D0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDE1F2362;
	Tue,  7 Jan 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W+PH0fHY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB481F1934;
	Tue,  7 Jan 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260121; cv=none; b=qKro/9Mg4yWuCOy/FKKndKliNhk62Lwdai+wESnQZ9oYhXvjuQfN5dWAeaKTrsDEH9Xd4jFyX0wsQ0hRKblFj8YK5THu6fvIAQN2AKjAnNv4Hs2ygii5mKitRxBN18dUx3yB4tcUVWGKyVQ6b59/ozQKuB3/MgJD/ppqwEpHsas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260121; c=relaxed/simple;
	bh=jt0g4HQC2ApGULGRSdheIj7kpFpp7zOFQDxoRPUkF9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S4avYNDtzfBkHFgzzFCbfiOlSdH47raklE05l+lf1dns4UMJuuNpUYhUS7qBoKiO0ny3PNunCdr0Kum+ceDCns1ZmbwX5dXOu3B598Q7shsS4IFTi5iWIRdn6pUyJMvIWBPqFCUFMz0esn9SeyoZZqB46wfsM9RrDIiQMfjxy0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W+PH0fHY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5078Ah8B015107;
	Tue, 7 Jan 2025 14:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mqrVUNW49lzpKto+HQEZxkSB8vhFVth/PJTNQPwkFXA=; b=W+PH0fHY9LS886oM
	tiC3rRXgS7rxepEsnw2sE1wAAA2ndr8qPLAw3ziTcokbhFzAQ3X8ih5okOnW49NJ
	SCaHiPkIWanDZ+lLk0RS1zv4XcAUEA98hPGXgvtuQ3Hlu9C/j333x3zSONOOxTDL
	7hJi8x8TaH4yQt1d/izU1dqRzTqK7KpNuaEV4QMHMDJOCCBH4r/xsMQ7XG3Jp5Lv
	QzT0/DHULm1dEwN3ebnWQ9OJeIpOzsAhd7Zi0v97khAC/Hx3Be7KGJwrI9qJv2mr
	993PSMHF7I3yFQ6dYFzwNIfTYz7puGRxFLeCZQv9GNv72p0O7gtf5xYRylUYAaZz
	4T7DTQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4410he8w2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:28:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507ESRok002693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 14:28:27 GMT
Received: from [10.216.0.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 Jan 2025
 06:28:21 -0800
Message-ID: <d4019981-1df2-0946-d093-7dc97c2d0ffe@quicinc.com>
Date: Tue, 7 Jan 2025 19:58:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241115161848.GA2961450-robh@kernel.org>
 <74eaef67-18f2-c2a1-1b9c-ac97cefecc54@quicinc.com>
 <kssmfrzgo7ljxveys4rh5wqyaottufhjsdjnro7k7h7e6fdgcl@i7tdpohtny2x>
 <20241230182201.4nem2dvg4lg5vdjv@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241230182201.4nem2dvg4lg5vdjv@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E7FtCkCRsb3BbOWdHcURCfaI4K4ENAeN
X-Proofpoint-ORIG-GUID: E7FtCkCRsb3BbOWdHcURCfaI4K4ENAeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=844 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070121



On 12/30/2024 11:52 PM, Manivannan Sadhasivam wrote:
> On Mon, Dec 23, 2024 at 08:57:37PM +0200, Dmitry Baryshkov wrote:
> 
> [...]
> 
>>> This switch allows us to configure both upstream, downstream ports and
>>> also embedded Ethernet port which is internal to the switch. These
>>> properties are applicable for all of those.
>>>>> +
>>>>> +    allOf:
>>>>> +      - $ref: /schemas/pci/pci-bus.yaml#
>>>>
>>>> pci-pci-bridge.yaml is more specific and closer to what this device is.
>>>>
>>> I tried this now, I was getting warning saying the compatible
>>> /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
>>> pcie@0,0: compatible: ['pci1179,0623'] does not contain items matching the
>>> given schema
>>>          from schema $id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
>>> /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
>>> pcie@0,0: Unevaluated properties are not allowed ('#address-cells',
>>> '#size-cells', 'bus-range', 'device_type', 'ranges' were unexpected)
>>>
>>> I think pci-pci-bridge is expecting the compatible string in this format
>>> only "pciclass,0604".
>>
>> I think the pci-pci-bridge schema requires to have "pciclass,0604" among
>> other compatibles. So you should be able to do something like:
>>
>> compatible = "pci1179,0623", "pciclass,0604";
>>
> 
> Even though a PCIe switch is supposed to be a network of PCI bridges, using
> PCI bridge fallback for this switch is not technically correct IMO. Mostly
> because, this switch requires other configurations which are not applicable to
> PCI bridges. So the drivers matching against the bridge compatible won't be able
> to use this switch.
> 
> - Mani
Rob,

Using pci-pci-bridge expects to use compatible as pciclass,0604, we
can't  use as this switch is doing other configurations which are
applicable to PCI bridges. can we continue to use pci-bus.yaml.

- Krishna Chaitanya.
> 

