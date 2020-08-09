Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC2A23FFAC
	for <lists+linux-pci@lfdr.de>; Sun,  9 Aug 2020 20:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHISX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Aug 2020 14:23:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59313 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726266AbgHISX1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Aug 2020 14:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596997405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mrrS8MVKLlFgW8fLgrP8erBvtQKYkON0fpsv+/xNpxs=;
        b=VcdsEAvJeUY6MBExuuzSLhJvDuWCpSw5fF/5EM6Mch2XF52YTBhnGwgRaryYHOapsOuyXH
        Af+YCHrSOMzQgPO4IajbNuL+ELSconou3cLE4OdpLRP5MJ1G2ARtLytMw0vsF5MrrP3XV2
        q9ZF918tju8AKHodK9uWutSqBU5974M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-r5DBe4IlOSSa5BCdnh04Qw-1; Sun, 09 Aug 2020 14:23:23 -0400
X-MC-Unique: r5DBe4IlOSSa5BCdnh04Qw-1
Received: by mail-ej1-f71.google.com with SMTP id sd23so3082855ejb.14
        for <linux-pci@vger.kernel.org>; Sun, 09 Aug 2020 11:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mrrS8MVKLlFgW8fLgrP8erBvtQKYkON0fpsv+/xNpxs=;
        b=dHJbkGl+QZhlEIFv68Ihst5wrKN9d6VnKB4dpcF/hO82qKPudHE7liaSQPezRUbeJn
         MTJSLvIXUZQ6y8gBOPnQSgpBhts4Q+fINVUdRF0NLuWyaFi2MicXUwrsu4wJWka9TFLt
         TBMTR8wO5SqMIaXkxdZHlTK7egZEz8RbyacBek1o/KQgbmC14dqd5TPv7DcEnXTlJK4o
         2uOUBGNZBf+qsywTdhbUfod2BJzadvtQpixJPkNkWnwVdLIPjEUfvbMVo/22O5xoB0ck
         YhQpGoOjMAeZY1lePzW231fG05Ldhr9rj82P6/yENttPaLfN8ruwSgcYGlv9NJYRlf0E
         r5Ig==
X-Gm-Message-State: AOAM5332cQVokZaJp7xKI3bzhOv6lxAe4B27XjbfztZPGcoTwbTQHJNY
        rbwWkYlMbit0FqhgmB8xXF55NWvsze5gFHFSciw274GEu9hixGpbL2uW/TgPaP/n10EY8tfrGR7
        i6v9wby2pBHiu0N1hxAGE
X-Received: by 2002:a17:906:2e0c:: with SMTP id n12mr18270810eji.35.1596997402163;
        Sun, 09 Aug 2020 11:23:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPOjP8n3UiSSn+7ODGCElcJVTDDghtbtVBDbOzVYW1jw1HQmoAz0xXLUn28C+ZRtjBKJ43kw==
X-Received: by 2002:a17:906:2e0c:: with SMTP id n12mr18270796eji.35.1596997401894;
        Sun, 09 Aug 2020 11:23:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d19sm11027044ejk.47.2020.08.09.11.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 11:23:20 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Lockdep warning in PCI-e hotplug code
Message-ID: <b469d86a-7567-db43-23d1-e499b32cb449@redhat.com>
Date:   Sun, 9 Aug 2020 20:23:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

When I connect my X1C8, running a 5.8.0 kernel with lockdep enabled, to a Lenovo 2nd gen thunderbolt dock I get the following warning from lockdep:

[  139.754540] pcieport 0000:06:01.0: PCI bridge to [bus 08-2c]
[  139.754545] pcieport 0000:06:01.0:   bridge window [io  0x4000-0x4fff]
[  139.754552] pcieport 0000:06:01.0:   bridge window [mem 0xdc100000-0xe80fffff]
[  139.754558] pcieport 0000:06:01.0:   bridge window [mem 0xa0000000-0xbfffffff 64bit pref]
[  139.754856] pcieport 0000:08:00.0: enabling device (0000 -> 0003)
[  139.755955] pcieport 0000:09:02.0: enabling device (0000 -> 0003)
[  139.757097] pcieport 0000:09:04.0: enabling device (0000 -> 0002)
[  139.757622] pcieport 0000:09:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+

[  139.759255] ============================================
[  139.759257] WARNING: possible recursive locking detected
[  139.759259] 5.8.0+ #16 Tainted: G            E
[  139.759260] --------------------------------------------
[  139.759261] irq/125-pciehp/143 is trying to acquire lock:
[  139.759263] ffff95ee9f3d1f38 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_check_presence+0x23/0x80
[  139.759269]
                but task is already holding lock:
