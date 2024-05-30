Return-Path: <linux-pci+bounces-8094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7E8D5211
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 21:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFB41F22E45
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C960DE9;
	Thu, 30 May 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkLVrvg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5406A332
	for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096042; cv=none; b=kPtIP9VH8gxMnwWkfULbpsfRtOxEaXEqcMzE1tpOMeremDmCr91iQ93Zb68p+yp5UUZ/+cPqZrJ00kYct7vwYonmsMlYQXISLI1b2bDJY4EC06UlDWB/6tGxba+hRYNc4tKhnpTAbrCzqkSVILq8rOMk4e/QZOdRnmL72U+U+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096042; c=relaxed/simple;
	bh=h99lmxSX/Nh1R8TVRd/8sWVXD825rROdrbQn7CRd1fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE7aCm1WDryrGDGs9UyrZJGT1XiGNoTJ64S7+bSt+nbGG0cYI6fc6uxl4wJ2mO4XzOlMsqe7BXPHzE5oUfXSV109QnPkYEb+NXuL75WmCV8rp95IvRZ/ONC8wekGqGgq4VPSc1df4gESuwjmCiRCLwX1nVK1/DJCB8xlJRJJwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkLVrvg+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717096038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQHTPeBwfG0o0ecfsz243f1zhg0gnrQUm/0eRKd+ehI=;
	b=EkLVrvg+DLY4pL5IUT87fMByJRakLK2UbmlHtTD6N4H7OXUtVjHRGzPMxNH/9Ig/G0hEon
	sVJUlneNWpxzm1+0FODcQUJEVQyEhUU6pFX7cP3LTiX8YCozDWDXI32LMhPoy6VlHJSIEz
	U2tOmx8Z8YJ6TQ63xZK+8XOElujEySY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-BBI-QHpONFGR9eMGMitfwg-1; Thu, 30 May 2024 15:07:16 -0400
X-MC-Unique: BBI-QHpONFGR9eMGMitfwg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6265d3cb79so61034566b.0
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 12:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717096034; x=1717700834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQHTPeBwfG0o0ecfsz243f1zhg0gnrQUm/0eRKd+ehI=;
        b=C0dqPAQLt6pj+FheQMLHLH6+6QQ0aA1yoYUfpJy5EzpvNg4vtpHwF8Dm/z9WKtUoDY
         9BWiT+0g4BN0x+T5XYoOclhQP9hRlWv8kY3MedjBgeSrjucNh3WHmLMk0av5gzly8J+N
         1Xyz3q0KIUwEL9Z1euwrxfgvyoNeX5lBs1RCP0/5ij7l+DKV3zf/JbT/TtfX2id8XHrk
         KBhSI6liugerbBqcjb5B3/VUC2/pZq97JdllajV3gJEEPsXsRJqwKXBrx9BA7ElyRaLn
         Jj5t7J4P0ZP0ukc3O6urYLgqxMN4/d/9SM7ninOc66mgOaS4CXdTow9YA4IDFETk/G4y
         5z5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6/99JTR5Bltq5azkC5h0KkaXWIDanNsu3EIrfOnPb0ExVb8qVcYMI4e6ZchH/RoVgZ12f5ZQZMsSN8xaEEc08FH2AQW2x+zd4
X-Gm-Message-State: AOJu0YxTfJftJsOJlmkvnR2EfjuA/YKeN8p1wyRN2wZC5Fmq20L2l6ce
	M2XdNiKDfzL/TEcpXVSID1CqYI+j6kBjf+Fh08yDnUg+n1BCijzvl7gazHKUlLpLWhDDBkwW5NT
	XPJ0vGbuoKXQmZNFVzKYuKvYMXUkfB7lZ4ZhlC095fnygq99zLfbxZ8NXr0eRzJCg7Q==
X-Received: by 2002:a17:906:a883:b0:a59:d5e4:1487 with SMTP id a640c23a62f3a-a65e8e7a244mr284709566b.42.1717096033674;
        Thu, 30 May 2024 12:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZA/uqvQpjYkz5324RE9sJnX7SYK+AfpcPM7GBm9D5q4/swM2YlVXOituJbW1J1ClMvx0tpw==
X-Received: by 2002:a17:906:a883:b0:a59:d5e4:1487 with SMTP id a640c23a62f3a-a65e8e7a244mr284706866b.42.1717096032937;
        Thu, 30 May 2024 12:07:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73f9a63sm5816866b.68.2024.05.30.12.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 12:07:11 -0700 (PDT)
Message-ID: <d606330a-1280-4399-bce3-3aac1e1de0dc@redhat.com>
Date: Thu, 30 May 2024 21:07:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI core lockdep warning with 6.10-rc1 on Dell XPS 13 plus 9320
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux PCI
 <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
