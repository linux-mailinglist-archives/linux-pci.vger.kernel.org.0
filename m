Return-Path: <linux-pci+bounces-7769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58048CCCC1
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 09:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054091C2214F
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6065613C9CD;
	Thu, 23 May 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QVD1OZ9I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647413C9BD;
	Thu, 23 May 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448108; cv=none; b=uCXLPJJu9seRvkO37yGG4KR1DWhtAUiLXkJ+yrakn51Nub99yvSUGSCZqjvl7vPjO/LYonZATJb09pfIL6XWJWNCi5LF8RuTNTqOB/RV2UmSrYO5ZU2mRx5tKBxCC/SD+CFRIr1cb66gO9bUcr72w9RveyIdA+fwi/qOn5GRA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448108; c=relaxed/simple;
	bh=ijvfwmsIYrGBjX90Bb1NC8ZZ5eC7RXM7EAhrgy++/3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C44U0O5/MuJ44JNWbKKAgvkjjQmIO0eLi4GcSo0PVHfoxGde2gWLqZmIQ9+YwWQqg0MwUeYUKdfFuD4Ro0TFSwpSrV68T0Xx0Zpmi7Y1p+BwX56lPQ4gQ5C3LhQMaG+NClRfwMtOJs3KXrzDZmtQEHw80UeCn4ZTt2hDMApPVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QVD1OZ9I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N4jThT010543;
	Thu, 23 May 2024 07:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AJAgBM8RRNv0boYLbUX7vZhvxHDqRZaUH76fthHL5T8=; b=QVD1OZ9IVQjmAQUK
	xIVPw3XTZbiszJlX+4djUVmfBYFwH/EkJN8/FyfptBZZ7dJij4S/nXNGEZK4uMV/
	/7AWpttDA6xxKv4d3j+gwj0MPA8jEHH6kJzR4BmamHWW9btJ8QpkNw4PRVGOFeBg
	KKbcjFh4zSkV56vd3nlbXAkGQqtcfxPuR925M83oJRW4dZp0l0Hv7JDB8ZVxgKah
	QmTmi06l7JaXDlLdWsI0k/muxGxRoc8+r2LOiFwAfZErCWcltOSbpijm7ARuWRYa
	v+tXcYy0CSO/PMjWuxHAItvOXseIirVQdZulHqOz8gKpeJV5rW4AY9DnjPuK2iJw
	8TtxNg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y9y29r83b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 07:07:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N77wXl018231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 07:07:58 GMT
Received: from [10.50.38.127] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 00:07:53 -0700
Message-ID: <a4c77ac8-f417-4d91-99a6-0420bd1259aa@quicinc.com>
Date: Thu, 23 May 2024 12:37:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/6] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
 <20240512082858.1806694-5-quic_devipriy@quicinc.com>
 <20240514073943.GB2463@thinkpad>
From: Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20240514073943.GB2463@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eQ-fLeVP4MIj0PUSQ70rZGe4jInovAs0
X-Proofpoint-GUID: eQ-fLeVP4MIj0PUSQ70rZGe4jInovAs0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405230045



On 5/14/2024 1:09 PM, Manivannan Sadhasivam wrote:
> On Sun, May 12, 2024 at 01:58:56PM +0530, devi priya wrote:
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V5:
>> 	- Dropped anoc and snoc lane clocks from Phy nodes and enabled them
>> 	  via interconnect.
>> 	- Dropped msi-parent as it is handled via msi IRQ
>>
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 365 +++++++++++++++++++++++++-
>>   1 file changed, 361 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 5b3e69379b1f..da6418c9d52b 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> 
> [...]
> 
>> +		pcie1: pci@10000000 {
> 
> 'pcie@' since this is a PCIe controller.
okay
> 
>> +			compatible = "qcom,pcie-ipq9574";
>> +			reg =  <0x10000000 0xf1d>,
>> +			       <0x10000F20 0xa8>,
> 
> Please use lower case for hex everywhere.
okay
> 
>> +			       <0x10001000 0x1000>,
>> +			       <0x000F8000 0x4000>,
>> +			       <0x10100000 0x1000>;
>> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <2>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			ranges = <0x01000000 0x0 0x00000000 0x10200000 0x0 0x100000>,  /* I/O */
>> +				 <0x02000000 0x0 0x10300000 0x10300000 0x0 0x7d00000>; /* MEM */
>> +
>> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi";
> 
> Are you sure that this platform only has single MSI SPI IRQ?
It has 8 MSI SPI IRQs, will define all of them
> 
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 0 35 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 0 49 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 0 84 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 0 85 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +			/* clocks and clock-names are used to enable the clock in CBCR */
> 
> This comment is redundant.
okay
> 
>> +			clocks = <&gcc GCC_PCIE1_AHB_CLK>,
>> +				 <&gcc GCC_PCIE1_AUX_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_M_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
>> +				 <&gcc GCC_PCIE1_RCHNG_CLK>;
>> +			clock-names = "ahb",
>> +				      "aux",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "axi_bridge",
>> +				      "rchng";
>> +
>> +			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
>> +				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_S_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_S_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_M_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_M_ARES>,
>> +				 <&gcc GCC_PCIE1_AUX_ARES>,
>> +				 <&gcc GCC_PCIE1_AHB_ARES>;
>> +			reset-names = "pipe",
>> +				      "sticky",
>> +				      "axi_s_sticky",
>> +				      "axi_s",
>> +				      "axi_m_sticky",
>> +				      "axi_m",
>> +				      "aux",
>> +				      "ahb";
>> +
>> +			phys = <&pcie1_phy>;
>> +			phy-names = "pciephy";
>> +			interconnects = <&gcc MASTER_ANOC_PCIE1 &gcc SLAVE_ANOC_PCIE1>,
>> +					<&gcc MASTER_SNOC_PCIE1 &gcc SLAVE_SNOC_PCIE1>;
> 
> Is this really the interconnect paths between PCIe-DDR and PCIe-CPU? I doubt...

We actually designed a minimalistic ICC driver for enabling the NoC 
clocks based on the suggestions received from the community.
Please find the link to the discussions that went in for introducing the 
ICC driver for NoC clock enablement

https://lore.kernel.org/linux-arm-msm/abd29b47-a8ab-4e2a-8147-d5d8ded98065@linaro.org/

Thanks,
Devi Priya
> 
> - Mani
> 

