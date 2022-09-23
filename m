Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA95E71AF
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 04:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiIWCAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiIWCAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 22:00:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D9DDDB6;
        Thu, 22 Sep 2022 19:00:10 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N1cIVJ029694;
        Fri, 23 Sep 2022 01:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fIilf/Rdf+6cocDi7rtmOOlCg2Um91x3yLyfyYicYSY=;
 b=IxJXlYElg+LOlhzG4iYqzlY6srE1u3FXL7Sf/z+uQ3E9cI05gOYriaKgiPy7tiq6ghnE
 duskBrqQcPtSqkYwuQWbAutEA2ql7WZ36SSLxT7tOteuf6x3jBN0ymhYZSVoVd4K4qWY
 Q8oRLxDTrmxp7M0B3dNYzXnJsMyuP0qo81GywR9/CzqsHWETEk46UTYKEIZXMlP++5OB
 O/eDoj3/VC4G14kMsLoRHDKfEN5zYSBlq7AFmXoOhtL/nvuZHqdQAfwBdsGsk/whkSzc
 AXFcl4rVK72VNW/WV4th2q1CwXfMMiefHSmcqgiLjml9/KfbubfhBVxjA+oyztUqGe5z FQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrmnf2gjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:59:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28N1xlfA019261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:59:47 GMT
Received: from [10.216.47.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 18:59:36 -0700
Message-ID: <95e4e9d9-3f39-6cf4-0739-967c7e568697@quicinc.com>
Date:   Fri, 23 Sep 2022 07:29:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 1/5] PCI: qcom: Add system suspend and resume support
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        <svarbanov@mm-sol.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-phy@lists.infradead.org>,
        <vkoul@kernel.org>, <kishon@ti.com>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>
References: <20220922184240.GA1326211@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220922184240.GA1326211@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WwJCSZEJnh-0vScMQvg7cP251S8Gru8D
X-Proofpoint-ORIG-GUID: WwJCSZEJnh-0vScMQvg7cP251S8Gru8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_16,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230011
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/23/2022 12:12 AM, Bjorn Helgaas wrote:
> On Thu, Sep 22, 2022 at 09:09:28PM +0530, Krishna Chaitanya Chundru wrote:
>> On 9/21/2022 10:26 PM, Bjorn Helgaas wrote:
>>> [+cc Rafael, linux-pm since this is real power management magic,
>>> beginning of thread:
>>> https://lore.kernel.org/all/1663669347-29308-1-git-send-email-quic_krichai@quicinc.com/
>>> full patch since I trimmed too much of it:
>>> https://lore.kernel.org/all/1663669347-29308-2-git-send-email-quic_krichai@quicinc.com/]
>>>
>>> On Wed, Sep 21, 2022 at 03:23:35PM +0530, Krishna Chaitanya Chundru wrote:
>>>> On 9/20/2022 11:46 PM, Bjorn Helgaas wrote:
>>>>> On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
>>>>>> Add suspend and resume syscore ops.
>>>>>>
>>>>>> Few PCIe endpoints like NVMe and WLANs are always expecting the device
>>>>>> to be in D0 state and the link to be active (or in l1ss) all the time
>>>>>> (including in S3 state).
>>>>> What does this have to do with the patch?  I don't see any NVMe or
>>>>> WLAN patches here.
>>>> Existing NVMe driver expecting NVMe device to be in D0 during S3 also. If we
>>>> turn off the link in
>>>> suspend, the NVMe resume path is broken as the state machine is getting
>>>> reset in the NVMe device.
>>>> Due to this, the host driver state machine and the device state machine are
>>>> going out of sync, and all NVMe commands
>>>> after resumes are getting timed out.
>>>>
>>>> IIRC, Tegra is also facing this issue with NVMe.
>>>>
>>>> This issue has been discussed below threads:
>>>>
>>>> https://lore.kernel.org/all/Yl+6V3pWuyRYuVV8@infradead.org/T/
>>>>
>>>> https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/
>>> The problem is that this commit log doesn't explain the problem and
>>> doesn't give us anything to connect the NVMe and WLAN assumptions with
>>> this special driver behavior.  There needs to be some explicit
>>> property of NVMe and WLAN that the PM core or drivers like qcom can
>>> use to tell whether the clocks can be turned off.
>> Not only that NVMe is expecting the device state to be always in D0.
>> So any PCIe drivers should not turn off the link in suspend and do
>> link retraining in the resume.  As this is considered a power cycle
>> by the NVMe device and eventually increases the wear of the NVMe
>> flash.
> I can't quite parse this.  Are you saying that all PCI devices should
> stay in D0 when the system is in S3?
Not all PCI devices  some PCI devices like NVMe. The NVMe driver is 
expecting the device to stay in D0 only.
>
>> We are trying to keep the device in D0 and also reduce the power
>> consumption when the system is in S3 by turning off clocks and phy
>> with this patch series.
> The decision to keep a device in D0 is not up to qcom or any other PCI
> controller driver.
Yes, it is the NVMe driver who is deciding to keep the device in D0. Our 
QCOM
PCI Controller driver is trying to keep the device in the same state as 
the client driver is
expecting and also trying to reduce power consumption.
>
>>>>>> In qcom platform PCIe resources( clocks, phy etc..) can
>>>>>> released when the link is in L1ss to reduce the power
>>>>>> consumption. So if the link is in L1ss, release the PCIe
>>>>>> resources. And when the system resumes, enable the PCIe
>>>>>> resources if they released in the suspend path.
>>>>> What's the connection with L1.x?  Links enter L1.x based on
>>>>> activity and timing.  That doesn't seem like a reliable
>>>>> indicator to turn PHYs off and disable clocks.
>>>> This is a Qcom PHY-specific feature (retaining the link state in
>>>> L1.x with clocks turned off).  It is possible only with the link
>>>> being in l1.x. PHY can't retain the link state in L0 with the
>>>> clocks turned off and we need to re-train the link if it's in L2
>>>> or L3. So we can support this feature only with L1.x.  That is
>>>> the reason we are taking l1.x as the trigger to turn off clocks
>>>> (in only suspend path).
>>> This doesn't address my question.  L1.x is an ASPM feature, which
>>> means hardware may enter or leave L1.x autonomously at any time
>>> without software intervention.  Therefore, I don't think reading the
>>> current state is a reliable way to decide anything.
>> After the link enters the L1.x it will come out only if there is
>> some activity on the link.  AS system is suspended and NVMe driver
>> is also suspended( queues will  freeze in suspend) who else can
>> initiate any data.
> I don't think we can assume that nothing will happen to cause exit
> from L1.x.  For instance, PCIe Messages for INTx signaling, LTR, OBFF,
> PTM, etc., may be sent even though we think the device is idle and
> there should be no link activity.
>
> Bjorn
I don't think after the link enters into L1.x there will some activity 
on the link as you mentioned,
except for PCIe messages like INTx/MSI/MSIX. These messages also will 
not come because the
client drivers like NVMe will keep their device in the lowest power mode.

The link will come out of L1.x only when there is config or memory 
access or some messages
to trigger the interrupts from the devices. We are already making sure 
this access will not be there in S3.
If the link is in L0 or L0s what you said is expected but not in L1.x