References: <20240528222143.GA472908@bhelgaas>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240528222143.GA472908@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 5/29/24 12:21 AM, Bjorn Helgaas wrote:
> On Tue, May 28, 2024 at 09:02:05PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> While testing 6.10-rc1 on a Dell XPS 13 plus 9320 I noticed the following PCI lockdep warnings:
> 
> Thanks for the report!  I think/hope this is the same as
> 
>   https://lore.kernel.org/r/171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com
> 
> which is queued on pci/for-linus.  Let me know if you still see it
> with that patch.

So I have tried with both related fixes from pci/for-linus added to 6.10.0-rc1+,
unfortunately this does not fix things.

Note my original logs contained 2 stack-traces, which I now realize might
be 2 different issues:

1) The lock_map_assert_held(&dev->cfg_access_lock); check in pci_bridge_secondary_bus_reset()
   (drivers/pci/pci.c:4886) triggering because it is called without that lock held

2) A mutex being unlocked while it was not locked, I thought this locking unbalance also
   triggered 1) but I think I was wrong there.

With the 2 fixes from pci/for-linus added to 6.10.0-rc1+, 1) still happens and
2) is replaced with a lockdep warning about circular locking now. So we still
have 2 issues and 1) is unchanged.

Here are the new logs of 6.10.0-rc1 with the 2 fixes from pci/for-linus. I'm leaving
the old logs without the fixes in place further below in for reference.

