Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A201A14A4E2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 14:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA0NXD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 08:23:03 -0500
Received: from foss.arm.com ([217.140.110.172]:44462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgA0NXD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 08:23:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A95930E;
        Mon, 27 Jan 2020 05:23:02 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 196E73F52E;
        Mon, 27 Jan 2020 05:23:01 -0800 (PST)
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20191115130654.GA3414@lst.de> <cf530590-26a4-22c6-c3ca-685fad7fd075@ti.com>
 <20191116163528.GE23951@lst.de>
 <872a502c-5921-2b2e-de65-afc524f156c7@arm.com>
 <7bf16dc1-6f39-771c-cfb4-090c2a87e859@ti.com>
 <6134ef5c-c289-5029-9083-ed9813d8655d@ti.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a32ca2e8-8f70-3097-e169-5c9d116738e4@arm.com>
Date:   Mon, 27 Jan 2020 13:22:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6134ef5c-c289-5029-9083-ed9813d8655d@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On 27/01/2020 1:10 pm, Kishon Vijay Abraham I wrote:
> Hi Christoph, Robin,
> 
> On 25/11/19 11:13 am, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On 18/11/19 10:51 PM, Robin Murphy wrote:
>>> On 16/11/2019 4:35 pm, Christoph Hellwig wrote:
>>>> On Fri, Nov 15, 2019 at 07:48:23PM +0530, Kishon Vijay Abraham I wrote:
>>>>> I think the fix on 5.3 was useful for platform drivers (where the platform
>>>>> driver will set dma_set_mask as 32bits) even when the system itself supports
>>>>> LPAE.
>>>>
>>>> Well, we can also use the bus_dma_mask for PCI(e) root port quirks,
>>>> as we do that for the VIA ones on x86.  But I think the OF parsing code
>>>> is missing something here, and Robin did plan to look into that.
>>>
>>> Right, the correct way to describe this is with "dma-ranges" on the host bridge
>>> node, and there are patches queued in linux-next to (finally) handle that
>>> properly for the way we bodge dynamically-discovered endpoints through
>>> of_dma_configure().
>>
>> Tried linux-next after adding dma-ranges property to the DRA7 RC dt node and
>> don't see the issue anymore.
> 
> Using the latest mainline kernel
> commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755 (tag: v5.5,
> origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Jan 26 16:23:03 2020 -0800
> 
>      Linux 5.5
> 
> I see the following warn dump when using a NVMe card with LPAE config
> enabled
> 
> nvme 0000:01:00.0: overflow 0x000000027b3be000+270336 of DMA mask

That's a 34-bit physical address...

> ffffffffffffffff bus limit ffffffff

...and that's your 32-bit PCI host bridge constraint. Thus the warning 
appears to be correct in that this is an attempt at an impossible direct 
DMA mapping. I'm assuming you do have RAM above the 32-bit boundary 
exposed by virtue of the LPAE config but don't have SWIOTLB enabled, is 
that the case?

Robin.

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 26 at kernel/dma/direct.c:35 report_addr+0xf0/0xf4
> Modules linked in:
> CPU: 0 PID: 26 Comm: kworker/u4:1 Not tainted 5.5.0-00002-g1383adf7b819 #2
> Hardware name: Generic DRA74X (Flattened Device Tree)
> Workqueue: writeback wb_workfn (flush-259:0)
> (unwind_backtrace) from [<c020b494>] (show_stack+0x10/0x14)
> (show_stack) from [<c0a2ae24>] (dump_stack+0x94/0xa8)
> (dump_stack) from [<c022bbd8>] (__warn+0xbc/0xd8)
> (__warn) from [<c022bc54>] (warn_slowpath_fmt+0x60/0xb8)
> (warn_slowpath_fmt) from [<c0299928>] (report_addr+0xf0/0xf4)
> (report_addr) from [<c0299ab8>] (dma_direct_map_page+0x18c/0x19c)
> (dma_direct_map_page) from [<c0299b2c>] (dma_direct_map_sg+0x64/0xb4)
> (dma_direct_map_sg) from [<c071b12c>] (nvme_queue_rq+0x778/0x9ec)
> (nvme_queue_rq) from [<c050c8c8>] (__blk_mq_try_issue_directly+0x130/0x1bc)
> (__blk_mq_try_issue_directly) from [<c050d1b8>]
> (blk_mq_request_issue_directly+0x48/0x78)
> (blk_mq_request_issue_directly) from [<c050d22c>]
> (blk_mq_try_issue_list_directly+0x44/0xb8)
> (blk_mq_try_issue_list_directly) from [<c0511620>]
> (blk_mq_sched_insert_requests+0xe0/0x154)
> (blk_mq_sched_insert_requests) from [<c050d13c>]
> (blk_mq_flush_plug_list+0x150/0x184)
> (blk_mq_flush_plug_list) from [<c0502ec4>] (blk_flush_plug_list+0xc8/0xe4)
> (blk_flush_plug_list) from [<c050cc44>] (blk_mq_make_request+0x24c/0x3f0)
> (blk_mq_make_request) from [<c0501acc>] (generic_make_request+0xb0/0x2d4)
> (generic_make_request) from [<c0501d34>] (submit_bio+0x44/0x180)
> (submit_bio) from [<c039ad10>] (mpage_writepages+0xac/0xe8)
> (mpage_writepages) from [<c02f96dc>] (do_writepages+0x44/0xdc)
> (do_writepages) from [<c0384830>] (__writeback_single_inode+0x2c/0x1bc)
> (__writeback_single_inode) from [<c0384b98>]
> (writeback_sb_inodes+0x1d8/0x404)
> (writeback_sb_inodes) from [<c0384e1c>] (__writeback_inodes_wb+0x58/0x9c)
> (__writeback_inodes_wb) from [<c0384ff4>] (wb_writeback+0x194/0x1d8)
> (wb_writeback) from [<c0386104>] (wb_workfn+0x244/0x33c)
> (wb_workfn) from [<c0244ff8>] (process_one_work+0x204/0x458)
> (process_one_work) from [<c0245290>] (worker_thread+0x44/0x598)
> (worker_thread) from [<c024ab30>] (kthread+0x14c/0x150)
> (kthread) from [<c02010d8>] (ret_from_fork+0x14/0x3c)
> 
> Thanks
> Kishon
> 
