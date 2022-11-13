Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCADD626FE4
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 14:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiKMNtn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 08:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiKMNtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 08:49:39 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF411160;
        Sun, 13 Nov 2022 05:49:37 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9DM36QxbzRpCv;
        Sun, 13 Nov 2022 21:49:19 +0800 (CST)
Received: from [10.174.148.223] (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 21:49:33 +0800
Message-ID: <49006cf2-1f54-d53d-4f8a-0c1dfae9aa28@huawei.com>
Date:   Sun, 13 Nov 2022 21:49:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jianjay.zhou@huawei.com>,
        <zhuangshengen@huawei.com>, <arei.gonglei@huawei.com>,
        <yechuan@huawei.com>, <huangzhichao@huawei.com>,
        <xiehong@huawei.com>
References: <20221111230703.GA759162@bhelgaas>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
In-Reply-To: <20221111230703.GA759162@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



在 2022/11/12 7:07, Bjorn Helgaas 写道:
> On Fri, Nov 11, 2022 at 10:27:18PM +0800, Longpeng(Mike) wrote:
>> From: Longpeng <longpeng2@huawei.com>
>>
>> We can enable SRIOV and add VFs by /sys/bus/pci/devices/..../sriov_numvfs, but
>> this operation needs to spend lots of time if there has a large amount of VFs.
>>                                                              
>> For example, if the machine has 10 PFs and 250 VFs per-PF, enable all the VFs
>> concurrently would cost about 200-250ms. However most of them are not need to be
>> used at the moment, so we can enable SRIOV first but add VFs on demand.
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
> 
> When you respond to Leon's questions, please also spend a little time
> to look at the iov.c history and coding style and follow it, so we
> don't have to waste time commenting on or fixing trivial things.
> 
Okay, thanks for your valuable suggestions.

> For example, there are no previous subject lines for that file that
> start with "pci/sriov".  Don't make up a new prefix; use what's been
> done in the past.  And follow the style of capitalizing the first word
> after the prefix.
> 
> There are a few comments that look like they are more than 80 columns.
> Again unlike everything else in the file.
> 
> The PCIe spec spells it "SR-IOV", not "sriov".  Do the same in your
> commit logs and comments.
> 
> Capitalize "VF" consistently.  I see "VF" and "vf" used randomly.
> 
> Sysfs changes require documention updates, e.g., in
> Documentation/ABI/testing/sysfs-bus-pci.
> .