[    5.453328] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    5.453334] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    5.453337] pci_bus 10000:e0: root bus resource [mem 0x72000000-0x73ffffff]
[    5.453339] pci_bus 10000:e0: root bus resource [mem 0x6040102000-0x60401fffff 64bit]
[    5.453412] pci 10000:e0:06.0: [8086:a74d] type 01 class 0x060400 PCIe Root Port
[    5.453432] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    5.453437] pci 10000:e0:06.0:   bridge window [io  0x0000-0x0fff]
[    5.453440] pci 10000:e0:06.0:   bridge window [mem 0x72000000-0x720fffff]
[    5.453502] pci 10000:e0:06.0: PME# supported from D0 D3hot D3cold
[    5.453535] pci 10000:e0:06.0: PTM enabled (root), 4ns granularity
[    5.455661] pci 10000:e0:06.0: Adding to iommu group 10
[    5.455801] pci 10000:e0:06.0: Primary bus is hard wired to 0
[    5.456085] pci 10000:e1:00.0: [15b7:5011] type 00 class 0x010802 PCIe Endpoint
[    5.456105] pci 10000:e1:00.0: BAR 0 [mem 0x72000000-0x72003fff 64bit]
[    5.457103] pci 10000:e1:00.0: Adding to iommu group 10
[    5.457229] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    5.457239] pci 10000:e0:06.0: Primary bus is hard wired to 0
[    5.548783] input: VEN_04F3:00 04F3:31D1 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input5
[    5.549356] input: VEN_04F3:00 04F3:31D1 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input6
[    5.549625] input: VEN_04F3:00 04F3:31D1 as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input8
[    5.550145] hid-generic 0018:04F3:31D1.0001: input,hidraw0: I2C HID v1.00 Mouse [VEN_04F3:00 04F3:31D1] on i2c-VEN_04F3:00
[    5.575726] ------------[ cut here ]------------
[    5.575735] WARNING: CPU: 4 PID: 529 at drivers/pci/pci.c:4886 pci_reset_bus+0x38d/0x3a0
[    5.575740] Modules linked in: hid_multitouch(+) sha512_ssse3 sha256_ssse3 sha1_ssse3 typec dw_dmac intel_ishtp cec vmd(+) i2c_hid_acpi i2c_hid wmi pinctrl_tigerlake serio_raw ip6_tables ip_tables i2c_dev fuse
[    5.575755] CPU: 4 PID: 529 Comm: (udev-worker) Not tainted 6.10.0-rc1+ #94
[    5.575757] Hardware name: Dell Inc. XPS 9320/01YN3R, BIOS 2.11.0 03/06/2024
[    5.575758] RIP: 0010:pci_reset_bus+0x38d/0x3a0
[    5.575760] Code: 39 34 ff ff 4c 89 e7 e8 31 06 7c 00 e9 29 fe ff ff 48 8d bb d0 09 00 00 be ff ff ff ff e8 eb fd 7a 00 85 c0 0f 85 3d fd ff ff <0f> 0b e9 36 fd ff ff 41 bc e7 ff ff ff e9 9f fc ff ff 90 90 90 90
[    5.575762] RSP: 0018:ffffad54039cbb30 EFLAGS: 00010246
[    5.575765] RAX: 0000000000000000 RBX: ffffa03e02098000 RCX: 0000000000000001
[    5.575766] RDX: 0000000000000000 RSI: ffffffffa59cc0d7 RDI: ffffffffa5a043c0
[    5.575767] RBP: ffffa03e0f775028 R08: 0000000000000001 R09: 0000000000000000
[    5.575768] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000020
[    5.575770] R13: ffffa03e0f775000 R14: 000000000000007f R15: 0000000000000630
[    5.575771] FS:  00007effdeb4d980(0000) GS:ffffa0456f200000(0000) knlGS:0000000000000000
[    5.575772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.575774] CR2: 00007f1eeb16cc58 CR3: 000000011051a000 CR4: 0000000000750ef0
[    5.575775] PKRU: 55555554
[    5.575776] Call Trace:
[    5.575778]  <TASK>
[    5.575779]  ? __warn.cold+0xb1/0x13e
[    5.575782]  ? pci_reset_bus+0x38d/0x3a0
[    5.575784]  ? report_bug+0xe6/0x170
[    5.575788]  ? handle_bug+0x3c/0x80
[    5.575799]  ? exc_invalid_op+0x13/0x60
[    5.575801]  ? asm_exc_invalid_op+0x16/0x20
[    5.575808]  ? pci_reset_bus+0x38d/0x3a0
[    5.575811]  vmd_probe+0x760/0xa30 [vmd]
[    5.575818]  local_pci_probe+0x3e/0x80
[    5.575821]  pci_device_probe+0xaf/0x250
[    5.575825]  really_probe+0xdb/0x340
[    5.575827]  ? pm_runtime_barrier+0x50/0x90
[    5.575830]  ? __pfx___driver_attach+0x10/0x10
[    5.575832]  __driver_probe_device+0x78/0x110
[    5.575835]  driver_probe_device+0x1f/0xa0
[    5.575837]  __driver_attach+0xba/0x1c0
[    5.575840]  bus_for_each_dev+0x68/0xb0
[    5.575844]  bus_add_driver+0x111/0x1f0
[    5.575846]  driver_register+0x6e/0xc0
[    5.575849]  ? __pfx_vmd_drv_init+0x10/0x10 [vmd]
[    5.575851]  do_one_initcall+0x5b/0x3a0
[    5.575854]  ? rcu_is_watching+0xd/0x40
[    5.575856]  ? kmalloc_trace_noprof+0x25c/0x320
[    5.575862]  do_init_module+0x60/0x220
[    5.575865]  __do_sys_init_module+0x15f/0x190
[    5.575872]  do_syscall_64+0x93/0x180
[    5.575875]  ? do_user_addr_fault+0x392/0x710
[    5.575877]  ? exc_page_fault+0x126/0x260
[    5.575881]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.575884] RIP: 0033:0x7effdf51d57e
[    5.575887] Code: 48 8b 0d 9d 98 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a 98 0c 00 f7 d8 64 89 01 48
[    5.575888] RSP: 002b:00007ffc32c52ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[    5.575890] RAX: ffffffffffffffda RBX: 00005599a037a580 RCX: 00007effdf51d57e
[    5.575891] RDX: 00007effdf63507d RSI: 000000000000a509 RDI: 00005599a0388f90
[    5.575892] RBP: 00007ffc32c52da0 R08: 00005599a034b010 R09: 0000000000000007
[    5.575894] R10: 0000000000000003 R11: 0000000000000246 R12: 00007effdf63507d
[    5.575895] R13: 0000000000020000 R14: 00005599a037b3b0 R15: 00005599a037c6a0
[    5.575900]  </TASK>
[    5.575901] irq event stamp: 29433
[    5.575903] hardirqs last  enabled at (29439): [<ffffffffa41bdead>] console_unlock+0x10d/0x140
[    5.575906] hardirqs last disabled at (29444): [<ffffffffa41bde92>] console_unlock+0xf2/0x140
[    5.575908] softirqs last  enabled at (28964): [<ffffffffa41177bd>] __irq_exit_rcu+0x9d/0x100
[    5.575910] softirqs last disabled at (28957): [<ffffffffa41177bd>] __irq_exit_rcu+0x9d/0x100
[    5.575912] ---[ end trace 0000000000000000 ]---
[    5.596838] input: LXT2021:00 29BD:3303 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-LXT2021:00/0018:29BD:3303.0002/input/input9
[    5.619910] hid-multitouch 0018:29BD:3303.0002: input,hidraw1: I2C HID v1.00 Device [LXT2021:00 29BD:3303] on i2c-LXT2021:00
[    5.642977] pxa2xx-spi pxa2xx-spi.3: no DMA channels available, using PIO
[    5.651149] input: VEN_04F3:00 04F3:31D1 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input11
[    5.651967] input: VEN_04F3:00 04F3:31D1 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input12
[    5.652376] input: VEN_04F3:00 04F3:31D1 UNKNOWN as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input14
[    5.652948] hid-multitouch 0018:04F3:31D1.0001: input,hidraw0: I2C HID v1.00 Mouse [VEN_04F3:00 04F3:31D1] on i2c-VEN_04F3:00

