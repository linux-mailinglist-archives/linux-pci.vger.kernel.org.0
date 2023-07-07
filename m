Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BE74AF29
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGGK4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjGGK4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 06:56:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F571FEF;
        Fri,  7 Jul 2023 03:55:58 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3679xdKc006721;
        Fri, 7 Jul 2023 10:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=obI5eKTLYtLpSbs+2g7o9F767TLV5GtMm+CGwjAlcQ8=;
 b=JZ7qL1k4JLWxW86LbHhgI1WikZ/zJfFi6vI8UfyjOstvJ0GJLq2rzAIHGS6xqFULetD9
 X0Z0kIg9QXS8FFooBvRpLmCJQpySvv64uwFNEzbusdY8ZVND4SH6WXS9DyIa0Me0sWVO
 Wj//mEaOglb1nU500jzuikXSz0Kh6ZdiXLe2DgQRvZlS8zGaV40jzMY6Nl7BS2ViJYYA
 /RIlmcMXo4CuJ35FydnhXS0mQ/p02fWuSEYFDlfKzjjaYpN2kdi0IjftQ8OhrLznJ+7v
 oMvVgdpVY2aNHwi4QcCsZvvGbjmFEwG+kBM7tYle7gFmNunAPPpnM6MgMeUtC+eeIj/O Xw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpenqrgmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:55:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367AtgZ1001607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 10:55:42 GMT
Received: from [10.216.29.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 03:55:36 -0700
Message-ID: <73323ece-720b-96cc-0b07-7dd477715c9d@quicinc.com>
Date:   Fri, 7 Jul 2023 16:25:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 3/8] PCI: epf-mhi: Add dtate change op
Content-Language: en-US
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
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-4-git-send-email-quic_krichai@quicinc.com>
 <20230707055906.GC6001@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230707055906.GC6001@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nHp-H3ntb405frFG0tKq9Qwfkd_Fwcb2
X-Proofpoint-GUID: nHp-H3ntb405frFG0tKq9Qwfkd_Fwcb2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=908 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070100
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/7/2023 11:29 AM, Manivannan Sadhasivam wrote:
> On Fri, Jun 30, 2023 at 04:22:06PM +0530, Krishna chaitanya chundru wrote:
>> Add dstate host op for MHI EPF.
>>
> Use "D-state" everywhere. Also the subject should be:
>
> "PCI: epf-mhi: Add support for handling D-state notification from EPC"
>
> Fix the commit message accordingly.
I will change it as you suggested.
>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/endpoint/functions/pci-epf-mhi.c | 13 +++++++++++++
>>   include/linux/mhi_ep.h                       |  3 +++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> index 9c1f5a1..64ff37d 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> @@ -339,6 +339,18 @@ static int pci_epf_mhi_bme(struct pci_epf *epf)
>>   	return 0;
>>   }
>>   
>> +static int pci_epf_mhi_dstate_change(struct pci_epf *epf, pci_power_t state)
>> +{
>> +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
>> +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
>> +	struct device *dev = &epf->dev;
>> +
>> +	mhi_cntrl->dstate = state;
>> +	dev_info(dev, "D-state changeg to %s\n", pci_power_name(state));
> This can be removed since we already print the state in pci driver.
>
> - Mani

ok

- KC

>
>> +
>> +	return 0;
>> +}
>> +
>>   static int pci_epf_mhi_bind(struct pci_epf *epf)
>>   {
>>   	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
>> @@ -394,6 +406,7 @@ static struct pci_epc_event_ops pci_epf_mhi_event_ops = {
>>   	.link_up = pci_epf_mhi_link_up,
>>   	.link_down = pci_epf_mhi_link_down,
>>   	.bme = pci_epf_mhi_bme,
>> +	.dstate_change = pci_epf_mhi_dstate_change,
>>   };
>>   
>>   static int pci_epf_mhi_probe(struct pci_epf *epf,
>> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
>> index f198a8a..c3a0685 100644
>> --- a/include/linux/mhi_ep.h
>> +++ b/include/linux/mhi_ep.h
>> @@ -8,6 +8,7 @@
>>   
>>   #include <linux/dma-direction.h>
>>   #include <linux/mhi.h>
>> +#include <linux/pci.h>
>>   
>>   #define MHI_EP_DEFAULT_MTU 0x8000
>>   
>> @@ -139,6 +140,8 @@ struct mhi_ep_cntrl {
>>   
>>   	enum mhi_state mhi_state;
>>   
>> +	pci_power_t dstate;
>> +
>>   	u32 max_chan;
>>   	u32 mru;
>>   	u32 event_rings;
>> -- 
>> 2.7.4
>>
