Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE2747B3B7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 20:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhLTT3q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 14:29:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51120 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhLTT3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 14:29:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44BFD612D2
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 19:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F857C36AE7;
        Mon, 20 Dec 2021 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640028584;
        bh=4QjtcY+xQp8d4klr39UbOl7J3RkM+RRAYmI05+Gjc90=;
        h=From:To:Subject:Date:From;
        b=dQsaSXJUUN3We5YiWHIOnAA9VQi+5A7CqhpysctNW631RxqSoPUhvszwY3Z0+kaum
         /kBrnB4izDdYMMeYRr4PbOCyfJR/k6U3BdZZYW2PuIVt6/ddCRF75hhsCCDtbq2tUm
         lRsYRbZAi71IxHi4h04rJPAjrJy+ZcqgZmi3EBLLLrrRJzL7ZThkzdgSa1XfIKqfQ5
         9qNv92J8N8ps1lSDvy1oBwbdqzFWayzCMKi81VvMhKaHSYsXV2ai3C8qN7zxwi+Ec4
         I5ZUyWrIag+MaR7UMp+EZ/UCHcfbk/Phbv7TRco5eztiqUhcQbOIippS/ybGkwIWHd
         feEbhpY7BrcZw==
Received: by pali.im (Postfix)
        id E559287B; Mon, 20 Dec 2021 20:29:41 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils] libpci: Fix intel_cleanup_io() implementations
Date:   Mon, 20 Dec 2021 20:28:43 +0100
Message-Id: <20211220192843.15052-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function intel_cleanup_io() should de-initialize I/O port access, e.g. by
calling iopl(0) to reset I/O privilege level to default value.

Caller of intel_cleanup_io() expects that this function returns negative
value on success and positive value on error. Error means that I/O port
access was not de-initialized and is still active. Success means that I/O
port access is not active anymore and intel_setup_io() needs to be called
again to access I/O ports.

Fix Cygwin, Haiku and Linux implementations of intel_cleanup_io() function
to correctly de-initialize I/O port access and fix return value.
---
 lib/i386-io-cygwin.h | 2 +-
 lib/i386-io-haiku.h  | 2 +-
 lib/i386-io-linux.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/i386-io-cygwin.h b/lib/i386-io-cygwin.h
index 16022482f268..038b02d00a94 100644
--- a/lib/i386-io-cygwin.h
+++ b/lib/i386-io-cygwin.h
@@ -17,7 +17,7 @@ intel_setup_io(struct pci_access *a UNUSED)
 static inline int
 intel_cleanup_io(struct pci_access *a UNUSED)
 {
-  iopl(3);
+  iopl(0);
   return -1;
 }
 
diff --git a/lib/i386-io-haiku.h b/lib/i386-io-haiku.h
index 2bbe592672ab..5c724b34e98a 100644
--- a/lib/i386-io-haiku.h
+++ b/lib/i386-io-haiku.h
@@ -72,7 +72,7 @@ static inline int
 intel_cleanup_io(struct pci_access *a UNUSED)
 {
   close(poke_driver_fd);
-  return 1;
+  return -1;
 }
 
 static inline u8
diff --git a/lib/i386-io-linux.h b/lib/i386-io-linux.h
index b39b4eb8267d..619f8ec11695 100644
--- a/lib/i386-io-linux.h
+++ b/lib/i386-io-linux.h
@@ -17,7 +17,7 @@ intel_setup_io(struct pci_access *a UNUSED)
 static inline int
 intel_cleanup_io(struct pci_access *a UNUSED)
 {
-  iopl(3);
+  iopl(0);
   return -1;
 }
 
-- 
2.20.1