[    5.741813] fbcon: Taking over console
[    5.741820] ======================================================
[    5.741824] WARNING: possible circular locking dependency detected
[    5.741828] 6.10.0-rc1+ #94 Tainted: G        W         
[    5.741832] ------------------------------------------------------
[    5.741835] (udev-worker)/529 is trying to acquire lock:
[    5.741839] ffffffffa60cd858 (pci_lock){....}-{2:2}, at: pci_cfg_access_unlock+0x16/0x70
[    5.741855] 
               but task is already holding lock:
[    5.741859] ffffa03e0fae19d0 (&dev->cfg_access_lock){+.+.}-{0:0}, at: pci_cfg_access_trylock+0x49/0x80
[    5.741868] 
               which lock already depends on the new lock.

[    5.741872] 
               the existing dependency chain (in reverse order) is:
[    5.741877] 
               -> #1 (&dev->cfg_access_lock){+.+.}-{0:0}:
[    5.741883]        pci_cfg_access_trylock+0x6b/0x80
[    5.741889]        pci_bus_trylock+0xaa/0x100
[    5.741894]        pci_reset_bus+0x6f/0x3a0
[    5.741897]        vmd_probe+0x760/0xa30 [vmd]
[    5.741904]        local_pci_probe+0x3e/0x80
[    5.741908]        pci_device_probe+0xaf/0x250
[    5.741912]        really_probe+0xdb/0x340
[    5.741917]        __driver_probe_device+0x78/0x110
[    5.741922]        driver_probe_device+0x1f/0xa0
[    5.741926]        __driver_attach+0xba/0x1c0
[    5.741930]        bus_for_each_dev+0x68/0xb0
[    5.741935]        bus_add_driver+0x111/0x1f0
[    5.741938]        driver_register+0x6e/0xc0
[    5.741943]        do_one_initcall+0x5b/0x3a0
[    5.741948]        do_init_module+0x60/0x220
[    5.741952]        __do_sys_init_module+0x15f/0x190
[    5.741957]        do_syscall_64+0x93/0x180
[    5.741962]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.741968] 
               -> #0 (pci_lock){....}-{2:2}:
[    5.741975]        __lock_acquire+0x11c6/0x1f20
[    5.741979]        lock_acquire+0xc8/0x2b0
[    5.741982]        _raw_spin_lock_irqsave+0x47/0x70
[    5.741987]        pci_cfg_access_unlock+0x16/0x70
[    5.741992]        pci_reset_bus+0x132/0x3a0
[    5.741996]        vmd_probe+0x760/0xa30 [vmd]
[    5.742000]        local_pci_probe+0x3e/0x80
[    5.742004]        pci_device_probe+0xaf/0x250
[    5.742008]        really_probe+0xdb/0x340
[    5.742012]        __driver_probe_device+0x78/0x110
[    5.742016]        driver_probe_device+0x1f/0xa0
[    5.742021]        __driver_attach+0xba/0x1c0
[    5.742025]        bus_for_each_dev+0x68/0xb0
[    5.742029]        bus_add_driver+0x111/0x1f0
[    5.742033]        driver_register+0x6e/0xc0
[    5.742037]        do_one_initcall+0x5b/0x3a0
[    5.742041]        do_init_module+0x60/0x220
[    5.742046]        __do_sys_init_module+0x15f/0x190
[    5.742050]        do_syscall_64+0x93/0x180
[    5.742054]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.742060] 
               other info that might help us debug this:

[    5.742064]  Possible unsafe locking scenario:

[    5.742068]        CPU0                    CPU1
[    5.742071]        ----                    ----
[    5.742074]   lock(&dev->cfg_access_lock);
[    5.742078]                                lock(pci_lock);
[    5.742082]                                lock(&dev->cfg_access_lock);
[    5.742088]   lock(pci_lock);
[    5.742091] 
                *** DEADLOCK ***

[    5.742095] 3 locks held by (udev-worker)/529:
[    5.742098]  #0: ffffa03e0388e1b0 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xaf/0x1c0
[    5.742108]  #1: ffffa03e0fae11b0 (&dev->mutex){....}-{3:3}, at: pci_bus_trylock+0x2b/0x100
[    5.742116]  #2: ffffa03e0fae19d0 (&dev->cfg_access_lock){+.+.}-{0:0}, at: pci_cfg_access_trylock+0x49/0x80
[    5.742126] 
               stack backtrace:
