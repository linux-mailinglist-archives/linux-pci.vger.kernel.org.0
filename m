Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D376703E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjG1PLa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjG1PL3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 11:11:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DE10CB;
        Fri, 28 Jul 2023 08:11:28 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SCxYmu021467;
        Fri, 28 Jul 2023 15:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+M1QcnslsutWlO5X/4Ecy8tXoGFGslAYbFb1EjhoPe8=;
 b=fD2x+4iEWo2Y5j6649zpeBgY5WzVO1ojQBHFIwRUiKHm56AxvceZfr8faNNeYQa4ND0Y
 8lPjSndLvM0HytKxLIvZAVD1xBolDnYbR5zM+57pV5axGDp/ZAMs8eXchKw2zjf7g0Mi
 5uu3ujBjMePVuyLStoo8/sNfG0W49ICP/n3TUZhxZAcFcArqwCcedImeoze1/IU2gK+G
 0IydaomdgAOkiNsZYuLJ3jL/nI/Jgsyh1nvrPGcl6/QoSfhiUxhs2WlSl/N/2J8mkwbK
 BSrkXVEOofw73EZWDtlPpUPOu8m3Pd/KFsDNFa0WmiTKw0GWGOSBMBiH7tuS1ayOvGkE +g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s469hha2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 15:11:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SFBKJM008061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 15:11:20 GMT
Received: from [10.216.26.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 08:10:58 -0700
Message-ID: <f3d5c72d-90d3-b091-f995-5ad0bf93ae1d@quicinc.com>
Date:   Fri, 28 Jul 2023 20:40:54 +0530
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
        <devicetree@vger.kernel.org>
References: <1690540760-20191-1-git-send-email-quic_krichai@quicinc.com>
 <17c2ba50-3b72-523c-d92b-1ecbf9be7450@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <17c2ba50-3b72-523c-d92b-1ecbf9be7450@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hOlM99BQYESLq8VgbD3ILXuwJl74JUvh
X-Proofpoint-GUID: hOlM99BQYESLq8VgbD3ILXuwJl74JUvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307280140
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/28/2023 5:33 PM, Krzysztof Kozlowski wrote:
> On 28/07/2023 12:39, Krishna chaitanya chundru wrote:
>> Add PCIe dtsi node for PCIe0 controller on sc7280 platform.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Thank you for your patch. There is something to discuss/improve.
>
>
>> +		pcie0_phy: phy@1c06000 {
>> +			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";
>> +			reg = <0 0x01c06000 0 0x1c0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>> +				 <&gcc GCC_PCIE_CLKREF_EN>,
>> +				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
>> +
>> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>> +			reset-names = "phy";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>> +			assigned-clock-rates = <100000000>;
>> +
>> +			status = "disabled";
>> +
>> +			pcie0_lane: phy@1c0e6200 {
> Isn't this old-style of bindings? Wasn't there a change? On what tree
> did you base it?
Let me rebase and send it again.
>> +
>> +			pcie0_wake_n: pcie0-wake-n {
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
>
> Nodes end with 'state'.

I will run it send it again.

Thanks,

KC

>
>> +				pins = "gpio89";
>> +				function = "gpio";
>> +
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
> Best regards,
> Krzysztof
>
