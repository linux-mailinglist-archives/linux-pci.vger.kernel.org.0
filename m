Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ACF3DB64A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhG3Jth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhG3Jtg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:49:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CDED60F12;
        Fri, 30 Jul 2021 09:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627638572;
        bh=+HGSWSx4UUfxxGXo4khEHRvj9y/6zqHga6iQwlMvVh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvSxakBLvpJlMYwTyD87AVVmnjpyGqvl5L034hEMY3pQnH+KUvjzXSsi2CGkUFYh+
         qWRKOj59P8DDckdLbfN76/jicvjv42pNd4ykL2jM+UjgYgKOb2L7Fxy/IGXh+kNyn6
         WLycbpmddWJaANWQwjMmjIxGdC6nKJ07juItKe8xuJ76Xc53df0WscVPk6933ZvPB+
         8yrl8TZqdlXDOjayFDEDQr/zL9dc5WA4E2WLopWQwpeH5s/RtM5nb+g4kf78mXcclw
         vl7o3+daM70BLvS026tDToGW7Ft8kvXoRT8uleFxOOE74yII9KIHDVpXZlhP8aZNOu
         dx5W55BcDaO1Q==
Received: by pali.im (Postfix)
        id AD8D6772; Fri, 30 Jul 2021 11:49:29 +0200 (CEST)
Date:   Fri, 30 Jul 2021 11:49:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
Message-ID: <20210730094929.njs3oh3vkycdy3sb@pali>
References: <m3eebg9puj.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3eebg9puj.fsf@t19.piap.pl>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 30 July 2021 10:18:44 Krzysztof Hałasa wrote:
> Pali, et al,
> 
> I'm encountering a problem booting an i.MX6-based device (Gateworks
> Ventana SBC). This is apparently a known issue:
> https://lkml.org/lkml/2020/7/16/388
> 
> Do you guys know of a fix for this? Booting this machine reliably is
> lately impossible.

Hello Krzysztof Hałasa! This is known issue and Krzysztof Wilczyński is
working on it... Just it will take some time as fixing it is not so
easy.

> First, it spews a warning:
> 
> pcieport 0000:00:00.0: PME: Signaling with IRQ 310
> 
> sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/0000:e0'
> CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 5.14.0-rc3+ #40
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Workqueue: events_unbound async_run_entry_fn
> 
> unwind_backtrace from show_stack+0x10/0x14
> show_stack from dump_stack_lvl+0x40/0x4c
> dump_stack_lvl from sysfs_warn_dup+0x54/0x60
> sysfs_warn_dup from sysfs_add_file_mode_ns+0x154/0x1a8
> sysfs_add_file_mode_ns from sysfs_create_bin_file+0x60/0x8c
> sysfs_create_bin_file from pci_create_resource_files+0xf4/0x140
> pci_create_resource_files from pci_bus_add_device+0x20/0x8c
> pci_bus_add_device from pci_bus_add_devices+0x3c/0x80
> pci_bus_add_devices from pci_bus_add_devices+0x70/0x80
> pci_bus_add_devices from pci_host_probe+0x3c/0x90
> pci_host_probe from dw_pcie_host_init+0x200/0x4b4
> dw_pcie_host_init from imx6_pcie_probe+0x338/0x668
> imx6_pcie_probe from platform_probe+0x80/0xc0
> platform_probe from really_probe+0x158/0x324
> really_probe from __driver_probe_device+0x84/0xe4
> __driver_probe_device from driver_probe_device+0x34/0xd0
> driver_probe_device from __driver_attach_async_helper+0x20/0x38
> __driver_attach_async_helper from async_run_entry_fn+0x24/0xb4
> async_run_entry_fn from process_one_work+0x164/0x3b0
> process_one_work from worker_thread+0x2c/0x52c
> worker_thread from kthread+0x110/0x154
> kthread from ret_from_fork+0x14/0x24
> 
> pcieport 0000:01:00.0: enabling device (0140 -> 0143)
> 
> Then:
> Unable to handle kernel paging request at virtual address 6f736572 (ASCII = "reso")
> pgd = (ptrval)
> [6f736572] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 5.14.0-rc3+ #40
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Workqueue: events_unbound async_run_entry_fn
> PC is at string_nocheck+0x20/0xa0
> LR is at string+0x54/0x64
> Process kworker/u8:0 (pid: 7, stack limit = 0x(ptrval))
> 
> string_nocheck from string+0x54/0x64
> string from vsnprintf+0x1c4/0x48c
> vsnprintf from vprintk_store+0x80/0x33c
> vprintk_store from vprintk_emit+0x6c/0x1e0
> vprintk_emit from vprintk_default+0x20/0x28
> vprintk_default from printk+0x1c/0x2c
> printk from sysfs_warn_dup+0x50/0x60
> sysfs_warn_dup from sysfs_add_file_mode_ns+0x154/0x1a8
> sysfs_add_file_mode_ns from sysfs_create_bin_file+0x60/0x8c
> sysfs_create_bin_file from pci_create_resource_files+0xf4/0x140
> pci_create_resource_files from pci_bus_add_device+0x20/0x8c
> pci_bus_add_device from pci_bus_add_devices+0x3c/0x80
> pci_bus_add_devices from pci_bus_add_devices+0x70/0x80
> pci_bus_add_devices from pci_host_probe+0x3c/0x90
> pci_host_probe from dw_pcie_host_init+0x200/0x4b4
> dw_pcie_host_init from imx6_pcie_probe+0x338/0x668
> imx6_pcie_probe from platform_probe+0x80/0xc0
> platform_probe from really_probe+0x158/0x324
> really_probe from __driver_probe_device+0x84/0xe4
> __driver_probe_device from driver_probe_device+0x34/0xd0
> driver_probe_device from __driver_attach_async_helper+0x20/0x38
> __driver_attach_async_helper from async_run_entry_fn+0x24/0xb4
> async_run_entry_fn from process_one_work+0x164/0x3b0
> process_one_work from worker_thread+0x2c/0x52c
> worker_thread from kthread+0x110/0x154
> kthread from ret_from_fork+0x14/0x24
> Code: e1dd42b2 e58d301c e3540000 0a000019 (e5d2e000)
> --
> Krzysztof "Chris" Hałasa
> 
> Sieć Badawcza Łukasiewicz
> Przemysłowy Instytut Automatyki i Pomiarów PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa
