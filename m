Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500587C505F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjJKKkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 06:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJKKkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 06:40:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7E494;
        Wed, 11 Oct 2023 03:40:07 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7kEow020666;
        Wed, 11 Oct 2023 10:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dbVR0f08zGU0LFTiDSP4fMsRyjEfLOVaROii0XQJqS4=;
 b=e5Z9P6OUmumkDhTHscAyOOmBe01pXPv8g4vfB6WXtU3x1tp4RK5iNASb/KvlLqBuPaHx
 KbJ5bp96Grg3vTQPiBmeifT046fmQXMFSSnkx/itrLhWvW+DnmcNdoHV42pSjFUM/41n
 jRi5w0AZCTBoKWnhCYUWWGhiMKl0NOhhpGNzvvXWG/autjQxdh4eAROkhvcw3u4pvOHI
 2+DHhWf1h3Vmz94IBTzVDCeG5OcdxsMOHujChKvgmukIj2sGFlteMb5ZrnGiQS6Z3HgL
 y6mvcJfYxEPKPYR+YCPieAWkmv/CVkKA2hQPPwtq7zoGPms/Z8nIgXrd9zMlRWeGZTaj aQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnqh1gd47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 10:39:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BAdeS6001148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 10:39:40 GMT
Received: from [10.216.52.55] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 03:39:33 -0700
Message-ID: <01230ca8-505b-74c2-7872-24b5411c6b2e@quicinc.com>
Date:   Wed, 11 Oct 2023 16:09:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 4/5] PCI: epf-mhi: Add support for SA8775P
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_shazhuss@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nayiluri@quicinc.com>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_parass@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-phy@lists.infradead.org>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-5-git-send-email-quic_msarkar@quicinc.com>
 <20230921084055.GD2891@thinkpad>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20230921084055.GD2891@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z6E6trT_zM5dT-pVAFs54BsmvzUih5xn
X-Proofpoint-ORIG-GUID: Z6E6trT_zM5dT-pVAFs54BsmvzUih5xn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_08,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=789
 mlxscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110093
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/21/2023 2:10 PM, Manivannan Sadhasivam wrote:
> On Wed, Sep 20, 2023 at 07:25:11PM +0530, Mrinmay Sarkar wrote:
>> Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
>> SA8775P has the PID (0x0306) and supports HDMA. Currently, it has
>> no fixed PCI class, so it is being advertised as "PCI_CLASS_OTHERS".
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   drivers/pci/endpoint/functions/pci-epf-mhi.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> index b7b9d3e..4b349fd 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> @@ -114,6 +114,23 @@ static const struct pci_epf_mhi_ep_info sm8450_info = {
>>   	.flags = MHI_EPF_USE_DMA,
>>   };
>>   
>> +static struct pci_epf_header sa8775p_header = {
> static const struct...
>
>> +	.vendorid = PCI_VENDOR_ID_QCOM,
>> +	.deviceid = 0x0306,
> Why are you not using a distinct device id?
>
> - Mani
distinct device id for EP is not created yet as of now we are reusing this.
Will update once device id is decided.

Thanks,
Mrinmay
>> +	.baseclass_code = PCI_CLASS_OTHERS,
>> +	.interrupt_pin = PCI_INTERRUPT_INTA,
>> +};
>> +
>> +static const struct pci_epf_mhi_ep_info sa8775p_info = {
>> +	.config = &mhi_v1_config,
>> +	.epf_header = &sa8775p_header,
>> +	.bar_num = BAR_0,
>> +	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
>> +	.msi_count = 32,
>> +	.mru = 0x8000,
>> +	.flags = MHI_EPF_USE_DMA,
>> +};
>> +
>>   struct pci_epf_mhi {
>>   	const struct pci_epc_features *epc_features;
>>   	const struct pci_epf_mhi_ep_info *info;
>> @@ -677,6 +694,7 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
>>   }
>>   
>>   static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
>> +	{ .name = "sa8775p", .driver_data = (kernel_ulong_t)&sa8775p_info },
>>   	{ .name = "sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
>>   	{ .name = "sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
>>   	{},
>> -- 
>> 2.7.4
>>
