Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A7E5BFBC5
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiIUJy6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiIUJyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 05:54:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC2D5E;
        Wed, 21 Sep 2022 02:54:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28L8dIP6003301;
        Wed, 21 Sep 2022 09:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uJlL+knB2fMw5vo335fNPEXeuy4SlqC7wRoCMhp2kHw=;
 b=kdvvH7r++bwXUrf+HYA3l8YNKXjaX4ub/1PsBSNR8OIvb//r9Swfn2YEUBPoJbEfXYfb
 MRZb1IecLvDvfdbKWa6CgUyJyf+RPb64eQeVgLE5ohHgfucjXWKdqcfVNml65EHJXlie
 FFj9BUNNSNQtEgIiGeMU4vpTxN1yzmdgRihLOLE1GmvNkj0HPLw8amSAdpA5A2gwrjn4
 1HBKgIrdmEsaQCLRIqdDaH5BreDdT4dBQmBxWRXIuRsedsrAuyUV2/p+xj9NmeeFXrqY
 lh86fsUkiK+3AJfw37Yllg5Xb3kUG04TxqpJFye3CEc0L+j0GyPraCNV/t6aWnwQOYyP 3w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jqtd6j2mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 09:53:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28L9rksu004685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 09:53:46 GMT
Received: from [10.216.24.214] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 02:53:38 -0700
Message-ID: <ed1a1260-0ef4-203a-f073-f5232bfc8466@quicinc.com>
Date:   Wed, 21 Sep 2022 15:23:35 +0530
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
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220920181637.GA1121154@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220920181637.GA1121154@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yoLzCr68NDAXE4Ox9--c6_X5lW-4ZsSS
X-Proofpoint-GUID: yoLzCr68NDAXE4Ox9--c6_X5lW-4ZsSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_05,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210066
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/20/2022 11:46 PM, Bjorn Helgaas wrote:
> On Tue, Sep 20, 2022 at 03:52:23PM +0530, Krishna chaitanya chundru wrote:
>> Add suspend and resume syscore ops.
>>
>> Few PCIe endpoints like NVMe and WLANs are always expecting the device
>> to be in D0 state and the link to be active (or in l1ss) all the time
>> (including in S3 state).
> What does this have to do with the patch?  I don't see any NVMe or
> WLAN patches here.
Existing NVMe driver expecting NVMe device to be in D0 during S3 also. 
If we turn off the link in
suspend, the NVMe resume path is broken as the state machine is getting 
reset in the NVMe device.
Due to this, the host driver state machine and the device state machine 
are going out of sync, and all NVMe commands
after resumes are getting timed out.

IIRC, Tegra is also facing this issue with NVMe.

This issue has been discussed below threads:

https://lore.kernel.org/all/Yl+6V3pWuyRYuVV8@infradead.org/T/

https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/

>> In qcom platform PCIe resources( clocks, phy etc..) can released
>> when the link is in L1ss to reduce the power consumption. So if the link
>> is in L1ss, release the PCIe resources. And when the system resumes,
>> enable the PCIe resources if they released in the suspend path.
> What's the connection with L1.x?  Links enter L1.x based on activity
> and timing.  That doesn't seem like a reliable indicator to turn PHYs
> off and disable clocks.
This is a Qcom PHY-specific feature (retaining the link state in L1.x 
with clocks turned off).
It is possible only with the link being in l1.x. PHY can't retain the 
link state in L0 with the
clocks turned off and we need to re-train the link if it's in L2 or L3. 
So we can support this feature only with L1.x.
That is the reason we are taking l1.x as the trigger to turn off clocks 
(in only suspend path).
>> is_suspended flag indicates if the PCIe resources are released or not
>> in the suspend path.
> Why is "is_suspended" important for the commit log?  It looks like
> just a standard implementation detail.
Someone in one of the previous patch asked to include this in the commit 
text.
>> Its observed that access to Ep PCIe space to mask MSI/MSIX is happening
>> at the very late stage of suspend path (access by affinity changes while
>> making CPUs offline during suspend, this will happen after devices are
>> suspended (after all phases of suspend ops)). If we turn off clocks in
>> any PM callback, afterwards running into crashes due to un-clocked access
>> due to above mentioned MSI/MSIx access.
>> So, we are making use of syscore framework to turn off the PCIe clocks
>> which will be called after making CPUs offline.
> Add blank lines between paragraphs.  Or rewrap into a single paragraph.
>
> s/Its observed/It's observed/
> s/MSIX/MSI-X/ throughout
> s/MSIx/MSI-X/ throughout
>
> Bjorn
