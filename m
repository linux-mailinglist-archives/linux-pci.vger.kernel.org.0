Return-Path: <linux-pci+bounces-6900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94548B7DF6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 19:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C281C23BF9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434721802CB;
	Tue, 30 Apr 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="HbBuP5Qm"
X-Original-To: linux-pci@vger.kernel.org
Received: from zdiv.net (xvm-107-148.dc0.ghst.net [46.226.107.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4921C187
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.107.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495922; cv=none; b=XA5BHT7ZHguV3RZqNZDQ/x351i/GMw08jVH+ZkMZvTUn0ydq/TjyGI6epSIlZhlYtSmp3srIZKlNobh21h1kf0roZla9WIsQ/lwiNyR8iYJqn8H+SppRT75GYsuRGuZzS2F7tCxjM04sxs2PPBbTvT/ZnRcgrE8PlMWyFJSOWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495922; c=relaxed/simple;
	bh=NC2zd3zZ/ZMq8iGRkKb9PG4VAcRkLw072Zwh3HBuoVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvHPDdJiC08B81IOrgn/jLX42Qa5QczslEdQqMXEGIZokabdL2qfkSgrTyhh3opzBd95NCS8dyfWcAgNczCbs5QtRcdaMNIc/OiTX45r2TzKd/RsNjFsvciZRxjt6bFOq6jVBq8uAAQ+OlMuXyTC2pq4iicPzp28c/QcFGgM5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=HbBuP5Qm; arc=none smtp.client-ip=46.226.107.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=23;
	t=1714495918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tW+pqP2qc+8ucfOdj6XxpJno7Db4XjyR+FosIfHdcoY=;
	b=HbBuP5QmnKSRMmfyuei22itnswjloyFMUO8kPQzYMQKDYgctK/VP6meZT5X6PrT18+hhHb
	4b2MtMBCBc7CyArTNDiUAj1Gbk2RHwR4F/rmRhcclkDZJIYXTbaoHq4C0xUJIC4jW5H+xB
	VuTpPLVq0iOCPnrXU4b57vuMfgUzwCYf1mgtVFjoAln33lgZN2rzkpn2ewnjcWMYaX4LHv
	vOAKDCY9VPkN7wVO6KYvspmuK6/prXvs5u88c5dDI8VezByxaqBVpDKGzaNjLD7FmwbHFV
	TQHKtBsuaz2MNQA+ODVtzQFew+HSzymc963nglUufx8eWxQctw1UNe4lnl/tJg==
Received: from mini.my.domain (91-160-75-97.subs.proxad.net [91.160.75.97])
	by zdiv.net (OpenSMTPD) with ESMTPSA id 1d600fc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 16:51:57 +0000 (UTC)
From: Jules Maselbas <jmaselbas@zdiv.net>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
	Jules Maselbas <jmaselbas@zdiv.net>
Subject: [PATCH] libpci: sysfs: Fix segmentation fault by including libgen.h
Date: Tue, 30 Apr 2024 18:51:21 +0200
Message-ID: <20240430165121.25143-1-jmaselbas@zdiv.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a musl-based system (Alpine-linux) the basename(3) function is not defined
by including string.h with _GNU_SOURCE defined. However basename(3) could be
defined by including libgen.h.

On musl this is a problem than can lead to a segmentation fault, as I have
experienced. This issue is caused by basename(3) function being implicitly
declared and thus having, implicitly, a return type of int. Which in my case
caused an erroneous sign extension of a pointer leading to a segmentation
fault.

Adding an include for libgen.h sound to me like a proper solution.
Also by doing so the `_GNU_SOURCE` defined is no longer needed.


You can find below details on the issue, on alpine linux (x86_64) running:
    $ lspci -s 00:01.0 -v
    00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h-19h PCIe Dummy Host Bridge (rev 01)
    Segmentation fault

After debugging, the fault is indirectly caused by this compilation warning:
    sysfs.c: In function 'sysfs_fill_info':
    sysfs.c:457:53: warning: implicit declaration of function 'basename' [-Wimplicit-function-declaration]
      457 |           pci_set_property(d, PCI_FILL_IOMMU_GROUP, basename(group_link));
          |                                                     ^~~~~~~~
    sysfs.c:457:53: warning: passing argument 3 of 'pci_set_property' makes pointer from integer without a cast [-Wint-conversion]
      457 |           pci_set_property(d, PCI_FILL_IOMMU_GROUP, basename(group_link));
          |                                                     ^~~~~~~~~~~~~~~~~~~~ int

Here is the relevant assembly, dump from gdb:
    0x7ffff7f4f072  call   *0x5db8(%rip)  # call to basename
    0x7ffff7f4f078  mov    %rbx,%rdi
    0x7ffff7f4f07b  mov    $0x4000,%esi   # PCI_FILL_IOMM_GROUP
    0x7ffff7f4f080  movslq %eax,%rdx      # return value of basename is signed extended from 32bit (eax) to 64bit (rdx)
    0x7ffff7f4f083  call   0x7ffff7f4831b # call to pci_set_property

And how the address becomes invalid:
    (gdb) x/s 0x7ffff7ffed20 # argument of basename
    0x7ffff7ffed20: "/sys/kernel/iommu_groups/0"
    (gdb) x/s 0x7ffff7ffed39 # result from basename
    0x7ffff7ffed39: "0"
    (gdb) x/s 0xfffffffff7ffed39 # after sign extension
    0xfffffffff7ffed39:     <error: Cannot access memory at address 0xfffffffff7ffed39>

Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
---
 lib/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 0e763dc..1644e51 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -9,11 +9,10 @@
  *	SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <libgen.h>
 #include <stdarg.h>
 #include <unistd.h>
 #include <errno.h>
-- 
2.44.0


