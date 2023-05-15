Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE24A702934
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 11:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbjEOJmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 05:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbjEOJlj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 05:41:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B0F19BE;
        Mon, 15 May 2023 02:38:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F8sbTB032080;
        Mon, 15 May 2023 09:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OvUxW3ggzDtwxpFxX6jlf1Ef9PaJvdrL+2RTDmBaS5U=;
 b=RB51rJNrjkfKGY6NGgQ6vEfF0ASSDmLTIAVEhC6nAInUTZYUxWU2iOR7/Zfx+Q1TRs2K
 CZYL3K3lUEuzPGsIyKaOm42RFH1yZreykHrn4fwEJi2s9GRAY0as7lH/uSLrIkqObRkG
 d5qL4nLeYuTABghhpGiNXridiE9F6NMrNcEN5WcswWgWCdWCKCCPeP9bNoVkb2hN49Ru
 80kMzrKaeWftYFELOsk4I4C+vl4P8QB6JrzCrBLHZePIAM1X7+CI2yEjdVY7H4RX8K9V
 4DXSye+6WIHOQ5XxYYFk+e2wqpXwuSzz1om8qtiVrc4swoDzH2JhUqMSy63UXNyxGiEv QQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj1gxub9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 09:37:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F9beH5031101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 09:37:40 GMT
Received: from [10.50.3.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 02:37:33 -0700
Message-ID: <61296c69-c8c1-5aca-f471-cc0286b5bff3@quicinc.com>
Date:   Mon, 15 May 2023 15:07:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 5/6] arm64: dts: qcom: ipq9574: Enable PCIe PHYs and
 controllers
Content-Language: en-US
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
 <20230421124938.21974-6-quic_devipriy@quicinc.com>
 <CAA8EJpqx1jv_xEnS-2rOOGCtEB=1vo477H7XLGGvH=o7NHJD7w@mail.gmail.com>
 <6c962760-d81c-af52-bce2-49090f66f4ee@quicinc.com>
 <fdf697c1-16a3-6b8c-90fa-51ef7137d546@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <fdf697c1-16a3-6b8c-90fa-51ef7137d546@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OtFBF-18Cck4b6FFI-aHYB_OjzOxAYO0
X-Proofpoint-ORIG-GUID: OtFBF-18Cck4b6FFI-aHYB_OjzOxAYO0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=914 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150082
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/8/2023 5:09 PM, Dmitry Baryshkov wrote:
> On 08/05/2023 13:55, Devi Priya wrote:
>>
>>
>> On 4/22/2023 5:43 AM, Dmitry Baryshkov wrote:
>>> On Fri, 21 Apr 2023 at 15:51, Devi Priya <quic_devipriy@quicinc.com> 
>>> wrote:
>>>>
>>>> Enable the PCIe controller and PHY nodes corresponding to
>>>> RDP 433.
>>>>
>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>> ---
>>>>   Changes in V3:
>>>>          - No change
>>>>
>>>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 62 
>>>> +++++++++++++++++++++
>>>>   1 file changed, 62 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts 
>>>> b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>>> index 7be578017bf7..3ae38cf327ea 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>>> @@ -8,6 +8,7 @@
>>>>
>>>>   /dts-v1/;
>>>>
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>   #include "ipq9574.dtsi"
>>>>
>>>>   / {
>>>> @@ -43,6 +44,42 @@
>>>>          };
>>>>   };
>>>>
>>>> +&pcie1_phy {
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&pcie1 {
>>>> +       pinctrl-names = "default";
>>>> +       pinctrl-0 = <&pcie_1_pin>;
>>>> +
>>>> +       perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
>>>
>>> Usually qcom PCIe hosts also define wake-gpios.
>> In IPQ9574, we do not have hot plug support and host always starts the
>> enumeration for the device. Hence no wake pin is required.
> 
> None of the qcom PCIe hosts support hotplug, if I remember correctly. 
> This is not a reason not to describe the hardware.

Okay, will add the pin definitions for wake and clkreq in the next spin.
> 
>>>
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&pcie2_phy {
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&pcie2 {
>>>> +       pinctrl-names = "default";
>>>> +       pinctrl-0 = <&pcie_2_pin>;
>>>> +
>>>> +       perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&pcie3_phy {
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&pcie3 {
>>>> +       pinctrl-names = "default";
>>>> +       pinctrl-0 = <&pcie_3_pin>;
>>>> +
>>>> +       perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>>   &sdhc_1 {
>>>>          pinctrl-0 = <&sdc_default_state>;
>>>>          pinctrl-names = "default";
>>>> @@ -60,6 +97,31 @@
>>>>   };
>>>>
>>>>   &tlmm {
>>>> +
>>>> +       pcie_1_pin: pcie-1-state {
>>>> +               pins = "gpio26";
>>>> +               function = "gpio";
>>>> +               drive-strength = <8>;
>>>> +               bias-pull-down;
>>>> +               output-low;
>>>
>>> No clkreq and no wake gpios?
>> We do not use any PCIe low power states and link is always in L0.
> 
> Again. We = software. Please describe the hardware here.
Got it.
> 
>>
>> Thanks,
>> Devi Priya
>>>
>>>> +       };
>>>> +
>>>> +       pcie_2_pin: pcie-2-state {
>>>> +               pins = "gpio29";
>>>> +               function = "gpio";
>>>> +               drive-strength = <8>;
>>>> +               bias-pull-down;
>>>> +               output-low;
>>>> +       };
>>>> +
>>>> +       pcie_3_pin: pcie-3-state {
>>>> +               pins = "gpio32";
>>>> +               function = "gpio";
>>>> +               drive-strength = <8>;
>>>> +               bias-pull-up;
>>>> +               output-low;
>>>> +       };
>>>> +
>>>>          sdc_default_state: sdc-default-state {
>>>>                  clk-pins {
>>>>                          pins = "gpio5";
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>>
> 
Thanks,
Devi Priya
