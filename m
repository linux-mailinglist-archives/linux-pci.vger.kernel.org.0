Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2AAD14A48A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 14:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgA0NHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 08:07:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35668 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgA0NHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jan 2020 08:07:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RD7SYH077325;
        Mon, 27 Jan 2020 07:07:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580130448;
        bh=YeYRYYvnJDV26+KtP0XlURczW3GRjjJw9DKDXt8pet0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=Pq5b1VRETxbU4mtVOzs8GbakFV3niUqEfHzL8ai3f3PBcEnbh5+pPEWXbwjaG8bk3
         wuDJzQoM/QFU6AB7nYFK74aaqJJQtIcFNkCmE0h02VuE+iJgkUaKgdhgNwu9vZ3hhT
         rK3xP5PGJsd1KJIImgDaojgLsmpVg7v3ANbRLuNM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00RD7RlO096979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jan 2020 07:07:27 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 07:07:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 07:07:27 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RD7P4K117564;
        Mon, 27 Jan 2020 07:07:26 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20191115130654.GA3414@lst.de> <cf530590-26a4-22c6-c3ca-685fad7fd075@ti.com>
 <20191116163528.GE23951@lst.de>
 <872a502c-5921-2b2e-de65-afc524f156c7@arm.com>
 <7bf16dc1-6f39-771c-cfb4-090c2a87e859@ti.com>
Message-ID: <6134ef5c-c289-5029-9083-ed9813d8655d@ti.com>
Date:   Mon, 27 Jan 2020 18:40:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <7bf16dc1-6f39-771c-cfb4-090c2a87e859@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph, Robin,

On 25/11/19 11:13 am, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 18/11/19 10:51 PM, Robin Murphy wrote:
>> On 16/11/2019 4:35 pm, Christoph Hellwig wrote:
>>> On Fri, Nov 15, 2019 at 07:48:23PM +0530, Kishon Vijay Abraham I wrote:
>>>> I think the fix on 5.3 was useful for platform drivers (where the platform
>>>> driver will set dma_set_mask as 32bits) even when the system itself supports
>>>> LPAE.
>>>
>>> Well, we can also use the bus_dma_mask for PCI(e) root port quirks,
>>> as we do that for the VIA ones on x86.  But I think the OF parsing code
>>> is missing something here, and Robin did plan to look into that.
>>
>> Right, the correct way to describe this is with "dma-ranges" on the host bridge
>> node, and there are patches queued in linux-next to (finally) handle that
>> properly for the way we bodge dynamically-discovered endpoints through
>> of_dma_configure().
> 
> Tried linux-next after adding dma-ranges property to the DRA7 RC dt node and
> don't see the issue anymore.

Using the latest mainline kernel
commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755 (tag: v5.5,
origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jan 26 16:23:03 2020 -0800

    Linux 5.5

I see the following warn dump when using a NVMe card with LPAE config
enabled

nvme 0000:01:00.0: overflow 0x000000027b3be000+270336 of DMA mask
ffffffffffffffff bus limit ffffffff
------------[ cut here ]------------
WARNING: CPU: 0 PID: 26 at kernel/dma/direct.c:35 report_addr+0xf0/0xf4
Modules linked in:
CPU: 0 PID: 26 Comm: kworker/u4:1 Not tainted 5.5.0-00002-g1383adf7b819 #2
Hardware name: Generic DRA74X (Flattened Device Tree)
Workqueue: writeback wb_workfn (flush-259:0)
(unwind_backtrace) from [<c020b494>] (show_stack+0x10/0x14)
(show_stack) from [<c0a2ae24>] (dump_stack+0x94/0xa8)
(dump_stack) from [<c022bbd8>] (__warn+0xbc/0xd8)
(__warn) from [<c022bc54>] (warn_slowpath_fmt+0x60/0xb8)
(warn_slowpath_fmt) from [<c0299928>] (report_addr+0xf0/0xf4)
(report_addr) from [<c0299ab8>] (dma_direct_map_page+0x18c/0x19c)
(dma_direct_map_page) from [<c0299b2c>] (dma_direct_map_sg+0x64/0xb4)
(dma_direct_map_sg) from [<c071b12c>] (nvme_queue_rq+0x778/0x9ec)
(nvme_queue_rq) from [<c050c8c8>] (__blk_mq_try_issue_directly+0x130/0x1bc)
(__blk_mq_try_issue_directly) from [<c050d1b8>]
(blk_mq_request_issue_directly+0x48/0x78)
(blk_mq_request_issue_directly) from [<c050d22c>]
(blk_mq_try_issue_list_directly+0x44/0xb8)
(blk_mq_try_issue_list_directly) from [<c0511620>]
(blk_mq_sched_insert_requests+0xe0/0x154)
(blk_mq_sched_insert_requests) from [<c050d13c>]
(blk_mq_flush_plug_list+0x150/0x184)
(blk_mq_flush_plug_list) from [<c0502ec4>] (blk_flush_plug_list+0xc8/0xe4)
(blk_flush_plug_list) from [<c050cc44>] (blk_mq_make_request+0x24c/0x3f0)
(blk_mq_make_request) from [<c0501acc>] (generic_make_request+0xb0/0x2d4)
(generic_make_request) from [<c0501d34>] (submit_bio+0x44/0x180)
(submit_bio) from [<c039ad10>] (mpage_writepages+0xac/0xe8)
(mpage_writepages) from [<c02f96dc>] (do_writepages+0x44/0xdc)
(do_writepages) from [<c0384830>] (__writeback_single_inode+0x2c/0x1bc)
(__writeback_single_inode) from [<c0384b98>]
(writeback_sb_inodes+0x1d8/0x404)
(writeback_sb_inodes) from [<c0384e1c>] (__writeback_inodes_wb+0x58/0x9c)
(__writeback_inodes_wb) from [<c0384ff4>] (wb_writeback+0x194/0x1d8)
(wb_writeback) from [<c0386104>] (wb_workfn+0x244/0x33c)
(wb_workfn) from [<c0244ff8>] (process_one_work+0x204/0x458)
(process_one_work) from [<c0245290>] (worker_thread+0x44/0x598)
(worker_thread) from [<c024ab30>] (kthread+0x14c/0x150)
(kthread) from [<c02010d8>] (ret_from_fork+0x14/0x3c)

Thanks
Kishon
