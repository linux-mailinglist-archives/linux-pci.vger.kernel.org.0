Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B94705768
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjEPTiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEPThy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CB3C10;
        Tue, 16 May 2023 12:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23FF66372E;
        Tue, 16 May 2023 19:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB46C433D2;
        Tue, 16 May 2023 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265828;
        bh=9mGjBlJh/v4od95uyV8nA9/tvAI7Fp8HXXcZE+gBPXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dchZZo9WqmTT5pXqQ91IEEzoZcfaltTNsqPX8uCQB2EtS7z6X18KvPkxGsTqXf4Im
         FZs0O9Gu21RgjwUSracQfDCkupgQf81CrS65a+HuQhXicxa375U5tO5k2auE3ZkfIX
         SKZBxS0YIyNz60tANL/6BP3KH5Ub5veXwRzbRJxH/VCBU7GKgNIbVhmkVUIQ8Vs5kv
         5GszcMPQCxAVwJPTq5LqISilKOY4ClP6e9zRYaqOL34Yi0tc5tzpXafXUnVrKXNOO3
         TsvuruEr2W76ZTF/RJBhwZwLfH80cVdeikTgUUcvyM1yAbkQhHNiX6snxmVt/CTQZJ
         lgJDvr4/QBZSw==
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
Subject: [PATCH 10/20] x86: xen: add missing prototypes
Date:   Tue, 16 May 2023 21:35:39 +0200
Message-Id: <20230516193549.544673-11-arnd@kernel.org>
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

arch/x86/xen/enlighten_pv.c:1233:34: error: no previous prototype for 'xen_start_kernel' [-Werror=missing-prototypes]
arch/x86/xen/irq.c:22:14: error: no previous prototype for 'xen_force_evtchn_callback' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:358:20: error: no previous prototype for 'xen_pte_val' [-Werror=missing-prototypes]
arch/x86/xen/mmu_pv.c:366:20: error: no previous prototype for 'xen_pgd_val' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/xen/efi.c     |  2 ++
 arch/x86/xen/smp.h     |  3 +++
 arch/x86/xen/xen-ops.h | 14 ++++++++++++++
 include/xen/xen.h      |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 7d7ffb9c826a..863d0d6b3edc 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -16,6 +16,8 @@
 #include <asm/setup.h>
 #include <asm/xen/hypercall.h>
 
+#include "xen-ops.h"
+
 static efi_char16_t vendor[100] __initdata;
 
 static efi_system_table_t efi_systab_xen __initdata = {
diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
index 22fb982ff971..cbc45e2462f5 100644
--- a/arch/x86/xen/smp.h
+++ b/arch/x86/xen/smp.h
@@ -2,6 +2,9 @@
 #ifndef _XEN_SMP_H
 
 #ifdef CONFIG_SMP
+
+asmlinkage void cpu_bringup_and_idle(void);
+
 extern void xen_send_IPI_mask(const struct cpumask *mask,
 			      int vector);
 extern void xen_send_IPI_mask_allbutself(const struct cpumask *mask,
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 6d7f6318fc07..0f71ee3fe86b 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -160,4 +160,18 @@ void xen_hvm_post_suspend(int suspend_cancelled);
 static inline void xen_hvm_post_suspend(int suspend_cancelled) {}
 #endif
 
+void xen_force_evtchn_callback(void);
+pteval_t xen_pte_val(pte_t pte);
+pgdval_t xen_pgd_val(pgd_t pgd);
+pte_t xen_make_pte(pteval_t pte);
+pgd_t xen_make_pgd(pgdval_t pgd);
+pmdval_t xen_pmd_val(pmd_t pmd);
+pmd_t xen_make_pmd(pmdval_t pmd);
+pudval_t xen_pud_val(pud_t pud);
+pud_t xen_make_pud(pudval_t pud);
+p4dval_t xen_p4d_val(p4d_t p4d);
+p4d_t xen_make_p4d(p4dval_t p4d);
+pte_t xen_make_pte_init(pteval_t pte);
+void xen_start_kernel(struct start_info *si);
+
 #endif /* XEN_OPS_H */
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0efeb652f9b8..f989162983c3 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -31,6 +31,9 @@ extern uint32_t xen_start_flags;
 
 #include <xen/interface/hvm/start_info.h>
 extern struct hvm_start_info pvh_start_info;
+void xen_prepare_pvh(void);
+struct pt_regs;
+void xen_pv_evtchn_do_upcall(struct pt_regs *regs);
 
 #ifdef CONFIG_XEN_DOM0
 #include <xen/interface/xen.h>
-- 
2.39.2

