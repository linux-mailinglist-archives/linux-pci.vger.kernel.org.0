Return-Path: <linux-pci+bounces-30009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71416ADE3B5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 08:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8622188F133
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F911891AB;
	Wed, 18 Jun 2025 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kMnf9/ps"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217AB14A82;
	Wed, 18 Jun 2025 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228229; cv=none; b=HHMy+5FOsIL2MYwFr3H3HJoYLKFcFWpXITXLDvbFyuNcrR9nUvB/reCtt8RJ0LIKe4SFdxXagFUu19JD1c/ZGO/tRZ2EW9Om4MzGilydAETtFGhIAiCUV+kT2uZgBJpAIb1K2fls1TH3Jno383neoqaWxs7XmDpf2phwTO7GiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228229; c=relaxed/simple;
	bh=WYYsAyYNCDXWl39jOOqsnoK/LvJ9/WMU77EIQhL6UYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KVjNujMbpUTp7W7Xv3Ko+sZetLNQLLETosgbaFo7WydBPEEiH684p+Hty0pNTG6/4DaTxYJg7tl+n2WuuEQXD9rAirMxXhmW4/wh52j9jZZJSGoH1RZYSjROtwG3ETRAjX9qt52P7LKE1/HpedJIwP4LgVhkPvDYie/O+BfH70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kMnf9/ps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNe2CA031861;
	Wed, 18 Jun 2025 06:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XBpiZTIP52dLbO4EiQ1O2XkE7KdeXc1MxyvCgM6rmxw=; b=kMnf9/psi4BSHA7A
	bJBMc5PVJU7r6+BS2foVqQxwxmZy5yvUVfHw5t2vW5Os64R3WDDuJTVpzaV03yRh
	Zsq6fja8dkOWRQw0Op5Jf4kb8C4TAZ4Zh/hH65Ch50R9tGPU84GRfhQFkHubbFk0
	yDPaZBzFcgJT2nAOxcG84x8f688fwRMiW3q/6lNOcSlmSE8zlhZtGhiFLHDFXn4m
	sljbUk9pxwW+pgAklDcCyDOFwu+HepE2nFv0omRfwlPtcxH1sbEZ8mhJJL832zIC
	Eurc23HFpB8iofYUTBdfyMR7jNUiDJcpsx/MY0nSyz9U7omXJkgUx4/iRbKXyeri
	18w9Eg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791enjvpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 06:30:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55I6UDZv018818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 06:30:13 GMT
Received: from [10.253.79.108] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Jun
 2025 23:30:07 -0700
Message-ID: <4748f657-8017-4794-9fe4-313af68603d0@quicinc.com>
Date: Wed, 18 Jun 2025 14:30:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: qcs615: enable pcie
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>, <kw@linux.com>,
        <conor+dt@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_qianyu@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
 <20250527072036.3599076-4-quic_ziyuzhan@quicinc.com>
 <lvquxxmdoom7pax6pf57cpdigwlwfbnxwqs5bverwdfopafqvc@qufo2bzyjilg>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <lvquxxmdoom7pax6pf57cpdigwlwfbnxwqs5bverwdfopafqvc@qufo2bzyjilg>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gWeAGAZGD6ef8JI40mBdVn7KxDTudKVK
X-Authority-Analysis: v=2.4 cv=D6RHKuRj c=1 sm=1 tr=0 ts=68525cf6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=kKiozkeNGAVY-bOXs7QA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gWeAGAZGD6ef8JI40mBdVn7KxDTudKVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1NCBTYWx0ZWRfX4uqU9HzNuHvM
 hDYvLIP0wyrvYPfeVzsZlM8dg6aONpI+P6ku/K6WD391Hcz68EBFdrDZx2X9OSamlZ++LCyeZm5
 Gcx6ODTzRmnWebZU7n/z7Tz8oNqaSs3/N2gv+kpLbzKY2zEmfh31alyfNwln+Cy1vleaZ4Zq0Tl
 EQo28uBry5pBXUzmlyyyFCoK/gHHc6tQK+G9eEGlhYIMoSWrTkV++nJslJn80mR13z9OiQkAe5V
 WN1OcZpwpLzl8yiwGZlhJ5YB1o4HN3BcLjtl4aa56MXzdfbAtasiXuK2VIzOxE1/zxZlmgn67Qo
 ICCg2vT8v7y5O5MpilpqTQzI+qf+gImjeKMKAPMAw7jV4oDUPh5tlcKZ6GSjsk08wrzx5A3SskO
 7QKhwtj8KQDjXTgl1ocwp4D4gYZHYTo/aZDfQExsw9+AK0OIujlgVHdHOKaoFnE2AdSnGPhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180054


