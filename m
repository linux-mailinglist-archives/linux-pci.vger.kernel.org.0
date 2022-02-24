Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBE4C2BCF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 13:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiBXMdm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 07:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiBXMdh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 07:33:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC026192E27;
        Thu, 24 Feb 2022 04:33:04 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4C304K1Pz67dyM;
        Thu, 24 Feb 2022 20:32:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 24 Feb 2022 13:33:02 +0100
Received: from [10.47.86.126] (10.47.86.126) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Feb
 2022 12:33:00 +0000
Message-ID: <aabd5f0a-1a54-e4da-734c-f940c45d66b4@huawei.com>
Date:   Thu, 24 Feb 2022 12:32:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 2/8] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     Yicong Yang <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
 <20220221084307.33712-3-yangyicong@hisilicon.com>
 <c7d8cff4-b84e-1b73-1d54-2e221b90dac1@huawei.com>
 <e78f6e5e-a0c3-4976-4f46-e3369635ee3d@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <e78f6e5e-a0c3-4976-4f46-e3369635ee3d@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.126]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/02/2022 03:53, Yicong Yang wrote:
> On 2022/2/22 19:06, John Garry wrote:
>> On 21/02/2022 08:43, Yicong Yang wrote:
>>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
>>> integrated Endpoint(RCiEP) device, providing the capability
>>> to dynamically monitor and tune the PCIe traffic, and trace
>>> the TLP headers.
>>>
>>> Add the driver for the device to enable the trace function.
>>> This patch adds basic function of trace, including the device's
>>> probe and initialization, functions for trace buffer allocation
>>> and trace enable/disable, register an interrupt handler to
>>> simply response to the DMA events. The user interface of trace
>>> will be added in the following patch.
>>>
>>
>> Fill commit message lines upto 75 characters
> 
> Hi John,
> 
> Thanks for the comments.
> 
> The commit message is within 75 characters. I checked again and checkpatch
> didn't warning for this.

I mean to fill the lines up as much as possible, upto 75 char max, if 
not already done so. I am not sure if you are doing this already, but it 
looks like you were not.

Checkpatch
will
no
warn
about
a
commit
message
like
this
:)


Thanks,
john
