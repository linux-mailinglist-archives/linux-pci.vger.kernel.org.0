Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B343F405E
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhHVQKw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 12:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhHVQKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 12:10:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE75C061575;
        Sun, 22 Aug 2021 09:10:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso12375664wmj.0;
        Sun, 22 Aug 2021 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSXX1JoXvG5K5PKjisS9BImgtclzTYpjATWwr5Azs4A=;
        b=tBVxcCppV4Y8b4NgNXNDPE1zoyOm6rxGJ684C2aVzwtdKlI06iAPPBQUAM1uBS3Wfn
         1EigME8VWB6cBIRyRuXLZqfWC5gs1cKFwDmxJ0ApoKpnlN+HV+Vs9kBcS5GbJJmjuWRb
         TJPQHB7LwRNtAe6zBGWKvkhsIy6nx0YIMgHZRlf7NLkGVON1+IZDyZN6TI7jFZE2VMZ7
         kFzjjn44Jfi7PW8m2dpZwQPXhjPdB3Gb41D32jGBCty+VjzW7lhhbfSqd+obR8QRY2ZZ
         s+8aq//VGUAawSTxuEVnB/etEsN/ln+CfzxFld6U03zv258ON8OZ2eRuVCjOVPZ559w8
         NcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSXX1JoXvG5K5PKjisS9BImgtclzTYpjATWwr5Azs4A=;
        b=FTCEUmKjXSISo5UxA7C5cYGhPZoJEsLqdK+lWCz5/Segcc5NlntpsKWvqmtAjuSO50
         uM22dpgtdHa7Amu+Ijn8k6jO6nRp3mbs13oL/hvym7ZC1EsDsvdJWMaquhdkdwhDtJFJ
         FOwurBpUhdUkFgLopXuASNB7mMP/LAwB08ruvdSjQhR9CZsa5narzzbRe6IYMk6eBcyl
         uVpknAHFXWkQNP/DsLTkZW7JKBfTqZ0myWLVtQXJWkSgGlzuVwGq4y4PPuNyNrLLa2Xv
         NvDEImrP9eHhb6R6lXtzihJemlgDpJLcyjG8tI1z2di/FhfX/93KFJ6O4BRJryz3pT2A
         cKFw==
X-Gm-Message-State: AOAM533hJJoShQsgQqDaIlj/LBAX0QDAm/fC68CDkML1grWZ/CZ8gZ4M
        4esH+oWgBnscafc9fVAMIug=
X-Google-Smtp-Source: ABdhPJzZzMwsRzU3TZVMg+llESmr69DSI8bn8ril64uySNWUeJ6OF0UGJwCC8UkXnjIEVlc0TPmlkg==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr12548033wmg.27.1629648609190;
        Sun, 22 Aug 2021 09:10:09 -0700 (PDT)
Received: from localhost.localdomain (10.red-83-57-27.dynamicip.rima-tde.net. [83.57.27.10])
        by smtp.gmail.com with ESMTPSA id y11sm14861976wru.0.2021.08.22.09.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:10:08 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: fix 'pci_remap_iospace' for architectures with PCI_IOBASE not defined
Date:   Sun, 22 Aug 2021 18:10:04 +0200
Message-Id: <20210822161005.22467-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Request for I/O resources from device tree call 'pci_remap_iospace' from
'devm_pci_remap_iospace' which is also called from device tree function
'pci_parse_request_of_pci_ranges'. if PCI_IOBASE is not defined and I/O
resources are requested the following warning appears:

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

Since there are architectures (like MIPS ralink) that can request I/O
resources from device tree but have not mapeable I/O space and also PCI_IOBASE
not defined, avoid this warning and just return zero to make the I/O ranges
assignment work.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..10bb2191f376 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4102,9 +4102,9 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
  * @phys_addr: physical address of range to be mapped
  *
  * Remap the memory mapped I/O space described by the @res and the CPU
- * physical address @phys_addr into virtual address space.  Only
- * architectures that have memory mapped IO functions defined (and the
- * PCI_IOBASE value defined) should call this function.
+ * physical address @phys_addr into virtual address space. There
+ * are architectures that don't define PCI_IOBASE but can have not
+ * mapeable IO space. Return zero for those cases.
  */
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
@@ -4122,10 +4122,10 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 #else
 	/*
 	 * This architecture does not have memory mapped I/O space,
-	 * so this function should never be called
+	 * but can have not mapeable I/O space, so just return ok
+	 * here.
 	 */
-	WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
-	return -ENODEV;
+	return 0;
 #endif
 }
 EXPORT_SYMBOL(pci_remap_iospace);
-- 
2.25.1