On 6/18/2025 12:29 AM, Manivannan Sadhasivam wrote:
> On Tue, May 27, 2025 at 03:20:35PM +0800, Ziyue Zhang wrote:
>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>> Add configurations in devicetree for PCIe0, including registers, clocks,
>> interrupts and phy setting sequence.
>>
>> Add PCIe lane equalization preset properties for 8 GT/s.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>
> One comment below.
>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615.dtsi | 146 +++++++++++++++++++++++++++
>>   1 file changed, 146 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> index bb8b6c3ebd03..0af757c45eb2 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> @@ -1012,6 +1012,152 @@ mmss_noc: interconnect@1740000 {
>>   			qcom,bcm-voters = <&apps_bcm_voter>;
>>   		};
>>   
>> +		pcie: pcie@1c08000 {
>> +			device_type = "pci";
>> +			compatible = "qcom,pcie-qcs615", "qcom,pcie-sm8150";
>> +			reg = <0x0 0x01c08000 0x0 0x3000>,
>> +			      <0x0 0x40000000 0x0 0xf1d>,
>> +			      <0x0 0x40000f20 0x0 0xa8>,
>> +			      <0x0 0x40001000 0x0 0x1000>,
>> +			      <0x0 0x40100000 0x0 0x100000>,
>> +			      <0x0 0x01c0b000 0x0 0x1000>;
>> +			reg-names = "parf",
>> +				    "dbi",
>> +				    "elbi",
>> +				    "atu",
>> +				    "config",
>> +				    "mhi";
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
>> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
>> +			bus-range = <0x00 0xff>;
>> +
>> +			dma-coherent;
>> +
>> +			linux,pci-domain = <0>;
>> +			num-lanes = <1>;
>> +
>> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi0",
>> +					  "msi1",
>> +					  "msi2",
>> +					  "msi3",
>> +					  "msi4",
>> +					  "msi5",
>> +					  "msi6",
>> +					  "msi7",
>> +					  "global";
>> +
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 2 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 3 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 4 &intc GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
>> +				 <&gcc GCC_PCIE_0_AUX_CLK>,
>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
>> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
>> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
>> +			clock-names = "pipe",
>> +				      "aux",
>> +				      "cfg",
>> +				      "bus_master",
>> +				      "bus_slave",
>> +				      "slave_q2a";
>> +			assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
>> +			assigned-clock-rates = <19200000>;
>> +
>> +			interconnects = <&aggre1_noc MASTER_PCIE QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					 &config_noc SLAVE_PCIE_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
>> +			interconnect-names = "pcie-mem", "cpu-pcie";
>> +
>> +			iommu-map = <0x0 &apps_smmu 0x400 0x1>,
>> +				    <0x100 &apps_smmu 0x401 0x1>;
>> +
>> +			resets = <&gcc GCC_PCIE_0_BCR>;
>> +			reset-names = "pci";
>> +
>> +			power-domains = <&gcc PCIE_0_GDSC>;
>> +
>> +			phys = <&pcie_phy>;
>> +			phy-names = "pciephy";
>> +
>> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
>> +						     0x5555 0x5555 0x5555 0x5555>;
> Do you really need to set the presets for this SoC? Just making sure that it is
> not randomly copied from other DTS without purpose.
>
> - Mani

Hi Mani,

We need the presets for improve stability, and I find there only needs one 0x5555
for qcs615 pcie only has 1 lane. I will fix this in the next post.

BRs
Ziyue


