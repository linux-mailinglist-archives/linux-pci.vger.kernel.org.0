Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267A5A120B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiHYN1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 09:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242640AbiHYN1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 09:27:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44290AD98E;
        Thu, 25 Aug 2022 06:27:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PBLT7H020653;
        Thu, 25 Aug 2022 13:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KvYeiFfwD3KZEQv3gwW5SF2mESyYzWmyxXd2x9ii1/Y=;
 b=a0lMObzE06xvmYISoTMrb8PwVlzzT0HxrLY3VCI8BdYQLxN0e4Vtdy16nhS8Fxcu1fcm
 wj17jVpfiRxBcW8wd/C5mEY4yIVygPG0CuceOCEayMvxLwVh2LV7KscJZgF/SF5LxBZF
 xrtdfXS46qFZ8eyaGM3XlLXkDtIP8TwYpI7IMm3E8K2ICaI0HHj/k77kybRPPAjDgowW
 ewgJyGhTW8orls/mHdp91z7Ac3Htg0Q3O1m1RAU4upAb6uizsDyK32/t+olkE5d/Wzh7
 X36YHL6IPjr2WKX3bfET+VCiZSKBuT99WPbBXAufo1wi4tDqXAb3xIRMqX7BJssDAQ/X 6Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j5xcuhy6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 13:27:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PDEOGw019448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 13:14:24 GMT
Received: from [10.216.34.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 06:14:18 -0700
Message-ID: <dc976f67-20ad-4b8a-f16b-1a080db15d27@quicinc.com>
Date:   Thu, 25 Aug 2022 18:44:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 0/3] PCI: Restrict pci transactions after pci suspend
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>
References: <20220824202949.GA2805069@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220824202949.GA2805069@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Lz3kULzS5zM_UZBPUf2vQjECdk8RqvwB
X-Proofpoint-ORIG-GUID: Lz3kULzS5zM_UZBPUf2vQjECdk8RqvwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/25/2022 1:59 AM, Bjorn Helgaas wrote:
> On Wed, Aug 03, 2022 at 04:58:51PM +0530, Krishna chaitanya chundru wrote:
>> If the endpoint device state is D0 and irq's are not freed, then
>> kernel try to mask interrupts in system suspend path by writing in to
>> the vector table (for MSIX interrupts) and config space (for MSI's).
> If clocks are being turned off while the PCI core is still accessing
> the device, I think that means qcom suspend is not implemented
> correctly.

we are registering the suspend and resume ops as NO_IRQ pm ops and in 
those suspend ops we are disbaling clks there.

NO_IRQ ops is the last the pm ops that are getting called. But we are 
getting pcie access nearly at end of the suspend and near cpu disable.

The pcie access is nothing but the interrupts masks to endpoint to 
disable the interrupts.

>> These transactions are initiated in the pm suspend after pcie clocks got
>> disabled as part of platform driver pm  suspend call. Due to it, these
>> transactions are resulting in un-clocked access and eventually to crashes.
>>
>> So added a logic in qcom driver to restrict these unclocked access.
>> And updated the logic to check the link state before masking
>> or unmasking the interrupts.
>>
>> And some devices are taking time to settle the link in L1ss, so added a
>> retry logic in the suspend ops.
>>
>> Krishna chaitanya chundru (3):
>>    PCI: qcom: Add system PM support
>>    PCI: qcom: Restrict pci transactions after pci suspend
>>    PCI: qcom: Add retry logic for link to be stable in L1ss
>>
>>   drivers/pci/controller/dwc/pcie-designware-host.c |  14 ++-
>>   drivers/pci/controller/dwc/pcie-qcom.c            | 117 +++++++++++++++++++++-
>>   2 files changed, 127 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.7.4
>>
