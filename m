Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B1770577A
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjEPTij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjEPTi3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B7244A5;
        Tue, 16 May 2023 12:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4096563EC3;
        Tue, 16 May 2023 19:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AE9C433A0;
        Tue, 16 May 2023 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265883;
        bh=j24rSNRgDIgmGiT2yXwRSRo4ZogPVSrZkif28sPhRnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeITFFPyf4T1O9Bk8T43ZhPjTAAH6Vi8ipARvhqNOYnVJGtz4HnVAYe+g/BzZ7026
         fDFAQ+Kwic0E1tpyAEjk9jRaCFQp+kn6j5QUapAXkZVr+cEC/j8Xd57pjknKmNJ40L
         YYnEhKGr6uzcXrPYT/H7qqH1VyhkhaztOT4kZMMxyyb3x1FoZRxS3qYbRHji3EIhxJ
         GIf04p+6OuzTuprxdmvEFq7KckfwLT/GHmqgM9hv9SmOoyBUuMT0F5NhocTm6xphV4
         BngR4+JYE7FOd9LAO6LyB06VqLeGQ76wR+h5GIBrwd5zRDNTjAQuZi2Pu27xvTgXI9
         pzCAFRefSXgnA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 19/20] x86: purgatory: include header for warn() declaration
Date:   Tue, 16 May 2023 21:35:48 +0200
Message-Id: <20230516193549.544673-20-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516193549.544673-1-arnd@kernel.org>
References: <20230516193549.544673-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The purgatory code has uses parts of the decompressor and provides
its own warn() function, but has to include the corresponding
header file to avoid a -Wmissing-prototypes warning.

It turns out that this the function prototype actually differs
from the declaration, so change it to get a constant pointer
in the declaration and the other definition as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/boot/compressed/error.c | 2 +-
 arch/x86/boot/compressed/error.h | 2 +-
 arch/x86/purgatory/purgatory.c   | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/error.c b/arch/x86/boot/compressed/error.c
index c881878e56d3..ce5ed7d8265e 100644
--- a/arch/x86/boot/compressed/error.c
+++ b/arch/x86/boot/compressed/error.c
@@ -7,7 +7,7 @@
 #include "misc.h"
 #include "error.h"
 
-void warn(char *m)
+void warn(const char *m)
 {
 	error_putstr("\n\n");
 	error_putstr(m);
diff --git a/arch/x86/boot/compressed/error.h b/arch/x86/boot/compressed/error.h
index 1de5821184f1..87062dea9a20 100644
--- a/arch/x86/boot/compressed/error.h
+++ b/arch/x86/boot/compressed/error.h
@@ -4,7 +4,7 @@
 
 #include <linux/compiler.h>
 
-void warn(char *m);
+void warn(const char *m);
 void error(char *m) __noreturn;
 
 #endif /* BOOT_COMPRESSED_ERROR_H */
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 7558139920f8..aea47e793963 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -14,6 +14,7 @@
 #include <crypto/sha2.h>
 #include <asm/purgatory.h>
 
+#include "../boot/compressed/error.h"
 #include "../boot/string.h"
 
 u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(".kexec-purgatory");
-- 
2.39.2

