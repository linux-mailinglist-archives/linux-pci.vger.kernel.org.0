Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E458F45934D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 17:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhKVQso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 11:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230406AbhKVQso (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 11:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637599537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UmKH+iwwDxUzhtck3arLL5dpZr8OtqPo5F0EpMBpf+0=;
        b=O4noqTGw1l0BxwXk/CHEYFdaCD4ZNWOf3ABSEEXMy7UdFIkGkUqllYTAhytQrZxB3i7CjQ
        gUHNI4AHAnFH1la9RV6r+AD/O0Tryp8FoxWWR2L+B8Ii39uGHzCZVbTVzDYcnbX9oJk05A
        tcyoGmlLEJyCpwt2G2nLEVKr7Y1ZSuQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-W1h8hpkrNS-wnx9F6H21fw-1; Mon, 22 Nov 2021 11:45:35 -0500
X-MC-Unique: W1h8hpkrNS-wnx9F6H21fw-1
Received: by mail-ed1-f71.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso15337510edb.11
        for <linux-pci@vger.kernel.org>; Mon, 22 Nov 2021 08:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=UmKH+iwwDxUzhtck3arLL5dpZr8OtqPo5F0EpMBpf+0=;
        b=isRNFph7uxM1JcYclepV5s/D+rGHcoD026dmh48OrdE0cxRm5h5zV04++rGx5YRDv+
         tfsBkDZyGkw2XWoJ9OHEWj1eJwl/2zsLSQXGh6tLeJgRZeIdXY/AntQ982td23q+h9cy
         ES08zWboNU3zxQRZ0ThU5s4Pg2UIPQR/pRtCZ3uYByhTRYSi1qqsGyHsZfg0MYCuY/OA
         hNsWlY1d8svQPGjFs/3gtwbPe2//wMnxLT/qmydMZDOOsAKB0WfNnM7lByPv/Wo+iPEd
         Z4aXAc/RONVBuoo5sG6XeYO7ZYaVf3sx8EidEs36b/OPNjAuf1fxwDa2ox6QqIvXYpsY
         YMNg==
X-Gm-Message-State: AOAM533Dqcza40r9vtRv3GucI5IcZ7TLqyGd6YJQVW+GeqFlUYDLj6mO
        TuSHjTtriYVx2OxLvjrknf5Y0ZhWLzbSU7KgiVQcJvgUOnbNEd+f8oDpjYLkY1btnBwCLxA+Lbi
        CO7Z0vM5vtsYNrd1FDqIW
X-Received: by 2002:a17:906:82c5:: with SMTP id a5mr43506574ejy.127.1637599534027;
        Mon, 22 Nov 2021 08:45:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxa8Nx5s42YyvzolM6YrdeSWNVw16JL/V2sbhtIAerfqdKe34NMRJYcoJcG7fdZY3QDMPu6DA==
X-Received: by 2002:a17:906:82c5:: with SMTP id a5mr43506496ejy.127.1637599533650;
        Mon, 22 Nov 2021 08:45:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ar4sm3916751ejc.52.2021.11.22.08.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 08:45:33 -0800 (PST)
Message-ID: <de684a28-9038-8fc6-27ca-3f6f2f6400d7@redhat.com>
Date:   Mon, 22 Nov 2021 17:45:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Lockdep warning about ctrl->reset_lock in
 pciehp_check_presence/pciehp_ist on TB3 dock unplug
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

With 5.16-rc2 I'm getting the following lockdep warning when unplugging
a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:

[   28.583853] pcieport 0000:06:01.0: pciehp: Slot(1): Link Down
[   28.583891] pcieport 0000:06:01.0: pciehp: Slot(1): Card not present
[   28.583995] pcieport 0000:09:04.0: can't change power state from D3cold to D0 (config space inaccessible)

[   28.584849] ============================================
[   28.584854] WARNING: possible recursive locking detected
[   28.584858] 5.16.0-rc2+ #621 Not tainted
[   28.584864] --------------------------------------------
[   28.584867] irq/124-pciehp/86 is trying to acquire lock:
[   28.584873] ffff8e5ac4299ef8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_check_presence+0x23/0x80
[   28.584904] 
               but task is already holding lock:
[   28.584908] ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
[   28.584929] 
               other info that might help us debug this:
[   28.584933]  Possible unsafe locking scenario:

[   28.584936]        CPU0
[   28.584939]        ----
[   28.584942]   lock(&ctrl->reset_lock);
[   28.584949]   lock(&ctrl->reset_lock);
[   28.584955] 
                *** DEADLOCK ***

[   28.584959]  May be due to missing lock nesting notation

[   28.584963] 3 locks held by irq/124-pciehp/86:
[   28.584970]  #0: ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
[   28.584991]  #1: ffffffffa3b024e8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_unconfigure_device+0x31/0x110
[   28.585012]  #2: ffff8e5ac1ee2248 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40
[   28.585037] 
               stack backtrace:
[   28.585042] CPU: 4 PID: 86 Comm: irq/124-pciehp Not tainted 5.16.0-rc2+ #621
[   28.585052] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET30W (1.20 ) 08/26/2021
[   28.585059] Call Trace:
[   28.585064]  <TASK>
[   28.585073]  dump_stack_lvl+0x59/0x73
[   28.585087]  __lock_acquire.cold+0xc5/0x2c6
[   28.585106]  ? find_held_lock+0x2b/0x80
[   28.585124]  lock_acquire+0xb5/0x2b0
[   28.585132]  ? pciehp_check_presence+0x23/0x80
[   28.585144]  ? lock_is_held_type+0xa8/0x120
[   28.585161]  down_read+0x3e/0x50
[   28.585172]  ? pciehp_check_presence+0x23/0x80
[   28.585183]  pciehp_check_presence+0x23/0x80
[   28.585194]  pciehp_runtime_resume+0x5c/0xa0
[   28.585206]  ? pci_msix_init+0x60/0x60
[   28.585214]  device_for_each_child+0x45/0x70
[   28.585227]  pcie_port_device_runtime_resume+0x20/0x30
[   28.585236]  pci_pm_runtime_resume+0xa7/0xc0
[   28.585246]  ? pci_pm_freeze_noirq+0x100/0x100
[   28.585257]  __rpm_callback+0x41/0x110
[   28.585271]  ? pci_pm_freeze_noirq+0x100/0x100
[   28.585281]  rpm_callback+0x59/0x70
[   28.585293]  rpm_resume+0x512/0x7b0
[   28.585309]  __pm_runtime_resume+0x4a/0x90
[   28.585322]  __device_release_driver+0x28/0x240
[   28.585338]  device_release_driver+0x26/0x40
[   28.585351]  pci_stop_bus_device+0x68/0x90
[   28.585363]  pci_stop_bus_device+0x2c/0x90
[   28.585373]  pci_stop_and_remove_bus_device+0xe/0x20
[   28.585384]  pciehp_unconfigure_device+0x6c/0x110
[   28.585396]  ? __pm_runtime_resume+0x58/0x90
[   28.585409]  pciehp_disable_slot+0x5b/0xe0
[   28.585421]  pciehp_handle_presence_or_link_change+0xc3/0x2f0
[   28.585436]  pciehp_ist+0x179/0x180
[   28.585449]  ? disable_irq_nosync+0x10/0x10
[   28.585460]  irq_thread_fn+0x1d/0x60
[   28.585470]  ? irq_thread+0x81/0x1a0
[   28.585480]  irq_thread+0xcb/0x1a0
[   28.585491]  ? irq_thread_fn+0x60/0x60
[   28.585502]  ? irq_thread_check_affinity+0xb0/0xb0
[   28.585514]  kthread+0x165/0x190
[   28.585522]  ? set_kthread_struct+0x40/0x40
[   28.585531]  ret_from_fork+0x1f/0x30
[   28.585554]  </TASK>
[   28.586512] xhci_hcd 0000:0a:00.0: remove, state 1
[   28.586538] usb usb4: USB disconnect, device number 1
[   28.586547] usb 4-2: USB disconnect, device number 2
[   28.586555] usb 4-2.1: USB disconnect, device number 3
[   28.586561] usb 4-2.1.2: USB disconnect, device number 5
[   28.587709] xhci_hcd 0000:0a:00.0: xHCI host controller not responding, assume dead
[   28.590021] usb 4-2.3: USB disconnect, device number 4
[   28.613814] xhci_hcd 0000:0a:00.0: WARN Can't disable streams for endpoint 0x1, streams are being disabled already
[   28.616865] xhci_hcd 0000:0a:00.0: USB bus 4 deregistered
[   28.617082] xhci_hcd 0000:0a:00.0: remove, state 1
[   28.617089] usb usb3: USB disconnect, device number 1
[   28.617092] usb 3-2: USB disconnect, device number 2
[   28.617094] usb 3-2.1: USB disconnect, device number 3
[   28.617096] usb 3-2.1.1: USB disconnect, device number 6
[   28.617098] usb 3-2.1.1.4: USB disconnect, device number 8
[   28.645354] usb 3-2.1.3: USB disconnect, device number 7
[   28.645357] usb 3-2.1.3.1: USB disconnect, device number 10
[   28.647489] usb 3-2.1.3.4: USB disconnect, device number 11
[   28.647494] usb 3-2.1.3.4.1: USB disconnect, device number 13
[   28.760411] usb 3-2.1.4: USB disconnect, device number 9
[   28.760414] usb 3-2.1.4.1: USB disconnect, device number 12
[   28.795513] usb 3-2.4: USB disconnect, device number 4
[   28.821464] usb 3-2.5: USB disconnect, device number 5
[   28.822850] xhci_hcd 0000:0a:00.0: Host halt failed, -19
[   28.822854] xhci_hcd 0000:0a:00.0: Host not accessible, reset failed.
[   28.823331] xhci_hcd 0000:0a:00.0: USB bus 3 deregistered
[   28.823589] pci 0000:0a:00.0: Removing from iommu group 15
[   28.823605] pci_bus 0000:0a: busn_res: [bus 0a] is released
[   28.823660] pci 0000:09:02.0: Removing from iommu group 15
[   28.823729] pci_bus 0000:0b: busn_res: [bus 0b-2c] is released
[   28.823773] pci 0000:09:04.0: Removing from iommu group 15
[   28.823782] pci_bus 0000:09: busn_res: [bus 09-2c] is released
[   28.823851] pci 0000:08:00.0: Removing from iommu group 15

I would be more then happy to test any potential fixes for this.

Regards,

Hans

