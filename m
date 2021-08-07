Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A13E33EB
	for <lists+linux-pci@lfdr.de>; Sat,  7 Aug 2021 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhHGHYi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Aug 2021 03:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhHGHYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Aug 2021 03:24:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39306C061798;
        Sat,  7 Aug 2021 00:24:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m12so13975924wru.12;
        Sat, 07 Aug 2021 00:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZpnRUE7Yphc08hk+DfeofGWDUldN9X75Xfsn9wH+PI=;
        b=tkuh9GwkNrziaUJcWCPMGArRfZFREuWJscQeOTFC2VdmpunXRGLccsjRmViIBy650D
         XOSRbSFpHjBi1x7WtDfb5P7qDUb2wGkF8j+qGWPQtLt6AO6MJfcvrt/V7gFgQEptTXny
         5gZ/du1j83vMH0O0lOuFx+Lf1+637JAathlRJg5WAhcnODdpH/IJ2OJbzr+ugsOxRcl3
         yds2YIZ2pcI9MDGv4P34nztU/dJzZQ9k7bl4NigCYMIv09yjsSjzCDRZdIfJ9pcnjXzh
         Sf9XsaSZRWU0LsMFNXNPtS5cBlCpNll9okhgIy2wsVVYhxBtaxMH/CRcYtA+quhKE/Wm
         JlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZpnRUE7Yphc08hk+DfeofGWDUldN9X75Xfsn9wH+PI=;
        b=CXvxrLAGij+rD5S03btpDJfSr4Q5vKXCPWd3l9EXk9jXlEWB0RwGwrC6BYhSYt49AI
         Gdnyeniz7VDtDsELpY3tnKdB35IUlVKwBBFiV3LIq9EOTNTZD/n+6wyP7e9lNDcYzk7K
         pKy61a3ixfHwlW1uBhGm3ZKlVowHgzkmJ6x+xY+NnTRe/7eREvs8ujYh6NXUXt+84FWv
         y1jkVMkZFRk8vGf9j1mIkHEIXbd7rCaN2lPdcnSsYPONY1nTFSc7QTgw2IpAml8zA4gS
         ooJg5L40j615XlqgkwIWGfchMaqwI8OjkhJZHhDvjv2S981j6qASluWPpBOVjnzV8nl0
         dGbQ==
X-Gm-Message-State: AOAM532sHDRPxcdd14L3zo4Nomi+2CTYF6HAQ0gjshKNoPHPYwVqGSad
        aesQPvIzUF3QB42pqGK50/A=
X-Google-Smtp-Source: ABdhPJzKUcb0GlM7+05lEwrA4+pLfbrxh+7eaDz8GgEdAS/28Q2qBHVfYajgOFmAupBXq5171WCmew==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr14596257wrp.144.1628321053823;
        Sat, 07 Aug 2021 00:24:13 -0700 (PDT)
Received: from localhost.localdomain (10.red-83-57-27.dynamicip.rima-tde.net. [83.57.27.10])
        by smtp.gmail.com with ESMTPSA id g5sm13915017wmh.31.2021.08.07.00.24.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:24:13 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: of: avoid 'devm_pci_remap_iospace' if PCI_IOBASE is not defined
Date:   Sat,  7 Aug 2021 09:24:08 +0200
Message-Id: <20210807072409.9018-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807072409.9018-1-sergio.paracuellos@gmail.com>
References: <20210807072409.9018-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Defining PCI_IOBASE for MIPS ralink in expected addresses results in PCI IO
resources being assigned but the addresses generated for IO accesses are wrong
since the ioremap in the PCI core function 'pci_parse_request_of_pci_ranges'
tries to remap to a fixed virtual address (PC_IOBASE) which can't work for KSEG1
addresses. To get it working this way, we would need to put PCI_IOBASE somewhere
into KSEG2 which will result in creating TLB entries for IO addresses, which most
of the time isn't needed on MIPS because of access via KSEG1. To allow MIPS PCI
drivers to properly use the PCI generic core we need to increase IO_SPACE_LIMIT
since IO addresses are in addresses higher that 0xffff. We also need to avoid
the call 'devm_pci_remap_iospace' when 'pci_parse_request_of_pci_ranges' is
called to avoid the following problem:

------------[ cut here ]------------
WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+0x3c/0x54
This architecture does not support memory mapped I/O
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.1+ #1228
Stack : 00000000 00000000 807fa974 00000000 827ffa80 80066b48 80710000 0000000b
        00000000 00000000 81c59aac 7d06ddec 80850000 00000001 81c59a40 7d06ddec
        00000000 00000000 807c909c 81c598f0 00000001 81c59904 00000000 0000000a
        203a6d6d 80708880 0000000f 70617773 80850000 00000000 00000000 807d0000
        807ffecc 1e160000 00000001 00000200 00000000 8054e920 00000008 815e0008
        ...
Call Trace:
[<80008efc>] show_stack+0x8c/0x130
[<806e1674>] dump_stack+0x9c/0xc8
[<80024a3c>] __warn+0xc0/0xe8
[<80024ad0>] warn_slowpath_fmt+0x6c/0xbc
[<80410ca8>] pci_remap_iospace+0x3c/0x54
[<80410d20>] devm_pci_remap_iospace+0x58/0xa4
[<8042019c>] devm_of_pci_bridge_init+0x4dc/0x55c
[<80408de8>] devm_pci_alloc_host_bridge+0x78/0x88
[<80424e44>] mt7621_pci_probe+0x68/0x9a4
[<80464804>] platform_drv_probe+0x40/0x7c
[<804628bc>] really_probe+0x2fc/0x4e4
[<80463214>] device_driver_attach+0x4c/0x74
[<80463384>] __driver_attach+0x148/0x150
[<8046047c>] bus_for_each_dev+0x6c/0xb0
[<804614dc>] bus_add_driver+0x1b4/0x1fc
[<80463aa0>] driver_register+0xd0/0x110
[<80001714>] do_one_initcall+0x84/0x1c0
[<808e7fd0>] kernel_init_freeable+0x214/0x24c
[<806e4164>] kernel_init+0x14/0x118
[<80003358>] ret_from_kernel_thread+0x14/0x1c

---[ end trace 1c9d4412bd51b53c ]---
mt7621-pci 1e140000.pcie: error -19: failed to map resource [io  0x1e160000-0x1e16ffff]

Hence don't call 'devm_pci_remap_iospace' if PCI_IOBASE is not defined to get
a working PCI core APIs for MIPS ralink platforms.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a143b02b2dcd..657aef39bf63 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -564,12 +564,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
+#ifdef PCI_IOBASE
 			err = devm_pci_remap_iospace(dev, res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
 				resource_list_destroy_entry(win);
 			}
+#endif
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-- 
2.25.1

