Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE125EACD2
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 18:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIZQnM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIZQlz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 12:41:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDACB57E0E;
        Mon, 26 Sep 2022 08:30:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QCTm1b014930;
        Mon, 26 Sep 2022 15:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kU9b44Kdwow6VsO17G9gwzumrAY2ZBNpSNpGbjF/zH4=;
 b=RI+HrIF2XEwlfwxLOCKPrTTQDQy9mbiKRbYAVZl7KTsQBidVMTQKSR0W5qtWdGTn3YmS
 JctChUnKX8OJS6OkhlJU2eKMjnTnsJxKXYQUolwWg2XK9KSB15Tq5ztAHOAEFEE7445p
 y8raaVlXHAACazORPiIK6qFPQpYY/CLmaPOmxATiYVVPQcoXOkpt0WwI6UumHsklq8zb
 XMQ+hxhs0A+8Vcnp4pXbXUfK25cp7DZhLDMk9WXfpJgWn69P2wFRutR4pL/yYj8VpOVN
 gck8zPw8WOHBAQr9AMc/3FrlC9D79g11Zrm6TpBuW9A26H5/ZMsu0eFcSZTIizja43Pv RQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jua2us08g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 15:30:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28QFUPQ8023317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 15:30:26 GMT
Received: from [10.216.15.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 08:30:16 -0700
Message-ID: <5d2f7167-818a-a655-9885-b71a3e91733e@quicinc.com>
Date:   Mon, 26 Sep 2022 21:00:11 +0530
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
References: <20220923142611.GA1389970@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220923142611.GA1389970@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MFrFhmIF7fAJ5ZdhzBXjWbyopZnBZq11
X-Proofpoint-ORIG-GUID: MFrFhmIF7fAJ5ZdhzBXjWbyopZnBZq11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=489 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260098
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/23/2022 7:56 PM, Bjorn Helgaas wrote:
> On Fri, Sep 23, 2022 at 07:29:31AM +0530, Krishna Chaitanya Chundru wrote:
>> On 9/23/2022 12:12 AM, Bjorn Helgaas wrote:
>>> On Thu, Sep 22, 2022 at 09:09:28PM +0530, Krishna Chaitanya Chundru wrote:
>>>> On 9/21/2022 10:26 PM, Bjorn Helgaas wrote:
>>>>> On Wed, Sep 21, 2022 at 03:23:35PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> On 9/20/2022 11:46 PM, Bjorn Helgaas wrote:
>>>>>>> On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
>>>>>>>> In qcom platform PCIe resources( clocks, phy etc..) can
>>>>>>>> released when the link is in L1ss to reduce the power
>>>>>>>> consumption. So if the link is in L1ss, release the PCIe
>>>>>>>> resources. And when the system resumes, enable the PCIe
>>>>>>>> resources if they released in the suspend path.
>>>>>>> What's the connection with L1.x?  Links enter L1.x based on
>>>>>>> activity and timing.  That doesn't seem like a reliable
>>>>>>> indicator to turn PHYs off and disable clocks.
>>>>>> This is a Qcom PHY-specific feature (retaining the link state in
>>>>>> L1.x with clocks turned off).  It is possible only with the link
>>>>>> being in l1.x. PHY can't retain the link state in L0 with the
>>>>>> clocks turned off and we need to re-train the link if it's in L2
>>>>>> or L3. So we can support this feature only with L1.x.  That is
>>>>>> the reason we are taking l1.x as the trigger to turn off clocks
>>>>>> (in only suspend path).
>>>>> This doesn't address my question.  L1.x is an ASPM feature, which
>>>>> means hardware may enter or leave L1.x autonomously at any time
>>>>> without software intervention.  Therefore, I don't think reading the
>>>>> current state is a reliable way to decide anything.
>>>> After the link enters the L1.x it will come out only if there is
>>>> some activity on the link.  AS system is suspended and NVMe driver
>>>> is also suspended( queues will  freeze in suspend) who else can
>>>> initiate any data.
>>> I don't think we can assume that nothing will happen to cause exit
>>> from L1.x.  For instance, PCIe Messages for INTx signaling, LTR, OBFF,
>>> PTM, etc., may be sent even though we think the device is idle and
>>> there should be no link activity.
>> I don't think after the link enters into L1.x there will some
>> activity on the link as you mentioned, except for PCIe messages like
>> INTx/MSI/MSIX. These messages also will not come because the client
>> drivers like NVMe will keep their device in the lowest power mode.
>>
>> The link will come out of L1.x only when there is config or memory
>> access or some messages to trigger the interrupts from the devices.
>> We are already making sure this access will not be there in S3.  If
>> the link is in L0 or L0s what you said is expected but not in L1.x
> Forgive me for being skeptical, but we just spent a few months
> untangling the fact that some switches send PTM request messages even
> when they're in a non-D0 state.  We expected that devices in D3hot
> would not send such messages because "why would they?"  But it turns
> out the spec allows that, and they actually *do*.
>
> I don't think it's robust interoperable design for a PCI controller
> driver like qcom to assume anything about PCI devices unless it's
> required by the spec.
>
> Bjorn
 From pci spec 4, in sec 5.5
"Ports that support L1 PM Substates must not require a reference clock 
while in L1 PM Substates
other than L1.0".
If there is no reference clk we can say there is no activity on the link.
If anything needs to be sent (such as LTR, or some messages ), the link 
needs to be back in L0 before it
sends the packet to the link partner.

To exit from L1.x clkreq pin should be asserted.

In suspend after turning off clocks and phy we can enable to trigger an 
interrupt whenever the clk req pin asserts.
In that interrupt handler, we can enable the pcie resources back.

What are your thoughts on this?
