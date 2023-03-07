Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0B6AE389
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCGO7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 09:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCGO7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 09:59:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFF830DB;
        Tue,  7 Mar 2023 06:42:54 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327Bkl0S012653;
        Tue, 7 Mar 2023 14:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Fvo30gbRhGuaT9z0lbU6iqwACOjYaP9OqUzlO2c5XS8=;
 b=hF7B9wigMBFHN3jiZ3XMdck5AkE8acHFz8zs5JQ7rmWaty0Ah+T5iTKwts/p/EyQdN9D
 9Kgxl5qiTzwEeHRpQ5yPZQjK1S4f0l67AcU1vukuCSVxdltMb81cjQmU1DcRfaD/coiF
 89fl+1+ntZ7xR6bvj4uYYWTfD+bQmOXmm9PaDLw16GkRoGGJioU2d7Y+T/09scojdWP4
 3bOE5aPZrufL1QuMwpD9lnTS8poKvAcRfHUE0Ve1Z6iStAM3XnqUWBwMRCyjEag11A4W
 9k/4VriUwAN7H0cgA05A2LQY7BIBRLzVZlO+NKP3aQcdV5d6wIsAceHYCBX8yuE6JAgW TA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417k0b9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 14:42:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 327EgdkW012791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 14:42:39 GMT
Received: from [10.216.11.93] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 06:42:29 -0800
Message-ID: <1350dee1-a79d-6169-1eb7-4ab93f97c8d6@quicinc.com>
Date:   Tue, 7 Mar 2023 20:12:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: [PATCH 7/7] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <svarbanov@mm-sol.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-8-quic_devipriy@quicinc.com>
 <20230224085902.GC5443@thinkpad>
