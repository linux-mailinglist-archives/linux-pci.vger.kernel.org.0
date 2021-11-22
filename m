Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D730459354
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 17:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhKVQt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 11:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233427AbhKVQt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 11:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637599581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GpxnLQh5MMXRTYO0tbbcPE/y/ZhjNaiB7hO+4hnY4nM=;
        b=ZN3jriTp1j9GKqPrBNYIu4jOZLFIMZSeWBaEUElHkAc/D4uoxZh0a0MLOoiS/o8EcL8ZmC
        IGMxCcTuFeOX06zxElkrQJKjh+P3tdLdalqYOFdK7oCPdAG7DQOjt96Ue++KTsw9U9q7gm
        aVpEZ02JoQMCLfxGsw1jMk7AKUqkU+U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-gAz7drd_MYKomHnmJ8pTYA-1; Mon, 22 Nov 2021 11:46:20 -0500
X-MC-Unique: gAz7drd_MYKomHnmJ8pTYA-1
Received: by mail-ed1-f71.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so15447676edx.9
        for <linux-pci@vger.kernel.org>; Mon, 22 Nov 2021 08:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=GpxnLQh5MMXRTYO0tbbcPE/y/ZhjNaiB7hO+4hnY4nM=;
        b=eiSyYSLqG102fpNLdX9IBFiSHKrgrTB6KlxEPTv+Xd03iqvQYuvcz+GxRLFIKtsTp/
         5z/ZqM7LMLiaERK+TAQzJ/s2K9YrBQg+b96zG9eHAyXqgaWZdXTytH9YjVyC10zGrpiI
         99j4QqcnraI8qVsoAgMeERENW8w52BcrU/FNh8DQVcWhWCfwx/IRswu1pNnn9HSVuxJY
         vLY20EeGrQg++sUscYJb6wo5LspLzUeqc7fZXYfII0KxepRkRqEu5fXy0RAr2WfZIYwY
         h4drs335u5aL0cMGvGKve1cSLxBbwLMEM1HffFnNpIKfDtWUZfGJ6UG7UBw5qZg8q5iJ
         Pgcw==
X-Gm-Message-State: AOAM530j2c2naxZBFdWCaViPP8beeIkVeyVuKkjXjf5rmy9RIeZ1sUsZ
        pgQwJU6nLXtlWbic9+KIyBsZc5Z3iTJ4p8s7CRLnZYM5NGdDQxRMKCDMePhmNNUa3uC254ac1x6
        F0NAJkVjyoefD4xw97w6Z
X-Received: by 2002:a17:907:97d0:: with SMTP id js16mr42941075ejc.199.1637599578887;
        Mon, 22 Nov 2021 08:46:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqq98Vkoozd/dLDKVT8M31+onhwOk3uKIo7v6pKhahrQZvmfcQTR1irBrDX6dpOOnEStM9IA==
X-Received: by 2002:a17:907:97d0:: with SMTP id js16mr42941043ejc.199.1637599578656;
        Mon, 22 Nov 2021 08:46:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z6sm4539976edc.76.2021.11.22.08.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 08:46:18 -0800 (PST)