[    5.742130] CPU: 6 PID: 529 Comm: (udev-worker) Tainted: G        W          6.10.0-rc1+ #94
[    5.742137] Hardware name: Dell Inc. XPS 9320/01YN3R, BIOS 2.11.0 03/06/2024
[    5.742142] Call Trace:
[    5.742145]  <TASK>
[    5.742147]  dump_stack_lvl+0x68/0x90
[    5.742152]  check_noncircular+0x10d/0x120
[    5.742158]  ? lock_acquire+0xc8/0x2b0
[    5.742163]  __lock_acquire+0x11c6/0x1f20
[    5.742169]  lock_acquire+0xc8/0x2b0
[    5.742172]  ? pci_cfg_access_unlock+0x16/0x70
[    5.742178]  ? _raw_spin_lock_irqsave+0x5f/0x70
[    5.742183]  _raw_spin_lock_irqsave+0x47/0x70
[    5.742188]  ? pci_cfg_access_unlock+0x16/0x70
[    5.742193]  pci_cfg_access_unlock+0x16/0x70
[    5.742197]  pci_reset_bus+0x132/0x3a0
[    5.742202]  vmd_probe+0x760/0xa30 [vmd]
[    5.742209]  local_pci_probe+0x3e/0x80
[    5.742214]  pci_device_probe+0xaf/0x250
[    5.742219]  really_probe+0xdb/0x340
[    5.742223]  ? pm_runtime_barrier+0x50/0x90
[    5.742228]  ? __pfx___driver_attach+0x10/0x10
[    5.742233]  __driver_probe_device+0x78/0x110
[    5.742237]  driver_probe_device+0x1f/0xa0
[    5.742242]  __driver_attach+0xba/0x1c0
[    5.742246]  bus_for_each_dev+0x68/0xb0
[    5.742252]  bus_add_driver+0x111/0x1f0
[    5.742256]  driver_register+0x6e/0xc0
[    5.742261]  ? __pfx_vmd_drv_init+0x10/0x10 [vmd]
[    5.742266]  do_one_initcall+0x5b/0x3a0
[    5.742271]  ? rcu_is_watching+0xd/0x40
[    5.742275]  ? kmalloc_trace_noprof+0x25c/0x320
[    5.742282]  do_init_module+0x60/0x220
[    5.742287]  __do_sys_init_module+0x15f/0x190
[    5.742294]  do_syscall_64+0x93/0x180
[    5.742299]  ? do_user_addr_fault+0x392/0x710
[    5.742304]  ? exc_page_fault+0x126/0x260
[    5.742310]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.742315] RIP: 0033:0x7effdf51d57e
[    5.742320] Code: 48 8b 0d 9d 98 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a 98 0c 00 f7 d8 64 89 01 48
[    5.742330] RSP: 002b:00007ffc32c52ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[    5.742337] RAX: ffffffffffffffda RBX: 00005599a037a580 RCX: 00007effdf51d57e
[    5.742342] RDX: 00007effdf63507d RSI: 000000000000a509 RDI: 00005599a0388f90
[    5.742347] RBP: 00007ffc32c52da0 R08: 00005599a034b010 R09: 0000000000000007
[    5.742351] R10: 0000000000000003 R11: 0000000000000246 R12: 00007effdf63507d
[    5.742356] R13: 0000000000020000 R14: 00005599a037b3b0 R15: 00005599a037c6a0
[    5.742363]  </TASK>
[    5.742509] pci 10000:e0:06.0: bridge window [mem 0x72000000-0x720fffff]: assigned
[    5.742515] pci 10000:e0:06.0: bridge window [io  size 0x1000]: can't assign; no space
[    5.742518] pci 10000:e0:06.0: bridge window [io  size 0x1000]: failed to assign
[    5.742521] pci 10000:e1:00.0: BAR 0 [mem 0x72000000-0x72003fff 64bit]: assigned
[    5.742531] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    5.742535] pci 10000:e0:06.0:   bridge window [mem 0x72000000-0x720fffff]
[    5.742545] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't have ASPM control
[    5.742579] pcieport 10000:e0:06.0: can't derive routing for PCI INT D
[    5.742581] pcieport 10000:e0:06.0: PCI INT D: no GSI
[    5.742690] pcieport 10000:e0:06.0: PME: Signaling with IRQ 161
[    5.742851] vmd 0000:00:0e.0: Bound to PCI domain 10000

Regards,

Hans



p.s. Here are the old logs of plain 6.10.0-rc1 without the 2 pending fixes:

