Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3AE6FA9BB
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 12:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjEHKzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjEHKy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 06:54:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991DA5E5;
        Mon,  8 May 2023 03:53:46 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3487lPGk012713;
        Mon, 8 May 2023 10:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=z+khvZx8pp+uw3QbyNvFHasMhMwrfOkd53ckBv2o4k4=;
 b=l3wv0dr22XbHKW92jVwvjfa+EWRUHMYWKo83B7Ndui/Lw172O4aC2ZQ2diI3XbcesTtA
 acjljF+1O4m9Qa0I7jtgz/eeRSGbTOi5x7ObQ2eD5MpRBWjG4Df9hcQM+atjsRN/TsdC
 t5eE+gJCCzYlXr+lWHo0csy0IGmnTj+B1uXYz1l/IFLa0km0UTyi5HmAxyYHmp8xON1D
 sOwwkzmmHeyMSzQ+Jlp4Nj85qwUdavKHlI6JyKk6OfP9g0xSd3NYebm3lCl41zGPAld2
 XGHhmy2JmgWwFOIbdrYxrvMhaDLOW5QDM6ei60oC3u9TN8Cy2uWIX6GqjFp9Gy9PYds2 3g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qddwhkdfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 10:53:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 348Arb6h008506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 10:53:37 GMT
Received: from [10.216.51.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 03:53:28 -0700
Message-ID: <a220e00d-0559-35d5-80e9-7e11e566851a@quicinc.com>
Date:   Mon, 8 May 2023 16:23:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 4/6] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-5-quic_devipriy@quicinc.com>
 <CAA8EJppyro1wM3KmDU3DVjKCqXH5+KaNoT_7ObVuuYNMoZKpoA@mail.gmail.com>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <CAA8EJppyro1wM3KmDU3DVjKCqXH5+KaNoT_7ObVuuYNMoZKpoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ry7y5iDaZMrucfTXWGuiSCOQ9mqYcvdk
