Return-Path: <linux-pci+bounces-20231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA89A18E7F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 10:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AED3A5CCC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E820FA9E;
	Wed, 22 Jan 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SP/+GjWD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A420FA8E;
	Wed, 22 Jan 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538753; cv=none; b=J/wlWTrGrZI8F6csi8xmd6z08vO+CaouYzysFJDk/fSQZqRhUmW1ihdf/LsKSipXTNQF/CN2Z6SKp3ws0VjuhRVJQU1m5kWk6TZ+EnABx4tR50aYmGHziL54PTypoZStA1yqnr2zuHE4/QPmCegaekiIGTAIDPGRzn9Hd+DrHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538753; c=relaxed/simple;
	bh=8Pe7Vt98QXcixxTxrRl6EWn+mJrsloRblddrYx9mR64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kka6XcwzCHTzFjYKtq47Y13mvUshyb+o5ElfrfzkuNo+0EDlop/jFdu8lWX46wIs3F40RcEY9DeZrHNGS8A1cSLTC1zm0ITAFeiyjkYYCqqzO5KzCwH1mpBHsVAA2+6Fvu7mwMUq3U2/i7RnnxN2vqB7NM8EAhD92ofYLmjB5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SP/+GjWD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M1hAmF018045;
	Wed, 22 Jan 2025 09:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+/C4qLdgTnGW+q1WfIWMZYdd1IriLkfNKUniJMtfyMk=; b=SP/+GjWD3WChOZhK
	0mGSyiUbn1qSQIotZ0B+KZNFRH+r4XbYyDIUrN5JVvEC0F5xgddiJzu1tP/ATSIi
	43J+fgOYprOygol01rorPQiC4HjB0CXNdqmaZu4TiNacQi0Fs5E9034NgdiyjDPr
	K+lUWUh5oegexn58t73oX2fO+P8WZgxLQgdRzUxsIAUbwuDwE+yphoda0hTopQNF
	UZGHtpFyRRkDGwEJBlw9VN5TJ5PL5sbfg7AmSf0gr1b1OtZThS9OtGlZk36kK/tI
	Vqqq41dhQoiGbI+cwkH9flEJmEA2VbBgoGPu/qwI8vGez6fRnw9J+rXpxgK/iHac
	3aYr3w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44aq8gs0wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 09:39:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M9d2QB032533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 09:39:02 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 Jan
 2025 01:38:57 -0800
Message-ID: <35dd1d13-f1cb-4708-9e90-f58401e27832@quicinc.com>
Date: Wed, 22 Jan 2025 15:08:52 +0530
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PkKUJSMTHpeppSG-ham7TeivakCvHhSg
X-Proofpoint-ORIG-GUID: PkKUJSMTHpeppSG-ham7TeivakCvHhSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501220070



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

Okay, sure.

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

Okay, sure.

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

Okay, sure.

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
>> +			interconnect-names = "pcie-mem", "cpu-pcie";
>> +
>> +			status = "disabled";
> 
> Add the root port node and OPP table.
> 
I will add the root port in the next version.

Unlike MSM SoCs, in IPQ5424 PCIe link speed and width is fixed.
Hence didn't add OPP table.

> All the above comments applies to other controller nodes also.

Okay, sure.

Thanks & Regards,
Manikanta.

