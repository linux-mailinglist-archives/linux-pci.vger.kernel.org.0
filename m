Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F350F79B4F5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350467AbjIKVio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbjIKNVh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 09:21:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185F12A;
        Mon, 11 Sep 2023 06:21:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BCVApY001138;
        Mon, 11 Sep 2023 13:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rX6uV9pMq+YZxXFlkOtDCFvmFDUZ4BTGpEAG11LI7UA=;
 b=eQUJlvTI8Z+G/ojrbbKhTJn5ZkRMYd12miibC4fEJMmK9DPZ+0H+iHqxC7HG+VeYfUyk
 qvkRGLAJUu+JSPbRls3eR5Oh816KFXGEXGujDZBkfUYz3+ycL2b2eGV+y0fNW+zK+Y3Q
 EfLXXQRmHpENDiG4StmqeTuqjBRNSsAn6Dd9d9L8LYZMCeacZQr08LVHxw47Lpv/JoZG
 kbtBxaPzeCtxChvbOuJBfbq2z+uZtI6mFjckllFfwz3UaNyL7zN7BPUubtgVAmIxZGOB
 5oll1FJR1dh/BvdmKny8ri5cQ8bmkhQfJfnU6AYgqM/mE6hwVXD3dHq1XiX/j57PNEJ0 Tg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0hfqkpvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 13:21:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BDLHaw020493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 13:21:17 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 06:21:13 -0700
Message-ID: <647e2b5e-6064-dbfa-bb56-f74358efd1fe@quicinc.com>
Date:   Mon, 11 Sep 2023 18:51:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/10] Add PCIe Bandwidth Controller
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
 <fa5a20d0-77db-58bd-3956-ac664dffa587@quicinc.com>
 <21b95d9-86a5-dcb0-9dda-3f1cdd426b9e@linux.intel.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <21b95d9-86a5-dcb0-9dda-3f1cdd426b9e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A7sIrciLOOLmIWHlA08WbhTGL190U4SX
X-Proofpoint-GUID: A7sIrciLOOLmIWHlA08WbhTGL190U4SX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110122
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/4/2023 4:46 PM, Ilpo Järvinen wrote:
> On Mon, 4 Sep 2023, Krishna Chaitanya Chundru wrote:
>
>> On 8/17/2023 5:46 PM, Ilpo Järvinen wrote:
>>> Hi all,
>>>
>>> This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
>>> cooling driver to the thermal core side for limiting PCIe link speed
>>> due to thermal reasons. PCIe bandwidth controller is a PCI express bus
>>> port service driver. A cooling device is created for each port the
>>> service driver finds if they support changing speeds.
>> I see we had support for only link speed changes here but we need to add
>> support for
>>
>> link width change also as bandwidth notification from PCIe supports both link
>> speed and link width.
> Hi,
>
> Thanks for the comment. In case you mean that the changes in Link Width
> should be reported correctly, they already are since the sysfs interface
> reads them directly from LNKSTA register.
>
> Or did you perhaps mean that Bandwidth Controller should support also
> changing Link Width? If this is the case I don't know how it can be
> realized so a pointer on how it can be achieved would be appreciated.

Hi,

I didn't have any idea on how thermal framework works.

But as we are adding bandwidth controller support we need to add support 
for width change also, may be we are not using this now, but we may need 
it in the future.

We had similar use case based on the bandwidth requirement on devices 
like WLAN, the client try to reduce or increase the link speed and link 
width.

So in the bandwidth controller driver we can add support for link width 
also. So any client can easily use the driver to change link speed or 
width or both to reduce the power consumption.

Adding link width support should be similar to how you added the link 
speed supported.

Please correct me if I misunderstood something here.

Thanks & Regards,

Krishna Chaitanya.

