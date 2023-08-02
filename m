Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41276C49C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 07:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjHBFIj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 01:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHBFIh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 01:08:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B31736;
        Tue,  1 Aug 2023 22:08:36 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724iq2T008426;
        Wed, 2 Aug 2023 05:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wvRy7uls/ygryFOVbiVe5u68L1wBTZIcWjlcO84YQ20=;
 b=CPGsq8eVC1WyWaXlru//vTda+/C3wnFv//p66lUcSWaPb0nsdWK6ndpAoBnQ8deJmCMC
 9oFSUUaQ6fI38jahth9kpugZIZlur7FoX6twWBEi3ctozS7rQN43mL6WlSg4X4+w3Ldo
 uVEFoLfFF+fMuJP87djNnLulwYzysW60OmMPmmpNe52PBV6XIET3dfLh0Y7k7PmCAFk/
 sXltdGil3czRUXbR89Q++2jZun1ed90EXq0Gy6YSrT6aGOY65SCG+P2MGpp7KbqXbEOn
 JyIZU0SI9fKveY1wsE5klUE8i25gaL/Re94LqfPDBKxOO9qxCkoL4ZSuYSOxhgPCW9e2 bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7bp68fpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 05:08:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37258VUW022715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 05:08:31 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 1 Aug
 2023 22:08:25 -0700
Message-ID: <386a727c-f845-c802-f4e3-8f727adfd2ad@quicinc.com>
Date:   Wed, 2 Aug 2023 10:38:22 +0530
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
 <1cfdf3c4-6e4f-e73d-c711-3890ceabb69d@quicinc.com>
 <0617841a-5d1f-b703-daa9-fedba148a05d@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <0617841a-5d1f-b703-daa9-fedba148a05d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iXuTwDUFsZQ3Rv9vbuUW956SySPTalAB
X-Proofpoint-ORIG-GUID: iXuTwDUFsZQ3Rv9vbuUW956SySPTalAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020045
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/31/2023 12:24 PM, Krzysztof Kozlowski wrote:
> On 31/07/2023 07:29, Krishna Chaitanya Chundru wrote:
>> On 7/28/2023 9:27 PM, Krzysztof Kozlowski wrote:
>>> On 28/07/2023 17:10, Krishna Chaitanya Chundru wrote:
>>>> On 7/28/2023 5:33 PM, Krzysztof Kozlowski wrote:
>>>>> On 28/07/2023 12:39, Krishna chaitanya chundru wrote:
>>>>>> Add PCIe dtsi node for PCIe0 controller on sc7280 platform.
>>>>>>
>>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>> Thank you for your patch. There is something to discuss/improve.
>>>>>
>>>>>
>>>>>> +		pcie0_phy: phy@1c06000 {
>>>>>> +			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";
>>>>>> +			reg = <0 0x01c06000 0 0x1c0>;
>>>>>> +			#address-cells = <2>;
>>>>>> +			#size-cells = <2>;
>>>>>> +			ranges;
>>>>>> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>>>>>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>>>>>> +				 <&gcc GCC_PCIE_CLKREF_EN>,
>>>>>> +				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>>>>>> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
>>>>>> +
>>>>>> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>>>>>> +			reset-names = "phy";
>>>>>> +
>>>>>> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>>>>>> +			assigned-clock-rates = <100000000>;
>>>>>> +
>>>>>> +			status = "disabled";
>>>>>> +
>>>>>> +			pcie0_lane: phy@1c0e6200 {
>>>>> Isn't this old-style of bindings? Wasn't there a change? On what tree
>>>>> did you base it?
>>> The work was here:
>>> https://lore.kernel.org/all/20230324022514.1800382-5-dmitry.baryshkov@linaro.org/
>>>
>>> But I don't remember the status.
>>>
>>>> Let me rebase and send it again.
>>> This anyway looks like wrong compatible. You used sm8250.
>> The patch was send on latest linux-next only and the above change is not
>> merged yet.
> I don't think we will want old DTS syntax... but this actually depends
> on the status of Dmitry's patchset.

Kryzysztof, as the bindings also not yet merged shall we use old DTS 
syntax or shall I rebase on dmitry's patch and send it.

- KC

>
>> We are using the same compatible string as sm8250 because the phy is
>> same both from hardware and software perspective for sm8250.
>>
>> that is why we are using the same compatible string.
>>
>> Can you let me know if we want create a separate compatible string for
>> this even though  we are using same phy?
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#42
>
>
> Best regards,
> Krzysztof
>
