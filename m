Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2374AF4B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 13:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjGGLBP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjGGLBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 07:01:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8BA183;
        Fri,  7 Jul 2023 04:01:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3677nwDH014849;
        Fri, 7 Jul 2023 11:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hh3FUEQLH5A6z7ukH7BO4W3WBRTzDGTQRuwB7yKyKK8=;
 b=NdwtTeT2a8wIwCkjroYSdMmXPJghg8roi3z8RKD+qVDjiOI9lSSUQkJ2ATX/IGoXwSBD
 pCuen9Ks/N40eXrz6+5RLQOfpomGvj47xouRsQ3lfFFY7Phoh9IKn3B9BhtKNhHY+M3e
 6XI7k7GFYTIC3pjaHRbRLsjXjOEwj8lK9LaMOLwRVoAn+fEZad7PCWRvR4dpNDFnrjNp
 mHNukOrY6v6mZFn5ufk2hAODUy/yQG+ByqYlwDo6t9lFb7zjd1zGL7/yEcicrFPfyvpT
 velbYgAZ9+OdKpKSNf+tt3GSEHSi64axkFbOQa0QOVe1qLh57bXyPH54A7pLMajIjO7E 8g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpenqrh7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:00:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367B0uQ1013508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 11:00:56 GMT
Received: from [10.216.29.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 04:00:49 -0700
Message-ID: <1d0bdd8d-0d6f-418a-e219-de71850d847a@quicinc.com>
Date:   Fri, 7 Jul 2023 16:30:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 7/8] PCI: epf-mhi: Add wakeup host op
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
 <1688122331-25478-8-git-send-email-quic_krichai@quicinc.com>
 <20230707061448.GF6001@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230707061448.GF6001@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -Dp4G1T1VJxFkQylrsHZi-RUXKnkmmx1
X-Proofpoint-GUID: -Dp4G1T1VJxFkQylrsHZi-RUXKnkmmx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070102
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/7/2023 11:44 AM, Manivannan Sadhasivam wrote:
> On Fri, Jun 30, 2023 at 04:22:10PM +0530, Krishna chaitanya chundru wrote:
>> Add wakeup host op for MHI EPF.
>> If the D-state is in D3cold toggle wake signal, otherwise send PME.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/endpoint/functions/pci-epf-mhi.c | 19 +++++++++++++++++++
>>   include/linux/mhi_ep.h                       |  1 +
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> index 64ff37d..deb742c 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> @@ -237,6 +237,24 @@ static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
>>   	return 0;
>>   }
>>   
>> +static int pci_epf_mhi_wakeup_host(struct mhi_ep_cntrl *mhi_cntrl)
>> +{
>> +	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
>> +	struct pci_epf *epf = epf_mhi->epf;
>> +	struct pci_epc *epc = epf->epc;
>> +	int ret;
>> +
>> +	if (mhi_cntrl->dstate == PCI_D3cold)
>> +		ret = pci_epc_wakeup_host(epc, epf->func_no,
>> +					epf->vfunc_no, PCI_WAKEUP_TOGGLE_WAKE);
>> +	else
>> +		ret = pci_epc_wakeup_host(epc, epf->func_no,
>> +					epf->vfunc_no, PCI_WAKEUP_SEND_PME);
>> +
> If the wakeup argument is of type bool (ie. bool use_pme), then
>
> 	wakeup = (mhi_cntrl->dstate == PCI_D3cold) ? false : true;
>
> 	return pci_epc_wakeup_host(epc, epf->func_no, epf->vfunc_no, state);
>
> - Mani

better to use type as it as it has more readability

but I have taken your inputs here and will change the code as suggetsed.

- KC

>> +	return ret;
>> +
>> +}
>> +
>>   static int pci_epf_mhi_core_init(struct pci_epf *epf)
>>   {
>>   	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
>> @@ -293,6 +311,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>>   	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
>>   	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
>>   	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
>> +	mhi_cntrl->wakeup_host = pci_epf_mhi_wakeup_host;
>>   
>>   	/* Register the MHI EP controller */
>>   	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
>> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
>> index c3a0685..e353c429 100644
>> --- a/include/linux/mhi_ep.h
>> +++ b/include/linux/mhi_ep.h
>> @@ -137,6 +137,7 @@ struct mhi_ep_cntrl {
>>   			   void __iomem *virt, size_t size);
>>   	int (*read_from_host)(struct mhi_ep_cntrl *mhi_cntrl, u64 from, void *to, size_t size);
>>   	int (*write_to_host)(struct mhi_ep_cntrl *mhi_cntrl, void *from, u64 to, size_t size);
>> +	int (*wakeup_host)(struct mhi_ep_cntrl *mhi_cntrl);
>>   
>>   	enum mhi_state mhi_state;
>>   
>> -- 
>> 2.7.4
>>
