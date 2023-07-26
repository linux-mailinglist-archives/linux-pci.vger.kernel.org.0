Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E97631E6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjGZJZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjGZJZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 05:25:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0020844A3;
        Wed, 26 Jul 2023 02:23:46 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q712cq019132;
        Wed, 26 Jul 2023 09:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vAPpEIr0isn/71/ioYM8Fd1GJjkXSLk8Q5T4v1mFx40=;
 b=iyyNAMk+p6QI5cSYHInQIO/ZyLoDLPHAkWEtDMPliouzlXWq4YWfup5pNBLiKiBDcZce
 1N5XQ20WG0i415gbiCkUC8TogjEH/dIjHZ8OX4sgJwIcZHfjNWj1uDNNjhpkSpTql0Wp
 lA7nqKRIBFkPL5VAjCZmb72d+A5SC7tt5/O7zEH8HTPEap5A6UBfI+C9JZUjsqwjI70r
 /uHuL3swTaL7GDcPR0WvwE6gSqEyL2Xuy8QMItw6WzLtW7NAr7R8R/pMVgDC9QWDskx3
 2//dBmbuO3Dl/cpiaW5v41aMQQIpE9iO12z00zxghqJ28Hu6+rEMBUbQ0XZOSx9sZYz6 WQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2dqajfar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:23:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q9NXrs002590
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:23:33 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 02:23:05 -0700
Message-ID: <c93f7705-c7c0-c03d-aa46-e1c6c1177b25@quicinc.com>
Date:   Wed, 26 Jul 2023 14:52:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] PCI: qcom: Add early fixup to set the max payload
 size for IPQ9574
Content-Language: en-US
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
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <20230725060635.GA22139@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1ITb65FFLeFwiPp3j4FYx7-aTC3Zt4IY
X-Proofpoint-ORIG-GUID: 1ITb65FFLeFwiPp3j4FYx7-aTC3Zt4IY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_03,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260082
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
Sorry, if I do so, then the above mentioned issue will come here as well 
right?

This one: https://lore.kernel.org/all/20230608093652.1409485-1-vidyas@nvidia.com/

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
