Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A53768B4D
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 07:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjGaFju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 01:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGaFjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 01:39:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F021738;
        Sun, 30 Jul 2023 22:39:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V5IHoU031259;
        Mon, 31 Jul 2023 05:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y37+2zogaPTYO9ta+KBrS9cJl/BaP8CRdIqHRWIBk7c=;
 b=AEb7imhqFNGFyOdBQEE/gEwDQ4b33tb2J9gkcHKAwIbp3er5rX+vw49ZWK6iV5RqMDz2
 35h3kA2jZEVD1YLw5X6yU8CG7dPO5OBELz/bdvmYkEzE7kZhAKHSTzaWNjbGMJqLMcWI
 YEFs7N/Gqn3ItIZk7LJl+ASl3gMsp8VaeelfkNhAAlKMirBwijoaJm2FA7K50wDJx1o3
 Ptd8++f1GcFe/7od246rGvN4nKaINaFbg2rXK1IxM1pbq9msusEdongUmjWTpZH2JjRg
 +XzeJTMWK5pU5Jqexy853FcGZjv4lFryW4tlHNe3ca8QKh002nLgIPFAaW4sdmiNxUhu cA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uantqdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:39:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V5d9S5021500
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:39:09 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 30 Jul
 2023 22:39:06 -0700
Message-ID: <7a84284c-d842-255d-8b68-037f79367ee7@quicinc.com>
Date:   Mon, 31 Jul 2023 11:09:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 0/9] PCI: EPC: Add support to wake up host from D3
 states
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <20230728043726.GJ4433@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230728043726.GJ4433@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tn6oj-hh4u42sMjLTjmxs--ob8FVfnD3
X-Proofpoint-ORIG-GUID: tn6oj-hh4u42sMjLTjmxs--ob8FVfnD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=755
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310050
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/28/2023 10:07 AM, Manivannan Sadhasivam wrote:
> On Thu, Jul 13, 2023 at 12:40:09PM +0530, Krishna chaitanya chundru wrote:
>> Here we propose this patch series to add support in PCI endpoint
>> driver to wake up host from D3 states.
>>
>> As endpoint cannot send any data/MSI when the D-state is in
>> D3cold or D3hot. Endpoint needs to bring the device back to D0
>> to send any kind of data.
>>
>> For this endpoint needs to send inband PME the device is in D3 state or
>> toggle wake when the device is D3 cold and vaux is not supplied.
>>
>> As EPF doestn't know the D-state of the PCI, added a notify op whenever
>> device state changes.
>>
>> Based on the D-state the EPF driver decides to wake host either by
>> toggling wake or by sending PME.
>>
>> When the MHI state is in M3 MHI driver will wakeup the host using the
>> wakeup op.
>>
> Please split this series into two. One adding D-state support and another
> (dependant) adding wakeup support. We can try to merge atleast first one for
> 6.6.
>
> - Mani
Sure, can you point me any patch series that is added dependant on 
another series.
>> ---
>> Changes from v3:
>> 	- changed the bool return type to int for waking the host in mhi ep driver
>> 	 as suggested by dan and bjorn.
>> 	- Changed commit logs as suggested by bjorn.
>> Changes from v2:
>>          - Addressed review comments made by mani.
>> Changes from v1:
>>          - Moved from RFC patch to regular patch
>>          - Inclueded EPF patch and added a new op patch to notify D-state change.
>> ---
>>
>> Krishna chaitanya chundru (9):
>>    PCI: endpoint: Add D-state change notifier support
>>    PCI: qcom-ep: Add support for D-state change notification
>>    PCI: epf-mhi: Add support for handling D-state notify from EPC
>>    PCI: qcom-ep: Update the D-state log
>>    PCI: endpoint: Add wakeup host API to EPC core
>>    PCI: dwc: Add wakeup host op to pci_epc_ops
>>    PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
>>    PCI: epf-mhi: Add wakeup host op
>>    bus: mhi: ep: wake up host if the MHI state is in M3
>>
>>   Documentation/PCI/endpoint/pci-endpoint.rst     | 11 +++++
>>   drivers/bus/mhi/ep/main.c                       | 27 ++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++
>>   drivers/pci/controller/dwc/pcie-designware.h    |  3 ++
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c       | 36 ++++++++++++++-
>>   drivers/pci/endpoint/functions/pci-epf-mhi.c    | 27 ++++++++++++
>>   drivers/pci/endpoint/pci-epc-core.c             | 58 +++++++++++++++++++++++++
>>   include/linux/mhi_ep.h                          |  4 ++
>>   include/linux/pci-epc.h                         | 12 +++++
>>   include/linux/pci-epf.h                         |  1 +
>>   10 files changed, 190 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.7.4
>>