Content-Language: en-US
In-Reply-To: <20230224085902.GC5443@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zPu9AwwOwNLsfXpvZgreshGezWA2tLf9
X-Proofpoint-ORIG-GUID: zPu9AwwOwNLsfXpvZgreshGezWA2tLf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_08,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/24/2023 2:29 PM, Manivannan Sadhasivam wrote:
> On Tue, Feb 14, 2023 at 10:11:35PM +0530, Devi Priya wrote:
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
> 
> Please split the board devicetree changes into a separate patch.
Sure, okay
> 
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  28 ++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 477 ++++++++++++++++++-
>>   2 files changed, 499 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> index 2c8430197ec0..21b53f34ce84 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> @@ -8,6 +8,7 @@
>>   
>>   /dts-v1/;
>>   
>> +#include <dt-bindings/gpio/gpio.h>
>>   #include "ipq9574.dtsi"
>>   
>>   / {
>> @@ -29,6 +30,33 @@
>>   	status = "okay";
>>   };
>>   
>> +&pcie1_phy {
>> +	status = "okay";
> 
> No PHY power supply needed? Same comment for rest of the PHY nodes.
The PHY power supplies (VDDA_0P9 and VDDA_1P8) would be turned 'on'
by default and so no supply is added here

> 
>> +};
>> +
>> +&pcie1_x1 {
> 
> No need to add a suffix to node label indicating the lane config.
Okay
> 
>> +	perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
> 
> What about "wake" pin? Don't you need pinctrl definitions for these GPIOs?
> Same comment for rest of the PCIe nodes.
In IPQ9574, Wake pin isn't required as the slave devices are not
hot-pluggable & they get enumerated during the bootup. Will add the
pinctrl definition for the Perst gpio in V2
> 
>> +	status = "okay";
>> +};
>> +
>> +&pcie2_phy {
>> +	status = "okay";
>> +};
>> +
>> +&pcie2_x2 {
>> +	perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
>> +
>> +&pcie3_phy {
>> +	status = "okay";
>> +};
>> +
>> +&pcie3_x2 {
>> +	perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
>> +
>>   &sdhc_1 {
>>   	pinctrl-0 = <&sdc_default_state>;
>>   	pinctrl-names = "default";
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 062f80798ebb..a32dbdeb5bed 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -6,8 +6,8 @@
>>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>> -#include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>   
>>   / {
>> @@ -22,11 +22,41 @@
>>   			#clock-cells = <0>;
>>   		};
>>   
>> +		pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <250000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <250000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie30_phy2_pipe_clk: pcie30_phy2_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <250000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie30_phy3_pipe_clk: pcie30_phy3_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <250000000>;
>> +			#clock-cells = <0>;
>> +		};
> 
> Why PIPE clocks are modeled as fixed clocks unlike other SoCs?
Sure, will add the clocks to corresponding PHY node and use the phandle
similar to other targets
> 
>> +
>>   		sleep_clk: sleep-clk {
>>   			compatible = "fixed-clock";
>>   			#clock-cells = <0>;
>>   		};
>>   
>> +		usb3phy_0_cc_pipe_clk: usb3phy_0_cc_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <125000000>;
>> +			#clock-cells = <0>;
>> +		};
> 
> Spurious?
Will drop it
> 
>> +
>>   		xo_board_clk: xo-board-clk {
>>   			compatible = "fixed-clock";
>>   			#clock-cells = <0>;
>> @@ -121,6 +151,155 @@
>>   		#size-cells = <1>;
>>   		ranges = <0 0 0 0xffffffff>;
>>   
>> +		pcie0_phy: phy@84000 {
>> +			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +			reg = <0x00084000 0x1bc>; /* Serdes PLL */
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
>> +				 <&gcc GCC_PCIE0_AHB_CLK>,
>> +				 <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
>> +				 <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
> 
> Care to explain what these anoc_lane and snoc_lane clocks are?
snoc & anoc lane clocks are used in the SNOC/ANOC Network Interface Unit
(NIU) which connects to the corresponding PCIE master/slave interface
> 
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
>> +			assigned-clock-rates = <20000000>;
>> +
>> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +			reset-names = "phy", "common";
>> +
>> +			status = "disabled";
>> +
>> +			pcie0_lane: phy@84200 {
>> +				reg = <0x00084200 0x16c>, /* Serdes Tx */
>> +				      <0x00084400 0x200>, /* Serdes Rx */
>> +				      <0x00084800 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +				      <0x00084c00 0xf4>;  /* pcs_misc */
>> +				#phy-cells = <0>;
>> +
>> +				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
>> +				clock-names = "pipe0";
>> +				clock-output-names = "gcc_pcie0_pipe_clk_src";
>> +				#clock-cells = <0>;
>> +			};
>> +		};
>> +
> 
> [...]
> 
>> +		pcie1_x1: pci@10000000 {
>> +			compatible = "qcom,pcie-ipq9574";
>> +			reg =  <0x10000000 0xf1d>,
>> +			       <0x10000F20 0xa8>,
>> +			       <0x10001000 0x1000>,
>> +			       <0x000F8000 0x4000>,
>> +			       <0x10100000 0x1000>,
>> +			       <0x00618108 0x4>;
>> +			reg-names = "dbi", "elbi", "atu", "parf", "config", "aggr_noc";
> 
> As I asked in the binding patch, why "aggr_noc" region is required?
The ANOC runs at a fixed frequency of 342MHz.
For the connected PCIe slave devices that run at lesser frequency,
the aggr_noc's rate adapter register is updated to configure
the packet transmission rate to ensure no wait cycles are inserted.
Can we use the 'syscon' property here to set the rate adapter?
> 
>> +			device_type = "pci";
>> +			linux,pci-domain = <2>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			ranges = <0x81000000 0 0x10200000 0x10200000
>> +				  0 0x00100000   /* downstream I/O */
>> +				  0x82000000 0 0x10300000 0x10300000
>> +				  0 0x07d00000>; /* non-prefetchable memory */
> 
> Don't split the ranges and encode them in a single line.
Okay
> 
> Also, the I'm not sure why you have set the relocatable flag (n) for both
> ranges i.e., in 0x81000000 and 0x82000000.
Will check and add comment in V2
> 
>> +
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 35
>> +					IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 49
>> +					IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 84
>> +					IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 85
>> +					IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
> 
> Again, wrap the interrupts in a single line.
Sure, okay
> 
>> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "global_irq";
>> +
> 
> Linux doesn't support global_irq yet. But since devicetree is supposed to
> describe the hardware, you can keep it.
Okay
> 
> Above comment applies to rest of the PCIe nodes.
> 
>> +			/* clocks and clock-names are used to enable the clock in CBCR */
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
>> +			phys = <&pcie1_lane>;
>> +			phy-names = "pciephy";
>> +			msi-parent = <&v2m0>;
>> +			status = "disabled";
>> +		};
>> +
> 
> [...]
> 
>> +		pcie2_x2: pci@20000000 {
>> +			compatible = "qcom,pcie-ipq9574";
>> +			reg =  <0x20000000 0xf1d>,
>> +			       <0x20000F20 0xa8>,
>> +			       <0x20001000 0x1000>,
>> +			       <0x00088000 0x4000>,
>> +			       <0x20100000 0x1000>;
>> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <3>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes =<2>;
> 
> Space after =
Sure, okay
> 
> Thanks,
> Mani
> 
