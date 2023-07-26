Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB72762DAD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjGZHbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjGZHak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 03:30:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6D269E;
        Wed, 26 Jul 2023 00:28:44 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q6x7mC013028;
        Wed, 26 Jul 2023 07:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b6d0Pgcb5T3zVyCrEF9Bn73mbjBIlw+8U/qf2e/tqdU=;
 b=AmPNxIwYcQJ2YKNxnPYPx/ZIiKw0YhjKB/z9Oe55+7dJ9MyVM5yUDHo7k3Cc91OcsvIA
 iDYta/GAg69/LXkyQpivqqBh3gnup0i6d3gxzKoNc7FJhfjAj6h0OywtgC83HVyZ/zZC
 hB9ovbfoBOvHiqKAtTkE+xGNC1QqUC+DhQfF6jPSZ2WS/XOpWrvQKHCKpKOdixloYLJq
 aOVCSfSIMpl3pgRyVla62z0l8K2SdrV1HABEjixhSCb14DxkN/lVPLuYoH/AOQLsBRxw
 ZfTVLm6TFyl+gRsAV6NwyfDYJTpUBM3KW4/Qecl+oB0lX4WhUB4CvQ7BOARcbHIP5gt2 yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2vq9g878-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:28:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q7SZrO004600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:28:35 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 00:28:31 -0700
Message-ID: <504e0678-9815-4a50-7d07-8a7fdad4ddfc@quicinc.com>
Date:   Wed, 26 Jul 2023 12:58:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] PCI: qcom: Add early fixup to set the max payload
 size for IPQ9574
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
 <20230724124711.2346886-2-quic_ipkumar@quicinc.com>
 <af7d1db2-8bbe-e078-6b17-7f841fb7f475@linaro.org>
 <20230724130855.GO6291@thinkpad> <20230724140940.GP6291@thinkpad>
 <172de6f2-ea61-568e-2845-d1334fb49cb6@quicinc.com>
 <20230725060635.GA22139@thinkpad>
Content-Language: en-US
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <20230725060635.GA22139@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I_S9jy7ZW7TUKJO14Lx_lzWZt30gBlZw
X-Proofpoint-GUID: I_S9jy7ZW7TUKJO14Lx_lzWZt30gBlZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307260064
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/25/2023 11:36 AM, Manivannan Sadhasivam wrote:
> On Tue, Jul 25, 2023 at 10:16:04AM +0530, Praveenkumar I wrote:
>> On 7/24/2023 7:39 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Jul 24, 2023 at 06:38:55PM +0530, Manivannan Sadhasivam wrote:
>>>> On Mon, Jul 24, 2023 at 02:53:37PM +0200, Konrad Dybcio wrote:
>>>>> On 24.07.2023 14:47, Praveenkumar I wrote:
>>>>>> Set 256 bytes as payload size for IPQ9574 via early fixup. This allows
>>>>>> PCIe RC to use the max payload size when a capable link partner is
>>>>>> connected.
>>>>>>
>>>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>>> ---
>>>>> [...]
>>>>>
>>>>>> +static void qcom_fixup_mps_256(struct pci_dev *dev)
>>>>>> +{
>>>>>> +	pcie_set_mps(dev, 256);
>>>>> Looks like setting "dev->pcie_mpss = 1" here would make the PCIe generic
>>>>> code take care of this.
>>>>>
>>>> Right, also this setting should not be PCI-PCI bridge specific but rather
>>>> controller specific.
>>>>
>>> Wait, have you tested this patch with PCIe devices having MPS < 256 i.e.,
>>> default 128?
>>>
>>> Take a look at this discussion: https://lore.kernel.org/all/20230608093652.1409485-1-vidyas@nvidia.com/
>>>
>>> - Mani
>> Yes, tested this patch with PCIe devices having default 128 and RC is
>> falling back to 128 when pci device is added.
>> This is handled inside pci_configure_mps().
>> /        mpss = 128 << dev->pcie_mpss;/
>> /        if (mpss < p_mps && pci_pcie_type(bridge) ==
>> PCI_EXP_TYPE_ROOT_PORT) {/
>> /                pcie_set_mps(bridge, mpss);/
>> /                pci_info(dev, "Upstream bridge's Max Payload Size set to %d
>> (was %d, max %d)\n",/
>> /                         mpss, p_mps, 128 << bridge->pcie_mpss);/
>> /                p_mps = pcie_get_mps(bridge);/
>> /        }/
>> //
>> Also getting the below print,
>> /[    2.011963] pci 0003:01:00.0: Upstream bridge's Max Payload Size set to
>> 128 (was 256, max 256)/
> Ok. But for setting MPS, you need to change the DEVCTL register in post_init
> sequence for IPQ9574. It is not a quirk, so you cannot use fixups.
Sure, will add in post_init of IPQ9574.

--
Thanks,
Praveenkumar
>
> - Mani
>
>>>> - Mani
>>>>
>>>>> Konrad
>>>> -- 
>>>> மணிவண்ணன் சதாசிவம்
>> --
>> Thanks,
>> Praveenkumar
