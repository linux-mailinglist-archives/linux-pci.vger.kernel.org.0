Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29605F3008
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 14:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJCMLC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 08:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJCMLC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 08:11:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F5B22B0F;
        Mon,  3 Oct 2022 05:10:58 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293Bj0j4003422;
        Mon, 3 Oct 2022 12:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TmtMV5g53OuRHxbjrDV5hTm21YfygvGwXjD9bGOD3uQ=;
 b=nEYOt2KYsyW2KbUiLhb1W1cVf2VuQyeR8W49TUPHHQbsUwzCp3XoSbFQ/t21cCXXSvNr
 uUdSQBqXq90Fd/lwDXM7OzFe1/HowLMYGHT/gCKN2aSGTx+96wPdRaWyZlgD4bC/IG0G
 Hxiosh2zjICBxhU6qk2NTUMVWOTKeUWIRw/zstZZgt8bJ80t86kd+zInCMWybwNA+/j+
 y6W+SkBgbJRK6oib/lXTWk03BjorLegzOQ26YasqGcPcHkqeXag1ZP5i1nj+CbDAWvRR
 Bnk7f8tAJB7i4gHe6MPCgLMomI0FYhzFGQEriI8bGZYwUYpTiYm+j0DeWkDf8mqRKGuz wA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxeugku90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 12:10:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 293CAYBJ025065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Oct 2022 12:10:34 GMT
