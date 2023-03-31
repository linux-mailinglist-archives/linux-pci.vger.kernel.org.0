Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CCF6D1491
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 02:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCaA7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 20:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCaA7r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 20:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB1C67E
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 17:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDF78B82B34
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 00:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52890C433A0;
        Fri, 31 Mar 2023 00:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680224378;
        bh=4zhx3nosjnn7ZxRbaApniO7eAnlVZEz3rIrHbU0rv/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=MHwrcg3BQvSnma+X2QHZN0WH8F+uQmx/sW9VVdCjpNVdlwDlvkd/vgcSCkB9J5oWG
         uk4g/h8J7ByNQQn+iXthHlwYUYQb8i687yAj1eIBLarP9GwGQd1hQRoPy5zd3azkLb
         3CcjRH+pmMCheZnVZN6/MblocZL/w0v4mkuKf72SMRFViojZGRkRnK17KzjFtVWLCm
         x6oln0Hd7Qg971PDwlFlX5F3w7L8UoXltQ2HaY/fnxdzoh2Yt35bvmX+3XvvCAIBsO
         +N2CoKK7Sq8qCRCvYtTE0v/IISJZ/ELhphoyXY0PT6F/6O37x88Y1O/BviaAnLAfCS
         4TQma9iAlOeqQ==
Date:   Thu, 30 Mar 2023 19:59:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 217276] New: Kernel panic - not
 syncing: Asynchronous SError Interrupt (brcm_pcie_probe), with Raspberry Pi
 CM4 + PCIe setups]
Message-ID: <20230331005936.GA3183917@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks very much for the report!  I'm forwarding it to maintainers and
lists, since most don't monitor bugzilla.

----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=217276

Created attachment 304062
  --> https://bugzilla.kernel.org/attachment.cgi?id=304062&action=edit
dmesg with master (b2bc47e9b201)

Hi,

This bug can be tricky to reproduce, since hitting or dodging it seems very
much dependent on the actual chips and revisions of all involved components.

The general setup is:

- Raspberry Pi Compute Module 4
- Raspberry Pi Compute Module 4 IO Board (carrier board)
- Something plugged onto the PCIe slot

At the moment, I'm able to reproduce this issue reliably with:

- Compute Module 4 including eMMC (Compute Module 4 Lite, without eMMC, using
the exact same operating system image on an SD card, doesn't trigger the
issue).
- SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
(PCE6U1C-R02, VER 006 looks very similar, but definitely includes different
chips on its PCB, and doesn't trigger the issue).

With either v6.1.20 as packaged by Debian, or with a local master build (as of
b2bc47e9b201), plus a Debian testing userspace, I'm hitting the following
kernel panic:

```
[    1.914315] Kernel panic - not syncing: Asynchronous SError Interrupt
[    1.914317] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc4+ #1
[    1.914322] Hardware name: Raspberry Pi Compute Module 4 Rev 1.1 (DT)
[    1.914324] Call trace:
[    1.914326]  dump_backtrace+0xa8/0x138
[    1.914333]  show_stack+0x20/0x38
[    1.914336]  dump_stack_lvl+0x48/0x60
[    1.914345]  dump_stack+0x18/0x28
[    1.914350]  panic+0x378/0x398
[    1.914355]  nmi_panic+0xb4/0xc0
[    1.914359]  arm64_serror_panic+0x78/0x90
[    1.914363]  do_serror+0x30/0x70
[    1.914367]  el1h_64_error_handler+0x30/0x48
[    1.914371]  el1h_64_error+0x64/0x68
[    1.914375]  pci_generic_config_read+0x44/0xe8
[    1.914380]  pci_bus_read_config_dword+0x98/0x140
[    1.914386]  pci_bus_generic_read_dev_vendor_id+0x3c/0x1c0
[    1.914390]  pci_scan_single_device+0xa8/0x118
[    1.914393]  pci_scan_slot+0x6c/0x1e0
[    1.914396]  pci_scan_child_bus_extend+0x50/0x2e0
[    1.914399]  pci_scan_bridge_extend+0x31c/0x5a8
[    1.914403]  pci_scan_child_bus_extend+0x1c4/0x2e0
[    1.914406]  pci_scan_root_bus_bridge+0x6c/0xf8
[    1.914409]  pci_host_probe+0x20/0xd0
[    1.914413]  brcm_pcie_probe+0x294/0x618
[    1.914419]  platform_probe+0x70/0xe8
[    1.914426]  really_probe+0x18c/0x3d8
[    1.914429]  __driver_probe_device+0x84/0x198
[    1.914434]  driver_probe_device+0x44/0x120
[    1.914437]  __driver_attach+0xfc/0x210
[    1.914441]  bus_for_each_dev+0x7c/0xe8
[    1.914445]  driver_attach+0x2c/0x40
[    1.914448]  bus_add_driver+0x118/0x228
[    1.914452]  driver_register+0x68/0x138
[    1.914456]  __platform_driver_register+0x30/0x48
[    1.914461]  brcm_pcie_driver_init+0x24/0x38
[    1.914468]  do_one_initcall+0x4c/0x238
[    1.914472]  kernel_init_freeable+0x21c/0x3f0
[    1.914479]  kernel_init+0x2c/0x1f8
[    1.914483]  ret_from_fork+0x10/0x20
```

Full dmesg captured from b2bc47e9b201 is attached, I'll follow up with a very
similar trace using v6.1.20.

Serial logging implemented this way, should that matter:

- "earlycon console=ttyS1,115200" on the kernel command line;
- "enable_jtag_gpio=1" and "force_turbo=1" in config.txt (consumed by the
bootloader);
- and pins 6, 8, 10 on the pin header hooked up on a cp210x-based serial
adapter.


Reminder: there was some discussion around the possible need for a subnode in
the DTB when I filed the PCIe regression a while back
(https://bugzilla.kernel.org/show_bug.cgi?id=215925).

I'm happy to test any patches and provide any input you folks might need.


Cheers,
Cyril.
