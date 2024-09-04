Return-Path: <linux-pci+bounces-12776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0E96C5B7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 19:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD763286D08
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0AA1E133C;
	Wed,  4 Sep 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pucGto3l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D21D88BF;
	Wed,  4 Sep 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472068; cv=none; b=qUlRX+YQwqWtWj9Ic2kqUVbcwOaSbua2J5bWyKoBQ83v5VNVp1YjSD1FEOcSVbcSEfh/iTdeffsFBPY7as3S5ZqmfWFIPaAZcx19aMtdWpabVaf+ShoC2sf6VcTKG2cATmLoLRQcgZvU9gXZ95EijZbKoVlRJbw0qyTw4CmVpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472068; c=relaxed/simple;
	bh=JIFxZElsjBlrrcNLTSikMQZRzfEJoNSRcxA5VX2JZ2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aJAFpqHYYVd9VUbVi6RHg0rllIVlezjAge7OAfGUt/uHqth0e8qwOBUrbjtjGto2Ddp4aDGG0wlF7dNT4zt0JiUZKyzTaGUfOg6TSmtusULtX7NZ1kopSXV3eoj9illrmPYqiUxHelFGoqL/m7jCbSSskwWPT48Pzjz6dsdbvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pucGto3l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484BSgSS003593;
	Wed, 4 Sep 2024 17:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qZQnCnyfSNwaoiRWrBhYJ06WGShR2EB7KQmdAo5/+YY=; b=pucGto3lCqkUWCXl
	V8WVhyNZTi6dz+ghjdudKLGcT+weQzqhfJ3tR5f1Z4CH8NQKr3IQCkvWs1VC42Ox
	Le5swwmozrzUcHyo+8qFn/HV6W4p1X2OvUBmC1A/XRlu7QNVxJ1SjpyzeJK1h9W2
	5THz24MknhHWQx6CxB+lr9pM9ddJq0eZGMjpIz+Xvig+jw/euJYudiVayaPu1ya6
	IjEIe6eION9zlHYSSNLM9aNfzH3Z2+HZdmB1myF7OCgkQx5PyNe5RxfAvmRj6mmZ
	8h5G8muyNE31pFYPDq9xX1NKUTcDoX7qNMf77trJe9sw4OuVEjTmYdF0rpQHrsHU
	W0kY5A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41buxfbdqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:47:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HlWCm002144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:47:32 GMT
Received: from [10.50.7.129] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 10:47:23 -0700
Message-ID: <c5c1f0bf-2f69-44ae-b54b-d69d002e3199@quicinc.com>
Date: Wed, 4 Sep 2024 23:17:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <dmitry.baryshkov@linaro.org>, <quic_nsekar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <robimarko@gmail.com>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-6-quic_srichara@quicinc.com>
 <20240830085901.oeiuuijlvq2ydho2@thinkpad>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20240830085901.oeiuuijlvq2ydho2@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QIgxJOTfgNCvH2OEJNI5EJz30P3lCKqI
X-Proofpoint-ORIG-GUID: QIgxJOTfgNCvH2OEJNI5EJz30P3lCKqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040134



On 8/30/2024 2:29 PM, Manivannan Sadhasivam wrote:
> On Tue, Aug 27, 2024 at 10:27:56AM +0530, Sricharan R wrote:
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>
>> Add phy and controller nodes for a 2-lane Gen2 and
>> 1-lane Gen2 PCIe buses.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> ---
>>   [v2] Removed relocatable flags,  removed assigned-clock-rates,
>>        fixed rest of the cosmetic comments.
>>
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 168 +++++++++++++++++++++++++-
>>   1 file changed, 166 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 7e6e2c121979..dd5d6b7ff094 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -9,6 +9,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>   #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>> +#include <dt-bindings/gpio/gpio.h>
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -143,7 +144,33 @@ usbphy0: phy@5b000 {
>>   			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
>>   
>>   			#phy-cells = <0>;
>> +		};
>> +
>> +		pcie_x1phy: phy@7e000{
>> +			compatible = "qcom,ipq5018-uniphy-pcie-gen2x1";
>> +			reg = <0x0007e000 0x800>;
>> +			#phy-cells = <0>;
>> +			#clock-cells = <0>;
>> +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
>> +			clock-names = "pipe";
>> +			assigned-clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
>> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
>> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
>> +			reset-names = "phy", "common";
>> +			status = "disabled";
>> +		};
>>   
>> +		pcie_x2phy: phy@86000{
>> +			compatible = "qcom,ipq5018-uniphy-pcie-gen2x2";
>> +			reg = <0x00086000 0x1000>;
>> +			#phy-cells = <0>;
>> +			#clock-cells = <0>;
>> +			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
>> +			clock-names = "pipe";
>> +			assigned-clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
>> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +			reset-names = "phy", "common";
>>   			status = "disabled";
>>   		};
>>   
>> @@ -170,8 +197,8 @@ gcc: clock-controller@1800000 {
>>   			reg = <0x01800000 0x80000>;
>>   			clocks = <&xo_board_clk>,
>>   				 <&sleep_clk>,
>> -				 <0>,
>> -				 <0>,
>> +				 <&pcie_x2phy>,
>> +				 <&pcie_x1phy>,
>>   				 <0>,
>>   				 <0>,
>>   				 <0>,
>> @@ -387,6 +414,143 @@ frame@b128000 {
>>   				status = "disabled";
>>   			};
>>   		};
>> +
>> +		pcie0: pci@80000000 {
> 
> pcie@
> 
  ok

>> +			compatible = "qcom,pcie-ipq5018";
>> +			reg =  <0x80000000 0xf1d>,
>> +			       <0x80000f20 0xa8>,
>> +			       <0x80001000 0x1000>,
>> +			       <0x00078000 0x3000>,
>> +			       <0x80100000 0x1000>;
> 
> Are you sure that the config space is only 4K?
> 
  ok, let me double check.

>> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <0>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +			max-link-speed = <2>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			phys = <&pcie_x1phy>;
>> +			phy-names ="pciephy";
>> +
>> +			ranges = <0x01000000 0 0x80200000 0x80200000 0 0x00100000
> 
> Please check the value of this field in other SoCs.

  ok, if its about the child address encoding for IO region, will fix.

> 
>> +				  0x02000000 0 0x80300000 0x80300000 0 0x10000000>;
>> +
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 0 142 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 2 &intc 0 0 143 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 3 &intc 0 0 144 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 4 &intc 0 0 145 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "global_irq";
> 
> I'm pretty sure that this SoC has SPI based MSI interrupts. So they should be
> described even though ITS is supported.

  ok

> 
>> +
>> +			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_M_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
>> +				 <&gcc GCC_PCIE1_AHB_CLK>,
>> +				 <&gcc GCC_PCIE1_AUX_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
>> +
>> +			clock-names = "iface",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "ahb",
>> +				      "aux",
>> +				      "axi_bridge";
>> +
>> +			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
>> +				 <&gcc GCC_PCIE1_SLEEP_ARES>,
>> +				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
>> +				 <&gcc GCC_PCIE1_AHB_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_SLAVE_STICKY_ARES>;
>> +
>> +			reset-names = "pipe",
>> +				      "sleep",
>> +				      "sticky",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "ahb",
>> +				      "axi_m_sticky",
>> +				      "axi_s_sticky";
>> +
>> +			msi-map = <0x0 &v2m0 0x0 0xff8>;
>> +			status = "disabled";
> 
> Please add the rootport node also as like other SoCs.
> 
  ok

> Above comments applies to below PCIe node.
>
  ok

Regards,
  Sricharan