>> [    5.688969] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
>> [    5.688976] pci_bus 10000:e0: root bus resource [bus e0-ff]
>> [    5.688978] pci_bus 10000:e0: root bus resource [mem 0x72000000-0x73ffffff]
>> [    5.688980] pci_bus 10000:e0: root bus resource [mem 0x6040102000-0x60401fffff 64bit]
>> [    5.689056] pci 10000:e0:06.0: [8086:a74d] type 01 class 0x060400 PCIe Root Port
>> [    5.689074] pci 10000:e0:06.0: PCI bridge to [bus e1]
>> [    5.689079] pci 10000:e0:06.0:   bridge window [io  0x0000-0x0fff]
>> [    5.689081] pci 10000:e0:06.0:   bridge window [mem 0x72000000-0x720fffff]
>> [    5.689141] pci 10000:e0:06.0: PME# supported from D0 D3hot D3cold
>> [    5.689172] pci 10000:e0:06.0: PTM enabled (root), 4ns granularity
>> [    5.690231] pci 10000:e0:06.0: Adding to iommu group 10
>> [    5.690293] pci 10000:e0:06.0: Primary bus is hard wired to 0
>> [    5.690379] pci 10000:e1:00.0: [15b7:5011] type 00 class 0x010802 PCIe Endpoint
>> [    5.690396] pci 10000:e1:00.0: BAR 0 [mem 0x72000000-0x72003fff 64bit]
>> [    5.690691] pci 10000:e1:00.0: Adding to iommu group 10
>> [    5.690962] pci 10000:e0:06.0: PCI bridge to [bus e1]
>> [    5.690971] pci 10000:e0:06.0: Primary bus is hard wired to 0
>> [    5.793802] input: VEN_04F3:00 04F3:31D1 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input5
>> [    5.794265] input: VEN_04F3:00 04F3:31D1 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input6
>> [    5.794529] input: VEN_04F3:00 04F3:31D1 as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input8
>> [    5.795072] hid-generic 0018:04F3:31D1.0001: input,hidraw0: I2C HID v1.00 Mouse [VEN_04F3:00 04F3:31D1] on i2c-VEN_04F3:00
>> [    5.831990] ------------[ cut here ]------------
>> [    5.831999] WARNING: CPU: 7 PID: 539 at drivers/pci/pci.c:4886 pci_reset_bus+0x38d/0x3a0
>> [    5.832005] Modules linked in: sha512_ssse3 sha256_ssse3 hid_multitouch(+) typec_ucsi sha1_ssse3 dw_dmac intel_ishtp cec vmd(+) typec i2c_hid_acpi i2c_hid wmi pinctrl_tigerlake serio_raw ip6_tables ip_tables fuse
>> [    5.832021] CPU: 7 PID: 539 Comm: (udev-worker) Not tainted 6.10.0-rc1+ #21
>> [    5.832023] Hardware name: Dell Inc. XPS 9320/01YN3R, BIOS 2.11.0 03/06/2024
>> [    5.832025] RIP: 0010:pci_reset_bus+0x38d/0x3a0
>> [    5.832027] Code: 29 34 ff ff 4c 89 e7 e8 51 06 7c 00 e9 29 fe ff ff 48 8d bb e0 09 00 00 be ff ff ff ff e8 0b fe 7a 00 85 c0 0f 85 3d fd ff ff <0f> 0b e9 36 fd ff ff 41 bc e7 ff ff ff e9 9f fc ff ff 90 90 90 90
>> [    5.832028] RSP: 0018:ffffac8f839c7af8 EFLAGS: 00010246
>> [    5.832031] RAX: 0000000000000000 RBX: ffff9d24c1fb3000 RCX: 0000000000000001
>> [    5.832033] RDX: 0000000000000000 RSI: ffffffff9e9cc0d4 RDI: ffffffff9ea043bd
>> [    5.832034] RBP: ffff9d24c1faf028 R08: 0000000000000001 R09: 0000000000000000
>> [    5.832036] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000020
>> [    5.832037] R13: ffff9d24c1faf000 R14: 000000000000007f R15: 0000000000000630
>> [    5.832039] FS:  00007f32c2adf980(0000) GS:ffff9d2c2f380000(0000) knlGS:0000000000000000
>> [    5.832041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    5.832042] CR2: 0000557a4c61a130 CR3: 000000010f6c0000 CR4: 0000000000750ef0
>> [    5.832044] PKRU: 55555554
>> [    5.832045] Call Trace:
>> [    5.832046]  <TASK>
>> [    5.832047]  ? __warn.cold+0xb1/0x13e
>> [    5.832051]  ? pci_reset_bus+0x38d/0x3a0
>> [    5.832052]  ? report_bug+0xe6/0x170
>> [    5.832056]  ? handle_bug+0x3c/0x80
>> [    5.832059]  ? exc_invalid_op+0x13/0x60
>> [    5.832062]  ? asm_exc_invalid_op+0x16/0x20
>> [    5.832070]  ? pci_reset_bus+0x38d/0x3a0
>> [    5.832072]  ? pci_reset_bus+0x385/0x3a0
>> [    5.832074]  vmd_probe+0x760/0xa30 [vmd]
>> [    5.832081]  local_pci_probe+0x3e/0x80
>> [    5.832084]  pci_device_probe+0xaf/0x250
>> [    5.832087]  really_probe+0xdb/0x340
>> [    5.832090]  ? pm_runtime_barrier+0x50/0x90
>> [    5.832093]  ? __pfx___driver_attach+0x10/0x10
>> [    5.832095]  __driver_probe_device+0x78/0x110
>> [    5.832099]  driver_probe_device+0x1f/0xa0
>> [    5.832103]  __driver_attach+0xba/0x1c0
>> [    5.832106]  bus_for_each_dev+0x68/0xb0
>> [    5.832110]  bus_add_driver+0x111/0x1f0
>> [    5.832112]  driver_register+0x6e/0xc0
>> [    5.832114]  ? __pfx_vmd_drv_init+0x10/0x10 [vmd]
>> [    5.832117]  do_one_initcall+0x5b/0x3a0
>> [    5.832120]  ? kmalloc_trace_noprof+0x25c/0x320
>> [    5.832125]  do_init_module+0x60/0x220
>> [    5.832128]  __do_sys_init_module+0x15f/0x190
>> [    5.832134]  do_syscall_64+0x93/0x180
>> [    5.832136]  ? do_syscall_64+0x9f/0x180
>> [    5.832138]  ? lockdep_hardirqs_on+0x78/0x100
>> [    5.832141]  ? do_syscall_64+0x9f/0x180
>> [    5.832143]  ? do_syscall_64+0x9f/0x180
>> [    5.832145]  ? do_user_addr_fault+0x392/0x710
>> [    5.832147]  ? exc_page_fault+0x126/0x260
>> [    5.832152]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [    5.832155] RIP: 0033:0x7f32c34af57e
>> [    5.832159] Code: 48 8b 0d 9d 98 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a 98 0c 00 f7 d8 64 89 01 48
>> [    5.832160] RSP: 002b:00007ffe33fbb568 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
>> [    5.832163] RAX: ffffffffffffffda RBX: 000055beacde5da0 RCX: 00007f32c34af57e
>> [    5.832165] RDX: 00007f32c35c707d RSI: 000000000000a509 RDI: 000055beacdf1800
>> [    5.832166] RBP: 00007ffe33fbb620 R08: 000055beacdb4010 R09: 0000000000000007
>> [    5.832167] R10: 0000000000000002 R11: 0000000000000246 R12: 00007f32c35c707d
>> [    5.832168] R13: 0000000000020000 R14: 000055beacde77a0 R15: 000055beacde5e90
>> [    5.832173]  </TASK>
>> [    5.832174] irq event stamp: 25575
>> [    5.832175] hardirqs last  enabled at (25581): [<ffffffff9d1bdead>] console_unlock+0x10d/0x140
>> [    5.832178] hardirqs last disabled at (25586): [<ffffffff9d1bde92>] console_unlock+0xf2/0x140
>> [    5.832180] softirqs last  enabled at (24952): [<ffffffff9d1177bd>] __irq_exit_rcu+0x9d/0x100
>> [    5.832182] softirqs last disabled at (24945): [<ffffffff9d1177bd>] __irq_exit_rcu+0x9d/0x100
>> [    5.832184] ---[ end trace 0000000000000000 ]---
>> [    5.847273] input: LXT2021:00 29BD:3303 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-LXT2021:00/0018:29BD:3303.0002/input/input9
>> [    5.859415] hid-multitouch 0018:29BD:3303.0002: input,hidraw1: I2C HID v1.00 Device [LXT2021:00 29BD:3303] on i2c-LXT2021:00
>> [    5.875251] pxa2xx-spi pxa2xx-spi.3: no DMA channels available, using PIO
>> [    5.890877] input: VEN_04F3:00 04F3:31D1 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input11
>> [    5.891185] input: VEN_04F3:00 04F3:31D1 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input12
>> [    5.891354] input: VEN_04F3:00 04F3:31D1 UNKNOWN as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-VEN_04F3:00/0018:04F3:31D1.0001/input/input14
>> [    5.891535] hid-multitouch 0018:04F3:31D1.0001: input,hidraw0: I2C HID v1.00 Mouse [VEN_04F3:00 04F3:31D1] on i2c-VEN_04F3:00
>>
>> [    5.998855] fbcon: Taking over console
>> [    5.998863] =====================================
>> [    5.998866] WARNING: bad unlock balance detected!
>> [    5.998869] 6.10.0-rc1+ #21 Tainted: G        W         
>> [    5.998873] -------------------------------------
>> [    5.998876] (udev-worker)/539 is trying to release lock (10000:e1:00.0) at:
>> [    5.998883] [<ffffffff9d964db8>] pci_cfg_access_unlock+0x58/0x70
>> [    5.998892] but there are no more locks to release!
>> [    5.998894] 
>>                other info that might help us debug this:
>> [    5.998898] 2 locks held by (udev-worker)/539:
>> [    5.998901]  #0: ffff9d24c36ee1b0 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xaf/0x1c0
>> [    5.998911]  #1: ffff9d24c1fb11b0 (&dev->mutex){....}-{3:3}, at: pci_bus_trylock+0x2b/0x100
>> [    5.998920] 
>>                stack backtrace:
>> [    5.998924] CPU: 12 PID: 539 Comm: (udev-worker) Tainted: G        W          6.10.0-rc1+ #21
>> [    5.998930] Hardware name: Dell Inc. XPS 9320/01YN3R, BIOS 2.11.0 03/06/2024
>> [    5.998934] Call Trace:
>> [    5.998937]  <TASK>
>> [    5.998940]  dump_stack_lvl+0x68/0x90
>> [    5.998945]  ? pci_cfg_access_unlock+0x58/0x70
>> [    5.998951]  lock_release.cold+0x21/0x2e
>> [    5.998958]  pci_reset_bus+0x132/0x3a0
>> [    5.998962]  vmd_probe+0x760/0xa30 [vmd]
>> [    5.998971]  local_pci_probe+0x3e/0x80
>> [    5.998975]  pci_device_probe+0xaf/0x250
>> [    5.998981]  really_probe+0xdb/0x340
>> [    5.998985]  ? pm_runtime_barrier+0x50/0x90
>> [    5.998990]  ? __pfx___driver_attach+0x10/0x10
>> [    5.998994]  __driver_probe_device+0x78/0x110
>> [    5.998999]  driver_probe_device+0x1f/0xa0
>> [    5.999004]  __driver_attach+0xba/0x1c0
>> [    5.999008]  bus_for_each_dev+0x68/0xb0
>> [    5.999014]  bus_add_driver+0x111/0x1f0
>> [    5.999019]  driver_register+0x6e/0xc0
>> [    5.999023]  ? __pfx_vmd_drv_init+0x10/0x10 [vmd]
>> [    5.999029]  do_one_initcall+0x5b/0x3a0
>> [    5.999034]  ? kmalloc_trace_noprof+0x25c/0x320
>> [    5.999041]  do_init_module+0x60/0x220
>> [    5.999047]  __do_sys_init_module+0x15f/0x190
>> [    5.999054]  do_syscall_64+0x93/0x180
>> [    5.999059]  ? do_syscall_64+0x9f/0x180
>> [    5.999063]  ? lockdep_hardirqs_on+0x78/0x100
>> [    5.999069]  ? do_syscall_64+0x9f/0x180
>> [    5.999073]  ? do_syscall_64+0x9f/0x180
>> [    5.999077]  ? do_user_addr_fault+0x392/0x710
>> [    5.999081]  ? exc_page_fault+0x126/0x260
>> [    5.999087]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [    5.999094] RIP: 0033:0x7f32c34af57e
>> [    5.999099] Code: 48 8b 0d 9d 98 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a 98 0c 00 f7 d8 64 89 01 48
>> [    5.999109] RSP: 002b:00007ffe33fbb568 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
>> [    5.999115] RAX: ffffffffffffffda RBX: 000055beacde5da0 RCX: 00007f32c34af57e
>> [    5.999120] RDX: 00007f32c35c707d RSI: 000000000000a509 RDI: 000055beacdf1800
>> [    5.999124] RBP: 00007ffe33fbb620 R08: 000055beacdb4010 R09: 0000000000000007
>> [    5.999129] R10: 0000000000000002 R11: 0000000000000246 R12: 00007f32c35c707d
>> [    5.999133] R13: 0000000000020000 R14: 000055beacde77a0 R15: 000055beacde5e90
>> [    5.999140]  </TASK>
>> [    5.999148] pci 10000:e0:06.0: bridge window [mem 0x72000000-0x720fffff]: assigned
>> [    5.999155] pci 10000:e0:06.0: bridge window [io  size 0x1000]: can't assign; no space
>> [    5.999161] pci 10000:e0:06.0: bridge window [io  size 0x1000]: failed to assign
>> [    5.999167] pci 10000:e1:00.0: BAR 0 [mem 0x72000000-0x72003fff 64bit]: assigned
>> [    5.999180] pci 10000:e0:06.0: PCI bridge to [bus e1]
>> [    5.999187] pci 10000:e0:06.0:   bridge window [mem 0x72000000-0x720fffff]
>> [    5.999211] pci 10000:e1:00.0: can't override BIOS ASPM; OS doesn't have ASPM control
>> [    5.999238] pcieport 10000:e0:06.0: can't derive routing for PCI INT D
>> [    5.999239] pcieport 10000:e0:06.0: PCI INT D: no GSI
>> [    5.999749] pcieport 10000:e0:06.0: PME: Signaling with IRQ 161
>> [    5.999847] vmd 0000:00:0e.0: Bound to PCI domain 10000


