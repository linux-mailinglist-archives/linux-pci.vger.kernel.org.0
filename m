Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A308662B041
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 01:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKPAwf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 19:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKPAwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 19:52:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32952CDCC;
        Tue, 15 Nov 2022 16:52:32 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBkyw4TSvzmVx6;
        Wed, 16 Nov 2022 08:52:08 +0800 (CST)
Received: from [10.174.148.223] (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 08:52:29 +0800
Message-ID: <726934f2-ded0-317f-2082-bf5ee08cf39d@huawei.com>
Date:   Wed, 16 Nov 2022 08:52:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
To:     Oliver O'Halloran <oohall@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jianjay.zhou@huawei.com>, <zhuangshengen@huawei.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <xiehong@huawei.com>
References: <20221111142722.1172-1-longpeng2@huawei.com>
 <Y256ty6xGyUpkFn9@unreal> <0b2202bf-18d3-b288-9605-279208165080@huawei.com>
 <Y3Hoi4zGFY4Fz1l4@unreal> <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com>
 <Y3I+Fs0/dXH/hnpL@unreal> <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com>
 <CAOSf1CFAG7FMjm0uzKCNMxB=0Q41JoNz7vr7mHNqEP0rr124Ug@mail.gmail.com>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
In-Reply-To: <CAOSf1CFAG7FMjm0uzKCNMxB=0Q41JoNz7vr7mHNqEP0rr124Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Hi Oliver,

在 2022/11/15 10:06, Oliver O'Halloran 写道:
> On Tue, Nov 15, 2022 at 1:08 AM Longpeng (Mike, Cloud Infrastructure
> Service Product Dept.) <longpeng2@huawei.com> wrote:
>>
>> *snip*
>>
>> Adding 2K+ VFs to the sysfs need too much time.
>>
>> Look at the bottomhalf of the hypervisor live update:
>> kexec --> add 2K VFs --> restore VMs
>>
>> The downtime can be reduced if the sequence is:
>> kexec --> add 100 VFs（the VMs used） --> resotre VMs --> add 1.9K VFs
> 
> Right, so you want to add VFs in batches rather than all at once.
> Personally I think the bitmap approach is error prone since it renders
> the meaning of pf_dev->sriov->num_VFs unclear and there's some hairy
> code in arch/powerpc/ that approach will likely break. A better

I ran a quick search in the arch/powerpc/, do you mean the 
pseries_call_allow_unfreeze ? Or would you please point the code?

> approach would be to add an attribute to control the number of VFs
> enabled in hardware and allowing sriov_numvfs to accept any number
> between the current value and sriov_hw_numvfs. e.g. your HV setup

Oh, this is a constructive suggestion, I'll try in the next step.

> would look something like:
>
> echo 2048 > sriov_hw_numvfs
> echo 100 > sriov_numvfs
> 
It's fixed to add the first 100 VFs first, maybe providing an interface 
that users can specify which id or which range of ids to be added first 
would be better?

> # time passes
> echo 2048 > sriov_numvfs
> 
> This would be fairly simple to implement and you can make it backwards
> compatible by having writes to sriov_numvfs retain their current
> semantics if sriov_hw_numvfs is zero.
> .
