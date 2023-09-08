Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCA079814A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 06:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjIHElp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 00:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjIHElo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 00:41:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660141BC1;
        Thu,  7 Sep 2023 21:41:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3884b5IX021572;
        Fri, 8 Sep 2023 04:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/YpH8EiXOi2Wqulnarf+kRVpHMxGqgcCEA1tZip1MHQ=;
 b=J0YDM8asu9d4CzV+lJMxzJiSEwDPhSFl4fqvpqc0LNVckzbL1+htrd3UtVP8czR14pPg
 y+0k1mKeYG9t0VgrcP3/25xBp0JcDusGMvlNjYV+kRGbNqX/nn607XzPeRojd5huTIsy
 po0JvML9Qu06l8SbcTWL9esX6G3xLRDvypjeiHQSJAz4WdosK8uUg7i3FEkqhHY3Kk1j
 4jyUi0Gm9zwg8CKoXW3z2DUMTOu+Ac6U/0XuzxuXtVbMhlCsZ7bIhcv85EHNaYQfi1Ko
 1oi/pqhQz6+nMpFUCqRgY1HK+HpeN4Ez5ZpaWAy17LkZ8uG1kZZbbO9ApaliyLqeYCfh Hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3synyq8qe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 04:41:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3884fS9G028485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 04:41:28 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 21:41:23 -0700
Message-ID: <ae239a22-a038-c4d4-c715-cb775de82659@quicinc.com>
Date:   Fri, 8 Sep 2023 10:11:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 1/4] PCI: endpoint: Add D-state change notifier support
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20230803174858.GA103086@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230803174858.GA103086@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: up_dQetlEW2PBoj_01JzC9Ph6IkKzxWU
X-Proofpoint-GUID: up_dQetlEW2PBoj_01JzC9Ph6IkKzxWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080042
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/3/2023 11:18 PM, Bjorn Helgaas wrote:
> On Wed, Aug 02, 2023 at 09:21:18AM +0530, Krishna chaitanya chundru wrote:
>> Add support to notify the EPF device about the D-state change event
>> from the EPC device.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/PCI/endpoint/pci-endpoint.rst |  4 ++++
>>   drivers/pci/endpoint/pci-epc-core.c         | 27 +++++++++++++++++++++++++++
>>   include/linux/pci-epc.h                     |  1 +
>>   include/linux/pci-epf.h                     |  1 +
>>   4 files changed, 33 insertions(+)
>>
>> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
>> index 4f5622a..66f3191 100644
>> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
>> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
>> @@ -78,6 +78,10 @@ by the PCI controller driver.
>>      Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
>>   
>>   
>> +* pci_epc_dstate_notity()
> s/notity/notify/ (several instances)

sorry for late reply, till now I was using a different branch which has 
some out of tree patches for testing and rebasing the patch on 
linux-next to send them because of that few things are getting missed.

Now I took time to completely move to the linux next so that testing and 
sending patches will be on same code base.

>> +
>> +   Notify all the function drivers that the EPC device has changed its D-state.
>> +
>>   EPC APIs for the PCI Endpoint Function Driver
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 6c54fa5..4cf9c82 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -785,6 +785,33 @@ void pci_epc_bme_notify(struct pci_epc *epc)
>>   EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
>>   
>>   /**
>> + * pci_epc_dstate_notity() - Notify the EPF driver that EPC device D-state
>> + *			has changed
>> + * @epc: the EPC device which has change in D-state
>> + * @state: the changed D-state
>> + *
>> + * Invoke to Notify the EPF device that the EPC device has D-state has
>> + * changed.
> s/device has D-state/device D-state/
>
>> + */
>> +void pci_epc_dstate_notity(struct pci_epc *epc, pci_power_t state)
>> +{
>> +	struct pci_epf *epf;
>> +
>> +	if (!epc || IS_ERR(epc))
>> +		return;
> Is this needed?  Looks like a programming error if we return here.  I
> don't like silently ignoring errors like this.  I generally prefer
> taking the NULL pointer dereference oops so we know the caller is
> broken and can fix it.
sure I will remove this check in the next patch series.
>
>> +	mutex_lock(&epc->list_lock);
>> +	list_for_each_entry(epf, &epc->pci_epf, list) {
>> +		mutex_lock(&epf->lock);
>> +		if (epf->event_ops && epf->event_ops->dstate_notify)
>> +			epf->event_ops->dstate_notify(epf, state);
>> +		mutex_unlock(&epf->lock);
>> +	}
>> +	mutex_unlock(&epc->list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_epc_dstate_notity);
>> +
>> +/**
>>    * pci_epc_destroy() - destroy the EPC device
>>    * @epc: the EPC device that has to be destroyed
>>    *
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index 5cb6940..26a1108 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -251,4 +251,5 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>>   				     phys_addr_t *phys_addr, size_t size);
>>   void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>>   			   void __iomem *virt_addr, size_t size);
>> +void pci_epc_dstate_change(struct pci_epc *epc, pci_power_t state);
>>   #endif /* __LINUX_PCI_EPC_H */
>> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
>> index 3f44b6a..529075b 100644
>> --- a/include/linux/pci-epf.h
>> +++ b/include/linux/pci-epf.h
>> @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
>>   	int (*link_up)(struct pci_epf *epf);
>>   	int (*link_down)(struct pci_epf *epf);
>>   	int (*bme)(struct pci_epf *epf);
>> +	int (*dstate_notify)(struct pci_epf *epf, pci_power_t state);
>>   };
>>   
>>   /**
>> -- 
>> 2.7.4
>>
