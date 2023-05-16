Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B579F70575D
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjEPThs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEPThj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B7A26F;
        Tue, 16 May 2023 12:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 456B663EA5;
        Tue, 16 May 2023 19:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D45FC433EF;
        Tue, 16 May 2023 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265834;
        bh=+aTnWzkkpkhZD/Q7mAQ3dRAZxC9ekU9RPhso/2vdjUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMBAvFb2VaJhJEHCkXY8xN9dopzfCYxzGAVtlxmPc4ecgoxsfcVqAYWppizbCyYp/
         VTvljPsItuhT+KslruGdf17RZHnkXZTeI5SNB0HcVA3Q2is1QzaTJ7NIWpw6KBUWf/
         zV4XavdE98t65jnuE5hyhNvdFmgDjcz0+x8JQ3Pa2M+Ke5oMTbpixoiurollUeJB73
         blh6OUjzwzOwaiTkJeA6SFn1+VvUJj1MKmXFKzsle/9hQMjVA4gOvU8RBqzqzy+ig5
         svmuwCrWyPhEepXDnslmThYsgGibYlGdcBhMAypATUJEGwuGF8kbOigthqqwhCFfB8
         Ic0+xYNIrQ58Q==
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
Subject: [PATCH 11/20] x86: entry: add  do_SYSENTER_32() prototype
Date:   Tue, 16 May 2023 21:35:40 +0200
Message-Id: <20230516193549.544673-12-arnd@kernel.org>
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

The 32-bit system call entry points can be called on both 32-bit
and 64-bit kernels, but on the former the declarations are hidden:

arch/x86/entry/common.c:238:24: error: no previous prototype for 'do_SYSENTER_32' [-Werror=missing-prototypes]

Move them all out of the #ifdef block to avoid the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/syscall.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 5b85987a5e97..4fb36fba4b5a 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -127,9 +127,11 @@ static inline int syscall_get_arch(struct task_struct *task)
 }
 
 void do_syscall_64(struct pt_regs *regs, int nr);
-void do_int80_syscall_32(struct pt_regs *regs);
-long do_fast_syscall_32(struct pt_regs *regs);
 
 #endif	/* CONFIG_X86_32 */
 
+void do_int80_syscall_32(struct pt_regs *regs);
+long do_fast_syscall_32(struct pt_regs *regs);
+long do_SYSENTER_32(struct pt_regs *regs);
+
 #endif	/* _ASM_X86_SYSCALL_H */
-- 
2.39.2

