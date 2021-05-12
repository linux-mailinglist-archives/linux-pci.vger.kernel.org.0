Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C79C37B6F6
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELHgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 03:36:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2714 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 03:36:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg62T5tp7z16Q8T;
        Wed, 12 May 2021 15:32:49 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 15:35:27 +0800
Subject: Re: [PATCH V2 5/5] PCI: Enable 10-Bit tag support for PCIe RP devices
To:     Christoph Hellwig <hch@infradead.org>
References: <1620745965-91535-1-git-send-email-liudongdong3@huawei.com>
 <YJqi7M/2bg0v5HvG@infradead.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <b12f19a1-423f-0da0-48c5-f1366961325c@huawei.com>
Date:   Wed, 12 May 2021 15:35:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YJqi7M/2bg0v5HvG@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/5/11 23:29, Christoph Hellwig wrote:
>> +	/*
>> +	 * PCIe spec 5.0r1.0 section 2.2.6.2 implementation note
>> +	 * For configurations where a Requester with 10-Bit Tag Requester capability
>> +	 * targets Completers where some do and some do not have 10-Bit Tag
>> +	 * Completer capability, how the Requester determines which NPRs include
>> +	 * 10-Bit Tags is outside the scope of this specification.  So we do not consider
>> +	 * hotplug scenario.
>> +	 */
>
> Please avoid > 80 char lines that make comments completely unreadable.
Thanks for pointing this, will fix.

Thanks,
Dongdong
> .
>
