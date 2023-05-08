Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86076FA9E7
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjEHK44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjEHK43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 06:56:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BBD31576;
        Mon,  8 May 2023 03:55:31 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3489RjBU016799;
        Mon, 8 May 2023 10:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wwGIVflxgcYEbSSfRt33GWz2bAD2ZPta9N/khOZxKJM=;
 b=Jg+uItN/CV+ZivaQF6nmXUHmJ6YoTPJuqQVBOb7VkTTxPzRJDjo2Z94ho0gUFUqJMOMd
 sed0+IOkCIRBk2pW+ikOsC49wmx19h1cU1CqKFRUmLcI9eNTwPY1YKm5qjEN6vcKyKo8
 zBkKb6F5CA7DD2k1XCdeG/pr1hBOdw23nTcsNUFflBfzRIpUr5PthM6a0K7dR6udKtJd
 h2kDEZmRX0e/OOWz7FUwK64+3xIVRkKEPsAASz7TDeMfB4W1hWFguqtlQC4KnkxbkwGq
 OmLegU3j0ohSk3x0dFcBnH/PzPRQjrSYhAkjbrhmYDaJSxjmEtFPPfBW0AYOnGH9+QHc zQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qexf1g5hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 10:55:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 348AtLUO010651
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 10:55:21 GMT
Received: from [10.216.51.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 03:55:14 -0700
Message-ID: <6c962760-d81c-af52-bce2-49090f66f4ee@quicinc.com>
Date:   Mon, 8 May 2023 16:25:10 +0530
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
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <CAA8EJpqx1jv_xEnS-2rOOGCtEB=1vo477H7XLGGvH=o7NHJD7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zS8fFU3lxbkVpPV_L_0MxgUOIKW40EgJ
X-Proofpoint-GUID: zS8fFU3lxbkVpPV_L_0MxgUOIKW40EgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=971 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080074
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/22/2023 5:43 AM, Dmitry Baryshkov wrote:
> On Fri, 21 Apr 2023 at 15:51, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>
>> Enable the PCIe controller and PHY nodes corresponding to
>> RDP 433.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V3:
>>          - No change
>>
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 62 +++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 7be578017bf7..3ae38cf327ea 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -8,6 +8,7 @@
>>
>>   /dts-v1/;
>>
>> +#include <dt-bindings/gpio/gpio.h>
>>   #include "ipq9574.dtsi"
>>
>>   / {
>> @@ -43,6 +44,42 @@
>>          };
>>   };
>>
>> +&pcie1_phy {
>> +       status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pcie_1_pin>;
>> +
>> +       perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
> 
> Usually qcom PCIe hosts also define wake-gpios.
In IPQ9574, we do not have hot plug support and host always starts the
enumeration for the device. Hence no wake pin is required.
> 
>> +       status = "okay";
>> +};
>> +
>> +&pcie2_phy {
>> +       status = "okay";
>> +};
>> +
>> +&pcie2 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pcie_2_pin>;
>> +
>> +       perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
>> +       status = "okay";
>> +};
>> +
>> +&pcie3_phy {
>> +       status = "okay";
>> +};
>> +
>> +&pcie3 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pcie_3_pin>;
>> +
>> +       perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
>> +       status = "okay";
>> +};
>> +
>>   &sdhc_1 {
>>          pinctrl-0 = <&sdc_default_state>;
>>          pinctrl-names = "default";
>> @@ -60,6 +97,31 @@
>>   };
>>
>>   &tlmm {
>> +
>> +       pcie_1_pin: pcie-1-state {
>> +               pins = "gpio26";
>> +               function = "gpio";
>> +               drive-strength = <8>;
>> +               bias-pull-down;
>> +               output-low;
> 
> No clkreq and no wake gpios?
We do not use any PCIe low power states and link is always in L0.

Thanks,
Devi Priya
> 
>> +       };
>> +
>> +       pcie_2_pin: pcie-2-state {
>> +               pins = "gpio29";
>> +               function = "gpio";
>> +               drive-strength = <8>;
>> +               bias-pull-down;
>> +               output-low;
>> +       };
>> +
>> +       pcie_3_pin: pcie-3-state {
>> +               pins = "gpio32";
>> +               function = "gpio";
>> +               drive-strength = <8>;
>> +               bias-pull-up;
>> +               output-low;
>> +       };
>> +
>>          sdc_default_state: sdc-default-state {
>>                  clk-pins {
>>                          pins = "gpio5";
>> --
>> 2.17.1
>>
> 
> 
