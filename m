Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496B5740838
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 04:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjF1CVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 22:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjF1CVB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 22:21:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371202D7F;
        Tue, 27 Jun 2023 19:20:24 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S1gwPO018118;
        Wed, 28 Jun 2023 02:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wChvnQpbZl0i7nYuGgGZYQce+R0ZoPhA/3GOZAW/6LY=;
 b=bzsNrOCL+QcrqXxcTl09QD2SIHi2pSJ8UGCB+0WSN86+EnHuzC+bKV6q4v/oVb8tbj7o
 ftHcxgREr2CWP7p3qEEUNaYGHWNTTnmRkVbJkfhLf5T9KNp0yNwLQZEgUTAnzFUlZGIW
 BgbOLyAuiaUs3kSxMXh4j7xl7qVGlEEzKeOyuiHudusQ34P3Ysa8hYs5nDRT23+GQgp0
 MhXI0ZI8ebcRRgm5kDudkqtSNfPDH/NvGqG0zV8YEx3wG1X4QL47F8nIysPJ8ALakVuR
 pTp4pvXAsfDDhVSo8x++rtEk5Gw+TcsSTpdfjV6MkT/SzuRMBMbMTEHeGq7bccuItsQU Vg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg21t99hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 02:20:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S2KFIA010891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 02:20:15 GMT
Received: from [10.216.43.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 19:20:09 -0700
Message-ID: <22c618f3-a8e1-57b7-86a1-d9f3d466c46a@quicinc.com>
Date:   Wed, 28 Jun 2023 07:50:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 2/3] arm: dts: qcom: sdx65: Add interconnect path
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
 <1687827692-6181-3-git-send-email-quic_krichai@quicinc.com>
 <20230627143912.GG5490@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230627143912.GG5490@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UkrywGR7YvnbB1A--3ZwlFA4O9dESNoB
X-Proofpoint-GUID: UkrywGR7YvnbB1A--3ZwlFA4O9dESNoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280020
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/27/2023 8:09 PM, Manivannan Sadhasivam wrote:
> On Tue, Jun 27, 2023 at 06:31:30AM +0530, Krishna chaitanya chundru wrote:
>> Add pcie-mem interconnect path to sdx65 target.
>>
> "target" is meaningless in upstream. Call it "SoC or platform".
>
> Also the subject should mention PCIe interconnect.
done
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> With both changes above,
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> - Mani
>
>> ---
>>   arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
>> index 1a35830..77fa97c 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
>> +++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
>> @@ -332,6 +332,9 @@
>>   				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>>   			interrupt-names = "global", "doorbell";
>>   
>> +			interconnects = <&system_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
>> +			interconnect-names = "pcie-mem";
>> +
>>   			resets = <&gcc GCC_PCIE_BCR>;
>>   			reset-names = "core";
>>   
>> -- 
>> 2.7.4
>>
