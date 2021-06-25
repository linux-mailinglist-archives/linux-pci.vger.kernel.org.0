Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA23B42BD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 13:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFYL40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 07:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFYL4Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 07:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAC7D61464;
        Fri, 25 Jun 2021 11:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624622045;
        bh=eKwvSIEBtV9yZ29mPOO8grGRX6O2AyCWp0i7Tkuc/eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFSo0RtCEX5GX6dxNXbQPazYaVXnToZoTw5wAT9kzABmT8tlQbNsI1XLHqgD94n8i
         OVyd/zpV1wDiEjb7Jjf72vfpx/tR91Omxa/B+VTUci7uCDvoBLoSVJBGVtVAY8T8Pp
         XuOMj1cBGeeONi3D8PXntWB+tqzF2qXfZlO4Kr139M4Qy1rHg0LgR5KPQNBM+pA8Ye
         85iPWTiuNn3Z6kAPZ0q8vwytmfGfK62g+9swaY+lqTUxR/n858VD7ckLYkLXAn7Fz7
         OV/EBGLBwEMvY3YXZvFdRAIyYB6y5ALIJLwKYxRNSI4YCEgz4/jOuHJpOpyAqCJXA4
         yrlT5YcDA1j1A==
Received: by pali.im (Postfix)
        id 7061360E; Fri, 25 Jun 2021 13:54:02 +0200 (CEST)
Date:   Fri, 25 Jun 2021 13:54:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Koen Vandeputte <koen.vandeputte@citymesh.com>
Cc:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20210625115402.jwga35xmknmo4vdk@pali>
References: <20200909112850.hbtgkvwqy2rlixst@pali>
 <20201006222222.GA3221382@bjorn-Precision-5520>
 <20201007081227.d6f6otfsnmlgvegi@pali>
 <20210407142538.GA12387@meh.true.cz>
 <20210407145147.bvtubdmz4k6nulf7@pali>
 <20210407153041.GA17046@meh.true.cz>
 <cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Friday 25 June 2021 13:29:00 Koen Vandeputte wrote:
> Hi all,
> 
> 
> Adding some more info regarding this issue:
> 
> I've cooked up this simple patch to get some more info:
> 
> 
> Index: linux-5.10.44/drivers/pci/pci-sysfs.c
> ===================================================================
> --- linux-5.10.44.orig/drivers/pci/pci-sysfs.c
> +++ linux-5.10.44/drivers/pci/pci-sysfs.c
> @@ -1335,6 +1335,8 @@ int __must_check pci_create_sysfs_dev_fi
>      int rom_size;
>      struct bin_attribute *attr;
> 
> +    dump_stack();
> +
>      if (!sysfs_initialized)
>          return -EACCES;
> 
> 
> Which shows this:
> 
> 
> [    1.847384] Key type .fscrypt registered
> [    1.854288] pci 0000:01:00.0: PCI bridge to [bus 02-05]
> [    1.859242] Key type fscrypt-provisioning registered
> [    1.863252] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x011fffff]
> [    1.874096] Key type encrypted registered
> [    1.879290] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    1.879306] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x012fffff]
> 
> --> patch kicking in here showing first creation now
> 
> [    1.879346] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.10.44 #0
> [    1.913354] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    1.919908] Workqueue: events_unbound async_run_entry_fn
> [    1.925255] [<8010d5e0>] (unwind_backtrace) from [<801099f0>]
> (show_stack+0x10/0x14)
> [    1.933008] [<801099f0>] (show_stack) from [<804ab92c>]
> (dump_stack+0x94/0xa8)
> [    1.940249] [<804ab92c>] (dump_stack) from [<804ea96c>]
> (pci_create_sysfs_dev_files+0x10/0x28c)
> [    1.948969] [<804ea96c>] (pci_create_sysfs_dev_files) from [<804dc648>]
> (pci_bus_add_device+0x20/0x84)
> [    1.958287] [<804dc648>] (pci_bus_add_device) from [<804dc6d8>]
> (pci_bus_add_devices+0x2c/0x70)
> [    1.966996] [<804dc6d8>] (pci_bus_add_devices) from [<804dffc8>]
> (pci_host_probe+0x40/0x94)
> [    1.975362] [<804dffc8>] (pci_host_probe) from [<804fd5f0>]
> (dw_pcie_host_init+0x1c0/0x3fc)
> [    1.983720] [<804fd5f0>] (dw_pcie_host_init) from [<804fdcb0>]
> (imx6_pcie_probe+0x358/0x63c)
> [    1.992179] [<804fdcb0>] (imx6_pcie_probe) from [<8054c79c>]
> (platform_drv_probe+0x48/0x98)
> [    2.000542] [<8054c79c>] (platform_drv_probe) from [<8054a9fc>]
> (really_probe+0xfc/0x4dc)
> [    2.008732] [<8054a9fc>] (really_probe) from [<8054b0bc>]
> (driver_probe_device+0x5c/0xb4)
> [    2.016916] [<8054b0bc>] (driver_probe_device) from [<8054b1bc>]
> (__driver_attach_async_helper+0xa8/0xac)
> [    2.026497] [<8054b1bc>] (__driver_attach_async_helper) from [<8014beec>]
> (async_run_entry_fn+0x44/0x108)
> [    2.036082] [<8014beec>] (async_run_entry_fn) from [<80141b64>]
> (process_one_work+0x1d8/0x43c)
> [    2.044704] [<80141b64>] (process_one_work) from [<80141e2c>]
> (worker_thread+0x64/0x5b0)
> [    2.052802] [<80141e2c>] (worker_thread) from [<80147698>]
> (kthread+0x148/0x14c)
> [    2.060207] [<80147698>] (kthread) from [<80100148>]
> (ret_from_fork+0x14/0x2c)
> [    2.067433] Exception stack(0x81075fb0 to 0x81075ff8)
> [    2.072493] 5fa0:                                     00000000 00000000
> 00000000 00000000
> [    2.080678] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> [    2.088864] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> --> getting called again ..  different caller this time .. seems unimportant
> ?
> 
> [    2.095490] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.44 #0
> [    2.095924] pcieport 0000:00:00.0: PME: Signaling with IRQ 307
> [    2.101510] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    2.113883] [<8010d5e0>] (unwind_backtrace) from [<801099f0>]
> (show_stack+0x10/0x14)
> [    2.121638] [<801099f0>] (show_stack) from [<804ab92c>]
> (dump_stack+0x94/0xa8)
> [    2.128875] [<804ab92c>] (dump_stack) from [<804ea96c>]
> (pci_create_sysfs_dev_files+0x10/0x28c)
> [    2.137588] [<804ea96c>] (pci_create_sysfs_dev_files) from [<80b1b920>]
> (pci_sysfs_init+0x34/0x54)
> [    2.146559] [<80b1b920>] (pci_sysfs_init) from [<80101820>]
> (do_one_initcall+0x54/0x1e8)
> [    2.154667] [<80101820>] (do_one_initcall) from [<80b01108>]
> (kernel_init_freeable+0x23c/0x290)
> [    2.163386] [<80b01108>] (kernel_init_freeable) from [<80837e3c>]
> (kernel_init+0x8/0x118)
> [    2.171578] [<80837e3c>] (kernel_init) from [<80100148>]
> (ret_from_fork+0x14/0x2c)
> [    2.179151] Exception stack(0x81053fb0 to 0x81053ff8)
> [    2.184210] 3fa0:                                     00000000 00000000
> 00000000 00000000
> [    2.192393] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> [    2.200575] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> --> And then finally, the error occurs as it's already been added before. 
> same cpu and same PID trying to add the same stuff again to sysfs

