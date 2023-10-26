Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0847D7CAD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 08:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjJZGHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 02:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 02:07:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9FB115;
        Wed, 25 Oct 2023 23:07:35 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q5eRr0031318;
        Thu, 26 Oct 2023 06:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KDM71q8BiVPqtYksL9m1q2Fw8IvCWeWBl16ry1SsfxY=;
 b=gNfjQFnFPePfSlmWez4c7MYbNmHGOejf0t4uNYmr/cTWS4wBaD7RjO7wnxyAjCyWEOFs
 Y4fGb85ihOjpLP4b0tqjbVBS40aXAUZA8v0GqZOUn3jbTzECPJKfPCjC+gaTMAaSPcA8
 KBBtSpNmdxgc8ssZDR9TEkpHXMp640xOH0hoZh+hUtEAkHG3MdnOpncdntmFP/IFeBdt
 esY+kM7UAbl1qEiZEphliHmKH2j+FTmz27ZkPTQqcfduDOdoliXvBTXuHDXK8o3elOJa
 1FkAc+LSJ+GQjWa1fi80UkpNt25wMvEZhzCcWczO9Jd5++JhKq9EbAh2t4mjIlATvZBz jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ty5wdsjj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 06:07:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q67Mel007246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 06:07:22 GMT
Received: from [10.216.45.182] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 23:07:14 -0700
Message-ID: <f961166d-a6ab-82f9-b5ed-113b81a1d709@quicinc.com>
Date:   Thu, 26 Oct 2023 11:37:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sa8775p: Add ep pcie0 controller
 node
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_shazhuss@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nayiluri@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <robh@kernel.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_parass@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-phy@lists.infradead.org>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-6-git-send-email-quic_msarkar@quicinc.com>
 <20231025075224.GB3648@thinkpad>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20231025075224.GB3648@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zBrtP00kc42ipvz1QcTqSLtmkt5Qg9mb
X-Proofpoint-ORIG-GUID: zBrtP00kc42ipvz1QcTqSLtmkt5Qg9mb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310260049
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/25/2023 1:22 PM, Manivannan Sadhasivam wrote:
> On Thu, Oct 19, 2023 at 05:07:10PM +0530, Mrinmay Sarkar wrote:
>> Add ep pcie dtsi node for pcie0 controller found on sa8775p platform.
>> It supports gen4 and x2 link width. Due to some stability issue in
>> gen4 enabling gen3 as of now.
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi | 48 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 13dd44d..2aa7383 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -3714,4 +3714,52 @@
>>   
>>   		status = "disabled";
>>   	};
>> +
>> +	pcie0_ep: pcie-ep@1c00000 {
>> +		compatible = "qcom,sa8775p-pcie-ep";
>> +		reg = <0x0 0x01c00000 0x0 0x3000>,
>> +		      <0x0 0x40000000 0x0 0xf20>,
>> +		      <0x0 0x40000f20 0x0 0xa8>,
>> +		      <0x0 0x40001000 0x0 0x4000>,
>> +		      <0x0 0x40200000 0x0 0x100000>,
>> +		      <0x0 0x01c03000 0x0 0x1000>,
>> +		      <0x0 0x40005000 0x0 0x2000>;
> Can we sort the reg entries?

Sort based on reg address? I think we are following the same sequence 
for other target as well.

--Mrinmay

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
>> +		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
>> +			    <0x100 &pcie_smmu 0x0001 0x1>;
> I think I recommended using "iommu-map" instead of "iommus" property. But
> looking at it again, I think it is fine to use just "iommus" property as the SID
> will be associated with the EP directly.
>
> Unless you want to have different SID for each function.
>
>> +
>> +		resets = <&gcc GCC_PCIE_0_BCR>;
>> +		reset-names = "core";
>> +		power-domains = <&gcc PCIE_0_GDSC>;
>> +		phys = <&pcie0_phy>;
>> +		phy-names = "pciephy";
>> +		max-link-speed = <3>;
> Please add a comment here that you are limiting the Gen speed due to stability
> issues. Like,
>
> 		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
>
>> +		num-lanes = <2>;
> Can you check if the controller is cache coherent? If so, we should add
> "dma-coherent" property.
>
> - Mani
>
>> +
>> +		status = "disabled";
>> +	};
>>   };
>> -- 
>> 2.7.4
>>