[  139.759270] ffff95eee497e738 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xdf/0x120
[  139.759274]
                other info that might help us debug this:
[  139.759275]  Possible unsafe locking scenario:

[  139.759276]        CPU0
[  139.759277]        ----
[  139.759278]   lock(&ctrl->reset_lock);
[  139.759279]   lock(&ctrl->reset_lock);
[  139.759281]
                 *** DEADLOCK ***

[  139.759282]  May be due to missing lock nesting notation

[  139.759283] 4 locks held by irq/125-pciehp/143:
[  139.759284]  #0: ffff95eee497e738 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xdf/0x120
[  139.759288]  #1: ffffffffa2a25e70 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_configure_device+0x22/0x110
[  139.759291]  #2: ffff95eec9a9a240 (&dev->mutex){....}-{3:3}, at: __device_attach+0x25/0x170
[  139.759296]  #3: ffff95ee9f0b19b0 (&dev->mutex){....}-{3:3}, at: __device_attach+0x25/0x170
[  139.759299]
                stack backtrace:
[  139.759301] CPU: 5 PID: 143 Comm: irq/125-pciehp Tainted: G            E     5.8.0+ #16
[  139.759303] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET16W (1.06 ) 05/10/2020
[  139.759304] Call Trace:
[  139.759310]  dump_stack+0x92/0xc8
[  139.759314]  __lock_acquire.cold+0x121/0x296
[  139.759319]  lock_acquire+0xa4/0x3d0
[  139.759321]  ? pciehp_check_presence+0x23/0x80
[  139.759327]  down_read+0x45/0x130
[  139.759329]  ? pciehp_check_presence+0x23/0x80
[  139.759331]  pciehp_check_presence+0x23/0x80
[  139.759333]  pciehp_probe+0x156/0x1a0
[  139.759337]  pcie_port_probe_service+0x31/0x50
[  139.759339]  really_probe+0x2d4/0x410
[  139.759342]  driver_probe_device+0xe1/0x150
[  139.759344]  ? driver_allows_async_probing+0x50/0x50
[  139.759346]  bus_for_each_drv+0x6d/0xa0
[  139.759349]  __device_attach+0xe4/0x170
[  139.759352]  bus_probe_device+0x9f/0xb0
[  139.759354]  device_add+0x389/0x810
[  139.759356]  ? __init_waitqueue_head+0x45/0x60
[  139.759359]  pcie_port_device_register+0x296/0x520
[  139.759363]  ? disable_irq_nosync+0x10/0x10
[  139.759365]  pcie_portdrv_probe+0x2d/0xb0
[  139.759368]  local_pci_probe+0x42/0x80
[  139.759371]  pci_device_probe+0xd9/0x190
[  139.759374]  really_probe+0x167/0x410
[  139.759377]  ? disable_irq_nosync+0x10/0x10
[  139.759379]  driver_probe_device+0xe1/0x150
[  139.759381]  ? driver_allows_async_probing+0x50/0x50
[  139.759383]  bus_for_each_drv+0x6d/0xa0
[  139.759386]  __device_attach+0xe4/0x170
[  139.759389]  pci_bus_add_device+0x4b/0x70
[  139.759391]  pci_bus_add_devices+0x2c/0x70
[  139.759394]  pci_bus_add_devices+0x57/0x70
[  139.759396]  pciehp_configure_device+0x92/0x110
[  139.759399]  pciehp_handle_presence_or_link_change+0x17b/0x2a0
[  139.759402]  pciehp_ist+0x116/0x120
[  139.759404]  irq_thread_fn+0x20/0x60
[  139.759407]  ? irq_thread+0x8c/0x1b0
[  139.759409]  irq_thread+0xf0/0x1b0
[  139.759412]  ? irq_finalize_oneshot.part.0+0xd0/0xd0
[  139.759414]  ? irq_thread_check_affinity+0xb0/0xb0
[  139.759417]  kthread+0x138/0x160
[  139.759419]  ? kthread_create_worker_on_cpu+0x40/0x40
[  139.759423]  ret_from_fork+0x1f/0x30

Regards,

Hans


p.s.

I've also filed this in bugzilla in case you prefer tracking this there:
https://bugzilla.kernel.org/show_bug.cgi?id=208855

I assume email is preferred, in that case I'll keep the bugzilla in sync
myself.

