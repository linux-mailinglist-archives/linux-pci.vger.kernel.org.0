Return-Path: <linux-pci+bounces-30011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF01ADE3F8
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 08:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACED1898CA3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929E211A27;
	Wed, 18 Jun 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZOffDGQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412C258A;
	Wed, 18 Jun 2025 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229325; cv=none; b=OGrL4cl561m1+BSDN5yNTgdpQ/m3WmbawJ5wB5wsub9Zl3F+15In7VQ1z5aGW7ZS0pfdegeOrYhsUlKO/Etgqa7VGL2VtR1aRzUuNVrA4sdwnSDCi7sRQKlyJmSC/L27nyakHKOCmQtnlsEM3s3byhdCgoYdZ0gF08Tj4pgnULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229325; c=relaxed/simple;
	bh=TGO80lBRkNCTJQ6qO2NW1xivbmtpOTU2RjLPvsK1/II=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A1YAhNa3OQN9kW05W9KqKHu9DLRWmwn07mK8y9RRPD899rP21w/qOBOelhcppPZts01sKX88GppIgQzeuzrfb71p63RxU9yTevkWGhVEOQAsBMSaVcjMsUp75W7P05alGTyFnTFRhS+/zYbNNPc1UpqO01FW2Ert71ZNcPqFxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZOffDGQh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNLVaj013410;
	Wed, 18 Jun 2025 06:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oI++LHOgvS0sCdsKtAg7awd/y6wSTuQFNPXw43o0t7E=; b=ZOffDGQhh5YbxXO+
	jkO+lTT40xjMJqmg0HfWBbt6xlmhqElJeJpofg6vE/tl3dTbesFBa4ZeAH9SIeyf
	t4UBaiygT+LCIRvX2oxA1IUygaj9yIv8c3/t+CHPEmwiVNBVT0BbtDpY28o/NT4V
	bQBqeh5MvAVAtmbJXp+t/ywoTH8mWCgqFZqZt/LG8fzhsJjv9MF2PawHvl67JkSM
	V018qPMM1saxcBVRXl8999cmDMzSP3MtuQ/jp44PhpdQ4bY/+HgE9QJVl1Yg3fdn
	H3tetSJL32nsyKCkzWRyXsOK63vdABSlnIAXoLHNQctV20mSSj/O2xoIYRqY+ny1
	ncVNWg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4792ca346f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 06:48:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55I6mWFd030179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 06:48:32 GMT
Received: from [10.253.79.108] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Jun
 2025 23:48:26 -0700
Message-ID: <ddfd1135-33d5-483b-afa0-69370ff3e061@quicinc.com>
Date: Wed, 18 Jun 2025 14:48:24 +0800
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
 <axcfeisgtkhnpoayj4zpn4sy237xz6udk2qzm62qk4nfxcica3@behrkpyuarb2>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <axcfeisgtkhnpoayj4zpn4sy237xz6udk2qzm62qk4nfxcica3@behrkpyuarb2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _-6Hup0SCjp_bbswg7FPcu3ZRl28gq3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1NyBTYWx0ZWRfX3Cfq8Wf9pSlZ
 YbWHJH2JspRaw8GcoBssuvyVYtk3kRoeRgM2te9FPALPMkn3yCLJqWndry8Hs0j1FFPzp0NQlob
 uFAdjnDDhXBOC7035atPeNmkcTFyEeH5tC2lHcok9770XgQbWV4tLl1+Y7ei6Xexo7omwLGZQNO
 x5OndYt7bmJeANYEdGoFoXAQlo0AlwlclwrRZ8TmPVENiCvIGWR2g99xZpOJKrAEPao1B/wvOil
 1t4XcnW+yhzAxjYk/bLYneEEZAr2nNIB+Suf9m70TgrQtSa1mgwNvHHJqg5kw9+k5z0P2RdHO/H
 M38Y+HWQMf5eTyZzHhXYJA2Ig9fPZa03otQM5rUNjDCOlcBokuLxy+rzJ/P1w7TMowMc7CLhMy+
 myB9aeEBS7jFKGlU3b2Kcrwc9JyBjzFPFlBB1gIraenmv0hzOAnx7GaiVfwbOU2cvbQuq/be
X-Proofpoint-ORIG-GUID: _-6Hup0SCjp_bbswg7FPcu3ZRl28gq3n
X-Authority-Analysis: v=2.4 cv=etffzppX c=1 sm=1 tr=0 ts=68526141 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=Eh31Mr4urJnSeGphYuEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180057


On 6/18/2025 12:36 AM, Manivannan Sadhasivam wrote:
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
>> +
>> +			operating-points-v2 = <&pcie_opp_table>;
>> +
>> +			status = "disabled";
>> +
> Please define the PCIe bridge node also.
>
> - Mani

Hi Mani

In a previous patch, you suggested removing this node. However, it now seems
there might be a need to add it back. Could you kindly advise on the correct
approach?

BRs
Ziyue


