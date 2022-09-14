Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D955B7E9F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 03:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiINBrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 21:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiINBrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 21:47:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092BB6E8A4;
        Tue, 13 Sep 2022 18:47:13 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E1Gww1031627;
        Wed, 14 Sep 2022 01:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C0rJFQpZgkOMNZ3d8KNq1C6GS7Pf9jhtROLQNxHI46Q=;
 b=VcULiepAsuH36YVkmOglk5bFIuJ5MyvYWFj553zdK5lppkcig46qfkLeuEOArT+tw/vX
 tzJVoLX05AZDOIz6FDuL2/iYjFsf2wixRVVxtvMQJPDQCOCOlMLVBnfXqZba+CBg4Puu
 oy8OL+UF15GsJkRHB35YKm2jfhSt9dL5VV3akib/vj4dwf/pxRUDS1YOcQjXLiYsH4Pt
 Jmh1/KCmoggPUkMleLg8wz2SMg1d7V2fFwC2GdG1U0AmZVoa0aQIbkyUaJ5BsaM4/IkW
 b8ZEjHhnqdTg40d8o37oFEG4bTYx3/SY359+RUOQaxCmP36MU3AgFFktg8t3T+vWtEER CQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxyu8vq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 01:47:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E1l9Il020056
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 01:47:09 GMT
Received: from [10.216.1.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 18:47:04 -0700
Message-ID: <77762109-ffa9-b9c5-96c6-6b143261f84c@quicinc.com>
Date:   Wed, 14 Sep 2022 07:17:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 0/5] PCI: qcom: Add system suspend & resume support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mka@chromium.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
 <20220912173742.GC25849@workstation>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220912173742.GC25849@workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O0ewullqAVWuwU5u6PFICK7vsmCyM3wA
X-Proofpoint-ORIG-GUID: O0ewullqAVWuwU5u6PFICK7vsmCyM3wA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=960 bulkscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140006
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/12/2022 11:07 PM, Manivannan Sadhasivam wrote:
> On Fri, Sep 09, 2022 at 02:14:39PM +0530, Krishna chaitanya chundru wrote:
>> Add suspend and resume syscore ops.
>>
>> When system suspends, and if the link is in L1ss, disable the clocks
>> and power down the phy so that system enters into low power state by
>> parking link in L1ss to save the maximum power. And when the system
>> resumes, enable the clocks back and power on phy if they are disabled
>> in the suspend path.
>>
> You need to mention that you are only turning off the PCIe controller
> clocks and PHY is still powered by a separate domain (MX) so the link
> statys intact.
sure I will update the commit in next series.
>> we are doing this only when link is in l1ss but not in L2/L3 as
>> nowhere we are forcing link to L2/L3 by sending PME turn off.
>>
>> is_suspended flag indicates if the clocks are disabled in the suspend
>> path or not.
>>
>> There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
>> (getting hit by affinity changes while making CPUs offline during suspend,
>> this will happen after devices are suspended (all phases of suspend ops)).
>> When registered with pm ops there is a crash due to un-clocked access,
>> as in the pm suspend op clocks are disabled. So, registering with syscore
>> ops which will called after making CPUs offline.
>>
>> Make GDSC always on to ensure controller and its dependent clocks
>> won't go down during system suspend.
>>
> Where is the changelog? You seem to have added PHY and CLK patches to
> this series. You need to comment on that.
>
> Thanks,
> Mani
I will update that in next patch.
>> Krishna chaitanya chundru (5):
>>    PCI: qcom: Add system suspend and resume support
>>    PCI: qcom: Add retry logic for link to be stable in L1ss
>>    phy: core: Add support for phy power down & power up
>>    phy: qcom: Add power down/up callbacks to pcie phy
>>    clk: qcom: Alwaya on pcie gdsc
>>
>>   drivers/clk/qcom/gcc-sc7280.c            |   2 +-
>>   drivers/pci/controller/dwc/pcie-qcom.c   | 156 ++++++++++++++++++++++++++++++-
>>   drivers/phy/phy-core.c                   |  30 ++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  50 ++++++++++
>>   include/linux/phy/phy.h                  |  20 ++++
>>   5 files changed, 256 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.7.4
>>
