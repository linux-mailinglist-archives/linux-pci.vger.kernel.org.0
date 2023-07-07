Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85974AF1B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 12:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGGKxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjGGKxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 06:53:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E919A5;
        Fri,  7 Jul 2023 03:53:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3675mDOi006007;
        Fri, 7 Jul 2023 10:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KtfkCOnIAXvYTY8NXlpZbf3tZAVETmZLz4XrH0WvJrk=;
 b=Q34raBANEaLo1s5FDGCQvV8PqYhh1JATCGBZGjCKJSJfVFb7LNztRW8iVVYJ9JZ8SqKR
 loFRt0EN2zy8ezC5NMp7NVHFM1IAzwpf0RYqUchiSga0U6IQ038rDyL+6iI8gBOrj33h
 LoKAJ7E/xDrYFkHMDvOxn+NQ69nUxa3FrqBY2RPN08V2IdLfgOGd+cY9ZxP5K0BND5SL
 UhSU0Q9+dHF0t61a/YDgQpUb5XTp7IF7JtjTOVFcRRj6pNcN4Ao8BJRgdAHv48OA7qLJ
 yijAGr2t2/gyS/bl6Pv7WgHAQjuTz/gA50rjql1qrifymCjoZrUI/RSNTQayTD5yJBBt Vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp8a61a2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:53:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367Aqw1O030665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 10:52:58 GMT
Received: from [10.216.29.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 03:52:52 -0700
Message-ID: <a5360f12-1687-d03e-6ba4-0f6e487905d5@quicinc.com>
Date:   Fri, 7 Jul 2023 16:22:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/8] PCI: endpoint: Add dstate change notifier support
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
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-2-git-send-email-quic_krichai@quicinc.com>
 <20230707054454.GA6001@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230707054454.GA6001@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N47EQJ3tPGMFEGeA0bYaakmohATvqppz
X-Proofpoint-GUID: N47EQJ3tPGMFEGeA0bYaakmohATvqppz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070099
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/7/2023 11:14 AM, Manivannan Sadhasivam wrote:
> On Fri, Jun 30, 2023 at 04:22:04PM +0530, Krishna chaitanya chundru wrote:
>> Add support to notify the EPF device about the D-state change event
>> from the EPC device.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/PCI/endpoint/pci-endpoint.rst |  5 +++++
>>   drivers/pci/endpoint/pci-epc-core.c         | 27 +++++++++++++++++++++++++++
>>   include/linux/pci-epc.h                     |  1 +
>>   include/linux/pci-epf.h                     |  1 +
>>   4 files changed, 34 insertions(+)
>>
>> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
>> index 4f5622a..0538cdc 100644
>> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
>> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
>> @@ -78,6 +78,11 @@ by the PCI controller driver.
>>      Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
>>   
>>   
>> +* pci_epc_dstate_change()
>> +
>> +   In order to notify all the function devices that the EPC device has
>> +   changed its D-state.
>> +
>>   EPC APIs for the PCI Endpoint Function Driver
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 6c54fa5..cad360f 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -785,6 +785,33 @@ void pci_epc_bme_notify(struct pci_epc *epc)
>>   EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
>>   
>>   /**
>> + * pci_epc_dstate_change() - Notify the EPF device that EPC device D-state
>> + *			has changed
>> + * @epc: the EPC device which has change in D-state
>> + * @state: the changed D-state
>> + *
>> + * Invoke to Notify the EPF device that the EPC device has D-state has
>> + * changed.
>> + */
>> +void pci_epc_dstate_change(struct pci_epc *epc, pci_power_t state)
> How about "pci_epc_dstate_notity()"?
>
> Rest looks good.
>
> - Mani

sure I will change to pci_epc_dstate_notity

-KC

>
>> +{
>> +	struct pci_epf *epf;
>> +
>> +	if (!epc || IS_ERR(epc))
>> +		return;
>> +
>> +	mutex_lock(&epc->list_lock);
>> +	list_for_each_entry(epf, &epc->pci_epf, list) {
>> +		mutex_lock(&epf->lock);
>> +		if (epf->event_ops && epf->event_ops->dstate_change)
>> +			epf->event_ops->dstate_change(epf, state);
>> +		mutex_unlock(&epf->lock);
>> +	}
>> +	mutex_unlock(&epc->list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_epc_dstate_change);
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
>> index 4b52807..1d3c2a2 100644
>> --- a/include/linux/pci-epf.h
>> +++ b/include/linux/pci-epf.h
>> @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
>>   	int (*link_up)(struct pci_epf *epf);
>>   	int (*link_down)(struct pci_epf *epf);
>>   	int (*bme)(struct pci_epf *epf);
>> +	int (*dstate_change)(struct pci_epf *epf, pci_power_t state);
>>   };
>>   
>>   /**
>> -- 
>> 2.7.4
>>