Received: from [10.216.56.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 05:10:24 -0700
Message-ID: <f1b079c9-d0b8-6d4d-bf3d-dee45731ee88@quicinc.com>
Date:   Mon, 3 Oct 2022 17:40:21 +0530
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
References: <20220929185305.GA1912842@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220929185305.GA1912842@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cM67SiMoHe_n5yZttNth0pK7TbGcJQ3q
X-Proofpoint-ORIG-GUID: cM67SiMoHe_n5yZttNth0pK7TbGcJQ3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=733 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210030075
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/30/2022 12:23 AM, Bjorn Helgaas wrote:
> On Mon, Sep 26, 2022 at 09:00:11PM +0530, Krishna Chaitanya Chundru wrote:
>> On 9/23/2022 7:56 PM, Bjorn Helgaas wrote:
>>> On Fri, Sep 23, 2022 at 07:29:31AM +0530, Krishna Chaitanya Chundru wrote:
>>>> On 9/23/2022 12:12 AM, Bjorn Helgaas wrote:
>>>>> On Thu, Sep 22, 2022 at 09:09:28PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> On 9/21/2022 10:26 PM, Bjorn Helgaas wrote:
>>>>>>> On Wed, Sep 21, 2022 at 03:23:35PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>> On 9/20/2022 11:46 PM, Bjorn Helgaas wrote:
>>>>>>>>> On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
>>>>>>>>>> In qcom platform PCIe resources( clocks, phy etc..) can
>>>>>>>>>> released when the link is in L1ss to reduce the power
>>>>>>>>>> consumption. So if the link is in L1ss, release the PCIe
>>>>>>>>>> resources. And when the system resumes, enable the PCIe
>>>>>>>>>> resources if they released in the suspend path.
>>>>>>>>> What's the connection with L1.x?  Links enter L1.x based on
>>>>>>>>> activity and timing.  That doesn't seem like a reliable
>>>>>>>>> indicator to turn PHYs off and disable clocks.
>>>>>>>> This is a Qcom PHY-specific feature (retaining the link state in
>>>>>>>> L1.x with clocks turned off).  It is possible only with the link
>>>>>>>> being in l1.x. PHY can't retain the link state in L0 with the
>>>>>>>> clocks turned off and we need to re-train the link if it's in L2
>>>>>>>> or L3. So we can support this feature only with L1.x.  That is
>>>>>>>> the reason we are taking l1.x as the trigger to turn off clocks
>>>>>>>> (in only suspend path).
>>>>>>> This doesn't address my question.  L1.x is an ASPM feature, which
>>>>>>> means hardware may enter or leave L1.x autonomously at any time
>>>>>>> without software intervention.  Therefore, I don't think reading the
>>>>>>> current state is a reliable way to decide anything.
>>>>>> After the link enters the L1.x it will come out only if there is
>>>>>> some activity on the link.  AS system is suspended and NVMe driver
>>>>>> is also suspended( queues will  freeze in suspend) who else can
>>>>>> initiate any data.
>>>>> I don't think we can assume that nothing will happen to cause exit
>>>>> from L1.x.  For instance, PCIe Messages for INTx signaling, LTR, OBFF,
>>>>> PTM, etc., may be sent even though we think the device is idle and
>>>>> there should be no link activity.
>>>> I don't think after the link enters into L1.x there will some
>>>> activity on the link as you mentioned, except for PCIe messages like
>>>> INTx/MSI/MSIX. These messages also will not come because the client
>>>> drivers like NVMe will keep their device in the lowest power mode.
>>>>
>>>> The link will come out of L1.x only when there is config or memory
>>>> access or some messages to trigger the interrupts from the devices.
>>>> We are already making sure this access will not be there in S3.  If
>>>> the link is in L0 or L0s what you said is expected but not in L1.x
>>> Forgive me for being skeptical, but we just spent a few months
>>> untangling the fact that some switches send PTM request messages even
>>> when they're in a non-D0 state.  We expected that devices in D3hot
>>> would not send such messages because "why would they?"  But it turns
>>> out the spec allows that, and they actually *do*.
>>>
>>> I don't think it's robust interoperable design for a PCI controller
>>> driver like qcom to assume anything about PCI devices unless it's
>>> required by the spec.
>>  From pci spec 4, in sec 5.5
>> "Ports that support L1 PM Substates must not require a reference clock while
>> in L1 PM Substates
>> other than L1.0".
>> If there is no reference clk we can say there is no activity on the link.
>> If anything needs to be sent (such as LTR, or some messages ), the link
>> needs to be back in L0 before it
>> sends the packet to the link partner.
>>
>> To exit from L1.x clkreq pin should be asserted.
>>
>> In suspend after turning off clocks and phy we can enable to trigger an
>> interrupt whenever the clk req pin asserts.
>> In that interrupt handler, we can enable the pcie resources back.
>  From the point of view of the endpoint driver, ASPM should be
> invisible -- no software intervention required.  I think you're
> suggesting that the PCIe controller driver could help exit L1.x by
> handling a clk req interrupt and enabling clock and PHY then.
>
> But doesn't L1.x exit also have to happen within the time the endpoint
> can tolerate?  E.g., I think L1.2 exit has to happen within the LTR
> time advertised by the endpoint (PCIe r6.0, sec 5.5.5).  How can we
> guarantee that if software is involved?
It is true that it is difficult to guarantee those delays. On our internal
boards, we are able to achieve this but that is not with linux kernel.

With NVMe attach we have connected the protocol analyzer and tried to see if
there are any transactions over the link. We found there are no transactions
on the link once the link enters L1.x till we resume the system. As the NVMe
is a passive system it is not initiating any transactions.

This whole requirement came from the NVMe driver, it requires keeping 
the link
active state when the system is suspended.

There are only two things we can in do in PCIe suspend as we have to 
turn off
PCIe clocks to allow the system to the lowest possible power state.
1) Keep the device in D3 cold and turn off all the clocks and phy etc.( 
It is not
an ideal one as this decreases the NVMe lifetime because link-down and 
link-up
is treated as a power cycle by a few NVMe devices).
2) This is the one we are proposing where we turn off the clocks, phy 
once the
link enters L1ss.

Can you please suggest us any other possible solutions to meet NVMe 
requirement
(That is to keep the link active during suspend) and the Qcom platform
requirement (that is to turn off all the clocks to allow a lower possible
power state)? Qcom PCIe controller is compatible with v3.1 specification 
only.


Thanks & Regards,
Krishna Chaitanya.

