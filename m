Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5F768B36
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 07:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGaFgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 01:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGaFgv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 01:36:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF259E6A;
        Sun, 30 Jul 2023 22:36:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V4t8NX014280;
        Mon, 31 Jul 2023 05:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Gl/yGtnp9U/poPTLy6857zeJ66HJ2b8zOy28r1cxRvQ=;
 b=lrDDegLbyPQZILQNOf3+HqDBVEs6G13QV8+47lKb3IVm2IMJ0OSQMaUO6rbtXNg2DVzW
 Qb65OcrD+j3ICA18ih4LlcCNHF089+ulq4oyrXJJ2PD67/HYz5xgWLxVco/cQ5+6DzR3
 MMDHhyTd9apJbuSNSUbeJuas86xuA8U+d7uf9ufv5lUZL5wqjwYNu0VvreRhIyUnQ6ph
 6KZw24sfyC0Bt/euAbYtIW0NPB7Lja0HHibzR6JMyz66p/V5oM3iKEYOZl0/AOUems1K
 eHbEKDwevMErkcOJqWiYf4k5JEB1JGVcbyVE/fswcxkJRZzqrfX5dwxd1KzEpw9oevD6 cQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ug22pr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:36:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V5aeev018138
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:36:40 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 30 Jul
 2023 22:36:35 -0700
Message-ID: <d82cc044-f3fb-f1a0-2ed2-e0d93c3a6667@quicinc.com>
Date:   Mon, 31 Jul 2023 11:06:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 5/9] PCI: endpoint: Add wakeup host API to EPC core
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
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-6-git-send-email-quic_krichai@quicinc.com>
 <20230728042129.GH4433@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230728042129.GH4433@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1xR4Rfj__F3A0HithiIRzpUy4q9lXK0w
X-Proofpoint-ORIG-GUID: 1xR4Rfj__F3A0HithiIRzpUy4q9lXK0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310050
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/28/2023 9:51 AM, Manivannan Sadhasivam wrote:
> On Thu, Jul 13, 2023 at 12:40:14PM +0530, Krishna chaitanya chundru wrote:
>> Endpoint cannot send any data/MSI when the D-state is in
>> D3cold or D3hot. Endpoint needs to wake up the host to
>> bring the D-state to D0.
>>
>> Endpoint can toggle wake signal when the D-state is in D3cold and vaux is
>> not supplied or can send inband PME.
>>
>> To support this add wakeup_host() callback to the EPC core.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/PCI/endpoint/pci-endpoint.rst |  6 ++++++
>>   drivers/pci/endpoint/pci-epc-core.c         | 31 +++++++++++++++++++++++++++++
>>   include/linux/pci-epc.h                     | 11 ++++++++++
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
>> index 3a54713..eb79b77 100644
>> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
>> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
>> @@ -53,6 +53,7 @@ by the PCI controller driver.
>>   	 * raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
>>   	 * start: ops to start the PCI link
>>   	 * stop: ops to stop the PCI link
>> +	 * wakeup_host: ops to wakeup host
>>   
>>      The PCI controller driver can then create a new EPC device by invoking
>>      devm_pci_epc_create()/pci_epc_create().
>> @@ -122,6 +123,11 @@ by the PCI endpoint function driver.
>>      The PCI endpoint function driver should use pci_epc_mem_free_addr() to
>>      free the memory space allocated using pci_epc_mem_alloc_addr().
>>   
>> +* pci_epc_wakeup_host()
>> +
>> +   The PCI endpoint function driver should use pci_epc_wakeup_host() to wakeup
>> +   host.
>> +
>>   Other EPC APIs
>>   ~~~~~~~~~~~~~~
>>   
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index ea76baf..b419eff 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -167,6 +167,37 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>>   EXPORT_SYMBOL_GPL(pci_epc_get_features);
>>   
>>   /**
>> + * pci_epc_wakeup_host() - Wakeup the host
>> + * @epc: the EPC device which has to wakeup the host
>> + * @func_no: the physical endpoint function number in the EPC device
>> + * @vfunc_no: the virtual endpoint function number in the physical function
>> + * @type: specify the type of wakeup: WAKEUP_FROM_D3COLD, WAKEUP_FROM_D3HOT
>> + *
>> + * Invoke to wakeup host
>> + */
>> +bool pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +			enum pci_epc_wakeup_host_type type)
>> +{
>> +	int ret;
>> +
>> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>> +		return false;
>> +
>> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
>> +		return false;
>> +
>> +	if (!epc->ops->wakeup_host)
>> +		return true;
>> +
>> +	mutex_lock(&epc->lock);
>> +	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no, type);
>> +	mutex_unlock(&epc->lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_epc_wakeup_host);
>> +
>> +/**
>>    * pci_epc_stop() - stop the PCI link
>>    * @epc: the link of the EPC device that has to be stopped
>>    *
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index 26a1108..d262179 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -26,6 +26,12 @@ enum pci_epc_irq_type {
>>   	PCI_EPC_IRQ_MSIX,
>>   };
>>   
>> +enum pci_epc_wakeup_host_type {
>> +	PCI_WAKEUP_UNKNOWN,
>> +	PCI_WAKEUP_SEND_PME,
>> +	PCI_WAKEUP_TOGGLE_WAKE,
> I think I asked you to get rid of these enums and use a bool. I don't see any
> new wakeup mechanism going to be added to the spec. So using enums for just 2
> options looks overkill to me.
>
> If you defer, please discuss it here.
>
> - Mani

I will remove the enum move in to bool in next series.

- KC

>> +};
>> +
>>   static inline const char *
>>   pci_epc_interface_string(enum pci_epc_interface_type type)
>>   {
>> @@ -59,6 +65,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>>    * @start: ops to start the PCI link
>>    * @stop: ops to stop the PCI link
>>    * @get_features: ops to get the features supported by the EPC
>> + * @wakeup_host: ops to wakeup the host
>>    * @owner: the module owner containing the ops
>>    */
>>   struct pci_epc_ops {
>> @@ -88,6 +95,8 @@ struct pci_epc_ops {
>>   	void	(*stop)(struct pci_epc *epc);
>>   	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>>   						       u8 func_no, u8 vfunc_no);
>> +	bool	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +				enum pci_epc_wakeup_host_type type);
>>   	struct module *owner;
>>   };
>>   
>> @@ -234,6 +243,8 @@ int pci_epc_start(struct pci_epc *epc);
>>   void pci_epc_stop(struct pci_epc *epc);
>>   const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>>   						    u8 func_no, u8 vfunc_no);
>> +bool pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +					enum pci_epc_wakeup_host_type type);
>>   enum pci_barno
>>   pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>>   enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>> -- 
>> 2.7.4
>>
