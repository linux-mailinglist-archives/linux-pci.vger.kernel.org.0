Return-Path: <linux-pci+bounces-20265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E4DA19E7E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 07:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8ED3AFE50
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 06:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FED19341F;
	Thu, 23 Jan 2025 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ci+8Xw7o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A629B0;
	Thu, 23 Jan 2025 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737614127; cv=none; b=TOmjF4QbuJT9yUD5ER88jR5hqRSFjAPIDyypO7fs5W1AOqRNeN/NVG9Fxc6VUTDdh1Y1YbIoi6qk0sBWuOBc+hZZ56jtEDWCL8o6E/EuLD6FHo2ByaZqF0RGN8F5thgCFGZ5nTH/Lh8IZ1ylf9i6kdpUbhoPTlvIythMn1qC+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737614127; c=relaxed/simple;
	bh=TEuoW8F8Vnvt9XVu5AALuEI0uF1tXuYk3zLXCDDcWg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P2NIO4YP5iZuvD9brK4i/i/i4eHfcga/xuvgCNX8He8f+QYzuop9sFPXP0uuO3cEOxV5FF8qe08XjApVXAn8MR1K80in5diecE8drzRsk1SQ5mWxU/jcXHF3tMdgPJDbuGSTulXpHXMamF/Cf7mhagn9idOU88jicrRY4ZvjFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ci+8Xw7o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N6ViUa008792;
	Thu, 23 Jan 2025 06:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gr9MUpSBK8n6hKp8fqGkmExMBG6XbEbZ7h/w/BY3tPE=; b=ci+8Xw7o6vxRrtHu
	0o72ccHE3Oi1dOdFXNoJdEg+q8QLmHgTeAt/ccLbag1ze/CZATf4VBy9/oP17PGZ
	ENqDF7kFc4HFECZkRmqVLMzIqY9MJKmVmUQqb5C5Qx79z1zPdtFr9cRl6QRePuzV
	qTVkk5pe4Ut2AaPc0JD7YBwK7+2qXmXTJPD8nKw3ZIeIAxxmwEr/ix8NoEqIDZUa
	f52uNQwu8tj6UgGLj8TGiccs+PDI23/WO3Nz9Cbkyt1GrRCUAV7ThfloF6wI35r+
	L1KnPh81iNT/crkgHQx8gXC05dEQS51GXA9O8c39LMVDauasaHEJDnX86yjJmTFW
	zpj8jw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bgk1g087-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 06:35:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50N6ZDAM014555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 06:35:13 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 Jan
 2025 22:35:08 -0800
Message-ID: <9206e44c-da4f-4bdb-850f-fac511f4ddc7@quicinc.com>
Date: Thu, 23 Jan 2025 12:05:04 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
 <20250115064747.3302912-3-quic_mmanikan@quicinc.com>
 <20250119124551.nl5272bz36ozvlqu@thinkpad>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <20250119124551.nl5272bz36ozvlqu@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TVwJr429VuGs63ODSIZI0Oigcnfr1Zqi
X-Proofpoint-ORIG-GUID: TVwJr429VuGs63ODSIZI0Oigcnfr1Zqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_02,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230049



