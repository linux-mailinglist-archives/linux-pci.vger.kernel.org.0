Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340747DF7E6
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 17:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKBQqH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 12:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQqG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 12:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8705136
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698943514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4pGcLJaNBwC1v+KjQOvj58B3m9mcip1YfSO+mB8Da10=;
        b=Hnbrk5G1ld1M6LvIEnirWb/01BWb3ORJQ3aAbuA/Mxu/aAWouC+Fpmgze1oxGcFc4Gec87
        ybcpuYK5OH5QSVL2NoFdMJY1bZ4d940HRARyk7YoTzxCqqdb9zrLTJMMrebUwQe/kYZj4N
        g6p/Pg0HZ3a3T6Cmroa96FZWyAGzovw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-fbtGQcVdODC0TzW8HEVWgg-1; Thu, 02 Nov 2023 12:45:13 -0400
X-MC-Unique: fbtGQcVdODC0TzW8HEVWgg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso91378766b.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Nov 2023 09:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698943512; x=1699548312;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4pGcLJaNBwC1v+KjQOvj58B3m9mcip1YfSO+mB8Da10=;
        b=GmeoSBshWT1ASyZRIPf9nhjXHM1QcLBmwbo4h+QjIOzS+RUqe1I9w0W3MelX/4GFdm
         7XDFhHBGhndJrCIDpVza15dI1bqfPFmOSCqlkbh74hP0piFBaOGWgl03sFDv4/NxQIt4
         flHuv8arpmZl+zNMoIbxIvrE61AURQRpLJ6SlRhkQf6hRJCN7uJNqEQGIOlPUOWw7yPU
         UuKPXDNYoCP0cFb6aMfn880Po1KTd4wIU2TehLvnUCyZwaz6aOODMGlw8A5op8lsFR2z
         vAGDX3qjfuuLRNKRa9VHbFwqpwfyJApt9mLwxHKpMbbbcvivQSfiGZc8Ij2SmmHHKZh8
         iL3w==
X-Gm-Message-State: AOJu0Yx9fO+Kp+06sV08hNyWol1mQfXa4jlprMZIw7hfVO0HihPLwZZx
        clg063TNFxcVyEJvCKAeHwBIdQlVDbQ7SSIdojHqr/Lgjhsy62rELkGRg3ChlirgnFubH+wsZON
        ZwA2EBYoxS7XR1z0m3suSOQ0Qo/DZ
X-Received: by 2002:a17:906:da8a:b0:9d1:6780:fb31 with SMTP id xh10-20020a170906da8a00b009d16780fb31mr5110578ejb.38.1698943511918;
        Thu, 02 Nov 2023 09:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMZgTElgawO9Ng46nlhG6CbCbtQYOk2fZuKGOAMAjvWFks9kNl8nR74y+xW6X+ay3B70nbFw==
X-Received: by 2002:a17:906:da8a:b0:9d1:6780:fb31 with SMTP id xh10-20020a170906da8a00b009d16780fb31mr5110567ejb.38.1698943511604;
        Thu, 02 Nov 2023 09:45:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kb21-20020a1709070f9500b009aa292a2df2sm1335394ejc.217.2023.11.02.09.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 09:45:11 -0700 (PDT)
Message-ID: <324caf3c-1f3a-68f1-95ee-ba682cf71c01@redhat.com>
Date:   Thu, 2 Nov 2023 17:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, nl
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: v6.6 lockdep splat about locking pci_bus_sem twice
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

When testing the 6.6 kernel release with lockdep
enabled on a Dell Latitude 9420 laptop, I got
the below lockdep warning.

I'm happy to test any patches to address this.

[    2.973360] pci 10000:e0:06.0: BAR 14: assigned [mem 0xbc000000-0xbc0fffff]
[    2.973365] pci 10000:e0:06.0: BAR 13: no space for [io  size 0x1000]
[    2.973367] pci 10000:e0:06.0: BAR 13: failed to assign [io  size 0x1000]
[    2.973370] pci 10000:e1:00.0: BAR 0: assigned [mem 0xbc000000-0xbc003fff 64bit]
[    2.973381] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    2.973385] pci 10000:e0:06.0:   bridge window [mem 0xbc000000-0xbc0fffff]
[    2.973407] ============================================
[    2.973409] WARNING: possible recursive locking detected
[    2.973411] 6.6.0+ #118 Not tainted
[    2.973413] --------------------------------------------
[    2.973415] (udev-worker)/425 is trying to acquire lock:
[    2.973417] ffffffffb5ec8830 (pci_bus_sem){++++}-{3:3}, at: pci_enable_link_state+0x77/0x1b0
[    2.973426] 
               but task is already holding lock:
[    2.973428] ffffffffb5ec8830 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x25/0x90
[    2.973433] 
               other info that might help us debug this:
[    2.973436]  Possible unsafe locking scenario:

[    2.973438]        CPU0
[    2.973439]        ----
[    2.973440]   lock(pci_bus_sem);
[    2.973442]   lock(pci_bus_sem);
[    2.973443] 
                *** DEADLOCK ***

[    2.973445]  May be due to missing lock nesting notation

[    2.973448] 2 locks held by (udev-worker)/425:
[    2.973450]  #0: ffff88810279d1a8 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xc7/0x1c0
[    2.973456]  #1: ffffffffb5ec8830 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x25/0x90
[    2.973461] 
               stack backtrace:
[    2.973463] CPU: 6 PID: 425 Comm: (udev-worker) Not tainted 6.6.0+ #118
[    2.973466] Hardware name: Dell Inc. Latitude 9420/, BIOS 1.23.0 07/10/2023
[    2.973469] Call Trace:
[    2.973471]  <TASK>
[    2.973472]  dump_stack_lvl+0x57/0x90
[    2.973477]  __lock_acquire+0x1272/0x2190
[    2.973482]  lock_acquire+0xc4/0x290
[    2.973485]  ? pci_enable_link_state+0x77/0x1b0
[    2.973489]  down_read+0x3e/0x190
[    2.973493]  ? pci_enable_link_state+0x77/0x1b0
[    2.973496]  pci_enable_link_state+0x77/0x1b0
[    2.973500]  ? __pfx_vmd_pm_enable_quirk+0x10/0x10 [vmd]
[    2.973505]  vmd_pm_enable_quirk+0x24/0xa0 [vmd]
[    2.973510]  ? down_read+0x48/0x190
[    2.973512]  pci_walk_bus+0x6f/0x90
[    2.973515]  vmd_probe+0x7e9/0xa40 [vmd]
[    2.973520]  local_pci_probe+0x3e/0x90
[    2.973523]  pci_device_probe+0xb3/0x210
[    2.973527]  really_probe+0x19b/0x3e0
[    2.973529]  ? __pfx___driver_attach+0x10/0x10
[    2.973532]  __driver_probe_device+0x78/0x160
[    2.973535]  driver_probe_device+0x1f/0x90
[    2.973537]  __driver_attach+0xd2/0x1c0
[    2.973540]  bus_for_each_dev+0x63/0xa0
[    2.973543]  bus_add_driver+0x115/0x210
[    2.973546]  driver_register+0x55/0x100
[    2.973548]  ? __pfx_vmd_drv_init+0x10/0x10 [vmd]
[    2.973553]  do_one_initcall+0x5a/0x360
[    2.973557]  ? rcu_is_watching+0xd/0x40
[    2.973561]  ? kmalloc_trace+0xa5/0xb0
[    2.973565]  do_init_module+0x60/0x230
[    2.973569]  __do_sys_init_module+0x16a/0x1a0
[    2.973571]  ? __seccomp_filter+0x320/0x510
[    2.973577]  do_syscall_64+0x59/0x90
[    2.973580]  ? do_user_addr_fault+0x366/0x830
[    2.973584]  ? exc_page_fault+0xf1/0x200
[    2.973588]  ? asm_exc_page_fault+0x22/0x30
[    2.973592]  ? lockdep_hardirqs_on+0x7d/0x100
[    2.973594]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[    2.973597] RIP: 0033:0x7f84bedcf7fe
[    2.973600] Code: 48 8b 0d 35 16 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 16 0c 00 f7 d8 64 89 01 48
[    2.973606] RSP: 002b:00007fff04d64ea8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[    2.973609] RAX: ffffffffffffffda RBX: 000055589fb73360 RCX: 00007f84bedcf7fe
[    2.973612] RDX: 00007f84beed507d RSI: 000000000000a3b9 RDI: 00005558a037de70
[    2.973614] RBP: 00007fff04d64f60 R08: 000055589fb44010 R09: 0000000000000007
[    2.973617] R10: 0000000000000002 R11: 0000000000000246 R12: 00007f84beed507d
[    2.973619] R13: 0000000000020000 R14: 000055589fb6c760 R15: 000055589fb74c70
[    2.973623]  </TASK>
[    2.974292] pci 10000:e1:00.0: VMD: Default LTR value set by driver

Regards,

Hans



