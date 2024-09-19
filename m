Return-Path: <linux-pci+bounces-13295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA997CACF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 16:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3871F21827
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B919F473;
	Thu, 19 Sep 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MpkRbTIe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2519F438;
	Thu, 19 Sep 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755290; cv=none; b=PO+8DuNYeBYN0ugRG06cV9UwVKQUyrVn2bAVIE/tEZCjZYvdpJKGespgMZIB44cQ9YzeCjtD9MjEhYqGEiHwFLasLmCllHRN+tLo3/6f6Ebiccog++Hbzm8jWp6gClD3RNV/zIn+Avpr/63/lG/apSIHGb57tp0xpXCUqFNyYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755290; c=relaxed/simple;
	bh=RjxsbUcR9qCHtR8wLG/owNx92UM2sxrUQl6XkPcFPeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d4cAsM/74Y6/BD7CaBJhKCdKAhy/elISC9wrpEEexrPKTXgRIl1YLXVbFww5DwmCZ3lmmewuT5R4gXB8Lgvwgqdyztxi2gKI48SrpIlJjJS1qVdf/AyJBD7smQQqAaMpyNlPQkgeJ3tgW0UrelHpLdgDIoc3CZQlnM+Hr36eyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MpkRbTIe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J6ui9d024651;
	Thu, 19 Sep 2024 14:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nb+2JDRR/I2mRpqjg1Du/MQPJZAJ7gRJ9cmY1nhoiC0=; b=MpkRbTIe1KYoNk6G
	l+OvWA1NytZxLP35PZEjl99uCCEkkMiNbnGgeJNUwzS9Q1yAmrsi4jwTaO1hotWf
	gYcOKPy6VwA05nfrQ/yDRY//EPCO7Ka99z0gN/yQpwuC2RFI7e/H0foRoPcQEpf8
	Yem9T/9WSnjKlPdDhpi6aC/8LyMiSE3rbGudA6EV2ZcSpCm35lcDxLngw3MG+PtQ
	rnTlutEf4myt00w4+j16pHvRP44fpNRAfsllDZlcxDCxdLJm/gfqZLfNFJzY4mNV
	n4eXJ7tPR01vwLZPhDoLdVnKkFrDnlV71k7mWERZBdQ0aIw7Pzbuc/82vvx3bLOj
	P+NmgQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hhdknw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 14:14:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48JEEDbB029992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 14:14:13 GMT
Received: from [10.253.37.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Sep
 2024 07:14:08 -0700
Message-ID: <6f1118eb-89cf-4fd4-a35d-e8b98b0b7a8d@quicinc.com>
Date: Thu, 19 Sep 2024 22:14:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add support for PCIe3 on x1e80100
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>
CC: <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <36bd9f69-e263-08a1-af07-45185ea03671@quicinc.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <36bd9f69-e263-08a1-af07-45185ea03671@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _mdC1IH3zYXwxrLCQBtGo18Z4GNH8Uo0
X-Proofpoint-ORIG-GUID: _mdC1IH3zYXwxrLCQBtGo18Z4GNH8Uo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409190093


On 9/14/2024 11:59 AM, Krishna Chaitanya Chundru wrote:
> Hi qiang,
>
> In next series can you add logic in controller driver
> to have new ops for this x1e80100 since this hardware
> has smmuv3 support but currently the ops_1_9_0 ops which
> is being used has configuring bdf to sid table which will
> be not present for this devices.
>
Sure, bdf2sid map is not supported and required since we use smmuv3 for
pcie on x1e80100. Can I add a new ops which is same as ops_1_9_0 basically
and only config_sid callback is removed. Or add a new flag to determine if
we need to config bdf2sid map like no_l0s.

Hi Mani, what do you think about this?

Thanks,
Qiang
>
> - Krishna Chaitanya.
>
> On 9/13/2024 2:07 PM, Qiang Yu wrote:
>> This series add support for PCIe3 on x1e80100.
>>
>> PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
>> PHY configuration compare other PCIe instances on x1e80100. Hence add
>> required resource configuration and usage for PCIe3.
>>
>> v2->v1:
>> 1. Squash [PATCH 1/8], [PATCH 2/8],[PATCH 3/8] into one patch and 
>> make the
>>     indentation consistent.
>> 2. Put dts patch at the end of the patchset.
>> 3. Put dt-binding patch at the first of the patchset.
>> 4. Add a new patch where opp-table is added in dt-binding to avoid dtbs
>>     checking error.
>> 5. Remove GCC_PCIE_3_AUX_CLK, RPMH_CXO_CLK, put in 
>> TCSR_PCIE_8L_CLKREF_EN
>>     as ref.
>> 6. Remove lane_broadcasting.
>> 7. Add 64 bit bar, Remove GCC_PCIE_3_PIPE_CLK_SRC,
>>     GCC_CFG_NOC_PCIE_ANOC_SOUTH_AHB_CLK is changed to
>>     GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK.
>> 8. Add Reviewed-by tag.
>> 9. Remove [PATCH 7/8], [PATCH 8/8].
>>
>> Qiang Yu (5):
>>    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100
>>      QMP PCIe PHY Gen4 x8
>>    dt-bindings: PCI: qcom: Add OPP table for X1E80100
>>    phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3
>>    clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
>>    arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100
>>
>>   .../bindings/pci/qcom,pcie-x1e80100.yaml      |   4 +
>>   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   3 +
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 202 ++++++++++++++++-
>>   drivers/clk/qcom/gcc-x1e80100.c               |  10 +-
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 211 ++++++++++++++++++
>>   .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 +++
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
>>   7 files changed, 468 insertions(+), 6 deletions(-)
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
>>

