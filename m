Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B477D7C39
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 07:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJZFbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 01:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZFbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 01:31:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B776C1;
        Wed, 25 Oct 2023 22:31:02 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q5RvLl020299;
        Thu, 26 Oct 2023 05:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TpmWst0YTaQbHQXHbu3AD6DbrLSZSlQlBc5MhXt+JO0=;
 b=G8wbEv0QaAvgZLrumCkdPm/i3sRkrWSiK3r0MR1VSOYKGAxXTmFje+qRe7yTYCmrrChr
 +zqfGhg1Y9riLQePifbaKh/rLxsA9Vx+kizNWOCzy4V5ibHGU9QgLqiGkB2+HLdzMD52
 BxpUcl7BnO5XBgYUVGuGjKnx0cEYBVVGgZE0Skx8HrD532epS0YQeW2UroowPp2KHg+u
 jE706Jl2ayp9WZAimPNWaC66//ZIxYAJzGYrkBNC+b2ExQfFCbnCYkCBR71PmbjZyjSv
 s7RX6ZRSLgKLCXUqR162IhgsYqUgOR4GXUHeQOk9+wTSAGEYmxa53nCNEaPxNGpjKbmQ Ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ty0tu265a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 05:30:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q5Uf4u026009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 05:30:41 GMT
Received: from [10.216.45.182] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 22:30:32 -0700
Message-ID: <610b0621-b140-ee9b-c450-0fec6862c4fc@quicinc.com>
Date:   Thu, 26 Oct 2023 11:00:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/5] PCI: epf-mhi: Add support for SA8775P
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_shazhuss@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nayiluri@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <robh@kernel.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_parass@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-phy@lists.infradead.org>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-5-git-send-email-quic_msarkar@quicinc.com>
 <20231025075603.GD3648@thinkpad>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20231025075603.GD3648@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UsPh1zzspnuUr39tC_m-xsRWj4z3LVWm
X-Proofpoint-GUID: UsPh1zzspnuUr39tC_m-xsRWj4z3LVWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=833
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310260045
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/25/2023 1:26 PM, Manivannan Sadhasivam wrote:
> On Thu, Oct 19, 2023 at 05:07:09PM +0530, Mrinmay Sarkar wrote:
>> Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
>> SA8775P has the PID (0x0306) and supports HDMA. Currently, it has
> Is the PID fixed? I thought you just want to reuse the SDXxx PID in the
> meantime.
>
> - Mani

The PID for SA8775p EP is not decided yet. So using 0x0306 PID meantime.

--Mrinmay

>> no fixed PCI class, so it is being advertised as "PCI_CLASS_OTHERS".
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   drivers/pci/endpoint/functions/pci-epf-mhi.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> index b7b9d3e..4487260 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
>> @@ -114,6 +114,22 @@ static const struct pci_epf_mhi_ep_info sm8450_info = {
>>   	.flags = MHI_EPF_USE_DMA,
>>   };
>>   
>> +static struct pci_epf_header sa8775p_header = {
>> +	.vendorid = PCI_VENDOR_ID_QCOM,
>> +	.deviceid = 0x0306,
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
>> +};
>> +
>>   struct pci_epf_mhi {
>>   	const struct pci_epc_features *epc_features;
>>   	const struct pci_epf_mhi_ep_info *info;
>> @@ -677,6 +693,7 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
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
