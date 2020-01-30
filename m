Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27D14D743
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 09:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgA3IGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 03:06:50 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37972 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgA3IGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2020 03:06:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00U86kaJ120755;
        Thu, 30 Jan 2020 02:06:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580371606;
        bh=qS2KQkbn+rYSntTI7CrR/Abg0y9Uhal/ocC0w2KxRWo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SZWQX8Ij7Zcgi3+mCPCyCK4ZxfjSrcsEdB7cTyuueJhahEdjU0Plx9rZMWkyRxY+f
         0+67HJHJJzkTYKwP+ff4KvR/7jByk27rN1ReZFlLQUJp0Fkz2az3Dat+HYtmDTh8QX
         YQS8qDcQWYuezzs5YhVuhOewe/mItWUrxtk/J62c=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00U86kca001586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jan 2020 02:06:46 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 30
 Jan 2020 02:06:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 30 Jan 2020 02:06:45 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00U86iIr100772;
        Thu, 30 Jan 2020 02:06:45 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20200130075833.GC30735@lst.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com>
Date:   Thu, 30 Jan 2020 13:39:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200130075833.GC30735@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On 30/01/20 1:28 pm, Christoph Hellwig wrote:
> On Fri, Nov 15, 2019 at 04:29:31PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Christoph,
>>
>> I think we are encountering a case where the connected PCIe card (like PCIe USB
>> card) supports 64-bit addressing and the ARM core supports 64-bit addressing
>> but the PCIe controller in the SoC to which PCIe card is connected supports
>> only 32-bits.
>>
>> Here dma APIs can provide an address above the 32 bit region to the PCIe card.
>> However this will fail when the card tries to access the provided address via
>> the PCIe controller.
> 
> What kernel version do you test?  The classic arm version of dma_capable
> doesn't take the bus dma mask into account.  In Linux 5.5 I switched
> ARM to use the generic version in
> 
> 130c1ccbf55 ("dma-direct: unify the dma_capable definitions")
> 
> so with that this case is supposed to work, without that it doesn't
> have much of a chance.

I got into a new issue in 5.5 kernel with NVMe card wherein I get the
below warn dump. This is different from the issue I initially posted
seen with USB and SATA cards (I was getting a data mismatch then). With
5.5 kernel I don't see those issues anymore in USB card. I only see the
below warn dump with NVMe card.

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
