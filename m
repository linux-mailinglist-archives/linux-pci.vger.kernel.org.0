Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC855DB56
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiF1HR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbiF1HRU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 03:17:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB22CCBC;
        Tue, 28 Jun 2022 00:17:18 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LXG7n0lRdz1L8mG;
        Tue, 28 Jun 2022 15:15:01 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 15:17:15 +0800
CC:     <yangyicong@hisilicon.com>, Greg KH <gregkh@linuxfoundation.org>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <jonathan.cameron@huawei.com>, <robin.murphy@arm.com>,
        <leo.yan@linaro.org>, <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <james.clark@arm.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <alexander.shishkin@linux.intel.com>, <acme@kernel.org>
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
To:     <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, Peter Zijlstra <peterz@infradead.org>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
 <Yrms2cI05O2yZRKU@kroah.com>
 <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
 <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <6c923b13-a588-9511-3f94-3241c8aacac5@huawei.com>
Date:   Tue, 28 Jun 2022 15:17:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/6/27 22:01, Peter Zijlstra wrote:
> On Mon, Jun 27, 2022 at 09:25:42PM +0800, Yicong Yang wrote:
>> On 2022/6/27 21:12, Greg KH wrote:
>>> On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
>>>> Hi Greg,
>>>>
>>>> Since the kernel side of this device has been reviewed for 8 versions with
>>>> all comments addressed and no more comment since v9 posted in 5.19-rc1,
>>>> is it ok to merge it first (for Patch 1-3 and 7-8)?
>>>
>>> I am not the maintainer of this subsystem, so I do not understand why
>>> you are asking me :(
>>>
>>
>> I checked the log of drivers/hwtracing and seems patches of coresight/intel_th/stm
>> applied by different maintainers and I see you applied some patches of intel_th/stm.
>> Should any of these three maintainers or you can help applied this?
> 
> I was hoping Mark would have a look, since he knows this ARM stuff
> better than me. But ISTR he's somewhat busy atm too. But an ACK from the
> CoreSight people would also be appreciated.
> 

Thanks for the instruction.

Hi Mark, Mathieu and Suzuki,

May I have an ack from you to have the driver part of this device merged?

Thanks!
