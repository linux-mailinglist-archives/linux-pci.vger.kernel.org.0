Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B88B5FC70C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 16:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJLOLA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJLOK4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 10:10:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D57AC382;
        Wed, 12 Oct 2022 07:10:51 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C9jlge004563;
        Wed, 12 Oct 2022 14:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=X56T0Y4BdSLVT4DObSFyKor0Immxx7awcwH20gDFW3A=;
 b=VSIUaIYH9BfAwE+KxU6/vwSmrLRfJRxC18QVIV4+nWqRjJGnuJNZgKAdPXYhbtFsOary
 KWcrQbPFWw7HzoqxkZheiv08AxpM1g1qb2Ua68yqOVYrK9K3jnc7pCGkoitvyt7fZayC
 fcOFvIkci55mRsLDbMEK3U0ywlmI7sbV71wz25SM57nzJkHAyy9x1aBJ3Z/d6Yz3k5wm
 laH67oEVj3JjCDXmSvdJ2mva00oJDMhKGMrrETZTX2u9ckh1rLNDjQsRQ9HRwhttdTDI
 CEQTXsAU//sULjVkYtZls3H1h5TbxpGdLUKQq99lrcJkItTM5TsDMr7pcmNabSsRA0um /A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5j7b244p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 14:10:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CEARlm024769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 14:10:27 GMT
