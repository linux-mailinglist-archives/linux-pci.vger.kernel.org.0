Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596231525C2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 06:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgBEFL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 00:11:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34386 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEFL5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2020 00:11:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0155Brh7096960;
        Tue, 4 Feb 2020 23:11:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580879514;
        bh=KViLbGAz8uHNLASTEWLNpPoUqZMUu7u7/HXDd+GsplU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KZGfgdvQidyfbzs/9IRDpiGHndW6VlDLwr7xT10Ry4PY6a5CqjQX/Vx0IjW6WdfkW
         26x19Xk6BQH+LZpffrQ3qZYV6RSFqXjp488ugUBvXUE5ypTxsUzuW+1yuQeofMuKnZ
         ymj0ZC6X6CGR3KQ0pUSyGcjV8GFwrJhY63t9JM9I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0155BrZn092610
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Feb 2020 23:11:53 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 23:11:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 23:11:53 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0155BqJo112619;
        Tue, 4 Feb 2020 23:11:52 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20200130075833.GC30735@lst.de> <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com>
 <20200130164235.GA6705@lst.de> <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com>
 <20200203142155.GA16388@lst.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a5eb4f73-418a-6780-354f-175d08395e71@ti.com>
Date:   Wed, 5 Feb 2020 10:45:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200203142155.GA16388@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On 03/02/20 7:51 PM, Christoph Hellwig wrote:
> On Fri, Jan 31, 2020 at 05:14:01PM +0530, Kishon Vijay Abraham I wrote:
>>> Can you throw in a little debug printk if this comes from
>>> dma_direct_possible or swiotlb_map?
>>
>> I could see swiotlb_tbl_map_single() returning DMA_MAPPING_ERROR.
>>
>> Kernel with debug print:
>> https://github.com/kishon/linux-wip.git nvm_dma_issue
>>
>> Full log: https://pastebin.ubuntu.com/p/Xf2ngxc3kB/
> 
> Ok, this mostly like means we allocate a swiotlb buffer that isn't
> actually addressable.  To verify that can you post the output with the
> first attached patch?  If it shows the overflow message added there,
> please try if the second patch fixes it.

I'm seeing some sort of busy loop after applying your 1st patch. I sent
a SysRq to see where it is stuck

[  182.641398] sysrq: Show Blocked State
[  182.645080]   task                PC stack   pid father
[  182.650359] sync            D    0  2101   1901 0x00000000
[  182.655889] [<c0a399b8>] (__schedule) from [<c0a39e54>]
(schedule+0xa0/0x138)
[  182.663063] [<c0a39e54>] (schedule) from [<c0a3a484>]
(io_schedule+0x14/0x34)
[  182.670237] [<c0a3a484>] (io_schedule) from [<c02eebec>]
(wait_on_page_bit+0x14c/0x1a8)
[  182.678283] [<c02eebec>] (wait_on_page_bit) from [<c02edaa4>]
(__filemap_fdatawait_range+0x94/0xec)
[  182.687374] [<c02edaa4>] (__filemap_fdatawait_range) from
[<c02edb8c>] (filemap_fdatawait_keep_errors+0x24/0x50)
[  182.697601] [<c02edb8c>] (filemap_fdatawait_keep_errors) from
[<c0385a84>] (sync_inodes_sb+0x1a8/0x23c)
[  182.707041] [<c0385a84>] (sync_inodes_sb) from [<c035bd84>]
(iterate_supers+0x88/0xdc)
[  182.714998] [<c035bd84>] (iterate_supers) from [<c0389be4>]
(ksys_sync+0x40/0xb8)
[  182.722519] [<c0389be4>] (ksys_sync) from [<c0389c64>]
(sys_sync+0x8/0x10)
[  182.729429] [<c0389c64>] (sys_sync) from [<c0201000>]
(ret_fast_syscall+0x0/0x4c)
[  182.736943] Exception stack(0xe5461fa8 to 0xe5461ff0)
[  182.742016] 1fa0:                   be8a8db4 be8a8db8 00000000
ffffffff 00000000 0009d6b8
[  182.750230] 1fc0: be8a8db4 be8a8db8 00000001 00000024 be8a8db4
00000000 b6f0b000 0009d6dc
[  182.758443] 1fe0: b6e2e3d0 be8a8c1c 00064821 b6e2e3dc

Full log here: https://pastebin.ubuntu.com/p/q6yDtP9vxR/

Thanks
Kishon
> 
