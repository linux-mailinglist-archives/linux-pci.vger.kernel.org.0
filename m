Return-Path: <linux-pci+bounces-6552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7CC8ADD5A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 08:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D048C28362B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 06:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35337225D7;
	Tue, 23 Apr 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TaTSjEEk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB0224F0;
	Tue, 23 Apr 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713852711; cv=none; b=X4/hh3h8M7SPPuHL8gL8YDkT0HCUR9WeFrmNMunDPIV1GenXpKtziaCwSRrvfjkeel7FvyAvsyTO+wVtPMQNTR4AHOB3WgYmF/9WviVNoZPwfVr7Fz2MnxS4VsOfpintvqen5iVtzTgd6CuamSlO0ZIezD8BEUxiO8uMp+uhuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713852711; c=relaxed/simple;
	bh=V7YpzEldJuTIV+Gf8sRePNx21jL0GM8qS7CvTMlG9Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Je2hIx/vdypa9adFYSqdQ9ZyobgEKE609S0PdhxGvUHx4ZU17kAZc/9ynr/U3SRgR4ivJMPs4TrNxfZ2TMBcmtWBwTW24w/zthnZBqUKNqxIVWS4NashmHLuYvyckS7U4ECupRfuItyuqRULYl4Jqkw9ohT9MIJIdVmLNKLBPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TaTSjEEk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N4ScPH016909;
	Tue, 23 Apr 2024 06:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tx5yxKtp0kmfVS31LxuwTSnEJXTe36IJzRgldANyxok=; b=Ta
	TSjEEkFxtUhCgqElvUis+oxGqi3MmrkL88jeixE+57Jed+07gPIK+74wRwMcQB9N
	VIIKjBW67ZFqp0D/0oHF04rEUSln9j4LBoPczZO4/TKnABqfEiAvh1TBfkH2VdVj
	6DnE5hkR8qPv0Mg8zG8zi3+ziFjjvJt/yJzoXVezo1xcrrvuQolYAKmJk2s3rh7P
	IK3OC1UTxuElG/gD1cmM7mwH46l3t/bkOrcBVhPB8x30OMPZ8USWzz19jlVvjuLR
	Zp+BWEiWLvu5DiLpsx8HthCxltZRhlBI2lyDVRl5HpOOnuP1UlcffxND3Tow7Q6G
	xZaTVtMBtwTBnOxrUpcw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnr0mj24b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:11:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43N6BSmP001076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:11:28 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 23:11:22 -0700
Message-ID: <b9081a61-c159-4659-a5e1-5586bb65dfce@quicinc.com>
Date: Tue, 23 Apr 2024 11:41:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] ipq9574: Enable PCI-Express support
To: <mr.nuke.me@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul
	<vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Michael
 Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <4a83afeb-8e82-4f95-b44e-74d39d55f448@quicinc.com>
 <c498f5b9-df07-0802-800c-67c18dcf3e67@gmail.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <c498f5b9-df07-0802-800c-67c18dcf3e67@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QuHGmmjbEFMUabia_uEJdttfqNqw857e
X-Proofpoint-ORIG-GUID: QuHGmmjbEFMUabia_uEJdttfqNqw857e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230017



On 4/20/2024 1:17 AM, mr.nuke.me@gmail.com wrote:
> Hi Kathiravan,
> 
> On 4/19/24 09:28, Kathiravan Thirumoorthy wrote:
>>
>>
>> On 4/15/2024 11:50 PM, Alexandru Gagniuc wrote:
>>> There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
>>> addresses pcie2, which is a gen3x2 port. The board I have only uses
>>> pcie2, and that's the only one enabled in this series.
>>>
>>> I believe this makes sense as a monolithic series, as the individual
>>> pieces are not that useful by themselves.
>>>
>>> In v2, I've had some issues regarding the dt schema checks. For
>>> transparency, I used the following test invocations to test v3:
>>>
>>>        make dt_binding_check 
>>> DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>>        make dtbs_check 
>>> DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>>
>>>
>>
>> Alexandru,
>>
>> Thanks for your contributions to the Qualcomm IPQ chipsets.
>>
>> I would like to inform you that we have also submitted the patches to 
>> enable the PCIe support on IPQ9574[1][2] and waiting for the ICC 
>> support[3] to land to enable the NOC clocks.
>>
>> [1] 
>> https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/
>> [2] 
>> https://lore.kernel.org/linux-arm-msm/20230519085723.15601-1-quic_devipriy@quicinc.com/
>> [3] 
>> https://lore.kernel.org/linux-arm-msm/20240418092305.2337429-1-quic_varada@quicinc.com/
>>
>> Please take a look at these patches as well.
> 
> I think I've seen [1] before -- I thought the series was abandoned. 
> Since we have the dt-schema and applicability on mainline resolved here, 
> do you want to use this series as the base for any new PCIe work?


Sure Alex. I believe some of the code review comments are already 
addressed in the series which I pointed out. If you could have picked 
those and re-posted the next version, it could have been better.


> 
> Alex
> 
>> Thanks,
>> Kathiravan T.
>>
>>
>>> Changes since v2:
>>>   - reworked resets in qcom,pcie.yaml to resolve dt schema errors
>>>   - constrained "reg" in qcom,pcie.yaml
>>>   - reworked min/max intems in qcom,ipq8074-qmp-pcie-phy.yaml
>>>   - dropped msi-parent for pcie node, as it is handled by "msi" IRQ
>>>
>>> Changes since v1:
>>>   - updated new tables in phy-qcom-qmp-pcie.c to use lowercase hex 
>>> numbers
>>>   - reorganized qcom,ipq8074-qmp-pcie-phy.yaml to use a single list 
>>> of clocks
>>>   - reorganized qcom,pcie.yaml to include clocks+resets per compatible
>>>   - Renamed "pcie2_qmp_phy" label to "pcie2_phy"
>>>   - moved "ranges" property of pcie@20000000 higher up
>>>
>>> Alexandru Gagniuc (7):
>>>    dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
>>>    clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
>>>    dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
>>>    PCI: qcom: Add support for IPQ9574
>>>    dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
>>>    phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
>>>    arm64: dts: qcom: ipq9574: add PCIe2 nodes
>>>
>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    |  35 +++++
>>>   .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |  36 ++++-
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  93 +++++++++++-
>>>   drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++++
>>>   drivers/pci/controller/dwc/pcie-qcom.c        |  13 +-
>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
>>>   8 files changed, 400 insertions(+), 7 deletions(-)
>>>

