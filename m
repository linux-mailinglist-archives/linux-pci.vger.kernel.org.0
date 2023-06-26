Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24B673E0DD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFZNlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFZNlM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 09:41:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043FBB1;
        Mon, 26 Jun 2023 06:41:10 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QCJKH3022110;
        Mon, 26 Jun 2023 13:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uwSY6gRpDVb91XporXxBIWrVp0dHiwcLnx3HQdjjDb0=;
 b=XZ1vmsiniq4cgL9idyltEgpu/vprKjtra/HvPplUBKbzuBjdlh0FoiOymH060NLAu4iW
 nU2QBbKNJNRfaQ7T5ojtwGRxLxRicMroafYqXq8V1YGXolQZUg7zkS2/Dp/xDiL8EyNA
 LQqzA1pWEqf6RcdMpycyBqgM3saipcJlA4owYwUJV1K857hK6+CVHSOqL72wKes02T55
 qTpoZXYrNMp+lFs27qyvb0Qi7RDc46mTUTEorCTaFFYdLkkutW+rsIHFcAZ4VRNo939c
 8vv8JEg3H5XjdN+y/tjARFo/FWffDD3goJ7cNTb8aj8X1gtqykDrkPN6xfXpx2FANqI6 nw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdrq845c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 13:41:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QDf2lQ023536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 13:41:03 GMT
Received: from [10.216.43.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 06:40:58 -0700
Message-ID: <3291d4f1-1cb8-ad7e-3dd4-5b9cab9e22c7@quicinc.com>
Date:   Mon, 26 Jun 2023 19:10:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH RFC v1 1/3] PCI: endpoint: Add wakeup host API to EPC core
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
 <1686754850-29817-2-git-send-email-quic_krichai@quicinc.com>
 <20230623054313.GB5611@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230623054313.GB5611@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f7_yjaIP6b38NVlZ-zlQ6g_dw1eh-xJA
X-Proofpoint-GUID: f7_yjaIP6b38NVlZ-zlQ6g_dw1eh-xJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_10,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=842 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260122
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/23/2023 11:13 AM, Manivannan Sadhasivam wrote:
> On Wed, Jun 14, 2023 at 08:30:47PM +0530, Krishna chaitanya chundru wrote:
>> Endpoint cannot send any data/MSI when the device state is in
>> D3cold or D3hot. Endpoint needs to bring the device back to D0
>> to send any kind of data.
>>
>> For this endpoint can send inband PME the device is in D3hot or
>> toggle wake when the device is D3 cold.
>>
> Are you referring to "host" as the "device"? If so, then it is a wrong
> terminology.
I will correct this in next series.
>
>> To support this adding wake up host to epc core.
>>
> Commit message should be imperative.
>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/endpoint/pci-epc-core.c | 29 +++++++++++++++++++++++++++++
>>   include/linux/pci-epc.h             |  3 +++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 46c9a5c..d203947 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -167,6 +167,35 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>>   EXPORT_SYMBOL_GPL(pci_epc_get_features);
>>   
>>   /**
>> + * pci_epc_wakeup_host() - interrupt the host system
> s/interrupt the host system/Wakeup the host
>
>> + * @epc: the EPC device which has to interrupt the host
> s/interrupt/wake
>
>> + * @func_no: the physical endpoint function number in the EPC device
>> + * @vfunc_no: the virtual endpoint function number in the physical function
>> + *
>> + * Invoke to wakeup host
>> + */
>> +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>> +{
>> +	int ret;
>> +
>> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>> +		return -EINVAL;
>> +
>> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
>> +		return -EINVAL;
>> +
> Use proper errno for both of the above.
>
> - Mani

raise_irq functions also using errno can you please suggest correct value.

- KC

>> +	if (!epc->ops->wakeup_host)
>> +		return 0;
>> +
>> +	mutex_lock(&epc->lock);
>> +	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no);
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
>> index 301bb0e..a8496be 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -59,6 +59,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>>    * @start: ops to start the PCI link
>>    * @stop: ops to stop the PCI link
>>    * @get_features: ops to get the features supported by the EPC
>> + * @wakeup_host: ops to wakeup the host
>>    * @owner: the module owner containing the ops
>>    */
>>   struct pci_epc_ops {
>> @@ -88,6 +89,7 @@ struct pci_epc_ops {
>>   	void	(*stop)(struct pci_epc *epc);
>>   	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>>   						       u8 func_no, u8 vfunc_no);
>> +	int	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>>   	struct module *owner;
>>   };
>>   
>> @@ -232,6 +234,7 @@ int pci_epc_start(struct pci_epc *epc);
>>   void pci_epc_stop(struct pci_epc *epc);
>>   const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>>   						    u8 func_no, u8 vfunc_no);
>> +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>>   enum pci_barno
>>   pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>>   enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>> -- 
>> 2.7.4
>>
