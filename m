Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20EA69CD4C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 14:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjBTNsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 08:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjBTNsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 08:48:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37BA270;
        Mon, 20 Feb 2023 05:47:56 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K6oXx1008956;
        Mon, 20 Feb 2023 13:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r6EUcESr3EsNtFncTgeBqrVDL+HQr5/zjGym9TXBqAI=;
 b=aD8SCXKkhA1ZHOaKgP1+G58S0CQMFeMu2GV4NHMKA+Kjmk6f7FL9njazAKu9bxs3e7X0
 GYxOiTL/f9Fl8/5gbGI/iI5QsELRxQsHV23Zd/xoORFGpTpnF2LsD/X4qaw25G73y5yW
 u/eQJ9MVlzgAzTOku9Y3tImaycl4J/2Uz9OdbItyMMQG3YjN7Wqi5qZtb7nrqEE8b+V3
 15iB4OIQAdLMsofs403PTdf24aBkXglTWJ/3FVcU+2SW75yUrVuCB0gNSdsRtOm0OwO2
 yaid5xZWjnyAG2eRRAjb+39QIJQs8mE++4hz6TyqA1XcdHtsWsDlALzBywnQ5twzdzz4 4w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntqencudr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:47:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31KDldxu027108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:47:39 GMT
Received: from [10.216.11.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Feb
 2023 05:47:31 -0800
Message-ID: <d2ad4b35-4aa3-8612-4a2a-1cb50cd05e44@quicinc.com>
Date:   Mon, 20 Feb 2023 19:17:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 7/7] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-8-quic_devipriy@quicinc.com>
 <288a7d8a-130d-5ad1-42ea-726db3b880ce@quicinc.com>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <288a7d8a-130d-5ad1-42ea-726db3b880ce@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RW5f2Ihs_R02c2ZA4c0xGVhWWEK94ZQ5
