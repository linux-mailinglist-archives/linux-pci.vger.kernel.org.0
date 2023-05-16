Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5470574F
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjEPThP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEPThO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:37:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B6B9;
        Tue, 16 May 2023 12:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1BB563E89;
        Tue, 16 May 2023 19:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98313C433A4;
        Tue, 16 May 2023 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265804;
        bh=LoIviGdfSLH1ko7JOljz+WAWBtvFrxU7baITA30Kitg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0SoTDZCBXANhO1JcRHoynXaLVhlO4XJ4vTd5g+5q0mXl9+dwihXQSjEJ2aF5PXD/
         YJxxo2zEzGeYvPkjnpK4ydF8PNotm4sCoP7sIPFgPh0+jYX3ClFJbP9hWa/pr/81FH
         rmiMLwAicNzJUMwErqx6DSJsta/whdlp/sC/tZT1cvxj5paHYr0r+8Nyyo5u5xkv5T
         3r84XCOMO59rOsDFBM8wNIcW0zhbFHV1ety++q1mSUr8ScvUEZcAnGwKVpfu1h2uwR
         waDu2tWolCE9YEYKKmG7d67vPlyLJ4ZYk6cOavjtt4C56mPdY+e8uvRCKegTvnFXKC
         xnJG4ywBEjUvw==
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
Subject: [PATCH 06/20] x86: math-emu: include asm/fpu/regset.h
Date:   Tue, 16 May 2023 21:35:35 +0200
Message-Id: <20230516193549.544673-7-arnd@kernel.org>
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

The fpregs_soft_set/fpregs_soft_get functions are declared in a
header that is not included in the file that defines them, causing
a W=1 warning:

/home/arnd/arm-soc/arch/x86/math-emu/fpu_entry.c:638:5: error: no previous prototype for 'fpregs_soft_set' [-Werror=missing-prototypes]
  638 | int fpregs_soft_set(struct task_struct *target,
      |     ^~~~~~~~~~~~~~~
/home/arnd/arm-soc/arch/x86/math-emu/fpu_entry.c:690:5: error: no previous prototype for 'fpregs_soft_get' [-Werror=missing-prototypes]
  690 | int fpregs_soft_get(struct task_struct *target,

Include the file here to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/math-emu/fpu_entry.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 7fe56c594aa6..91c52ead1226 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -32,6 +32,7 @@
 #include <asm/traps.h>
 #include <asm/user.h>
 #include <asm/fpu/api.h>
+#include <asm/fpu/regset.h>
 
 #include "fpu_system.h"
 #include "fpu_emu.h"
-- 
2.39.2