This just proves that you have hit this race condition.

> [    2.207200] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.10.44 #0
> [    2.207263] sysfs: cannot create duplicate filename
> '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/config' <------
> [    2.213478] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    2.230798] Workqueue: events_unbound async_run_entry_fn
> [    2.236129] [<8010d5e0>] (unwind_backtrace) from [<801099f0>]
> (show_stack+0x10/0x14)
> [    2.243882] [<801099f0>] (show_stack) from [<804ab92c>]
> (dump_stack+0x94/0xa8)
> [    2.251118] [<804ab92c>] (dump_stack) from [<804ea96c>]
> (pci_create_sysfs_dev_files+0x10/0x28c)
> [    2.259837] [<804ea96c>] (pci_create_sysfs_dev_files) from [<804dc648>]
> (pci_bus_add_device+0x20/0x84)
> [    2.269153] [<804dc648>] (pci_bus_add_device) from [<804dc6d8>]
> (pci_bus_add_devices+0x2c/0x70)
> [    2.277861] [<804dc6d8>] (pci_bus_add_devices) from [<804dc70c>]
> (pci_bus_add_devices+0x60/0x70)
> [    2.286656] [<804dc70c>] (pci_bus_add_devices) from [<804dffc8>]
> (pci_host_probe+0x40/0x94)
> [    2.295018] [<804dffc8>] (pci_host_probe) from [<804fd5f0>]
> (dw_pcie_host_init+0x1c0/0x3fc)
> [    2.303377] [<804fd5f0>] (dw_pcie_host_init) from [<804fdcb0>]
> (imx6_pcie_probe+0x358/0x63c)
> [    2.311832] [<804fdcb0>] (imx6_pcie_probe) from [<8054c79c>]
> (platform_drv_probe+0x48/0x98)
> [    2.320196] [<8054c79c>] (platform_drv_probe) from [<8054a9fc>]
> (really_probe+0xfc/0x4dc)
> [    2.328382] [<8054a9fc>] (really_probe) from [<8054b0bc>]
> (driver_probe_device+0x5c/0xb4)
> [    2.336567] [<8054b0bc>] (driver_probe_device) from [<8054b1bc>]
> (__driver_attach_async_helper+0xa8/0xac)
> [    2.346145] [<8054b1bc>] (__driver_attach_async_helper) from [<8014beec>]
> (async_run_entry_fn+0x44/0x108)
> [    2.355727] [<8014beec>] (async_run_entry_fn) from [<80141b64>]
> (process_one_work+0x1d8/0x43c)
> [    2.364350] [<80141b64>] (process_one_work) from [<80141e2c>]
> (worker_thread+0x64/0x5b0)
> [    2.372449] [<80141e2c>] (worker_thread) from [<80147698>]
> (kthread+0x148/0x14c)
> [    2.379853] [<80147698>] (kthread) from [<80100148>]
> (ret_from_fork+0x14/0x2c)
> [    2.387077] Exception stack(0x81075fb0 to 0x81075ff8)
> [    2.392134] 5fa0:                                     00000000 00000000
> 00000000 00000000
> [    2.400317] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> [    2.408498] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> 
> 
> Any idea?
> 
> Thanks,
> 
> Koen
> 

It is same race condition which I described in the first email of this
email thread. I described exactly when it happens. I'm not able to
trigger it with new kernels but as we know race conditions are hard to
trigger...

So result is that we know about it, just fix is not ready yet as it is
not easy to fix it.

Krzysztof has been working on fixing it, so maybe can provide an
update...
