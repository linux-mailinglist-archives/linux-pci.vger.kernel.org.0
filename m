Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089BF768B2A
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 07:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGaFaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 01:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaFaK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 01:30:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1446EE5C;
        Sun, 30 Jul 2023 22:30:10 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V5HZwo021616;
        Mon, 31 Jul 2023 05:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TfNJPRBwuW14VhhvfqZLWDeDCPiAPZ3dM663NzuDllk=;
 b=GYZ9+eL5665LKRPpKzQafpLQHpkH0l0cWt7RfIcMMMhbTdfVl6CbNqrfGsad0Uhxobfc
 J+ths8nUDfrwnRUl64Fh0I2WWtt6II1619FAyFcA9WYBF4880Xalua++Cks++jWFxJNg
 C7xav8qhZu1MIuhnv94Ag8bJWV0BlyRAIKpG/dg6J9k3pNBzUn9SdyOf51YE/ZsHmHWH
 DdpNAI+1Gta+nLLjVKW9Fd1FL/hHthOlkC3wuItW0j60AARkvxxXmR84Dqb6AD02J2TO
 ZOEsqzQLJeyRBrnN7cmH6p0yRGCFm0H8sWhYwSW66W+Bq1tBJb1FLwXtNSbx77vEieWJ zg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ueujpq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:30:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V5U5HE005197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:30:05 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 30 Jul
 2023 22:29:59 -0700
Message-ID: <1cfdf3c4-6e4f-e73d-c711-3890ceabb69d@quicinc.com>
Date:   Mon, 31 Jul 2023 10:59:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add PCIe0 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_parass@quicinc.com>,
        "reviewer:ARM/QUALCOMM CHROMEBOOK SUPPORT" 
        <cros-qcom-dts-watchers@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <1690540760-20191-1-git-send-email-quic_krichai@quicinc.com>
 <17c2ba50-3b72-523c-d92b-1ecbf9be7450@linaro.org>
 <f3d5c72d-90d3-b091-f995-5ad0bf93ae1d@quicinc.com>
 <a2024453-e749-b659-52a0-83ded8bb5c38@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <a2024453-e749-b659-52a0-83ded8bb5c38@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E4f9m9AGOeiuf4H1X0iHjhlat3W8oNo3
X-Proofpoint-ORIG-GUID: E4f9m9AGOeiuf4H1X0iHjhlat3W8oNo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=848
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310049
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/28/2023 9:27 PM, Krzysztof Kozlowski wrote:
> On 28/07/2023 17:10, Krishna Chaitanya Chundru wrote:
>> On 7/28/2023 5:33 PM, Krzysztof Kozlowski wrote:
>>> On 28/07/2023 12:39, Krishna chaitanya chundru wrote:
>>>> Add PCIe dtsi node for PCIe0 controller on sc7280 platform.
>>>>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> Thank you for your patch. There is something to discuss/improve.
>>>
>>>
>>>> +		pcie0_phy: phy@1c06000 {
>>>> +			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";
>>>> +			reg = <0 0x01c06000 0 0x1c0>;
>>>> +			#address-cells = <2>;
>>>> +			#size-cells = <2>;
>>>> +			ranges;
>>>> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>>>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>>>> +				 <&gcc GCC_PCIE_CLKREF_EN>,
>>>> +				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>>>> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
>>>> +
>>>> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>>>> +			reset-names = "phy";
>>>> +
>>>> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>>>> +			assigned-clock-rates = <100000000>;
>>>> +
>>>> +			status = "disabled";
>>>> +
>>>> +			pcie0_lane: phy@1c0e6200 {
>>> Isn't this old-style of bindings? Wasn't there a change? On what tree
>>> did you base it?
> The work was here:
> https://lore.kernel.org/all/20230324022514.1800382-5-dmitry.baryshkov@linaro.org/
>
> But I don't remember the status.
>
>> Let me rebase and send it again.
> This anyway looks like wrong compatible. You used sm8250.

The patch was send on latest linux-next only and the above change is not 
merged yet.

We are using the same compatible string as sm8250 because the phy is 
same both from hardware and software perspective for sm8250.

that is why we are using the same compatible string.

Can you let me know if we want create a separate compatible string for 
this even though  we are using same phy?

- KC.

>
> Best regards,
> Krzysztof
>
