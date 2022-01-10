Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAEA48900C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 07:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiAJGON (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 01:14:13 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:42777 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230147AbiAJGOM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jan 2022 01:14:12 -0500
X-UUID: f8ee75e034d249e78de128520a5baf80-20220110
X-CPASD-INFO: 6ea753e34b544140b0870acfa4bfa87f@f7WbV2Jlk2NggneAg3R_aoJhaGdhjYO
        1o26Clo9oY4aVhH5xTWJsXVKBfG5QZWNdYVN_eGpQY19gZFB5i3-XblBgXoZgUZB3haebV2VhlQ==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 6ea753e34b544140b0870acfa4bfa87f
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:172.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:1.0,CUTS:298.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CF
        OB:0.0,SPC:0.0,SIG:-5,AUF:0,DUF:29951,ACD:159,DCD:261,SL:0,AG:0,CFC:0.326,CFS
        R:0.082,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: f8ee75e034d249e78de128520a5baf80-20220110
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1, 1
X-UUID: f8ee75e034d249e78de128520a5baf80-20220110
X-User: weirongguang@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <weirongguang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1379409369; Mon, 10 Jan 2022 14:27:06 +0800
From:   weirongguang <weirongguang@kylinos.cn>
To:     sergio.paracuellos@gmail.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: mt7621: Add missing arch include 'asm/mips-cps.h' to avoid implicit function declarations
Date:   Mon, 10 Jan 2022 14:14:03 +0800
Message-Id: <20220110061403.546389-1-weirongguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rongguang Wei<weirongguang@kylinos.cn>

When compile the latest kernel in x86 platform and
the build environment like this:

Compiler: gcc
Compiler version: 10
Compiler string: mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
Cross-compile: mips-linux-gnu-

It make a compile error:

drivers/pci/controller/pcie-mt7621.c: In function 'setup_cm_memory_region':
drivers/pci/controller/pcie-mt7621.c:224:6: error: implicit declaration of function 'mips_cps_numiocu' [-Werror=implicit-function-declaration]
  224 |  if (mips_cps_numiocu(0)) {
      |      ^~~~~~~~~~~~~~~~
drivers/pci/controller/pcie-mt7621.c:232:3: error: implicit declaration of function 'write_gcr_reg1_base'; did you mean 'write_gc0_ebase'? [-Werror=implicit-function-declaration]
  232 |   write_gcr_reg1_base(entry->res->start);
      |   ^~~~~~~~~~~~~~~~~~~
      |   write_gc0_ebase
drivers/pci/controller/pcie-mt7621.c:233:3: error: implicit declaration of function 'write_gcr_reg1_mask'; did you mean 'write_gc0_pagemask'? [-Werror=implicit-function-declaration]
  233 |   write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
      |   ^~~~~~~~~~~~~~~~~~~
      |   write_gc0_pagemask
drivers/pci/controller/pcie-mt7621.c:233:30: error: 'CM_GCR_REGn_MASK_CMTGT_IOCU0' undeclared (first use in this function)
  233 |   write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/pci/controller/pcie-mt7621.c:233:30: note: each undeclared identifier is reported only once for each function it appears in
In file included from ./include/linux/device.h:15,
                 from ./include/linux/of_platform.h:9,
                 from drivers/pci/controller/pcie-mt7621.c:26:
drivers/pci/controller/pcie-mt7621.c:235:25: error: implicit declaration of function 'read_gcr_reg1_base'; did you mean 'read_gc0_ebase'? [-Werror=implicit-function-declaration]
  235 |     (unsigned long long)read_gcr_reg1_base(),
      |                         ^~~~~~~~~~~~~~~~~~
./include/linux/dev_printk.h:110:23: note: in definition of macro 'dev_printk_index_wrap'
  110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
      |                       ^~~~~~~~~~~
drivers/pci/controller/pcie-mt7621.c:234:3: note: in expansion of macro 'dev_info'
  234 |   dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
      |   ^~~~~~~~
drivers/pci/controller/pcie-mt7621.c:236:25: error: implicit declaration of function 'read_gcr_reg1_mask'; did you mean 'read_gc0_pagemask'? [-Werror=implicit-function-declaration]
  236 |     (unsigned long long)read_gcr_reg1_mask());
      |                         ^~~~~~~~~~~~~~~~~~
./include/linux/dev_printk.h:110:23: note: in definition of macro 'dev_printk_index_wrap'
  110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
      |                       ^~~~~~~~~~~
drivers/pci/controller/pcie-mt7621.c:234:3: note: in expansion of macro 'dev_info'
  234 |   dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
      |   ^~~~~~~~
cc1: all warnings being treated as errors

The problem is that the <asm/mips-cps.h> head file was missing
and it can resolved when include the file.

Fix: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Signed-off-by: Rongguang Wei<weirongguang@kylinos.cn>
---
 drivers/pci/controller/pcie-mt7621.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index b60dfb45ef7b..8a009e427a25 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -29,6 +29,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/sys_soc.h>
+#include <asm/mips-cps.h>
 
 /* MediaTek-specific configuration registers */
 #define PCIE_FTS_NUM			0x70c
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
