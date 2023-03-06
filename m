Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4916AC48D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCFPN6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCFPN5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:13:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49420044;
        Mon,  6 Mar 2023 07:13:55 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326DhlLI007269;
        Mon, 6 Mar 2023 15:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T7/SMlEP0i5jF/rvaqPXk10U51jTGqVEFpIxRO9I11c=;
 b=krjunMrpMXWTnhiuFqxlzVbaAAj8nabbHzjh6Top6IZFTAGguIbItWR8uQpVnoO9oBOR
 PGCDZWPDig27oQjg8iVzggLLi5W/anTblc1Ex2rPj3IEXAHnhJnCPUhgg9b3sOHrmnj/
 83KEruNVxMe+Q/SkfrEcwbyg8jQtcmoCJe3h7kVeXoVMyJNkosecOKX1NiO/Re1LlogX
 2SoR421IJhRkHbVT6GdL4StmCl1gTTIG8dQqQCgrF7fVA0PtbHepmg8hm+NYp9THfuQr
 ocOiqmXHN7Qh2Mi++BNMprFPj3h+XXkTdJqXoxxIO4S5thr9EOudfqrMvYv1PnhFz9F8 4g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p418754pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:13:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326FDlUq009046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 15:13:47 GMT
Received: from [10.216.34.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 07:13:41 -0800
Message-ID: <06fc09a3-d17f-e35e-3622-1773b9fda83d@quicinc.com>
Date:   Mon, 6 Mar 2023 20:43:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/6] ARM: dts: qcom: sdx65: Add support for PCIe PHY
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678080302-29691-4-git-send-email-quic_rohiagar@quicinc.com>
 <302654ee-3ecb-2274-af1a-9b58f7d0f49d@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <302654ee-3ecb-2274-af1a-9b58f7d0f49d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZNIl0H3pFIGMXuFexQ6qRYOHuDETHXFO
X-Proofpoint-ORIG-GUID: ZNIl0H3pFIGMXuFexQ6qRYOHuDETHXFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060134
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/6/2023 2:11 PM, Dmitry Baryshkov wrote:
> On 06/03/2023 07:24, Rohit Agarwal wrote:
>> Add devicetree support for PCIe PHY used in SDX65 platform. This PHY is
>> used by the PCIe EP controller.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm/boot/dts/qcom-sdx65.dtsi | 32 
>> ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi 
>> b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> index b073e0c..246290d 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> @@ -292,6 +292,38 @@
>>               status = "disabled";
>>           };
>>   +        pcie0_phy: phy@1c07000 {
>> +            compatible = "qcom,sdx65-qmp-pcie-phy";
>> +            reg = <0x01c07000 0x1e4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +            clocks = <&gcc GCC_PCIE_AUX_PHY_CLK_SRC>,
>> +                 <&gcc GCC_PCIE_CFG_AHB_CLK>,
>> +                 <&gcc GCC_PCIE_0_CLKREF_EN>,
>> +                 <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "ref", "refgen";
>> +
>> +            resets = <&gcc GCC_PCIE_PHY_BCR>;
>> +            reset-names = "phy";
>> +            assigned-clocks = <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
>> +            assigned-clock-rates = <100000000>;
>> +            status = "disabled";
>> +
>> +            pcie0_lane: lanes@1c06000 {
>
> Please use new style bindings found in qcom,sc8280xp-qmp-pcie-phy.yaml

Sure, Will update it the bindings and this.

Thanks,
Rohit.
>
>> +                reg = <0x01c06000 0xf0>, /* tx0 */
>> +                      <0x01c06200 0x2f0>, /* rx0 */
>> +                      <0x01c07200 0x1e8>, /* pcs */
>> +                      <0x01c06800 0xf0>, /* tx1 */
>> +                      <0x01c06a00 0x2f0>, /* rx1 */
>> +                      <0x01c07400 0xc00>; /* pcs_misc */
>> +                clocks = <&gcc GCC_PCIE_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                #phy-cells = <0>;
>> +                clock-output-names = "pcie_pipe_clk";
>> +            };
>> +        };
>> +
>>           tcsr_mutex: hwlock@1f40000 {
>>               compatible = "qcom,tcsr-mutex";
>>               reg = <0x01f40000 0x40000>;
>
