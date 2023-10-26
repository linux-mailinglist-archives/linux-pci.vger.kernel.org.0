Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388FC7D7D25
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjJZHAG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 03:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJZHAF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 03:00:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE5192;
        Thu, 26 Oct 2023 00:00:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q4LBEM025969;
        Thu, 26 Oct 2023 06:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RvSu2wBlTyaSD4rRdyzHdiuXKRFtHzfpvGcgmEvfdi8=;
 b=Mm3H6XKxmd5uT50Wi9fpdzKVVVedUokbzNypEo330L0LypWhAUzZ2xq2AjEFQhwL2RJV
 UN+xBSeDHTGiFpQewp5JK82LOeD1Hsolkx3gEdPjWFQjdvjWTN6ANdSl9Bx18IX7Nlex
 WYvHR+sh3hEZziS9wVvlHExJNDbmdkQDRIZK2cPKliWNurusuLiS/DhE+zmTzSbqJv94
 mNQo6S8I/rDu2rwBrR7dITH58zA4cYy4BrPIWuDZRFw661oY+fEGswtoiYQ2dFIXYN7Z
 +37BKGzR5879Ihm6nflQ9IB0/6nIkqBfo0lRyhmbkk8J40WNXFH44urFBlSn1YGb1Nhv fw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyfwfre7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 06:59:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q6xlJ0009877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 06:59:47 GMT
Received: from [10.216.45.182] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 23:59:34 -0700
Message-ID: <23f3f2a8-dcbd-6764-195b-49bcec451084@quicinc.com>
Date:   Thu, 26 Oct 2023 12:29:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/5] PCI: qcom-ep: Add support for SA8775P SOC
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_shazhuss@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nayiluri@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <robh@kernel.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_parass@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-phy@lists.infradead.org>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-3-git-send-email-quic_msarkar@quicinc.com>
 <20231025075317.GC3648@thinkpad>
 <adbca084-a74b-51be-67b5-a3b9e45da506@quicinc.com>
 <20231026061035.GA4915@thinkpad>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20231026061035.GA4915@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4qyOtCkhD_4PxOxnlRidLfytKY9mAn1X
X-Proofpoint-GUID: 4qyOtCkhD_4PxOxnlRidLfytKY9mAn1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260058
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/26/2023 11:40 AM, Manivannan Sadhasivam wrote:
> On Thu, Oct 26, 2023 at 11:08:03AM +0530, Mrinmay Sarkar wrote:
>> On 10/25/2023 1:23 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Oct 19, 2023 at 05:07:07PM +0530, Mrinmay Sarkar wrote:
>>>> Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
>>>> driver. There will be some change specific to SA8775P so adding new
>>>> compatible string.
>>>>
>>> What are those specific changes?
>>>
>>> - Mani
>> Need to enable cache snooping logic for SA8775P only.
>>
> Then you can add the compatible to the driver at that time and use the fallback
> till then i.e., just document the SA8775P compatible in bindings and use both
> SA8775P and SM8450 compatibles in the dts where the latter will act as a
> fallback.
>
> - Mani

I am getting below error in dtb checking if I add SM8450 as fallback 
compatible in dtsi. As both has different set of clocks.

//local/mnt/workspace/Mrinmay/new_lemans/next-20231018/linux-next/out/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: 
pcie-ep@1c00000: compatible: 'oneOf' conditional failed, one must be 
fixed://
//        ['qcom,sa8775p-pcie-ep', 'qcom,sm8450-pcie-ep'] is too long//
//        'qcom,sdx65-pcie-ep' was expected//
//        'qcom,sdx55-pcie-ep' was expected//
//        from schema $id: 
http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
///local/mnt/workspace/Mrinmay/new_lemans/next-20231018/linux-next/out/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: 
pcie-ep@1c00000: clocks: [[31, 66], [31, 68], [31, 69], [31, 78], [31, 
79]] is too short//
//        from schema $id: 
http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
///local/mnt/workspace/Mrinmay/new_lemans/next-20231018/linux-next/out/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: 
pcie-ep@1c00000: clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave', 
'slave_q2a'] is too short/

>> --Mrinmay
>>
>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>>> index 32c8d9e..4c01c34 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>>> @@ -858,6 +858,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
>>>>    }
>>>>    static const struct of_device_id qcom_pcie_ep_match[] = {
>>>> +	{ .compatible = "qcom,sa8775p-pcie-ep", },
>>>>    	{ .compatible = "qcom,sdx55-pcie-ep", },
>>>>    	{ .compatible = "qcom,sm8450-pcie-ep", },
>>>>    	{ }
>>>> -- 
>>>> 2.7.4
>>>>