Message-ID: <03bce043-1568-e86c-6c1b-a3051108fa07@redhat.com>
Date:   Mon, 22 Nov 2021 17:46:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Lockdep warning about ctrl->reset_lock in
 pciehp_check_presence/pciehp_ist on TB3 dock unplug
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>
References: <de684a28-9038-8fc6-27ca-3f6f2f6400d7@redhat.com>
In-Reply-To: <de684a28-9038-8fc6-27ca-3f6f2f6400d7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/22/21 17:45, Hans de Goede wrote:
> Hi All,
> 
> With 5.16-rc2 I'm getting the following lockdep warning when unplugging
> a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:
> 
> [   28.583853] pcieport 0000:06:01.0: pciehp: Slot(1): Link Down
> [   28.583891] pcieport 0000:06:01.0: pciehp: Slot(1): Card not present
> [   28.583995] pcieport 0000:09:04.0: can't change power state from D3cold to D0 (config space inaccessible)
> 
> [   28.584849] ============================================
> [   28.584854] WARNING: possible recursive locking detected
> [   28.584858] 5.16.0-rc2+ #621 Not tainted
> [   28.584864] --------------------------------------------
> [   28.584867] irq/124-pciehp/86 is trying to acquire lock:
> [   28.584873] ffff8e5ac4299ef8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_check_presence+0x23/0x80
> [   28.584904] 
>                but task is already holding lock:
> [   28.584908] ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
> [   28.584929] 
>                other info that might help us debug this:
> [   28.584933]  Possible unsafe locking scenario:
> 
> [   28.584936]        CPU0
> [   28.584939]        ----
> [   28.584942]   lock(&ctrl->reset_lock);
> [   28.584949]   lock(&ctrl->reset_lock);
> [   28.584955] 
>                 *** DEADLOCK ***
> 
> [   28.584959]  May be due to missing lock nesting notation
> 
> [   28.584963] 3 locks held by irq/124-pciehp/86:
> [   28.584970]  #0: ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
> [   28.584991]  #1: ffffffffa3b024e8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_unconfigure_device+0x31/0x110
> [   28.585012]  #2: ffff8e5ac1ee2248 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40
> [   28.585037] 
>                stack backtrace:
> [   28.585042] CPU: 4 PID: 86 Comm: irq/124-pciehp Not tainted 5.16.0-rc2+ #621
> [   28.585052] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET30W (1.20 ) 08/26/2021
> [   28.585059] Call Trace:
> [   28.585064]  <TASK>
> [   28.585073]  dump_stack_lvl+0x59/0x73
> [   28.585087]  __lock_acquire.cold+0xc5/0x2c6
> [   28.585106]  ? find_held_lock+0x2b/0x80
> [   28.585124]  lock_acquire+0xb5/0x2b0
> [   28.585132]  ? pciehp_check_presence+0x23/0x80
> [   28.585144]  ? lock_is_held_type+0xa8/0x120
> [   28.585161]  down_read+0x3e/0x50
> [   28.585172]  ? pciehp_check_presence+0x23/0x80
> [   28.585183]  pciehp_check_presence+0x23/0x80
> [   28.585194]  pciehp_runtime_resume+0x5c/0xa0
> [   28.585206]  ? pci_msix_init+0x60/0x60
> [   28.585214]  device_for_each_child+0x45/0x70
> [   28.585227]  pcie_port_device_runtime_resume+0x20/0x30
> [   28.585236]  pci_pm_runtime_resume+0xa7/0xc0
> [   28.585246]  ? pci_pm_freeze_noirq+0x100/0x100
> [   28.585257]  __rpm_callback+0x41/0x110
> [   28.585271]  ? pci_pm_freeze_noirq+0x100/0x100
> [   28.585281]  rpm_callback+0x59/0x70
> [   28.585293]  rpm_resume+0x512/0x7b0
> [   28.585309]  __pm_runtime_resume+0x4a/0x90
> [   28.585322]  __device_release_driver+0x28/0x240
> [   28.585338]  device_release_driver+0x26/0x40
> [   28.585351]  pci_stop_bus_device+0x68/0x90
> [   28.585363]  pci_stop_bus_device+0x2c/0x90
> [   28.585373]  pci_stop_and_remove_bus_device+0xe/0x20
> [   28.585384]  pciehp_unconfigure_device+0x6c/0x110
> [   28.585396]  ? __pm_runtime_resume+0x58/0x90
> [   28.585409]  pciehp_disable_slot+0x5b/0xe0
> [   28.585421]  pciehp_handle_presence_or_link_change+0xc3/0x2f0
> [   28.585436]  pciehp_ist+0x179/0x180
> [   28.585449]  ? disable_irq_nosync+0x10/0x10
> [   28.585460]  irq_thread_fn+0x1d/0x60
> [   28.585470]  ? irq_thread+0x81/0x1a0
> [   28.585480]  irq_thread+0xcb/0x1a0
> [   28.585491]  ? irq_thread_fn+0x60/0x60
> [   28.585502]  ? irq_thread_check_affinity+0xb0/0xb0
> [   28.585514]  kthread+0x165/0x190
> [   28.585522]  ? set_kthread_struct+0x40/0x40
> [   28.585531]  ret_from_fork+0x1f/0x30
> [   28.585554]  </TASK>
> [   28.586512] xhci_hcd 0000:0a:00.0: remove, state 1
> [   28.586538] usb usb4: USB disconnect, device number 1
> [   28.586547] usb 4-2: USB disconnect, device number 2
> [   28.586555] usb 4-2.1: USB disconnect, device number 3
> [   28.586561] usb 4-2.1.2: USB disconnect, device number 5
> [   28.587709] xhci_hcd 0000:0a:00.0: xHCI host controller not responding, assume dead
> [   28.590021] usb 4-2.3: USB disconnect, device number 4
> [   28.613814] xhci_hcd 0000:0a:00.0: WARN Can't disable streams for endpoint 0x1, streams are being disabled already
> [   28.616865] xhci_hcd 0000:0a:00.0: USB bus 4 deregistered
> [   28.617082] xhci_hcd 0000:0a:00.0: remove, state 1
> [   28.617089] usb usb3: USB disconnect, device number 1
> [   28.617092] usb 3-2: USB disconnect, device number 2
> [   28.617094] usb 3-2.1: USB disconnect, device number 3
> [   28.617096] usb 3-2.1.1: USB disconnect, device number 6
> [   28.617098] usb 3-2.1.1.4: USB disconnect, device number 8
> [   28.645354] usb 3-2.1.3: USB disconnect, device number 7
> [   28.645357] usb 3-2.1.3.1: USB disconnect, device number 10
> [   28.647489] usb 3-2.1.3.4: USB disconnect, device number 11
> [   28.647494] usb 3-2.1.3.4.1: USB disconnect, device number 13
> [   28.760411] usb 3-2.1.4: USB disconnect, device number 9
> [   28.760414] usb 3-2.1.4.1: USB disconnect, device number 12
> [   28.795513] usb 3-2.4: USB disconnect, device number 4
> [   28.821464] usb 3-2.5: USB disconnect, device number 5
> [   28.822850] xhci_hcd 0000:0a:00.0: Host halt failed, -19
> [   28.822854] xhci_hcd 0000:0a:00.0: Host not accessible, reset failed.
> [   28.823331] xhci_hcd 0000:0a:00.0: USB bus 3 deregistered
> [   28.823589] pci 0000:0a:00.0: Removing from iommu group 15
> [   28.823605] pci_bus 0000:0a: busn_res: [bus 0a] is released
> [   28.823660] pci 0000:09:02.0: Removing from iommu group 15
> [   28.823729] pci_bus 0000:0b: busn_res: [bus 0b-2c] is released
> [   28.823773] pci 0000:09:04.0: Removing from iommu group 15
> [   28.823782] pci_bus 0000:09: busn_res: [bus 09-2c] is released
> [   28.823851] pci 0000:08:00.0: Removing from iommu group 15
> 
> I would be more then happy to test any potential fixes for this.
> 
> Regards,
> 
> Hans

p.s.

I'm not sure if this is a new problem with 5.16, this might very well
have been around for a while.




