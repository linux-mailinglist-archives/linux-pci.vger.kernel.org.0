Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765B7DDCA0
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 07:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjKAG2h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjKAG2g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 02:28:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C8F4;
        Tue, 31 Oct 2023 23:28:31 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A140ApP002361;
        Wed, 1 Nov 2023 06:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NvlO8hyE+EMyAG/EGJTufk+yIskf1ldqOh3svl/SLRU=;
 b=mSWLGLr1c5xvnU1nzuu9vetqpKMqv9Dh7WxtB8MxsI+bLisPsmeUHARKKrtzMKHFUmfQ
 fX7XbWbueux88K6OJCxhfDjOovtDNgu+1VV8iPyD4QZiKZlDkNSC32mKX/YcvWAEx46f
 Eo5MRksoyYNdk3v73EASkVwZ3xJzUYslYUnKMosv93dnK5rlu6G9wsiL5UOGPmRCfdx1
 GaxtnQcZnEPBJ3SBwT6tSlzcjBaB6KJ26wXybGEDHvv7I0eiZ3CLGSc03AvvwtZyg1mL
 38PK0ZBLTe7la9U85QDP4OvqsMwFpdwYH180rNYq8PPqnMUgxy1W1sNisSoE/fByhOs7 5g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3ayvry0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 06:28:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A16SETO009121
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 06:28:14 GMT
Received: from [10.216.34.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 23:28:06 -0700
Message-ID: <3c96e4c7-361a-86e7-3590-254f17f71efe@quicinc.com>
Date:   Wed, 1 Nov 2023 11:58:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 4/4] arm64: dts: qcom: sa8775p: Add ep pcie0 controller
 node
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_shazhuss@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nayiluri@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <robh@kernel.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_parass@quicinc.com>,
        <quic_schintav@quicinc.com>, <quic_shijose@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhi@lists.linux.dev>
References: <1698729108-27356-1-git-send-email-quic_msarkar@quicinc.com>
 <1698729108-27356-5-git-send-email-quic_msarkar@quicinc.com>
 <20231101052633.GF2897@thinkpad>
Content-Language: en-US
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20231101052633.GF2897@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vY5lM5IG10suTWP1_HEUlof0nI3u2Jda
X-Proofpoint-ORIG-GUID: vY5lM5IG10suTWP1_HEUlof0nI3u2Jda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_03,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010054
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/1/2023 10:56 AM, Manivannan Sadhasivam wrote:
> On Tue, Oct 31, 2023 at 10:41:48AM +0530, Mrinmay Sarkar wrote:
>> Add ep pcie dtsi node for pcie0 controller found on sa8775p platform.
>> It supports gen4 and x2 link width. Limiting the speed to Gen3 due to
>> stability issues.
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> One question below:
>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi | 46 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 13dd44d..7eab458 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -3586,6 +3586,52 @@
>>   		status = "disabled";
>>   	};
>>   
>> +	pcie0_ep: pcie-ep@1c00000 {
>> +		compatible = "qcom,sa8775p-pcie-ep";
>> +		reg = <0x0 0x01c00000 0x0 0x3000>,
>> +		      <0x0 0x40000000 0x0 0xf20>,
>> +		      <0x0 0x40000f20 0x0 0xa8>,
>> +		      <0x0 0x40001000 0x0 0x4000>,
>> +		      <0x0 0x40200000 0x0 0x100000>,
>> +		      <0x0 0x01c03000 0x0 0x1000>,
>> +		      <0x0 0x40005000 0x0 0x2000>;
>> +		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
>> +			    "mmio", "dma";
>> +
>> +		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>> +			<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>> +			<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
>> +			<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
>> +			<&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
>> +
>> +		clock-names = "aux",
>> +			      "cfg",
>> +			      "bus_master",
>> +			      "bus_slave",
>> +			      "slave_q2a";
>> +
>> +		interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +		interrupt-names = "global", "doorbell", "dma";
>> +
>> +		interconnects = <&pcie_anoc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
>> +				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
>> +		interconnect-names = "pcie-mem", "cpu-pcie";
>> +
>> +		iommus = <&pcie_smmu 0x0000 0x7f>;
> SID is really 0?
>
> - Mani
Yes Mani, SA877P has SID 0x0 for pcie 0 controller and 0x80 for pcie 1 
controller.
> --Mrinmay
>
>> +		resets = <&gcc GCC_PCIE_0_BCR>;
>> +		reset-names = "core";
>> +		power-domains = <&gcc PCIE_0_GDSC>;
>> +		phys = <&pcie0_phy>;
>> +		phy-names = "pciephy";
>> +		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
>> +		num-lanes = <2>;
>> +
>> +		status = "disabled";
>> +	};
>> +
>>   	pcie0_phy: phy@1c04000 {
>>   		compatible = "qcom,sa8775p-qmp-gen4x2-pcie-phy";
>>   		reg = <0x0 0x1c04000 0x0 0x2000>;
>> -- 
>> 2.7.4
>>
