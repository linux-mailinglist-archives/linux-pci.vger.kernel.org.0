Return-Path: <linux-pci+bounces-7399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062328C35C0
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 10:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8770C1F2139D
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E726179AE;
	Sun, 12 May 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="askoPFk3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B54CA40;
	Sun, 12 May 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715502954; cv=none; b=YVUlREDDeiUQmf1Ojxj/GmOgtUwQEbM9JbzlQBBY4oqEZVasY80lD8NV01H3M9VqZGWe+6CYUCM9MvabeHmTvCBQLflxXuzpPiIPset2+K6kxFdGJ9okzYnYscOENdmlEhyQG/PDVXnZD4nPxity9OqsIvV43O2wiEI0HSjiPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715502954; c=relaxed/simple;
	bh=AYAOGX2iykH9oRAdYbACeysu3pcN+xhSPwvPYtAF/u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ktk4c7LYWGvDLddpahZEgMQXNUvceO0g1jg5vp64HyQ6Ax+JzX2oyV0HmVdp/tW3U2lF1EWHLLxqog2622i/34b3u1VagPO5cyl2rqUwACHCzvnue9OPCkqLmN1gFRVFSvvyuQQZIt23eDibts+qiFZoG1ckoFgC3hhNAN7d3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=askoPFk3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44C7l93p030917;
	Sun, 12 May 2024 08:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Fofzy2llsdid6StBXTMQNjdLNqsuy2vO0XIxoDRwRQU=; b=as
	koPFk3XB0DgMlPA3842tl2FyFadbf596uEyEaiLHR5ngGr/aASQZKrCFs05ftQ+e
	KzbPe9I2HsPbKoR+VOZ5yDNGNFjCGkvNdmlAWsxU4aZEdC879A3sck6vU4PM+1Oi
	0tYGF/aC0AtV1AxkrnNl3pXQuaMMvwlrQof7OlQasOhZroN5/XGMwyxMuFI8P1eT
	uAMqk4SYI8pSTIjk2MD70BEpH+vTPzsu2rHYWkd+1/vd3YCIYQtjAJM3Z3Nx4RsM
	vQMk08W4oeBwGZuf7jmC+swHPCj3mU5l/a6ZIZXZHguU8mq8CQcb25ZeXaTuUCm5
	eYpPg9NlT3UmjjCh9ukA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y20rt9gyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:35:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44C8ZY6A015767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:35:34 GMT
Received: from [10.216.17.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 May
 2024 01:35:26 -0700
Message-ID: <d283bf55-8b7b-4873-b2e3-aade4231dc78@quicinc.com>
Date: Sun, 12 May 2024 14:05:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 0/8] ipq9574: Enable PCI-Express support
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
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
 <569087fe-e675-41a4-b975-2d01d95b6d3c@quicinc.com>
 <c3f99ece-7f66-4c6f-a262-4d8894154ae9@gmail.com>
Content-Language: en-US
From: Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <c3f99ece-7f66-4c6f-a262-4d8894154ae9@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aATPM805tWjekuvXtQyCUttm-CIsjzFz
X-Proofpoint-GUID: aATPM805tWjekuvXtQyCUttm-CIsjzFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_05,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405120064



On 5/8/2024 10:40 PM, mr.nuke.me@gmail.com wrote:
> On 5/8/24 1:16 AM, Devi Priya wrote:
>>
>>
>> On 5/1/2024 9:58 AM, Alexandru Gagniuc wrote:
>>> There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
>>> addresses pcie2, which is a gen3x2 port. The board I have only uses
>>> pcie2, and that's the only one enabled in this series. pcie3 is added
>>> as a special request, but is untested.
>>>
>>> I believe this makes sense as a monolithic series, as the individual
>>> pieces are not that useful by themselves.
>>
>> Hi Alexandru,
>>
>> As Dmitry suggested, we are working on enabling the PCIe NOC clocks
>> via Interconnect. We will be posting the PCIe series with
>> Interconnect support [1] shortly.
> 
> I am generally very hesitant to depend on unmerged series, as this can 
> cause undue delays. In this particular case, I considered that both 
> series can continue to stay independent, with the ability to convert the 
> PCIe users to the new clock scheme when the time is right.
> 
>> [1] - 
>> https://lore.kernel.org/linux-arm-msm/20240430064214.2030013-1-quic_varada@quicinc.com/
> 
> What changes would be needed to this series to make use of this? How 
> does one use the "interconnected" clocks?
> 
> Alex
Hi Alex,

Please refer to the latest PCIe series which adds support for enabling
the NoC clocks via interconnect.

https://lore.kernel.org/linux-arm-msm/20240512082858.1806694-1-quic_devipriy@quicinc.com/

Thanks & Regards,
S.Devi Priya
> 
>> Thanks,
>> S.Devi Priya
>>>
>>> In v2, I've had some issues regarding the dt schema checks. For
>>> transparency, I used the following test invocations to test:
>>>
>>>        make dt_binding_check 
>>> DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>>        make dtbs_check 
>>> DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>>
>>> Changes since v3:
>>>   - "const"ify .hw.init fields for the PCIE pipe clocks
>>>   - Used pciephy_v5_regs_layout instead of v4 in phy-qcom-qmp-pcie.c
>>>   - Included Manivannan's patch for qcom-pcie.c clocks
>>>   - Dropped redundant comments in "ranges" and "interrupt-map" of pcie2.
>>>   - Added pcie3 and pcie3_phy dts nodes
>>>   - Moved snoc and anoc clocks to PCIe controller from PHY
>>>
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
>>>    arm64: dts: qcom: ipq9574: add PCIe2 and PCIe3 nodes
>>>
>>> Manivannan Sadhasivam (1):
>>>    PCI: qcom: Switch to devm_clk_bulk_get_all() API to get the clocks
>>>      from Devicetree
>>>
>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    |  37 ++++
>>>   .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |   1 +
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 178 +++++++++++++++++-
>>>   drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++
>>>   drivers/pci/controller/dwc/pcie-qcom.c        | 164 +++-------------
>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 ++++++++++++-
>>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
>>>   8 files changed, 469 insertions(+), 141 deletions(-)
>>>

