Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BED28E09B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgJNMiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 08:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgJNMiG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 08:38:06 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7E620878;
        Wed, 14 Oct 2020 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602679085;
        bh=IdTP0WSdI8fWeMMkl3zJ83hS9CPARhN91bT+SihJV4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SccyUPbNrIN5fBS8uyBxV1vAYsd9e9FjhEXgZJup/g9OD5lzSm/aIJCcK5+2VtJO3
         XCMuWLibkgTqC4E2mDpAEnh+81ovdr6VzCsSQItbhJ/qksYgKZDhNiqGu8IYZnWihR
         Szb94jCz4LKAXeM3lI3gB68G3e7kYHrL0Zopauo4=
Received: by mail-ot1-f45.google.com with SMTP id n15so2147815otl.8;
        Wed, 14 Oct 2020 05:38:05 -0700 (PDT)
X-Gm-Message-State: AOAM533lcUEkIOqNffL90DVh5H6sk9GTwko0lLPtIjGnFrKJV+n7IYzn
        GZUsgkROM2472GsDpclMBf6KH1xWGvnUzyIq1w==
X-Google-Smtp-Source: ABdhPJy6vNUMgOVopNGFgLppRvRprfnYZgT7BNvEMmkkNSXWXv8vgIJmiuOiWv17E1qdvfb3FmZMQtsY5VplLOV4/vo=
X-Received: by 2002:a9d:1c90:: with SMTP id l16mr3415025ota.192.1602679084411;
 Wed, 14 Oct 2020 05:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com> <20201014111312.GA4110@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201014111312.GA4110@e121166-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Oct 2020 07:37:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+4QwybLg4xTxC8VY3r0hz3YyP9zWTi9_iPugUoiNqTMg@mail.gmail.com>
Message-ID: <CAL_Jsq+4QwybLg4xTxC8VY3r0hz3YyP9zWTi9_iPugUoiNqTMg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of dw_child_pcie_ops
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 14, 2020 at 6:13 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Sep 16, 2020 at 01:41:30PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > On NXP Layerscape platforms, it results in SError in the
> > enumeration of the PCIe controller, which is not connecting
> > with an Endpoint device. And it doesn't make sense to
> > enumerate the Endpoints when the PCIe link is down. So this
> > patch added the link up check to avoid to fire configuration
> > transactions on link down bus.
> >
> > [    0.807773] SError Interrupt on CPU2, code 0xbf000002 -- SError
> > [    0.807775] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc5-next-20200914-00001-gf965d3ec86fa #67
> > [    0.807776] Hardware name: LS1046A RDB Board (DT)
> > [    0.807777] pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> > [    0.807778] pc : pci_generic_config_read+0x3c/0xe0
> > [    0.807778] lr : pci_generic_config_read+0x24/0xe0
> > [    0.807779] sp : ffff80001003b7b0
> > [    0.807780] x29: ffff80001003b7b0 x28: ffff80001003ba74
> > [    0.807782] x27: ffff000971d96800 x26: ffff00096e77e0a8
> > [    0.807784] x25: ffff80001003b874 x24: ffff80001003b924
> > [    0.807786] x23: 0000000000000004 x22: 0000000000000000
> > [    0.807788] x21: 0000000000000000 x20: ffff80001003b874
> > [    0.807790] x19: 0000000000000004 x18: ffffffffffffffff
> > [    0.807791] x17: 00000000000000c0 x16: fffffe0025981840
> > [    0.807793] x15: ffffb94c75b69948 x14: 62203a383634203a
> > [    0.807795] x13: 666e6f635f726568 x12: 202c31203d207265
> > [    0.807797] x11: 626d756e3e2d7375 x10: 656877202c307830
> > [    0.807799] x9 : 203d206e66766564 x8 : 0000000000000908
> > [    0.807801] x7 : 0000000000000908 x6 : ffff800010900000
> > [    0.807802] x5 : ffff00096e77e080 x4 : 0000000000000000
> > [    0.807804] x3 : 0000000000000003 x2 : 84fa3440ff7e7000
> > [    0.807806] x1 : 0000000000000000 x0 : ffff800010034000
> > [    0.807808] Kernel panic - not syncing: Asynchronous SError Interrupt
> > [    0.807809] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc5-next-20200914-00001-gf965d3ec86fa #67
> > [    0.807810] Hardware name: LS1046A RDB Board (DT)
> > [    0.807811] Call trace:
> > [    0.807812]  dump_backtrace+0x0/0x1c0
> > [    0.807813]  show_stack+0x18/0x28
> > [    0.807814]  dump_stack+0xd8/0x134
> > [    0.807814]  panic+0x180/0x398
> > [    0.807815]  add_taint+0x0/0xb0
> > [    0.807816]  arm64_serror_panic+0x78/0x88
> > [    0.807817]  do_serror+0x68/0x180
> > [    0.807818]  el1_error+0x84/0x100
> > [    0.807818]  pci_generic_config_read+0x3c/0xe0
> > [    0.807819]  dw_pcie_rd_other_conf+0x78/0x110
> > [    0.807820]  pci_bus_read_config_dword+0x88/0xe8
> > [    0.807821]  pci_bus_generic_read_dev_vendor_id+0x30/0x1b0
> > [    0.807822]  pci_bus_read_dev_vendor_id+0x4c/0x78
> > [    0.807823]  pci_scan_single_device+0x80/0x100
> > [    0.807824]  pci_scan_slot+0x38/0x130
> > [    0.807825]  pci_scan_child_bus_extend+0x54/0x2a0
> > [    0.807826]  pci_scan_child_bus+0x14/0x20
> > [    0.807827]  pci_scan_bridge_extend+0x230/0x570
> > [    0.807828]  pci_scan_child_bus_extend+0x134/0x2a0
> > [    0.807829]  pci_scan_root_bus_bridge+0x64/0xf0
> > [    0.807829]  pci_host_probe+0x18/0xc8
> > [    0.807830]  dw_pcie_host_init+0x220/0x378
> > [    0.807831]  ls_pcie_probe+0x104/0x140
> > [    0.807832]  platform_drv_probe+0x54/0xa8
> > [    0.807833]  really_probe+0x118/0x3e0
> > [    0.807834]  driver_probe_device+0x5c/0xc0
> > [    0.807835]  device_driver_attach+0x74/0x80
> > [    0.807835]  __driver_attach+0x8c/0xd8
> > [    0.807836]  bus_for_each_dev+0x7c/0xd8
> > [    0.807837]  driver_attach+0x24/0x30
> > [    0.807838]  bus_add_driver+0x154/0x200
> > [    0.807839]  driver_register+0x64/0x120
> > [    0.807839]  __platform_driver_probe+0x7c/0x148
> > [    0.807840]  ls_pcie_driver_init+0x24/0x30
> > [    0.807841]  do_one_initcall+0x60/0x1d8
> > [    0.807842]  kernel_init_freeable+0x1f4/0x24c
> > [    0.807843]  kernel_init+0x14/0x118
> > [    0.807843]  ret_from_fork+0x10/0x34
> > [    0.807854] SMP: stopping secondary CPUs
> > [    0.807855] Kernel Offset: 0x394c64080000 from 0xffff800010000000
> > [    0.807856] PHYS_OFFSET: 0xffff8bfd40000000
> > [    0.807856] CPU features: 0x0240022,21806000
> > [    0.807857] Memory Limit: none
> >
> > Fixes: c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
>
> Hi Rob,
>
> can I squash this patch into the commit above ?

Okay on applying, but better to not squash it so we can see why it is needed.

Rob
