Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17ED705773
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjEPTiW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEPTiI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592EDA24F;
        Tue, 16 May 2023 12:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71AA863EA8;
        Tue, 16 May 2023 19:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EEEC433D2;
        Tue, 16 May 2023 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265840;
        bh=HzuyPJn9FfyStpC9b/gY3UOkJ1RIpy94E010iL3VMAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyMTmn90wbr/qFgLkHQFxSX2cjoGcxvnL1nVSavn0cO0jwQAdZ0abIUvOOmHaJE4h
         SRKGKH4YuALaqYyeDXwC2rmXjbD8x3uOm+2hb9k6zSm0RE9k2ye4pRA7pKDh/KFcUg
         74ThzTAjh7UyyblnQImUp9i/blUb9mBsmos5h+x7AgL6jhJm2i+7HlTCuZjmpcKHzQ
         a92UzT+0fGfuHuE9dTXbB60MlSLud/EeFS1nvtAW1I2R9HUD4pSyK9Lo7mDNBfABSe
         uLCctFq8BxZkKc2zL5wl5wy4XGrTMum5M9PugMRDnqjPC1nckk1AZSNKzdl5PpJ2N5
         Yjoqi6uLxWodA==
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
Subject: [PATCH 12/20] x86: qspinlock-paravirt: fix mising-prototype warnings
Date:   Tue, 16 May 2023 21:35:41 +0200
Message-Id: <20230516193549.544673-13-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516193549.544673-1-arnd@kernel.org>
References: <20230516193549.544673-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

__pv_queued_spin_unlock_slowpath is defined in a header file as a global
function, and designed to be called from an inline asm, but there is
no prototype visible in the definition:

kernel/locking/qspinlock_paravirt.h:493:1: error: no previous prototype for '__pv_queued_spin_unlock_slowpath' [-Werror=missing-prototypes]

Add this to the x86 header that contains the inline asm calling it,
and ensure this gets included before the definition, rather than
after it.

The native_pv_lock_init function in turn is only declared in SMP
builds but can be left out in UP to avoid another warning:

arch/x86/kernel/paravirt.c:76:13: error: no previous prototype for 'native_pv_lock_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/qspinlock_paravirt.h |  2 ++
 arch/x86/kernel/paravirt.c                |  2 ++
 kernel/locking/qspinlock_paravirt.h       | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 42b17cf10b10..85b6e3609cb9 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -4,6 +4,8 @@
 
 #include <asm/ibt.h>
 
+void __lockfunc __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked);
+
 /*
  * For x86-64, PV_CALLEE_SAVE_REGS_THUNK() saves and restores 8 64-bit
  * registers. For i386, however, only 1 32-bit register needs to be saved
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ac10b46c5832..eb67aa4cc5ef 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -73,11 +73,13 @@ DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
+#ifdef CONFIG_SMP
 void __init native_pv_lock_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
+#endif
 
 unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
 			    unsigned int len)
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 6afc249ce697..6a0184e9c234 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -485,6 +485,16 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
 }
 
+/*
+ * Include the architecture specific callee-save thunk of the
+ * __pv_queued_spin_unlock(). This thunk is put together with
+ * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
+ * function close to each other sharing consecutive instruction cachelines.
+ * Alternatively, architecture specific version of __pv_queued_spin_unlock()
+ * can be defined.
+ */
+#include <asm/qspinlock_paravirt.h>
+
 /*
  * PV versions of the unlock fastpath and slowpath functions to be used
  * instead of queued_spin_unlock().
@@ -533,16 +543,6 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 	pv_kick(node->cpu);
 }
 
-/*
- * Include the architecture specific callee-save thunk of the
- * __pv_queued_spin_unlock(). This thunk is put together with
- * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
- * function close to each other sharing consecutive instruction cachelines.
- * Alternatively, architecture specific version of __pv_queued_spin_unlock()
- * can be defined.
- */
-#include <asm/qspinlock_paravirt.h>
-
 #ifndef __pv_queued_spin_unlock
 __visible __lockfunc void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
-- 
2.39.2

