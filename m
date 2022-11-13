Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15553626FD9
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiKMNrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 08:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiKMNrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 08:47:18 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B756430;
        Sun, 13 Nov 2022 05:47:16 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N9DDK5rcKzqSNJ;
        Sun, 13 Nov 2022 21:43:29 +0800 (CST)
Received: from [10.174.148.223] (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 21:47:13 +0800
Message-ID: <0b2202bf-18d3-b288-9605-279208165080@huawei.com>
Date:   Sun, 13 Nov 2022 21:47:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
To:     Leon Romanovsky <leon@kernel.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jianjay.zhou@huawei.com>,
        <zhuangshengen@huawei.com>, <arei.gonglei@huawei.com>,
        <yechuan@huawei.com>, <huangzhichao@huawei.com>,
        <xiehong@huawei.com>
References: <20221111142722.1172-1-longpeng2@huawei.com>
 <Y256ty6xGyUpkFn9@unreal>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
In-Reply-To: <Y256ty6xGyUpkFn9@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi leon,

在 2022/11/12 0:39, Leon Romanovsky 写道:
> On Fri, Nov 11, 2022 at 10:27:18PM +0800, Longpeng(Mike) wrote:
>> From: Longpeng <longpeng2@huawei.com>
>>
>> We can enable SRIOV and add VFs by /sys/bus/pci/devices/..../sriov_numvfs, but
>> this operation needs to spend lots of time if there has a large amount of VFs.
>>                                                              
>> For example, if the machine has 10 PFs and 250 VFs per-PF, enable all the VFs
>> concurrently would cost about 200-250ms. However most of them are not need to be
>> used at the moment, so we can enable SRIOV first but add VFs on demand.
> 
> It is unclear what took 200-250ms, is it physical VF creation or bind of
> the driver to these VFs?
>
It is neither. In our test, we already created physical VFs before, so 
we skipped the 100ms waiting when writing PCI_SRIOV_CTRL. And our driver 
only probes PF, it just returns an error if the function is VF.

The hotspot is the sriov_add_vfs (but no driver probe in fact) which is 
a long procedure. Each step costs only a little, but the total cost is 
not acceptable in some time-sensitive cases.

What’s more, the sriov_add_vfs adds the VFs of a PF one by one. So we 
can mostly support 10 concurrent calls if there has 10 PFs.

> If the latter, you can try with sriov_drivers_autoprobe set to true. This is how
> ennoblement of large SR-IOV systems is done.
>  > Also PCI spec declares "VF enable" bit, which is applicable to all VFs
> associated to that PF, see section "9.3.3.3.1 VF Enable".
> 
> Thanks
> 
>>
>> This series introduces two interfaces:
>> 1. sriov_numvfs_no_scan: enable SRIOV without add the VFs.
>> 2. sriov_scan_vf_id: add a specific VF.
>>
>> Longpeng (4):
>>    pci/sriov: extract sriov_numvfs common helper
>>    pci/sriov: add vf_bitmap to mark the vf id allocation
>>    pci/sriov: add sriov_numfs_no_scan interface
>>    pci/sriov: add sriov_scan_vf_id interface
>>
>>   drivers/pci/iov.c | 162 +++++++++++++++++++++++++++++++++++++++++-----
>>   drivers/pci/pci.h |   1 +
>>   2 files changed, 148 insertions(+), 15 deletions(-)
>>
>> -- 
>> 2.23.0
>>
> .
