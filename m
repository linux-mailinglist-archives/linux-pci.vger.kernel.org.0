Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C96577C2F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiGRHK0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiGRHK0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 03:10:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5117079;
        Mon, 18 Jul 2022 00:10:24 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LmY0r3K9qzVfrT;
        Mon, 18 Jul 2022 15:06:36 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 15:10:22 +0800
CC:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>, <peterz@infradead.org>,
        <corbet@lwn.net>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <suzuki.poulose@arm.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        <linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v10 7/8] docs: trace: Add HiSilicon PTT device driver
 documentation
To:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <20220714092710.53486-1-yangyicong@hisilicon.com>
 <20220714092710.53486-8-yangyicong@hisilicon.com>
 <YtEgoZveaZJ3a7+4@debian.me>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <f0dc5cb8-ec3b-eb8f-98e3-4a6301e8be06@huawei.com>
Date:   Mon, 18 Jul 2022 15:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YtEgoZveaZJ3a7+4@debian.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/7/15 16:09, Bagas Sanjaya wrote:
> On Thu, Jul 14, 2022 at 05:27:09PM +0800, Yicong Yang wrote:
>> +1. Tx path QoS control
>> +------------------------
>> +
> <snip>
>> +2. Tx path buffer control
>> +-------------------------
>> +
> 
> Shouldn't Tx in the headings above be lowercase (tx)?

Tx is used to keep consistence with other places.

> 
>> +1. filter
>> +---------
> <snip>
>> +2. type
>> +-------
> <snip>
>> +3. direction
>> +------------
> <snip>
>> +4. format
>> +--------------
> <snip>
>> +5. memory management
>> +--------------------
> <snip>
>> +6. decoding
>> +-----------
> 
> I think these headings above should use title case instead.

ok.

> 
> Anyway, the documentation (htmldocs) builds successfully without new
> warnings.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 

Thanks.

