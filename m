Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A73DB505
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 10:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhG3I14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 04:27:56 -0400
Received: from ni.piap.pl ([195.187.100.5]:49332 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231411AbhG3I1z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 04:27:55 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 04:27:55 EDT
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 7B72DC39A780;
        Fri, 30 Jul 2021 10:18:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 7B72DC39A780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1627633124; bh=vlgwYjhsUzUKACptFyNyB+NiqP+0vvSB/lF9vp142Kk=;
        h=From:To:Cc:Subject:Date:From;
        b=Sjc5DN22IYJ7QoN7q7Q8tI17P1WeLFfGTNTlpYw0CCVte4RIgoSvsWYL9x9Un6S4z
         r5+7XpipzyFvVc5rkH7+yVwN1LU7H3jR7mU389Ko06Ywl336XvlrgtxS3v+ARBhLyv
         0xlNnhSnziQO6UCMrVHqHsfardnKuHf7Wf4XEqaU=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?utf-8?Q?Kr?= =?utf-8?Q?zysztof_Wilczy=C5=84ski?= <kw@linux.com>
Subject: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
Sender: khalasa@piap.pl
Date:   Fri, 30 Jul 2021 10:18:44 +0200
Message-ID: <m3eebg9puj.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165318 [Jul 30 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4, {Tracking_uf_ne_domains}, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, t19.piap.pl:7.1.1;piap.pl:7.1.1;lkml.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/07/30 06:56:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/07/30 04:15:00 #16998356
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali, et al,

I'm encountering a problem booting an i.MX6-based device (Gateworks
Ventana SBC). This is apparently a known issue:
https://lkml.org/lkml/2020/7/16/388

Do you guys know of a fix for this? Booting this machine reliably is
lately impossible.

First, it spews a warning:

pcieport 0000:00:00.0: PME: Signaling with IRQ 310

sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie=
/pci0000:00/0000:00:00.0/0000:e0'
CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 5.14.0-rc3+ #40
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Workqueue: events_unbound async_run_entry_fn

unwind_backtrace from show_stack+0x10/0x14
show_stack from dump_stack_lvl+0x40/0x4c
dump_stack_lvl from sysfs_warn_dup+0x54/0x60
sysfs_warn_dup from sysfs_add_file_mode_ns+0x154/0x1a8
sysfs_add_file_mode_ns from sysfs_create_bin_file+0x60/0x8c
sysfs_create_bin_file from pci_create_resource_files+0xf4/0x140
pci_create_resource_files from pci_bus_add_device+0x20/0x8c
pci_bus_add_device from pci_bus_add_devices+0x3c/0x80
pci_bus_add_devices from pci_bus_add_devices+0x70/0x80
pci_bus_add_devices from pci_host_probe+0x3c/0x90
pci_host_probe from dw_pcie_host_init+0x200/0x4b4
dw_pcie_host_init from imx6_pcie_probe+0x338/0x668
imx6_pcie_probe from platform_probe+0x80/0xc0
platform_probe from really_probe+0x158/0x324
really_probe from __driver_probe_device+0x84/0xe4
__driver_probe_device from driver_probe_device+0x34/0xd0
driver_probe_device from __driver_attach_async_helper+0x20/0x38
__driver_attach_async_helper from async_run_entry_fn+0x24/0xb4
async_run_entry_fn from process_one_work+0x164/0x3b0
process_one_work from worker_thread+0x2c/0x52c
worker_thread from kthread+0x110/0x154
kthread from ret_from_fork+0x14/0x24

pcieport 0000:01:00.0: enabling device (0140 -> 0143)

Then:
Unable to handle kernel paging request at virtual address 6f736572 (ASCII =
=3D "reso")
pgd =3D (ptrval)
[6f736572] *pgd=3D00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 5.14.0-rc3+ #40
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Workqueue: events_unbound async_run_entry_fn
PC is at string_nocheck+0x20/0xa0
LR is at string+0x54/0x64
Process kworker/u8:0 (pid: 7, stack limit =3D 0x(ptrval))

string_nocheck from string+0x54/0x64
string from vsnprintf+0x1c4/0x48c
vsnprintf from vprintk_store+0x80/0x33c
vprintk_store from vprintk_emit+0x6c/0x1e0
vprintk_emit from vprintk_default+0x20/0x28
vprintk_default from printk+0x1c/0x2c
printk from sysfs_warn_dup+0x50/0x60
sysfs_warn_dup from sysfs_add_file_mode_ns+0x154/0x1a8
sysfs_add_file_mode_ns from sysfs_create_bin_file+0x60/0x8c
sysfs_create_bin_file from pci_create_resource_files+0xf4/0x140
pci_create_resource_files from pci_bus_add_device+0x20/0x8c
pci_bus_add_device from pci_bus_add_devices+0x3c/0x80
pci_bus_add_devices from pci_bus_add_devices+0x70/0x80
pci_bus_add_devices from pci_host_probe+0x3c/0x90
pci_host_probe from dw_pcie_host_init+0x200/0x4b4
dw_pcie_host_init from imx6_pcie_probe+0x338/0x668
imx6_pcie_probe from platform_probe+0x80/0xc0
platform_probe from really_probe+0x158/0x324
really_probe from __driver_probe_device+0x84/0xe4
__driver_probe_device from driver_probe_device+0x34/0xd0
driver_probe_device from __driver_attach_async_helper+0x20/0x38
__driver_attach_async_helper from async_run_entry_fn+0x24/0xb4
async_run_entry_fn from process_one_work+0x164/0x3b0
process_one_work from worker_thread+0x2c/0x52c
worker_thread from kthread+0x110/0x154
kthread from ret_from_fork+0x14/0x24
Code: e1dd42b2 e58d301c e3540000 0a000019 (e5d2e000)
--
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
