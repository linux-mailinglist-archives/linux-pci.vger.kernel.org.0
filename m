Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9FC340B3E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhCRRLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbhCRRLU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:11:20 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE243C061762
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:20 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j3so30367083qvo.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bTCEWvQMjkTW/eVBx3Fi28gIb6vhFXkJKuQZd7egWL4=;
        b=QM8OLA42Fm+EJhSNbxgSxVvavuc0ct1+LtSBad1ujRa/OzI2Sowpd5cVK5d0O16hO8
         uC2iMD4ZsB/rqG1ibhH0g8xsGLCFm9x2/25I+DF+OQl1Tp4Zg0L0mp971oSaCRNAfmOw
         7T/2advDlbtcf9VqAEsJxAvqR/ynMYkjAIGf9g/WeJetJJtkJK54+yUsHEq1VvoRePUJ
         WjqokvZG+GIY9pOOXNtMIiqWaWTnZHTrE+mpb6S+aGII/qO6ro0/KVVDvaitknQFsCyD
         Gjv7qk0Hj97HRxdkYp4vKMy9MbiCmotBT002R6BVFJdzDdPQXIQZkv9qEh7QBRt4tywX
         RLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bTCEWvQMjkTW/eVBx3Fi28gIb6vhFXkJKuQZd7egWL4=;
        b=Mi3KeXAdZeY5V7ZIrn16OlGuMX9cPz6Af1YZ4XaBo5wMfrm+f1k+yNnM6ueh/eSLcG
         T9+O6q+7EJE4hgZxvvhsxuFe95CXuYDysn545lUaPCBO07oQoIYVePVNqzQnL0p6j15V
         utAGt1Wme8qW+U6WIM5YInHOFZpHeMCeor74ynPBqTSRtUG2VSEkiW37JjeVRVmLOEy2
         LBmwRo9obw1frvUzBqsgxoNYeJuxoj9HaZJI8fVGGDw360m2pt2YGcuD5V7piSTPNPpT
         g3KbDym93oqOr0zdlBPdYmHxTC0qZdQsnwi8k4magoJT5lO0+AoQ11cAryZ1kXzZGfEz
         V2sw==
X-Gm-Message-State: AOAM533lJNzr90rtv0Ytskpa7Z0d3uVgFBxd6JAPCuSHMVVl9hkg34YV
        E4MBdaXZtR1PVPpABJtJE/f6uS6+Ks/vdTJP/bg=
X-Google-Smtp-Source: ABdhPJwKwcToOfhCBTwXzQOiIF7vT2J3y29SKQntX1XhREjSGT+g+sCTqRnigKZhWgl0MUUC1k4zzyQm6rc2YIEytFI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5bc9:: with SMTP id
 t9mr5270737qvt.61.1616087479813; Thu, 18 Mar 2021 10:11:19 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:10:56 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 02/17] cfi: add __cficanonical
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces a function address taken
in C code with the address of a local jump table entry, which passes
runtime indirect call checks. However, the compiler won't replace
addresses taken in assembly code, which will result in a CFI failure
if we later jump to such an address in instrumented C code. The code
generated for the non-canonical jump table looks this:

  <noncanonical.cfi_jt>: /* In C, &noncanonical points here */
	jmp noncanonical
  ...
  <noncanonical>:        /* function body */
	...

This change adds the __cficanonical attribute, which tells the
compiler to use a canonical jump table for the function instead. This
means the compiler will rename the actual function to <function>.cfi
and points the original symbol to the jump table entry instead:

  <canonical>:           /* jump table entry */
	jmp canonical.cfi
  ...
  <canonical.cfi>:       /* function body */
	...

As a result, the address taken in assembly, or other non-instrumented
code always points to the jump table and therefore, can be used for
indirect calls in instrumented code without tripping CFI checks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # pci.h
---
 include/linux/compiler-clang.h | 1 +
 include/linux/compiler_types.h | 4 ++++
 include/linux/init.h           | 4 ++--
 include/linux/pci.h            | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 6de9d0c9377e..adbe76b203e2 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -63,3 +63,4 @@
 #endif
 
 #define __nocfi		__attribute__((__no_sanitize__("cfi")))
+#define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 796935a37e37..d29bda7f6ebd 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -246,6 +246,10 @@ struct ftrace_likely_data {
 # define __nocfi
 #endif
 
+#ifndef __cficanonical
+# define __cficanonical
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/include/linux/init.h b/include/linux/init.h
index b3ea15348fbd..045ad1650ed1 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -220,8 +220,8 @@ extern bool initcall_debug;
 	__initcall_name(initstub, __iid, id)
 
 #define __define_initcall_stub(__stub, fn)			\
-	int __init __stub(void);				\
-	int __init __stub(void)					\
+	int __init __cficanonical __stub(void);			\
+	int __init __cficanonical __stub(void)			\
 	{ 							\
 		return fn();					\
 	}							\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..39684b72db91 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1944,8 +1944,8 @@ enum pci_fixup_pass {
 #ifdef CONFIG_LTO_CLANG
 #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
 				  class_shift, hook, stub)		\
-	void stub(struct pci_dev *dev);					\
-	void stub(struct pci_dev *dev)					\
+	void __cficanonical stub(struct pci_dev *dev);			\
+	void __cficanonical stub(struct pci_dev *dev)			\
 	{ 								\
 		hook(dev); 						\
 	}								\
-- 
2.31.0.291.g576ba9dcdaf-goog

