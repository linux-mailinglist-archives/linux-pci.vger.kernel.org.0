Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0CE3CF1EE
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 04:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhGTBcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 21:32:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15040 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbhGTBZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 21:25:03 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GTMRH45VlzZj5T;
        Tue, 20 Jul 2021 10:02:19 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 10:05:41 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 10:05:40 +0800
Subject: Re: [question]: Query regarding the PCI addresses
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <lijinlin3@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210716142527.GA2097477@bjorn-Precision-5520>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <3ad42d27-f7a8-56d7-778d-5e26511e4e24@huawei.com>
Date:   Tue, 20 Jul 2021 10:05:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210716142527.GA2097477@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/7/16 22:25, Bjorn Helgaas wrote:
> On Fri, Jul 16, 2021 at 10:04:51PM +0800, Wenchao Hao wrote:
>> On 2021/7/15 1:26, Keith Busch wrote:
>>> On Wed, Jul 14, 2021 at 11:54:27AM -0500, Bjorn Helgaas wrote:
>>>> On Wed, Jul 14, 2021 at 02:33:37PM +0800, Wenchao Hao wrote:
>>>>
>>>>> If they are not fixed, then is there anyway I can get a fixed ID
>>>>> which can indicate physical connection.
>>>> You can look at the "lspci -P" option.  I'm not really familiar with
>>>> this, but I think Matthew (cc'd) implemented it.
>>> That option shows the parent devices for each listed device, but that
>>> may not produce the same output if BDf doesn't always enumerate the
>>> same.
>>>
>>> I think Wenchao was seeking some invariant device identification that
>>> can be used to look up its BDf. There's no PCI level requirement for
>>> uniquely identifying a specific device across changing topologies, so I
>>> don't think this is generically possible.
>> Yes, I want a way to access device which can keep unchanged, a
>> direction is according to hardware. If we have anyway which makes
>> it possible for software can describe hardware connection would
>> satisfy our demand.
> I don't know whether this would be useful, but PCI does define an
> optional "Device Serial Number" extended capability.  It has issues
> like the fact that many devices don't support it at all, and even on
> devices that do support it, the serial number may not actually be
> unique.  There is minimal support for this in Linux (pci_get_dsn()),
> but it is currently not exposed to userspace via sysfs.
>
> Bjorn
> .

This "Device Serial Number" seems can not satisfy our demand because it 
is looks
not a general ID. According to BIOS conclusion, if we can the hardware keeps
unchanged, the BUS number would not change. We would put some 
restrictions as
workaround temporarily.

Thanks a lot for your suggestions.