X-Proofpoint-ORIG-GUID: ry7y5iDaZMrucfTXWGuiSCOQ9mqYcvdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305080072
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/22/2023 5:49 AM, Dmitry Baryshkov wrote:
> On Fri, 21 Apr 2023 at 15:50, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V3:
>>          - Fixed up the PCI I/O port ranges
>>
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 375 +++++++++++++++++++++++++-
>>   1 file changed, 370 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index e757b57957cf..953a839a1141 100644
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
>> @@ -116,6 +116,58 @@
>>                  #size-cells = <1>;
>>                  ranges = <0 0 0 0xffffffff>;
>>
>> +               pcie0_phy: phy@84000 {
>> +                       compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +                       reg = <0x00084000 0x1000>;
>> +
>> +                       clocks = <&gcc GCC_PCIE0_AUX_CLK>,
>> +                                <&gcc GCC_PCIE0_AHB_CLK>,
>> +                                <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
>> +                                <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>,
>> +                                <&gcc GCC_PCIE0_PIPE_CLK>;
>> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
>> +
>> +                       assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
>> +                       assigned-clock-rates = <20000000>;
>> +
>> +                       resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +                                <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +                       reset-names = "phy", "common";
>> +
>> +                       #clock-cells = <0>;
>> +                       clock-output-names = "gcc_pcie0_pipe_clk_src";
>> +
>> +                       #phy-cells = <0>;
>> +                       status = "disabled";
>> +
>> +               };
>> +
>> +               pcie2_phy: phy@8c000 {
>> +                       compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +                       reg = <0x0008c000 0x2000>;
>> +
>> +                       clocks = <&gcc GCC_PCIE2_AUX_CLK>,
>> +                                <&gcc GCC_PCIE2_AHB_CLK>,
>> +                                <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
>> +                                <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>,
>> +                                <&gcc GCC_PCIE2_PIPE_CLK>;
>> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
>> +
>> +                       assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
>> +                       assigned-clock-rates = <20000000>;
>> +
>> +                       resets = <&gcc GCC_PCIE2_PHY_BCR>,
>> +                                <&gcc GCC_PCIE2PHY_PHY_BCR>;
>> +                       reset-names = "phy", "common";
>> +
>> +                       #clock-cells = <0>;
>> +                       clock-output-names = "gcc_pcie2_pipe_clk_src";
>> +
>> +                       #phy-cells = <0>;
>> +                       status = "disabled";
>> +
>> +               };
>> +
>>                  rng: rng@e3000 {
>>                          compatible = "qcom,prng-ee";
>>                          reg = <0x000e3000 0x1000>;
>> @@ -123,6 +175,58 @@
>>                          clock-names = "core";
>>                  };
>>
>> +               pcie3_phy: phy@f4000 {
>> +                       compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +                       reg = <0x000f4000 0x2000>;
>> +
>> +                       clocks = <&gcc GCC_PCIE3_AUX_CLK>,
>> +                                <&gcc GCC_PCIE3_AHB_CLK>,
>> +                                <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
>> +                                <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>,
>> +                                <&gcc GCC_PCIE3_PIPE_CLK>;
>> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
>> +
>> +                       assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
>> +                       assigned-clock-rates = <20000000>;
>> +
>> +                       resets = <&gcc GCC_PCIE3_PHY_BCR>,
>> +                                <&gcc GCC_PCIE3PHY_PHY_BCR>;
>> +                       reset-names = "phy", "common";
>> +
>> +                       #clock-cells = <0>;
>> +                       clock-output-names = "gcc_pcie3_pipe_clk_src";
>> +
>> +                       #phy-cells = <0>;
>> +                       status = "disabled";
>> +
>> +               };
>> +
>> +               pcie1_phy: phy@fc000 {
>> +                       compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +                       reg = <0x000fc000 0x1000>;
>> +
>> +                       clocks = <&gcc GCC_PCIE1_AUX_CLK>,
>> +                                <&gcc GCC_PCIE1_AHB_CLK>,
>> +                                <&gcc GCC_ANOC_PCIE1_1LANE_M_CLK>,
>> +                                <&gcc GCC_SNOC_PCIE1_1LANE_S_CLK>,
>> +                                <&gcc GCC_PCIE1_PIPE_CLK>;
>> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
>> +
>> +                       assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
>> +                       assigned-clock-rates = <20000000>;
>> +
>> +                       resets = <&gcc GCC_PCIE1_PHY_BCR>,
>> +                                <&gcc GCC_PCIE1PHY_PHY_BCR>;
>> +                       reset-names = "phy", "common";
>> +
>> +                       #clock-cells = <0>;
>> +                       clock-output-names = "gcc_pcie1_pipe_clk_src";
>> +
>> +                       #phy-cells = <0>;
>> +                       status = "disabled";
>> +
>> +               };
>> +
>>                  tlmm: pinctrl@1000000 {
>>                          compatible = "qcom,ipq9574-tlmm";
>>                          reg = <0x01000000 0x300000>;
>> @@ -146,10 +250,10 @@
>>                          reg = <0x01800000 0x80000>;
>>                          clocks = <&xo_board_clk>,
>>                                   <&sleep_clk>,
>> -                                <0>,
>> -                                <0>,
>> -                                <0>,
>> -                                <0>,
>> +                                <&pcie0_phy>,
>> +                                <&pcie1_phy>,
>> +                                <&pcie2_phy>,
>> +                                <&pcie3_phy>,
>>                                   <0>;
>>                          #clock-cells = <1>;
>>                          #reset-cells = <1>;
>> @@ -478,6 +582,267 @@
>>                                  status = "disabled";
>>                          };
>>                  };
>> +
>> +               pcie1: pci@10000000 {
>> +                       compatible = "qcom,pcie-ipq9574";
>> +                       reg =  <0x10000000 0xf1d>,
>> +                              <0x10000F20 0xa8>,
>> +                              <0x10001000 0x1000>,
>> +                              <0x000F8000 0x4000>,
>> +                              <0x10100000 0x1000>;
>> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +                       device_type = "pci";
>> +                       linux,pci-domain = <2>;
>> +                       bus-range = <0x00 0xff>;
>> +                       num-lanes = <1>;
>> +                       #address-cells = <3>;
>> +                       #size-cells = <2>;
>> +
>> +                       ranges = <0x01000000 0x0 0x00000000 0x10200000 0x0 0x100000>,  /* I/O */
>> +                                <0x02000000 0x0 0x10300000 0x10300000 0x0 0x7d00000>; /* MEM */
>> +
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-map-mask = <0 0 0 0x7>;
>> +                       interrupt-map = <0 0 0 1 &intc 0 35 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +                                       <0 0 0 2 &intc 0 49 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +                                       <0 0 0 3 &intc 0 84 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +                                       <0 0 0 4 &intc 0 85 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
> 
> No iommu-map?
We do not enable the IOMMU stage1 translation for PCIe and the registers
have secure access only from TrustZone (It enables only stage2 for
Access control)

Thanks,
Devi Priya
> 
>> +                       interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "global_irq";
>> +
>> +                       /* clocks and clock-names are used to enable the clock in CBCR */
>> +                       clocks = <&gcc GCC_PCIE1_AHB_CLK>,
>> +                                <&gcc GCC_PCIE1_AUX_CLK>,
>> +                                <&gcc GCC_PCIE1_AXI_M_CLK>,
>> +                                <&gcc GCC_PCIE1_AXI_S_CLK>,
>> +                                <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
>> +                                <&gcc GCC_PCIE1_RCHNG_CLK>;
>> +                       clock-names = "ahb",
>> +                                     "aux",
>> +                                     "axi_m",
>> +                                     "axi_s",
>> +                                     "axi_bridge",
>> +                                     "rchng";
>> +
>> +                       resets = <&gcc GCC_PCIE1_PIPE_ARES>,
>> +                                <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE1_AXI_S_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE1_AXI_S_ARES>,
>> +                                <&gcc GCC_PCIE1_AXI_M_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE1_AXI_M_ARES>,
>> +                                <&gcc GCC_PCIE1_AUX_ARES>,
>> +                                <&gcc GCC_PCIE1_AHB_ARES>;
>> +                       reset-names = "pipe",
>> +                                     "sticky",
>> +                                     "axi_s_sticky",
>> +                                     "axi_s",
>> +                                     "axi_m_sticky",
>> +                                     "axi_m",
>> +                                     "aux",
>> +                                     "ahb";
>> +
>> +                       phys = <&pcie1_phy>;
>> +                       phy-names = "pciephy";
>> +                       msi-parent = <&v2m0>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               pcie3: pci@18000000 {
>> +                       compatible = "qcom,pcie-ipq9574";
>> +                       reg =  <0x18000000 0xf1d>,
>> +                              <0x18000F20 0xa8>,
>> +                              <0x18001000 0x1000>,
>> +                              <0x000F0000 0x4000>,
>> +                              <0x18100000 0x1000>;
>> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +                       device_type = "pci";
>> +                       linux,pci-domain = <4>;
>> +                       bus-range = <0x00 0xff>;
>> +                       num-lanes = <2>;
>> +                       #address-cells = <3>;
>> +                       #size-cells = <2>;
>> +
>> +                       ranges = <0x01000000 0x0 0x00000000 0x18200000 0x0 0x100000>,  /* I/O */
>> +                                <0x02000000 0x0 0x18300000 0x18300000 0x0 0x7d00000>; /* MEM */
>> +
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-map-mask = <0 0 0 0x7>;
>> +                       interrupt-map = <0 0 0 1 &intc 0 189 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +                                       <0 0 0 2 &intc 0 190 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +                                       <0 0 0 3 &intc 0 191 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +                                       <0 0 0 4 &intc 0 192 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +                       interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "global_irq";
>> +
>> +                       /* clocks and clock-names are used to enable the clock in CBCR */
>> +                       clocks = <&gcc GCC_PCIE3_AHB_CLK>,
>> +                                <&gcc GCC_PCIE3_AUX_CLK>,
>> +                                <&gcc GCC_PCIE3_AXI_M_CLK>,
>> +                                <&gcc GCC_PCIE3_AXI_S_CLK>,
>> +                                <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
>> +                                <&gcc GCC_PCIE3_RCHNG_CLK>;
>> +                       clock-names = "ahb",
>> +                                     "aux",
>> +                                     "axi_m",
>> +                                     "axi_s",
>> +                                     "axi_bridge",
>> +                                     "rchng";
>> +
>> +                       resets = <&gcc GCC_PCIE3_PIPE_ARES>,
>> +                                <&gcc GCC_PCIE3_CORE_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE3_AXI_S_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE3_AXI_S_ARES>,
>> +                                <&gcc GCC_PCIE3_AXI_M_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE3_AXI_M_ARES>,
>> +                                <&gcc GCC_PCIE3_AUX_ARES>,
>> +                                <&gcc GCC_PCIE3_AHB_ARES>;
>> +                       reset-names = "pipe",
>> +                                     "sticky",
>> +                                     "axi_s_sticky",
>> +                                     "axi_s",
>> +                                     "axi_m_sticky",
>> +                                     "axi_m",
>> +                                     "aux",
>> +                                     "ahb";
>> +
>> +                       phys = <&pcie3_phy>;
>> +                       phy-names = "pciephy";
>> +                       msi-parent = <&v2m0>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               pcie2: pci@20000000 {
>> +                       compatible = "qcom,pcie-ipq9574";
>> +                       reg =  <0x20000000 0xf1d>,
>> +                              <0x20000F20 0xa8>,
>> +                              <0x20001000 0x1000>,
>> +                              <0x00088000 0x4000>,
>> +                              <0x20100000 0x1000>;
>> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +                       device_type = "pci";
>> +                       linux,pci-domain = <3>;
>> +                       bus-range = <0x00 0xff>;
>> +                       num-lanes = <2>;
>> +                       #address-cells = <3>;
>> +                       #size-cells = <2>;
>> +
>> +                       ranges = <0x01000000 0x0 0x00000000 0x20200000 0x0 0x100000>,  /* I/O */
>> +                                <0x02000000 0x0 0x20300000 0x20300000 0x0 0x7d00000>; /* MEM */
>> +
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-map-mask = <0 0 0 0x7>;
>> +                       interrupt-map = <0 0 0 1 &intc 0 164 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +                                       <0 0 0 2 &intc 0 165 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +                                       <0 0 0 3 &intc 0 186 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +                                       <0 0 0 4 &intc 0 187 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +                       interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "global_irq";
>> +
>> +                       /* clocks and clock-names are used to enable the clock in CBCR */
>> +                       clocks = <&gcc GCC_PCIE2_AHB_CLK>,
>> +                                <&gcc GCC_PCIE2_AUX_CLK>,
>> +                                <&gcc GCC_PCIE2_AXI_M_CLK>,
>> +                                <&gcc GCC_PCIE2_AXI_S_CLK>,
>> +                                <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
>> +                                <&gcc GCC_PCIE2_RCHNG_CLK>;
>> +                       clock-names = "ahb",
>> +                                     "aux",
>> +                                     "axi_m",
>> +                                     "axi_s",
>> +                                     "axi_bridge",
>> +                                     "rchng";
>> +
>> +                       resets = <&gcc GCC_PCIE2_PIPE_ARES>,
>> +                                <&gcc GCC_PCIE2_CORE_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE2_AXI_S_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE2_AXI_S_ARES>,
>> +                                <&gcc GCC_PCIE2_AXI_M_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE2_AXI_M_ARES>,
>> +                                <&gcc GCC_PCIE2_AUX_ARES>,
>> +                                <&gcc GCC_PCIE2_AHB_ARES>;
>> +                       reset-names = "pipe",
>> +                                     "sticky",
>> +                                     "axi_s_sticky",
>> +                                     "axi_s",
>> +                                     "axi_m_sticky",
>> +                                     "axi_m",
>> +                                     "aux",
>> +                                     "ahb";
>> +
>> +                       phys = <&pcie2_phy>;
>> +                       phy-names = "pciephy";
>> +                       msi-parent = <&v2m0>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               pcie0: pci@28000000 {
>> +                       compatible = "qcom,pcie-ipq9574";
>> +                       reg =  <0x28000000 0xf1d>,
>> +                              <0x28000F20 0xa8>,
>> +                              <0x28001000 0x1000>,
>> +                              <0x00080000 0x4000>,
>> +                              <0x28100000 0x1000>;
>> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
>> +                       device_type = "pci";
>> +                       linux,pci-domain = <1>;
>> +                       bus-range = <0x00 0xff>;
>> +                       num-lanes = <1>;
>> +                       #address-cells = <3>;
>> +                       #size-cells = <2>;
>> +
>> +                       ranges = <0x01000000 0x0 0x00000000 0x28200000 0x0 0x100000>,  /* I/O */
>> +                                <0x02000000 0x0 0x28300000 0x28300000 0x0 0x7d00000>; /* MEM */
>> +
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-map-mask = <0 0 0 0x7>;
>> +                       interrupt-map = <0 0 0 1 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +                                       <0 0 0 2 &intc 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +                                       <0 0 0 3 &intc 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +                                       <0 0 0 4 &intc 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "global_irq";
>> +
>> +                       /* clocks and clock-names are used to enable the clock in CBCR */
>> +                       clocks = <&gcc GCC_PCIE0_AHB_CLK>,
>> +                                <&gcc GCC_PCIE0_AUX_CLK>,
>> +                                <&gcc GCC_PCIE0_AXI_M_CLK>,
>> +                                <&gcc GCC_PCIE0_AXI_S_CLK>,
>> +                                <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
>> +                                <&gcc GCC_PCIE0_RCHNG_CLK>;
>> +                       clock-names = "ahb",
>> +                                     "aux",
>> +                                     "axi_m",
>> +                                     "axi_s",
>> +                                     "axi_bridge",
>> +                                     "rchng";
>> +
>> +                       resets = <&gcc GCC_PCIE0_PIPE_ARES>,
>> +                                <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE0_AXI_S_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE0_AXI_S_ARES>,
>> +                                <&gcc GCC_PCIE0_AXI_M_STICKY_ARES>,
>> +                                <&gcc GCC_PCIE0_AXI_M_ARES>,
>> +                                <&gcc GCC_PCIE0_AUX_ARES>,
>> +                                <&gcc GCC_PCIE0_AHB_ARES>;
>> +                       reset-names = "pipe",
>> +                                     "sticky",
>> +                                     "axi_s_sticky",
>> +                                     "axi_s",
>> +                                     "axi_m_sticky",
>> +                                     "axi_m",
>> +                                     "aux",
>> +                                     "ahb";
>> +
>> +                       phys = <&pcie0_phy>;
>> +                       phy-names = "pciephy";
>> +                       msi-parent = <&v2m0>;
>> +                       status = "disabled";
>> +               };
>> +
>>          };
>>
>>          timer {
>> --
>> 2.17.1
>>
> 
> 