X-Proofpoint-ORIG-GUID: RW5f2Ihs_R02c2ZA4c0xGVhWWEK94ZQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_11,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302200125
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/17/2023 2:05 PM, Sricharan Ramabadhran wrote:
> 
> Hi Devi,
> 
> On 2/14/2023 10:11 PM, Devi Priya wrote:
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  28 ++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 477 ++++++++++++++++++-
>>   2 files changed, 499 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts 
>> b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> index 2c8430197ec0..21b53f34ce84 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> @@ -8,6 +8,7 @@
>>   /dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>>   #include "ipq9574.dtsi"
>>   / {
>> @@ -29,6 +30,33 @@
>>       status = "okay";
>>   };
>> +&pcie1_phy {
>> +    status = "okay";
>> +};
>> +
>> +&pcie1_x1 {
>> +    perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
>> +    status = "okay";
>> +};
>> +
>> +&pcie2_phy {
>> +    status = "okay";
>> +};
>> +
>> +&pcie2_x2 {
>> +    perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
>> +    status = "okay";
>> +};
>> +
>> +&pcie3_phy {
>> +    status = "okay";
>> +};
>> +
>> +&pcie3_x2 {
>> +    perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
>> +    status = "okay";
>> +};
>> +
>>   &sdhc_1 {
>>       pinctrl-0 = <&sdc_default_state>;
>>       pinctrl-names = "default";
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 062f80798ebb..a32dbdeb5bed 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -6,8 +6,8 @@
>>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>>    */
>> -#include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>   / {
>> @@ -22,11 +22,41 @@
>>               #clock-cells = <0>;
>>           };
>> +        pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <250000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>> +        pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <250000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>> +        pcie30_phy2_pipe_clk: pcie30_phy2_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <250000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>> +        pcie30_phy3_pipe_clk: pcie30_phy3_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <250000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>>           sleep_clk: sleep-clk {
>>               compatible = "fixed-clock";
>>               #clock-cells = <0>;
>>           };
>> +        usb3phy_0_cc_pipe_clk: usb3phy_0_cc_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <125000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
> 
>    Why is the usb clock added here ?
As we have brought in the QMP PHY support, added the usb pipe clock too.
Will drop it as it is unrelated to the series.
> 
>>           xo_board_clk: xo-board-clk {
>>               compatible = "fixed-clock";
>>               #clock-cells = <0>;
>> @@ -121,6 +151,155 @@
>>           #size-cells = <1>;
>>           ranges = <0 0 0 0xffffffff>;
>> +        pcie0_phy: phy@84000 {
>> +            compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +            reg = <0x00084000 0x1bc>; /* Serdes PLL */
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +            clocks = <&gcc GCC_PCIE0_AUX_CLK>,
>> +                 <&gcc GCC_PCIE0_AHB_CLK>,
>> +                 <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
>> +                 <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
>> +
>> +            assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
>> +            assigned-clock-rates = <20000000>;
>> +
>> +            resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +                 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +            reset-names = "phy", "common";
>> +
>> +            status = "disabled";
>> +
>> +            pcie0_lane: phy@84200 {
>> +                reg = <0x00084200 0x16c>, /* Serdes Tx */
>> +                      <0x00084400 0x200>, /* Serdes Rx */
>> +                      <0x00084800 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +                      <0x00084c00 0xf4>;  /* pcs_misc */
>> +                #phy-cells = <0>;
>> +
>> +                clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                clock-output-names = "gcc_pcie0_pipe_clk_src";
>> +                #clock-cells = <0>;
>> +            };
>> +        };
>> +
>> +        pcie2_phy: phy@8c000 {
> 
>    Can the phy/pcie nodes labelled in order ?
>    Currently it 0/2/3/1 ?
Sure, okay
> 
>> +            compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +            reg = <0x0008c000 0x1bc>; /* Serdes PLL */
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            clocks = <&gcc GCC_PCIE2_AUX_CLK>,
>> +                 <&gcc GCC_PCIE2_AHB_CLK>,
>> +                 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
>> +                 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
>> +
>> +            assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
>> +            assigned-clock-rates = <20000000>;
>> +
>> +            resets = <&gcc GCC_PCIE2_PHY_BCR>,
>> +                 <&gcc GCC_PCIE2PHY_PHY_BCR>;
>> +            reset-names = "phy", "common";
>> +
>> +            status = "disabled";
>> +
>> +            pcie2_lanes: phy@8c200 {
>> +                reg = <0x0008c200 0x16c>, /* Serdes Tx0 */
>> +                      <0x0008c400 0x200>, /* Serdes Rx0 */
>> +                      <0x0008d000 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +                      <0x0008c600 0x16c>, /* Serdes Tx1 */
>> +                      <0x0008c800 0x200>, /* Serdes Rx1 */
>> +                      <0x0008d400 0x0f8>; /* pcs_misc */
>> +
>> +                #phy-cells = <0>;
>> +
>> +                clocks = <&gcc GCC_PCIE2_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                clock-output-names = "gcc_pcie2_pipe_clk_src";
>> +                #clock-cells = <0>;
>> +            };
>> +        };
>> +
>> +        pcie3_phy: phy@f4000 {
>> +            compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +            reg = <0x000f4000 0x1bc>; /* Serdes PLL */
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            clocks = <&gcc GCC_PCIE3_AUX_CLK>,
>> +                 <&gcc GCC_PCIE3_AHB_CLK>,
>> +                 <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
>> +                 <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
>> +
>> +            assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
>> +            assigned-clock-rates = <20000000>;
>> +
>> +            resets = <&gcc GCC_PCIE3_PHY_BCR>,
>> +                 <&gcc GCC_PCIE3PHY_PHY_BCR>;
>> +            reset-names = "phy", "common";
>> +
>> +            status = "disabled";
>> +
>> +            pcie3_lanes: phy@f4200 {
>> +                reg = <0x000f4200 0x16c>, /* Serdes Tx0 */
>> +                      <0x000f4400 0x200>, /* Serdes Rx0 */
>> +                      <0x000f5000 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +                      <0x000f4600 0x16c>, /* Serdes Tx1 */
>> +                      <0x000f4800 0x200>, /* Serdes Rx1 */
>> +                      <0x000f5400 0x0f8>; /* pcs_misc */
>> +
>> +                #phy-cells = <0>;
>> +
>> +                clocks = <&gcc GCC_PCIE3_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                clock-output-names = "gcc_pcie3_pipe_clk_src";
>> +                #clock-cells = <0>;
>> +            };
>> +        };
>> +
>> +        pcie1_phy: phy@fc000 {
>> +            compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +            reg = <0x000fc000 0x1bc>; /* Serdes PLL */
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            clocks = <&gcc GCC_PCIE1_AUX_CLK>,
>> +                 <&gcc GCC_PCIE1_AHB_CLK>,
>> +                 <&gcc GCC_ANOC_PCIE1_1LANE_M_CLK>,
>> +                 <&gcc GCC_SNOC_PCIE1_1LANE_S_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
>> +
>> +            assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
>> +            assigned-clock-rates = <20000000>;
>> +
>> +            resets = <&gcc GCC_PCIE1_PHY_BCR>,
>> +                 <&gcc GCC_PCIE1PHY_PHY_BCR>;
>> +            reset-names = "phy", "common";
>> +
>> +            status = "disabled";
>> +
>> +            pcie1_lane: phy@fc200 {
>> +                reg = <0x000fc200 0x16c>, /* Serdes Tx */
>> +                      <0x000fc400 0x200>, /* Serdes Rx */
>> +                      <0x000fc800 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +                      <0x000fcc00 0xf4>;  /* pcs_misc */
>> +                #phy-cells = <0>;
>> +
>> +                clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                clock-output-names = "gcc_pcie1_pipe_clk_src";
>> +                #clock-cells = <0>;
>> +            };
>> +        };
>> +
>>           tlmm: pinctrl@1000000 {
>>               compatible = "qcom,ipq9574-tlmm";
>>               reg = <0x01000000 0x300000>;
>> @@ -145,11 +324,11 @@
>>               clocks = <&xo_board_clk>,
>>                    <&sleep_clk>,
>>                    <&bias_pll_ubi_nc_clk>,
>> -                 <0>,
>> -                 <0>,
>> -                 <0>,
>> -                 <0>,
>> -                 <0>;
>> +                 <&pcie30_phy0_pipe_clk>,
>> +                 <&pcie30_phy1_pipe_clk>,
>> +                 <&pcie30_phy2_pipe_clk>,
>> +                 <&pcie30_phy3_pipe_clk>,
>> +                 <&usb3phy_0_cc_pipe_clk>;
> 
>     Same , why usb3 clk is added here ?
Sure, will drop it
> 
> Regards,
>   Sricharan
> 
Best Regards,
Devi Priya
