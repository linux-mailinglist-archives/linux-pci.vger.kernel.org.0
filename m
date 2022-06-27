Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84355C4EB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiF0NZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiF0NZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 09:25:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D13663C5;
        Mon, 27 Jun 2022 06:25:45 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LWpPD2x5mz9srs;
        Mon, 27 Jun 2022 21:25:04 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 21:25:42 +0800
CC:     <yangyicong@hisilicon.com>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <jonathan.cameron@huawei.com>,
        <robin.murphy@arm.com>, <leo.yan@linaro.org>,
        <mark.rutland@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <james.clark@arm.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <alexander.shishkin@linux.intel.com>, <acme@kernel.org>
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
 <Yrms2cI05O2yZRKU@kroah.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
Date:   Mon, 27 Jun 2022 21:25:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Yrms2cI05O2yZRKU@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/6/27 21:12, Greg KH wrote:
> On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
>> Hi Greg,
>>
>> Since the kernel side of this device has been reviewed for 8 versions with
>> all comments addressed and no more comment since v9 posted in 5.19-rc1,
>> is it ok to merge it first (for Patch 1-3 and 7-8)?
> 
> I am not the maintainer of this subsystem, so I do not understand why
> you are asking me :(
> 

I checked the log of drivers/hwtracing and seems patches of coresight/intel_th/stm
applied by different maintainers and I see you applied some patches of intel_th/stm.
Should any of these three maintainers or you can help applied this?

Thanks.
