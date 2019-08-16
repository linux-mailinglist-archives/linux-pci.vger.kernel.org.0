Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5D8FBD2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfHPHLL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 03:11:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3089 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbfHPHLL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 03:11:11 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 0871427F69B56E791BA8;
        Fri, 16 Aug 2019 15:11:08 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 16 Aug 2019 15:11:07 +0800
Received: from [127.0.0.1] (10.40.49.11) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 16
 Aug 2019 15:11:07 +0800
Subject: Re: Bug report: AER driver deadlock
From:   Jay Fang <f.fangjian@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <a7dcc378-6101-ac08-ec8e-be7d5c183b49@huawei.com>
 <20190625171639.GA103694@google.com>
 <7b181647-3158-2a79-c6ca-d81056625fc8@huawei.com>
Message-ID: <bea119ec-9ff7-3cdd-df62-a78bf4e2a9d9@huawei.com>
Date:   Fri, 16 Aug 2019 15:11:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <7b181647-3158-2a79-c6ca-d81056625fc8@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.49.11]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping...

Best Regards,
Jay


On 2019/8/5 20:43, Fangjian (Turing) wrote:
> Kindly Ping...
> 
> 
> 
> Best Regards,
> Jay
> 
> On 2019/6/26 1:16, Bjorn Helgaas wrote:
>> On Tue, Jun 04, 2019 at 11:25:44AM +0800, Fangjian (Turing) wrote:
>>> Hi, We met a deadlock triggered by a NONFATAL AER event during a sysfs
>>> "sriov_numvfs" operation. Any suggestion to fix such deadlock ?
>>
>> Here's a bugzilla report for this; please reference it and this email
>> thread in any patches to fix it:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=203981
>>
>> .
>>
> 
> 
> .
> 

