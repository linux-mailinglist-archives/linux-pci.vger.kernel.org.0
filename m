Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032A7BA2D4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjJEPsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJEPsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 11:48:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491411E55;
        Thu,  5 Oct 2023 07:28:57 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3952fMpg014041;
        Thu, 5 Oct 2023 02:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t2VKfZO3kaUydr1C8UHvRTAhUAaI59kgNGZmiU5iSQw=;
 b=ZVzbzDBvRjg/6Id8Gi63jMlR9FTP5+qsuIx5xcOS/cXU1PTId+D76+lTILukyL1neuHb
 gthGRfZion4nudW86OLnQ1EzpfFX7qKHDTjxfLOgaNS3DZTX/q8dqpkUzCQB5GyZCPoR
 lbRTxVV/ltBJrUJIoKMWGuwsimCIAAwFDHc/Jiv7YPq7pYXLFUx5FdbzC18ruMvg/Ipb
 HqQRH1Z8ZHvE/nVmz/oxfE7EUZIDSpeLcS8xzraJhSX4MyrcC2I2yksuMC817L/HkksK
 ntWKkiYdR3ilAY7ox6LDLEs+YsnIcCoOSUXbNOoo93kDnI43UfInwum47o2//Fb5to/H 3Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th2gq2njh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 02:53:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3952rHx2005537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 02:53:17 GMT
Received: from [10.50.3.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 19:53:10 -0700
Message-ID: <d4ea5877-b2e8-4cfe-9129-7fdae30adf20@quicinc.com>
Date:   Thu, 5 Oct 2023 08:23:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_ipkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20231003120846.28626-1-quic_nsekar@quicinc.com>
 <20231003120846.28626-2-quic_nsekar@quicinc.com>
 <4bc021c1-0198-41a4-aa73-bf0cf0c0420a@linaro.org>
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
In-Reply-To: <4bc021c1-0198-41a4-aa73-bf0cf0c0420a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Lhri4GHhApCv2WP1UNSg7ujlNiVXSe8W
X-Proofpoint-ORIG-GUID: Lhri4GHhApCv2WP1UNSg7ujlNiVXSe8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/4/2023 12:27 PM, Krzysztof Kozlowski wrote:
> On 03/10/2023 14:08, Nitheesh Sekar wrote:
>> Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5018.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Thank you for your patch. There is something to discuss/improve.
Sure. Will learn and improve.
>
>
>> ---
>>   .../bindings/phy/qcom,uniphy-pcie-28lp.yaml   | 77 +++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
>> new file mode 100644
>> index 000000000000..6b2574f9532e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
> Filename should match compatibles and they do not use 28lp.
Sure. will remove the 28lp. added it based on the file name.
Is "qcom,uniphy-pcie.yaml" good ? Because this will be used for other 
SoCs as well which will have different compatibles. So i did not include 
the SoC name, lane and speed info which i have used int he compatible 
names.
>
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/qcom,uniphy-pcie-28lp.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm UNIPHY PCIe 28LP PHY driver
> Driver as Linux driver? Drop. Describe the hardware instead.
>
>> +
>> +maintainers:
>> +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
>> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5018-uniphy-pcie-gen2x1
>> +      - qcom,ipq5018-uniphy-pcie-gen2x2
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: pipe_clk
> Drop _clk... or even drop entire clock-names. Not needed for one entry.
Sure. Will drop "_clk" part.
>
>> +
>> +  resets:
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: phy
>> +      - const: phy_phy
> These are absolutely terrible names. If you have third one, it would be
> "phy_phy_phy"? Drop or provide something useful.
Sure. Will update.

Thanks,
Nitheesh
