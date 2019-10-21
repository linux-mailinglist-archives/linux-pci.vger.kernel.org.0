Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF11DE2E1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 06:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbfJUEFu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 00:05:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfJUEFt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 00:05:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A4A356633E3751C2050;
        Mon, 21 Oct 2019 12:05:48 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 12:05:44 +0800
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
To:     Christoph Hellwig <hch@infradead.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhocko@kernel.org>,
        <peterz@infradead.org>, <robin.murphy@arm.com>,
        <geert@linux-m68k.org>, <gregkh@linuxfoundation.org>,
        <paul.burton@mips.com>
References: <1571467543-26125-1-git-send-email-linyunsheng@huawei.com>
 <20191019083431.GA26340@infradead.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <96b8737d-5fbf-7942-bf10-7521cf954d6e@huawei.com>
Date:   Mon, 21 Oct 2019 12:05:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191019083431.GA26340@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/10/19 16:34, Christoph Hellwig wrote:
> On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
>> +	if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
>> +		dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
>> +
> 
> The whole idea of mentioning a BIOS in architeture indepent code doesn't
> make sense at all.

Mentioning the BIOS is to tell user what firmware is broken, so that
user can report this to their vendor by referring the specific firmware.

It seems we can specific the node through different ways(DT, ACPI, etc).

Is there a better name for mentioning instead of BIOS, or we should do
the checking and warning in the architeture dependent code?

Or maybe just remove the BIOS from the above log?

Thanks.

> 
> .
> 

