Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD350B30E1
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2019 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbfIOQel (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Sep 2019 12:34:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfIOQel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Sep 2019 12:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tqxgl1GXmiRxMEjAk3Bu0fH3492cxMOoJoDu4VCbZ08=; b=papHXAhzVbiaFdkN3lIRadTkN
        s+qvInAlc1RJDF4W9iycPitnpGBg7bm/Eab3YhCsx/itoxPnk2uhLJn+chTaRaBCT9q43fsFnc6K4
        s3rX8DEDudbRNs+mdmHsnpBtg6RiaiMITn5u8cZLnyTdvekF38NB5W1UHSMq6ABUhUufS6hB33SMZ
        ctnWPCE3nuSgJMMNS+P/PhFhPyLzwRXTt49KswKmLOfjeYultf/24BrM/anoBh5phDkROXGiMM2ic
        NLleO8FcspojXqAPxo+UL357MY6Qs+GV7eh6uJWlCjCct4Pv8OkWhnHM5A4FFML3TR3se16FJRCVQ
        Tbl2t/MPw==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9XTy-0001uQ-8F; Sun, 15 Sep 2019 16:34:38 +0000
To:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: pci: endpoint test BUG
Message-ID: <5d9eda26-fb92-063e-f84d-7dfafe5d6b29@infradead.org>
Date:   Sun, 15 Sep 2019 09:34:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kernel is 5.3-rc8 on x86_64.

Loading and removing the pci-epf-test module causes a BUG.


[40928.435755] calling  pci_epf_test_init+0x0/0x1000 [pci_epf_test] @ 12132
[40928.436717] initcall pci_epf_test_init+0x0/0x1000 [pci_epf_test] returned 0 after 891 usecs
[40936.996081] ==================================================================
[40936.996125] BUG: KASAN: use-after-free in pci_epf_remove_cfs+0x1ae/0x1f0
[40936.996153] Write of size 8 at addr ffff88810a22a068 by task rmmod/12139

[40936.996193] CPU: 2 PID: 12139 Comm: rmmod Not tainted 5.3.0-rc8 #3
[40936.996217] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[40936.996247] Call Trace:
[40936.996265]  dump_stack+0x7b/0xb5
[40936.996288]  print_address_description+0x6e/0x470
[40936.996316]  __kasan_report+0x11a/0x198
[40936.996337]  ? pci_epf_remove_cfs+0x1ae/0x1f0
[40936.996362]  ? pci_epf_remove_cfs+0x1ae/0x1f0
[40936.996384]  kasan_report+0x12/0x20
[40936.996404]  __asan_report_store8_noabort+0x17/0x20
[40936.996427]  pci_epf_remove_cfs+0x1ae/0x1f0
[40936.996452]  pci_epf_unregister_driver+0xd/0x20
[40936.996476]  pci_epf_test_exit+0x10/0x19 [pci_epf_test]
[40936.996500]  __x64_sys_delete_module+0x329/0x490
[40936.996523]  ? __ia32_sys_delete_module+0x490/0x490
[40936.996549]  ? _raw_spin_unlock_irq+0x22/0x40
[40936.996582]  do_syscall_64+0xaa/0x380
[40936.996601]  ? prepare_exit_to_usermode+0xad/0x1b0
[40936.996625]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[40936.996648] RIP: 0033:0x7fb84c88d187
[40936.996667] Code: 73 01 c3 48 8b 0d 11 ad 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 ac 2b 00 f7 d8 64 89 01 48
[40936.996724] RSP: 002b:00007ffc1c5c7b38 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[40936.996753] RAX: ffffffffffffffda RBX: 00007ffc1c5c7b98 RCX: 00007fb84c88d187
[40936.996780] RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000556838f1c7d8
[40936.996806] RBP: 0000556838f1c770 R08: 00007ffc1c5c6ab1 R09: 0000000000000000
[40936.996833] R10: 00007fb84c8fc5e0 R11: 0000000000000206 R12: 00007ffc1c5c7d60
[40936.996859] R13: 00007ffc1c5c975c R14: 0000556838f1c260 R15: 0000556838f1c770

[40936.996910] Allocated by task 12132:
[40936.996929]  save_stack+0x21/0x90
[40936.996947]  __kasan_kmalloc.constprop.8+0xa7/0xd0
[40936.996968]  kasan_kmalloc+0x9/0x10
[40936.996988]  configfs_register_default_group+0x63/0xe0
[40936.997010]  pci_ep_cfs_add_epf_group+0x20/0x50
[40936.997031]  __pci_epf_register_driver+0x2b2/0x410
[40936.997052]  0xffffffffc1c9004a
[40936.997070]  do_one_initcall+0xab/0x2d5
[40936.997089]  do_init_module+0x1c7/0x582
[40936.997107]  load_module+0x4efa/0x5f30
[40936.997126]  __do_sys_finit_module+0x12a/0x1b0
[40936.997146]  __x64_sys_finit_module+0x6e/0xb0
[40936.997166]  do_syscall_64+0xaa/0x380
[40936.997185]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[40936.997218] Freed by task 12139:
[40936.997235]  save_stack+0x21/0x90
[40936.997253]  __kasan_slab_free+0x137/0x190
[40936.997281]  kasan_slab_free+0xe/0x10
[40936.997301]  kfree+0xb8/0x210
[40936.997320]  configfs_unregister_default_group+0x15/0x20
[40936.997344]  pci_ep_cfs_remove_epf_group+0x17/0x20
[40936.997367]  pci_epf_remove_cfs+0x8e/0x1f0
[40936.997389]  pci_epf_unregister_driver+0xd/0x20
[40936.997419]  pci_epf_test_exit+0x10/0x19 [pci_epf_test]
[40936.997441]  __x64_sys_delete_module+0x329/0x490
[40936.997462]  do_syscall_64+0xaa/0x380
[40936.997480]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[40936.997513] The buggy address belongs to the object at ffff88810a229fe8
                which belongs to the cache kmalloc-192 of size 192
[40936.997557] The buggy address is located 128 bytes inside of
                192-byte region [ffff88810a229fe8, ffff88810a22a0a8)
[40936.997597] The buggy address belongs to the page:
[40936.997619] page:ffffea0004288a00 refcount:1 mapcount:0 mapping:ffff888107c10f40 index:0x0 compound_mapcount: 0
[40936.997655] flags: 0x17ffc000010200(slab|head)
[40936.997677] raw: 0017ffc000010200 ffffea0004992e08 ffff888107c036b0 ffff888107c10f40
[40936.997706] raw: 0000000000000000 00000000001e001e 00000001ffffffff 0000000000000000
[40936.997734] page dumped because: kasan: bad access detected

[40936.997767] Memory state around the buggy address:
[40936.997789]  ffff88810a229f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[40936.997816]  ffff88810a229f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fb fb fb
[40936.997843] >ffff88810a22a000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[40936.997869]                                                           ^
[40936.997895]  ffff88810a22a080: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
[40936.997922]  ffff88810a22a100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[40936.997948] ==================================================================


-- 
~Randy
