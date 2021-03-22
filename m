Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EE344049
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 12:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhCVL5A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 07:57:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14840 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCVL4c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 07:56:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F3tFy67Jqz92FB;
        Mon, 22 Mar 2021 19:54:30 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Mon, 22 Mar 2021
 19:56:22 +0800
Subject: Re: [PATCH v2] PCI: Factor functions of PCI function reset
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <alex.williamson@redhat.com>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.dom>, Amey Narkhede <ameynarkhede03@gmail.com>
References: <1616145918-31356-1-git-send-email-yangyicong@hisilicon.com>
 <YFTaskobyoEzLkeE@rocinante>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <29166e97-950c-47da-d226-e8827befde75@hisilicon.com>
Date:   Mon, 22 Mar 2021 19:56:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YFTaskobyoEzLkeE@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof，

On 2021/3/20 1:09, Krzysztof Wilczyński wrote:
> [+cc Amey as he is workingo on a larger refactor of the reset functions]
> 
> Hi,
> 
>> Previously we used pci_probe_reset_function() to probe whether a function
>> can be reset and use __pci_reset_function_locked() to perform a function
>> reset. These two functions have lots of common lines.
>>
>> Factor the two functions and reduce the redundancy.
> [...]
> 
> I wanted to bring the following thread to your attention as you are
> working on the same code that it's being talked about there in the
> on-going conversation, see:
> 
>   https://lore.kernel.org/linux-pci/20210312173452.3855-1-ameynarkhede03@gmail.com/
> 
> I wonder if there would be some overlap, etc.

thanks for the reminder. i roughly look through Amey's series and i think this little
refactor is unnecessary anymore. i'll follow on that series and i may need a further
understanding.

Thanks,
Yicong

> 
> Krzysztof
> 
> .
> 

