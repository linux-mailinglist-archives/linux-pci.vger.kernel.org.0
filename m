Return-Path: <linux-pci+bounces-7707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1648CA9C7
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F038C1C20EEC
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383E254277;
	Tue, 21 May 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="L2TJo5Sy"
X-Original-To: linux-pci@vger.kernel.org
Received: from zdiv.net (xvm-107-148.dc0.ghst.net [46.226.107.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7115466C
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.107.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279157; cv=none; b=X2x6LDSoeTVSllZYQ9nQnjQORCF4P9au8/NlgpNQDuBPHQCU0DeSiYdfUSCTQ58nKo3c/z410YC2CDEBhcgWuJTPEkEKpfVtbbknZm3XKRE+zRSTA0KXOCDieRI3X6d6NxvpNCTbhl0/Vzi6xtx+CTtGf7Z/eoPjeuDYy0xMnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279157; c=relaxed/simple;
	bh=NC2zd3zZ/ZMq8iGRkKb9PG4VAcRkLw072Zwh3HBuoVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtpkkhO8GXKq5qNGW3IAMIG1UCp7ndfBwZTVvmEFiCWr44W9sSkCHYq1cjzLujC0KcLmDKefa7aLlK4RYOTPn+21JIhbAjtpT2XhsWsb8jfSahN6uslrfH8CceJ+qMsPgwbK6lRBVAnE6gzfCFb3yLfz6x+2N2x1bK709AjBPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=L2TJo5Sy; arc=none smtp.client-ip=46.226.107.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=23;
	t=1716278753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tW+pqP2qc+8ucfOdj6XxpJno7Db4XjyR+FosIfHdcoY=;
	b=L2TJo5SyDSB5vK9RFZc8puNyIWY/9fJWnz662XmKAlEGV5E6c6JDfGeEX2Q5Up88EadzRA
	VDdxkiHI9VHcEdd9aCDG9CaUIoCKdduJYkGLCvN4uVOkj4ppjNzIEBdlPp8+bcvKodDyYf
	10O2L0OyLAqI8mfguiKBcPYTm1VQnNJjt6sBxAHecMb0nP3FI779WiHJUEKuBxgsaV8AkH
	hnsZ14bfLcUzBB3IO6uxTSN7YXK2pZI8P1GyNQRyF4oogTagsmjCxJ+VNMVB0OGMIjayQB
	ezm8TVecH/rBi+sqm9yZAJreW7GlFOXfdY8PxIs6/1Thmw3GXcPyx8+zWGVA/g==
Received: from mini.my.domain (91-160-75-97.subs.proxad.net [91.160.75.97])
	by zdiv.net (OpenSMTPD) with ESMTPSA id 617baff8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 08:05:53 +0000 (UTC)
From: Jules Maselbas <jmaselbas@zdiv.net>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
	Jules Maselbas <jmaselbas@zdiv.net>
Subject: [RESEND PATCH] libpci: sysfs: Fix segmentation fault by including libgen.h
Date: Tue, 21 May 2024 10:05:19 +0200
Message-ID: <20240521080519.7833-1-jmaselbas@zdiv.net>
X-Mailer: git-send-email 2.45.0
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


