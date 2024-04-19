Return-Path: <linux-pci+bounces-6482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F78AB0C5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5208B23AD5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA11C12EBD8;
	Fri, 19 Apr 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CGzj7yAj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA312E1F6;
	Fri, 19 Apr 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536923; cv=none; b=MHvCP6dgX0R1jRtki7o8PFzTJ9Ywg03PdiaeuLAJe5ddLwHkmGphDMJYQi+PxS06Xw3QltUL0eyoRtLDt1CpDI6B4JYVJzNtUKNFWBihT7F0huhZMLC+wPV/sgVtTlXzPMRxcBPDSh6nHvCgLVdgyTvgpl19zS+F7NAsksUEMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536923; c=relaxed/simple;
	bh=w4dSRLxO7SADjX8lbbGLrNHxtnVtV8dTjvr+uJLW3ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sUcTtv2knHS7fvm+pO/E6vjeKaxyY6UB3EZbGWVZlRsk0Yguo8hgtzaugQbYPL6vJU2ZS4gKLEwGhaj1OG/Y0Ym5MLBVbjmgJ7P/6GZb4t394+gYiQrFh3qdvNVhue1Pw7P/EtYmd8Xi/+IbXRU5Khpave8yOr51B6YFBgb9Eek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CGzj7yAj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JD629E017627;
	Fri, 19 Apr 2024 14:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/7AD6EwruIBOLZzV5oOINOaZDwI2eqymeSzVhuKzQpE=; b=CG
	zj7yAjeTYIKlJiJJQI0tO4qcKFU7GuUcwUEwtkUcsUvhUavs9TkZPFggqACOreAb
	4bWREDIo+WThsQg1Px+oBKzPUhuZS4r/antob7rPievHyz4dPEizvq6E1ED5qtkT
	3XGtcksOEJdE7tjB65Sqo2Oef6uToIPIlW0Vv6cj70aXBjE08ND6U4AGenY72/dd
	Xe9451BsEbN+Lwh0tdVvItLgv3xfdqQm+Z0EWPlS+VPKp17emLSxEZG6H06Lel9Z
	F964EEhJLpUcEfqpbY7CQIVKYE1INxqMXYL3p17F1s53CVftBP89tO2Ezil1Jtus
	OLlh4SsOYtXwqPDNW+pA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xks6s8550-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:28:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JESL0M014875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:28:21 GMT
Received: from [10.216.17.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 07:28:13 -0700
Message-ID: <4a83afeb-8e82-4f95-b44e-74d39d55f448@quicinc.com>
Date: Fri, 19 Apr 2024 19:58:08 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] ipq9574: Enable PCI-Express support
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo
 Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen
 Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240415182052.374494-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f5HZFmDXBrCPKCpPNSOydsESSpTxuWBO
X-Proofpoint-ORIG-GUID: f5HZFmDXBrCPKCpPNSOydsESSpTxuWBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_09,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190108



On 4/15/2024 11:50 PM, Alexandru Gagniuc wrote:
> There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
> addresses pcie2, which is a gen3x2 port. The board I have only uses
> pcie2, and that's the only one enabled in this series.
> 
> I believe this makes sense as a monolithic series, as the individual
> pieces are not that useful by themselves.
> 
> In v2, I've had some issues regarding the dt schema checks. For
> transparency, I used the following test invocations to test v3:
> 
>        make dt_binding_check     DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>        make dtbs_check           DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
> 
> 

Alexandru,

Thanks for your contributions to the Qualcomm IPQ chipsets.

I would like to inform you that we have also submitted the patches to 
enable the PCIe support on IPQ9574[1][2] and waiting for the ICC 
support[3] to land to enable the NOC clocks.

[1] 
https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/
[2] 
https://lore.kernel.org/linux-arm-msm/20230519085723.15601-1-quic_devipriy@quicinc.com/
[3] 
https://lore.kernel.org/linux-arm-msm/20240418092305.2337429-1-quic_varada@quicinc.com/

Please take a look at these patches as well.

Thanks,
Kathiravan T.


> Changes since v2:
>   - reworked resets in qcom,pcie.yaml to resolve dt schema errors
>   - constrained "reg" in qcom,pcie.yaml
>   - reworked min/max intems in qcom,ipq8074-qmp-pcie-phy.yaml
>   - dropped msi-parent for pcie node, as it is handled by "msi" IRQ
> 
> Changes since v1:
>   - updated new tables in phy-qcom-qmp-pcie.c to use lowercase hex numbers
>   - reorganized qcom,ipq8074-qmp-pcie-phy.yaml to use a single list of clocks
>   - reorganized qcom,pcie.yaml to include clocks+resets per compatible
>   - Renamed "pcie2_qmp_phy" label to "pcie2_phy"
>   - moved "ranges" property of pcie@20000000 higher up
> 
> Alexandru Gagniuc (7):
>    dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
>    clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
>    dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
>    PCI: qcom: Add support for IPQ9574
>    dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
>    phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
>    arm64: dts: qcom: ipq9574: add PCIe2 nodes
> 
>   .../devicetree/bindings/pci/qcom,pcie.yaml    |  35 +++++
>   .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |  36 ++++-
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  93 +++++++++++-
>   drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++++
>   drivers/pci/controller/dwc/pcie-qcom.c        |  13 +-
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>   include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
>   8 files changed, 400 insertions(+), 7 deletions(-)
> 

