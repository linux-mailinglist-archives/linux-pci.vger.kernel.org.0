Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D346F3CB865
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhGPOHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 10:07:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6944 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhGPOHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 10:07:48 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GRCZj0V6Hz7tyN;
        Fri, 16 Jul 2021 22:01:17 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 22:04:52 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 22:04:51 +0800
Subject: Re: [question]: Query regarding the PCI addresses
To:     Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <lijinlin3@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
References: <bb7e27ea-5957-21a0-34b4-5adf517c3546@huawei.com>
 <20210714165427.GA1854138@bjorn-Precision-5520>
 <20210714172623.GB1159813@dhcp-10-100-145-180.wdc.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <7d146a3a-199a-3135-331e-b34371d5ec80@huawei.com>
Date:   Fri, 16 Jul 2021 22:04:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210714172623.GB1159813@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/7/15 1:26, Keith Busch wrote:
> On Wed, Jul 14, 2021 at 11:54:27AM -0500, Bjorn Helgaas wrote:
>> On Wed, Jul 14, 2021 at 02:33:37PM +0800, Wenchao Hao wrote:
>>
>>> If they are not fixed, then is there anyway I can get a fixed ID
>>> which can indicate physical connection.
>> You can look at the "lspci -P" option.  I'm not really familiar with
>> this, but I think Matthew (cc'd) implemented it.
> That option shows the parent devices for each listed device, but that
> may not produce the same output if BDf doesn't always enumerate the
> same.
>
> I think Wenchao was seeking some invariant device identification that
> can be used to look up its BDf. There's no PCI level requirement for
> uniquely identifying a specific device across changing topologies, so I
> don't think this is generically possible.
> .

Yes, I want a way to access device which can keep unchanged, a
direction is according to hardware. If we have anyway which makes
it possible for software can describe hardware connection would
satisfy our demand.
Wenchao


