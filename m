Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF5D76A822
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 07:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjHAFCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 01:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHAFCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 01:02:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D51FC0;
        Mon, 31 Jul 2023 22:02:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3714ttAh005630;
        Tue, 1 Aug 2023 05:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wm30csJIa8z9huWOXeGea+qwS8xfPAuLuBvd7DemDJA=;
 b=QMz7CcVBsJeTJxYEamzA6U3MwbJQBnnB6cEPle4qtJd8z+HqYX8NNNM/4K0A9TEU17z9
 AAQ48u7LtgC2SLiblM0BCsFr024MRq1wJQ350p68QQF+hYoF/SlKQ/BB+QGW0Q1xbX+5
 O2siZb8r5Q/FTUjw1NmfElmwfDgoPvD6imJvyMBH2YidsiSjd6esvXIIyXpSJrJYzE6m
 VZvwOJC4xYuyhcJosH1BVmcwMmE4OFtjxeNzhwbFSmE6AxVMRRkPBuvCsOmJKryRG9i5
 9ZmCbwqvX2AwabT/Ptri5j2LeBBq3sP5sbXnNqZ+oSlZsbegmpxyjiZ+QROvS5iRNF2q Mg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8gt4e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 05:01:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37151okm006868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 05:01:50 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 22:01:45 -0700
Message-ID: <0a6ca984-9797-88b1-ae12-c64916f6c61c@quicinc.com>
Date:   Tue, 1 Aug 2023 10:31:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 3/9] PCI: epf-mhi: Add support for handling D-state
 notify from EPC
Content-Language: en-US
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-4-git-send-email-quic_krichai@quicinc.com>
 <20230728040949.GF4433@thinkpad>
 <1cfa6656-8130-ce1d-e28e-3665f12cc76a@quicinc.com>
In-Reply-To: <1cfa6656-8130-ce1d-e28e-3665f12cc76a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eIDeKjv3DqUaD_b_sypyi86MOCdefaxH
X-Proofpoint-GUID: eIDeKjv3DqUaD_b_sypyi86MOCdefaxH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_02,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=978
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010045
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/31/2023 11:05 AM, Krishna Chaitanya Chundru wrote:
>
> On 7/28/2023 9:39 AM, Manivannan Sadhasivam wrote:
>> On Thu, Jul 13, 2023 at 12:40:12PM +0530, Krishna chaitanya chundru 
>> wrote:
>>> Add support for handling D-state notify for MHI EPF.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> ---
>>>   drivers/pci/endpoint/functions/pci-epf-mhi.c | 11 +++++++++++
>>>   include/linux/mhi_ep.h                       |  3 +++
>>>   2 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c 
>>> b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>>> index 9c1f5a1..ee91bfc 100644
>>> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
>>> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>>> @@ -339,6 +339,16 @@ static int pci_epf_mhi_bme(struct pci_epf *epf)
>>>       return 0;
>>>   }
>>>   +static int pci_epf_mhi_dstate_notify(struct pci_epf *epf, 
>>> pci_power_t state)
>>> +{
>>> +    struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
>>> +    struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
>>> +
>>> +    mhi_cntrl->dstate = state;
>> Where is this variable being used? Also, don't we need any locking?
>>
>> - Mani
>
> we are using this variable in wakeup host op which is introduced on 
> patch [PATCH v4 8/9] PCI: epf-mhi: Add wakeup host op
>
> I will add lock in my next series.
>
> - KC

Mani, as this is being called from IRQ context do we need to add any 
lock here.

- KC

>
>>
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int pci_epf_mhi_bind(struct pci_epf *epf)
>>>   {
>>>       struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
>>> @@ -394,6 +404,7 @@ static struct pci_epc_event_ops 
>>> pci_epf_mhi_event_ops = {
>>>       .link_up = pci_epf_mhi_link_up,
>>>       .link_down = pci_epf_mhi_link_down,
>>>       .bme = pci_epf_mhi_bme,
>>> +    .dstate_notify = pci_epf_mhi_dstate_notify,
>>>   };
>>>     static int pci_epf_mhi_probe(struct pci_epf *epf,
>>> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
>>> index f198a8a..c3a0685 100644
>>> --- a/include/linux/mhi_ep.h
>>> +++ b/include/linux/mhi_ep.h
>>> @@ -8,6 +8,7 @@
>>>     #include <linux/dma-direction.h>
>>>   #include <linux/mhi.h>
>>> +#include <linux/pci.h>
>>>     #define MHI_EP_DEFAULT_MTU 0x8000
>>>   @@ -139,6 +140,8 @@ struct mhi_ep_cntrl {
>>>         enum mhi_state mhi_state;
>>>   +    pci_power_t dstate;
>>> +
>>>       u32 max_chan;
>>>       u32 mru;
>>>       u32 event_rings;
>>> -- 
>>> 2.7.4
>>>
>
