Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3845E67A6
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiIVPyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIVPyU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 11:54:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE250F8C04;
        Thu, 22 Sep 2022 08:54:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MDUWSf021785;
        Thu, 22 Sep 2022 15:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=US13UxSFNQuHhq+dXkWL+HohYUtp82gPRRe3BJERysc=;
 b=bW9R+CkuNVB1UiU5dGGV+QIz0uWebcQlh1VDjZWXJBHXrem21bKtzbkrOalUGn+C2Mv7
 Z5eLrziimecoCYpopS/mqyqxqJVKjl337Ck4KH+Jp0DRT+p7smmiPfBceer+J/T5JDd8
 hMKWvM9lXKA081F0OwFYQo7HFnRQGn+ibBHtTsRM/HqSVlyR2Mz5ATPq6oWN3C4g0rgs
 761mz/XCkTalhFAtDjJBIQvnlCY7ANbvHIU16RxwTUgqDHeKMpJ5PJ8IB7wjE4H/nH0I
 4nSXKqaLTGqX95pERQchzVpend5D62mPn2YYPJrIVAPAcJOxOZfs6tVzReQIV0xefFZX xQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrq4r8kn6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 15:53:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28MFdfXI025772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 15:39:41 GMT
Received: from [10.216.47.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 08:39:31 -0700
Message-ID: <807730f9-0220-d297-dffd-929dde30d513@quicinc.com>
Date:   Thu, 22 Sep 2022 21:09:28 +0530
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
References: <20220921165601.GA1215223@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220921165601.GA1215223@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qy6KnT5DFSRzCuruOAI_w_U-p6xqbqlO
X-Proofpoint-ORIG-GUID: qy6KnT5DFSRzCuruOAI_w_U-p6xqbqlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220106
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/21/2022 10:26 PM, Bjorn Helgaas wrote:
> [+cc Rafael, linux-pm since this is real power management magic,
> beginning of thread:
> https://lore.kernel.org/all/1663669347-29308-1-git-send-email-quic_krichai@quicinc.com/
> full patch since I trimmed too much of it:
> https://lore.kernel.org/all/1663669347-29308-2-git-send-email-quic_krichai@quicinc.com/]
>
> On Wed, Sep 21, 2022 at 03:23:35PM +0530, Krishna Chaitanya Chundru wrote:
>> On 9/20/2022 11:46 PM, Bjorn Helgaas wrote:
>>> On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
>>>> Add suspend and resume syscore ops.
>>>>
>>>> Few PCIe endpoints like NVMe and WLANs are always expecting the device
>>>> to be in D0 state and the link to be active (or in l1ss) all the time
>>>> (including in S3 state).
>>> What does this have to do with the patch?  I don't see any NVMe or
>>> WLAN patches here.
>> Existing NVMe driver expecting NVMe device to be in D0 during S3 also. If we
>> turn off the link in
>> suspend, the NVMe resume path is broken as the state machine is getting
>> reset in the NVMe device.
>> Due to this, the host driver state machine and the device state machine are
>> going out of sync, and all NVMe commands
>> after resumes are getting timed out.
>>
>> IIRC, Tegra is also facing this issue with NVMe.
>>
>> This issue has been discussed below threads:
>>
>> https://lore.kernel.org/all/Yl+6V3pWuyRYuVV8@infradead.org/T/
>>
>> https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/
> The problem is that this commit log doesn't explain the problem and
> doesn't give us anything to connect the NVMe and WLAN assumptions with
> this special driver behavior.  There needs to be some explicit
> property of NVMe and WLAN that the PM core or drivers like qcom can
> use to tell whether the clocks can be turned off.
Not only that NVMe is expecting the device state to be always in D0. So 
any PCIe
drivers should not turn off the link in suspend and do link retraining 
in the resume.
As this is considered a power cycle by the NVMe device and eventually 
increases the
wear of the NVMe flash.

We are trying to keep the device in D0 and also reduce the power 
consumption when the system
is in S3 by turning off clocks and phy with this patch series.
>
>>>> In qcom platform PCIe resources( clocks, phy etc..) can released
>>>> when the link is in L1ss to reduce the power consumption. So if the link
>>>> is in L1ss, release the PCIe resources. And when the system resumes,
>>>> enable the PCIe resources if they released in the suspend path.
>>> What's the connection with L1.x?  Links enter L1.x based on activity
>>> and timing.  That doesn't seem like a reliable indicator to turn PHYs
>>> off and disable clocks.
>> This is a Qcom PHY-specific feature (retaining the link state in L1.x with
>> clocks turned off).
>> It is possible only with the link being in l1.x. PHY can't retain the link
>> state in L0 with the
>> clocks turned off and we need to re-train the link if it's in L2 or L3. So
>> we can support this feature only with L1.x.
>> That is the reason we are taking l1.x as the trigger to turn off clocks (in
>> only suspend path).
> This doesn't address my question.  L1.x is an ASPM feature, which
> means hardware may enter or leave L1.x autonomously at any time
> without software intervention.  Therefore, I don't think reading the
> current state is a reliable way to decide anything.
After the link enters the L1.x it will come out only if there is some 
activity on the link.
AS system is suspended and NVMe driver is also suspended( queues will  
freeze in suspend)
who else can initiate any data. As long the link stays in L1ss we can 
turn off clocks and phy.
When the system resumes we turn off clocks and phy before resuming the 
NVMe, this makes sure
the clocks and phy are up before there is any activity to bring up the 
link back to L0 state from L1.x.
>
>> ...
>>>> Its observed that access to Ep PCIe space to mask MSI/MSIX is happening
>>>> at the very late stage of suspend path (access by affinity changes while
>>>> making CPUs offline during suspend, this will happen after devices are
>>>> suspended (after all phases of suspend ops)). If we turn off clocks in
>>>> any PM callback, afterwards running into crashes due to un-clocked access
>>>> due to above mentioned MSI/MSIx access.
>>>> So, we are making use of syscore framework to turn off the PCIe clocks
>>>> which will be called after making CPUs offline.
