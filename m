Return-Path: <linux-pci+bounces-4578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DE88737C8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 14:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D89A286369
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7B13173F;
	Wed,  6 Mar 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N/kKxGsH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28839130E53;
	Wed,  6 Mar 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732165; cv=none; b=ClvVatI71obYvivrjWllCgGDZkhzN58foXCA8EN4oBXEboOMZ+gFdPmKql/sy1J3C83rh1kZOcRkL31L35s27oHLgSB3gayw+pFlf3r7NrXWRG9Yl5dAJTDVOow7xbNdGedgvLhqwVdRWo6ykcZrWJ9bi3nhMkJJwb35opEh4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732165; c=relaxed/simple;
	bh=45rfJriq8pHTLWr4t7k5bjYjJj5l2xBOYzlRQciLBtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mzkjRCfvc3mjQLABKTb+FR5SzxhfUTg+F3l3WQxr/FPmgi8yq67M2+rEXFIwrt6+0p4fB0oBLiPeH1JPT2uCoE6Hhi8f1+tdFDaRtHbc1DGPYspT4lxrcw5KJmm3fW5t9TACabbtgR0vRWLF13Tuty5yFqHWgcv1JDw33AlWNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N/kKxGsH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42668Qg7020826;
	Wed, 6 Mar 2024 13:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xoHpZpwwQUQZQok0NwWkenfwu8JYTx3dNHbq+3VZ4PQ=; b=N/
	kKxGsHJEPtiLZxKmtQvnUvzWquGzPrnyOOi0iFmeqivp1ggD1s5Qs5d9WPtr0uPf
	CeGMKxYL6eqsbBsDdqjB/0JPDhrzjb1iK+0x9eWkP+nv4v8bAmTqsodzi8xMiT0r
	5QwZ2z/AipyNSWaD+pT+pUh7yqo+F8EXXuaLr4movpeHOsA8AtNeDglMVp5b6Ub6
	iarlV2a21cYlipIAc/Wt4F02PZ6dW1wlFHIFOCSybyceRvAyPVtrTeDGT2cgz808
	RVryyS1ZUzL9PLeGiI9n8Lk2HDMV40wZUJWQyL20CgOvm3ixC2JzASA4XR/sN8vc
	mL8RoZnCeQuRt8koL4yQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjy3rup5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 13:35:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426DZpMW018597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 13:35:51 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 05:35:43 -0800
Message-ID: <da971427-e3d3-88d4-b455-57b469c2fea8@quicinc.com>
Date: Wed, 6 Mar 2024 19:05:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 0/5] arm64: qcom: sa8775p: add support for EP PCIe
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <robh@kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_schintav@quicinc.com>,
        <quic_shijjose@quicinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhi@lists.linux.dev>
References: <1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com>
 <20240216105241.GB2559@thinkpad>
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20240216105241.GB2559@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q27V3CctFGVspXbA9dCVLk9ZDdGVC6f6
X-Proofpoint-ORIG-GUID: Q27V3CctFGVspXbA9dCVLk9ZDdGVC6f6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060109


On 2/16/2024 4:22 PM, Manivannan Sadhasivam wrote:
> On Fri, Dec 01, 2023 at 05:36:11PM +0530, Mrinmay Sarkar wrote:
>> This series adds the relavent DT bindings, new compatible string,
>> add support to EPF driver and add EP PCIe node in dtsi file for
>> ep pcie0 controller.
>>
> Applied patches 3 and 4 to pci/endpoint!
>
> - Mani
>
>> v8 -> v9:
>> - update author in "Add pci_epf_mhi_ prefix to the function" patch.
>> - add ack by and reviewed by tag in commit message.
>>
>> v7 -> v8:
>> - Add new patch PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function
>>    names
>> - Update PCI: epf-mhi: Add support for SA8775P patch on top of the new
>>    patch and update commit message.
>>
>> v6 -> v7:
>> - add reviewed by tag in commit message in all patches.
>> - update commit message in patch 2 as per comment.
>> - update reason for reusing PID in commit message.
>>
>> v5 -> v6:
>> - update cover letter.
>>
>> v4 -> v5:
>> - add maxItems to the respective field to constrain io space and
>>    interrupt in all variants.
>>
>> v3 -> v4:
>> - add maxItems field in dt bindings
>> - update comment in patch2
>> - dropped PHY driver patch as it is already applied [1]
>> - update comment in EPF driver patch
>> - update commect in dtsi and add iommus instead of iommu-map
>>
>> [1] https://lore.kernel.org/all/169804254205.383714.18423881810869732517.b4-ty@kernel.org/
>>
>> v2 -> v3:
>> - removed if/then schemas, added minItems for reg,
>>    reg-bnames, interrupt and interrupt-names instead.
>> - adding qcom,sa8775p-pcie-ep compitable for sa8775p
>>    as we have some specific change to add.
>> - reusing sm8450's pcs_misc num table as it is same as sa8775p.
>>    used appropriate namespace for pcs.
>> - remove const from sa8775p_header as kernel test robot
>>    throwing some warnings due to this.
>> - remove fallback compatiable as we are adding compatiable for sa8775p.
>>
>> v1 -> v2:
>> - update description for dma
>> - Reusing qcom,sdx55-pcie-ep compatibe so remove compaitable
>>    for sa8775p
>> - sort the defines in phy header file and remove extra defines
>> - add const in return type pci_epf_header and remove MHI_EPF_USE_DMA
>>    flag as hdma patch is not ready
>> - add fallback compatiable as qcom,sdx55-pcie-ep, add iommu property
>>
>>
>> Manivannan Sadhasivam (1):
>>    PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names
>>
>> Mrinmay Sarkar (4):
>>    dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
>>    PCI: qcom-ep: Add support for SA8775P SOC
>>    PCI: epf-mhi: Add support for SA8775P
>>    arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
>>
>>   .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 ++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
>>   drivers/pci/endpoint/functions/pci-epf-mhi.c       | 21 ++++++-
>>   4 files changed, 128 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.7.4
Thanks for applying patches 3 and 4.

Seems like patches 1,2 and 5 are yet to apply on linux-next.
Please help me by applying those patches.

Thanks,
Mrinmay
>>
>>

