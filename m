Return-Path: <linux-pci+bounces-13204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9067978D39
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 05:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1D31C22440
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 03:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDC175A1;
	Sat, 14 Sep 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dWZr7WPS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26D7344C;
	Sat, 14 Sep 2024 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726286386; cv=none; b=mxQryzgSJDWEsFcVjZ3DPqfx86xzBDpXzIgXnjQMoLndHjPPsoruHJejYYbNZe33nEq2YiDN2lvGlvwvU8nRv6wi3RqKBxTP8p0Sg5dT0q7ZjM3cMntOQ1yQVpM2+hB6nJDBkSSIGHUJMpet5pFNcuk34LhA5bUDV2Zk3X3b/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726286386; c=relaxed/simple;
	bh=06upt1Vs+/DbmoMxTZMYSr4eiBax5V3t8bLJ+fYqkVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rRF7LxcAA7MbS0aKi76XVJcASSlBx0I4TarwiPKYo4YfS32lS30OsbBgdmwUErMDD7IIxj09rOu3kX1NHGEQqtBahSQoiEKT58N3Lgg0hnTX5PfxdCk1XKVOlQJiN8Y8+Aa51Jl1Uz0ywJx+MJWmXu8G6AZh3XVuGyQp7120JmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dWZr7WPS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48E0K2rd029091;
	Sat, 14 Sep 2024 03:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iA/kORVBL6Wxi6a/guxYnyVIschyH2EOUiO0lvyRjFk=; b=dWZr7WPST3zK1SYM
	e5AOEV3hgapNEn59a8Z2qG7wO069I6mEu7jE0ozy6fcxiz9gQ+NKtIKHNBnlYXAo
	7Uvpb4j5LwP267Fwtil94dNau2/Hm0S2+xKZO8M+uY59FFgcAJi4VR9Q5IeTWzSN
	j6iAal/17XtVTkSfdhwL8yW8i7EZgzZqFQuAgUfCr75fzzqPyKY/rErTzIC0/cG+
	Z3BHZcx5TTVon3tybhzyTVz5p3WxL4RuVmOqArXjxjjXN/rbZe4bkT9ERRAUcZh/
	wOXmPsSep+Dd2tccayag0P42R+qnBmH13skPiIzDIZHzpM+ZNws6XnlkbubpMTVs
	6/1r1A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41myumrarv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Sep 2024 03:59:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48E3xUFo030003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Sep 2024 03:59:30 GMT
Received: from [10.216.29.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Sep
 2024 20:59:22 -0700
Message-ID: <36bd9f69-e263-08a1-af07-45185ea03671@quicinc.com>
Date: Sat, 14 Sep 2024 09:29:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/5] Add support for PCIe3 on x1e80100
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>
CC: <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zFX8fzgqJUywOZLiwxkJshUCOO-16e_o
X-Proofpoint-GUID: zFX8fzgqJUywOZLiwxkJshUCOO-16e_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409140026

Hi qiang,

In next series can you add logic in controller driver
to have new ops for this x1e80100 since this hardware
has smmuv3 support but currently the ops_1_9_0 ops which
is being used has configuring bdf to sid table which will
be not present for this devices.


- Krishna Chaitanya.

On 9/13/2024 2:07 PM, Qiang Yu wrote:
> This series add support for PCIe3 on x1e80100.
> 
> PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
> PHY configuration compare other PCIe instances on x1e80100. Hence add
> required resource configuration and usage for PCIe3.
> 
> v2->v1:
> 1. Squash [PATCH 1/8], [PATCH 2/8],[PATCH 3/8] into one patch and make the
>     indentation consistent.
> 2. Put dts patch at the end of the patchset.
> 3. Put dt-binding patch at the first of the patchset.
> 4. Add a new patch where opp-table is added in dt-binding to avoid dtbs
>     checking error.
> 5. Remove GCC_PCIE_3_AUX_CLK, RPMH_CXO_CLK, put in TCSR_PCIE_8L_CLKREF_EN
>     as ref.
> 6. Remove lane_broadcasting.
> 7. Add 64 bit bar, Remove GCC_PCIE_3_PIPE_CLK_SRC,
>     GCC_CFG_NOC_PCIE_ANOC_SOUTH_AHB_CLK is changed to
>     GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK.
> 8. Add Reviewed-by tag.
> 9. Remove [PATCH 7/8], [PATCH 8/8].
> 
> Qiang Yu (5):
>    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100
>      QMP PCIe PHY Gen4 x8
>    dt-bindings: PCI: qcom: Add OPP table for X1E80100
>    phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3
>    clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
>    arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100
> 
>   .../bindings/pci/qcom,pcie-x1e80100.yaml      |   4 +
>   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   3 +
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 202 ++++++++++++++++-
>   drivers/clk/qcom/gcc-x1e80100.c               |  10 +-
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 211 ++++++++++++++++++
>   .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 +++
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
>   7 files changed, 468 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
> 