Received: from [10.216.32.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 07:10:18 -0700
Message-ID: <04ace1ae-26d0-4157-b7eb-8dff29895180@quicinc.com>
Date:   Wed, 12 Oct 2022 19:36:52 +0530
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
References: <20221005211323.GA2390992@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20221005211323.GA2390992@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6dfLb38IxSjGoasAJ9pMdvLlzZF_6S-6
X-Proofpoint-ORIG-GUID: 6dfLb38IxSjGoasAJ9pMdvLlzZF_6S-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 mlxlogscore=951 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120093
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/6/2022 2:43 AM, Bjorn Helgaas wrote:
> On Mon, Oct 03, 2022 at 05:40:21PM +0530, Krishna Chaitanya Chundru wrote:
>> On 9/30/2022 12:23 AM, Bjorn Helgaas wrote:
>>> On Mon, Sep 26, 2022 at 09:00:11PM +0530, Krishna Chaitanya Chundru wrote:
>>>> On 9/23/2022 7:56 PM, Bjorn Helgaas wrote:
>>>>> On Fri, Sep 23, 2022 at 07:29:31AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> On 9/23/2022 12:12 AM, Bjorn Helgaas wrote:
>>>>>>> On Thu, Sep 22, 2022 at 09:09:28PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>> On 9/21/2022 10:26 PM, Bjorn Helgaas wrote:
>>>>>>>>> On Wed, Sep 21, 2022 at 03:23:35PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>>>> On 9/20/2022 11:46 PM, Bjorn Helgaas wrote:
>>>>>>>>>>> On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
>>>>>>>>>>>> In qcom platform PCIe resources( clocks, phy
>>>>>>>>>>>> etc..) can released when the link is in L1ss to
>>>>>>>>>>>> reduce the power consumption. So if the link is
>>>>>>>>>>>> in L1ss, release the PCIe resources. And when
>>>>>>>>>>>> the system resumes, enable the PCIe resources if
>>>>>>>>>>>> they released in the suspend path.
>>>>>>>>>>> What's the connection with L1.x?  Links enter L1.x
>>>>>>>>>>> based on activity and timing.  That doesn't seem
>>>>>>>>>>> like a reliable indicator to turn PHYs off and
>>>>>>>>>>> disable clocks.
>>>>>>>>>> This is a Qcom PHY-specific feature (retaining the
>>>>>>>>>> link state in L1.x with clocks turned off).  It is
>>>>>>>>>> possible only with the link being in l1.x. PHY can't
>>>>>>>>>> retain the link state in L0 with the clocks turned
>>>>>>>>>> off and we need to re-train the link if it's in L2
>>>>>>>>>> or L3. So we can support this feature only with
>>>>>>>>>> L1.x.  That is the reason we are taking l1.x as the
>>>>>>>>>> trigger to turn off clocks (in only suspend path).
>>>>>>>>> This doesn't address my question.  L1.x is an ASPM
>>>>>>>>> feature, which means hardware may enter or leave L1.x
>>>>>>>>> autonomously at any time without software
>>>>>>>>> intervention.  Therefore, I don't think reading the
>>>>>>>>> current state is a reliable way to decide anything.
>>>>>>>> After the link enters the L1.x it will come out only if
>>>>>>>> there is some activity on the link.  As system is
>>>>>>>> suspended and NVMe driver is also suspended (queues
>>>>>>>> will freeze in suspend) who else can initiate any data.
>>>>>>> I don't think we can assume that nothing will happen to
>>>>>>> cause exit from L1.x.  For instance, PCIe Messages for
>>>>>>> INTx signaling, LTR, OBFF, PTM, etc., may be sent even
>>>>>>> though we think the device is idle and there should be no
>>>>>>> link activity.
>>>>>> I don't think after the link enters into L1.x there will
>>>>>> some activity on the link as you mentioned, except for PCIe
>>>>>> messages like INTx/MSI/MSIX. These messages also will not
>>>>>> come because the client drivers like NVMe will keep their
>>>>>> device in the lowest power mode.
>>>>>>
>>>>>> The link will come out of L1.x only when there is config or
>>>>>> memory access or some messages to trigger the interrupts
>>>>>> from the devices.  We are already making sure this access
>>>>>> will not be there in S3.  If the link is in L0 or L0s what
>>>>>> you said is expected but not in L1.x
>>>>> Forgive me for being skeptical, but we just spent a few months
>>>>> untangling the fact that some switches send PTM request
>>>>> messages even when they're in a non-D0 state.  We expected
>>>>> that devices in D3hot would not send such messages because
>>>>> "why would they?"  But it turns out the spec allows that, and
>>>>> they actually *do*.
>>>>>
>>>>> I don't think it's robust interoperable design for a PCI
>>>>> controller driver like qcom to assume anything about PCI
>>>>> devices unless it's required by the spec.
>>>>   From pci spec 4, in sec 5.5 "Ports that support L1 PM Substates
>>>>   must not require a reference clock while in L1 PM Substates
>>>>   other than L1.0".  If there is no reference clk we can say
>>>>   there is no activity on the link.  If anything needs to be sent
>>>>   (such as LTR, or some messages ), the link needs to be back in
>>>>   L0 before it sends the packet to the link partner.
>>>>
>>>> To exit from L1.x clkreq pin should be asserted.
>>>>
>>>> In suspend after turning off clocks and phy we can enable to
>>>> trigger an interrupt whenever the clk req pin asserts.  In that
>>>> interrupt handler, we can enable the pcie resources back.
>>>  From the point of view of the endpoint driver, ASPM should be
>>> invisible -- no software intervention required.  I think you're
>>> suggesting that the PCIe controller driver could help exit L1.x by
>>> handling a clk req interrupt and enabling clock and PHY then.
>>>
>>> But doesn't L1.x exit also have to happen within the time the
>>> endpoint can tolerate?  E.g., I think L1.2 exit has to happen
>>> within the LTR time advertised by the endpoint (PCIe r6.0, sec
>>> 5.5.5).  How can we guarantee that if software is involved?
>> It is true that it is difficult to guarantee those delays. On our
>> internal boards, we are able to achieve this but that is not with
>> linux kernel.
>>
>> With NVMe attach we have connected the protocol analyzer and tried
>> to see if there are any transactions over the link. We found there
>> are no transactions on the link once the link enters L1.x till we
>> resume the system. As the NVMe is a passive system it is not
>> initiating any transactions.
>>
>> This whole requirement came from the NVMe driver, it requires
>> keeping the link active state when the system is suspended.
>>
>> There are only two things we can in do in PCIe suspend as we have to
>> turn off PCIe clocks to allow the system to the lowest possible
>> power state.
>>
>> 1) Keep the device in D3 cold and turn off all the clocks and phy
>> etc. (It is not an ideal one as this decreases the NVMe lifetime
>> because link-down and link-up is treated as a power cycle by a few
>> NVMe devices).
>>
>> 2) This is the one we are proposing where we turn off the clocks,
>> phy once the link enters L1ss.
> It sounds like both options turn off the clocks and PHY.  But
> apparently they do not look the same to the NVMe endpoint?  I guess
> NVMe is in D3cold for 1), but it's in D0 for 2), right?
>
>> Can you please suggest us any other possible solutions to meet NVMe
>> requirement (That is to keep the link active during suspend) and the
>> Qcom platform requirement (that is to turn off all the clocks to
>> allow a lower possible power state)? Qcom PCIe controller is
>> compatible with v3.1 specification only.
> The PCIe spec clearly envisions Refclk being turned off
> (sec 5.5.3.3.1) and PHYs being powered off (sec 5.5.3.2) while in
> L1.2.
>
> I've been assuming L1.2 exit (which includes Refclk being turned on
> and PHYs being powered up) is completely handled by hardware, but it
> sounds like the Qcom controller needs software assistance which fields
> an interrupt when CLKREQ# is asserted and turns on Refclk and the
> PHYs?
>
> 5.5.3 does say "All Link and PHY state must be maintained during L1.2,
> or must be restored upon exit using implementation specific means",
> and maybe Qcom counts as using implementation specific means.
>
> I *am* concerned about whether software can do the L1.2 exit fast
> enough, but the biggest reason I'm struggling with this is because
> using the syscore framework to work around IRQ affinity changes that
> happen late in suspend just seems kind of kludgy and it doesn't seem
> like it fits cleanly in the power management model.
>
> Bjorn

Bjorn,

Can you please suggest any another way to work around IRQ affinity changes.

Thanks & Regards,

Krishna Chaitanya.