On 1/19/2025 6:15 PM, Manivannan Sadhasivam wrote:
> On Wed, Jan 15, 2025 at 12:17:46PM +0530, Manikanta Mylavarapu wrote:
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Add a newline above status in all pcie nodes.
>> 	- Changed reg-names to a vertical list format in
>> 	  all pcie nodes.
>> 	- Updated the order of pcie phy clocks in gcc node,
>> 	  move the <0> entry to the end of clock list.
>> 	- Updated the ranges property in the soc@0 node to align
>> 	  with the linux-next tip.
>>
>>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 500 +++++++++++++++++++++++++-
>>  1 file changed, 496 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> index 7034d378b1ef..708cd709a495 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
>> @@ -9,6 +9,7 @@
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
>>  #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
>> +#include <dt-bindings/interconnect/qcom,ipq5424.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>  
>>  / {
>> @@ -152,6 +153,98 @@ soc@0 {
>>  		#size-cells = <2>;
>>  		ranges = <0 0 0 0 0x10 0>;
>>  
>> +		pcie0_phy: phy@84000 {
>> +			compatible = "qcom,ipq5424-qmp-gen3x1-pcie-phy",
>> +				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +			reg = <0 0x00084000 0 0x2000>;
> 
> Use 0x0 for consistency. Here and everywhere.
> 
>> +			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
>> +				 <&gcc GCC_PCIE0_AHB_CLK>,
>> +				 <&gcc GCC_PCIE0_PIPE_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "pipe";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
>> +			assigned-clock-rates = <20000000>;
>> +
>> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +			reset-names = "phy", "common";
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "gcc_pcie0_pipe_clk_src";
>> +
>> +			#phy-cells = <0>;
>> +			status = "disabled";
>> +		};
> 
> [...]
> 
>> +		pcie3: pcie@40000000 {
>> +			compatible = "qcom,pcie-ipq5424",
>> +				     "qcom,pcie-ipq9574";
> 
> Put it in previous line itself.
> 
>> +			reg = <0 0x40000000 0 0xf1d>,
>> +			      <0 0x40000f20 0 0xa8>,
>> +			      <0 0x40001000 0 0x1000>,
>> +			      <0 0x000f8000 0 0x3000>,
>> +			      <0 0x40100000 0 0x1000>;
>> +			reg-names = "dbi",
>> +				    "elbi",
>> +				    "atu",
>> +				    "parf",
>> +				    "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <3>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <2>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x00100000>,
>> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x0fd00000>;
>> +			interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi0",
>> +					  "msi1",
>> +					  "msi2",
>> +					  "msi3",
>> +					  "msi4",
>> +					  "msi5",
>> +					  "msi6",
>> +					  "msi7";
> 
> Define the 'global' interrupt if it exists in hw.
> 
>> +
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 479 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 2 &intc 0 480 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 3 &intc 0 481 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 4 &intc 0 482 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			clocks = <&gcc GCC_PCIE3_AXI_M_CLK>,
>> +				 <&gcc GCC_PCIE3_AXI_S_CLK>,
>> +				 <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
>> +				 <&gcc GCC_PCIE3_RCHNG_CLK>,
>> +				 <&gcc GCC_PCIE3_AHB_CLK>,
>> +				 <&gcc GCC_PCIE3_AUX_CLK>;
>> +			clock-names = "axi_m",
>> +				      "axi_s",
>> +				      "axi_bridge",
>> +				      "rchng",
>> +				      "ahb",
>> +				      "aux";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE3_AHB_CLK>,
>> +					  <&gcc GCC_PCIE3_AUX_CLK>,
>> +					  <&gcc GCC_PCIE3_AXI_M_CLK>,
>> +					  <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
>> +					  <&gcc GCC_PCIE3_AXI_S_CLK>,
>> +					  <&gcc GCC_PCIE3_RCHNG_CLK>;
>> +			assigned-clock-rates = <100000000>,
>> +					       <20000000>,
>> +					       <266666666>,
>> +					       <240000000>,
>> +					       <240000000>,
>> +					       <100000000>;
> 
> Why does this platform has to assign clock rate for all the clocks?
> 

Only the RCHNG clock requires rate configuration.
The other clocks have already been set according to the frequency plan.
Therefore, I will exclude all clocks except the RCHNG clock.

>> +
>> +			resets = <&gcc GCC_PCIE3_PIPE_ARES>,
>> +				 <&gcc GCC_PCIE3_CORE_STICKY_RESET>,
>> +				 <&gcc GCC_PCIE3_AXI_S_STICKY_RESET>,
>> +				 <&gcc GCC_PCIE3_AXI_S_ARES>,
>> +				 <&gcc GCC_PCIE3_AXI_M_STICKY_RESET>,
>> +				 <&gcc GCC_PCIE3_AXI_M_ARES>,
>> +				 <&gcc GCC_PCIE3_AUX_ARES>,
>> +				 <&gcc GCC_PCIE3_AHB_ARES>;
>> +			reset-names = "pipe",
>> +				      "sticky",
>> +				      "axi_s_sticky",
>> +				      "axi_s",
>> +				      "axi_m_sticky",
>> +				      "axi_m",
>> +				      "aux",
>> +				      "ahb";
>> +
>> +			msi-map = <0x0 &intc 0x0 0x1000>;
>> +
>> +			phys = <&pcie3_phy>;
>> +			phy-names = "pciephy";
>> +			interconnects = <&gcc MASTER_ANOC_PCIE3 &gcc SLAVE_ANOC_PCIE3>,
>> +					<&gcc MASTER_CNOC_PCIE3 &gcc SLAVE_CNOC_PCIE3>;
> 
> Define icc tags also.
> 

Okay, sure.

Thanks & Regards,
Manikanta.

