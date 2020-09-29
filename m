Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83F727DAAB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgI2VrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbgI2VrV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 17:47:21 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23884C0613D8
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id v187so4108014pgv.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5ADrbIYYdkQ2THetWVdXFRMGM/F7dNAyZUNR6Ura+J8=;
        b=MekhgGdQDfVYCDwXqPqLOmRuR7bDrOrx74bKs36BEL9DMLEqc3GHdIW78xNvVW+CXD
         OBR1TA7PPlKp15z5Yvt6TGU00YrPE6jEVmJU2/BObk6f58edi9mDYneayNLG3BF+85eI
         JjVCIO2RNOdO/LFMDVGntOPmSZ80VCfWnW6rDxt2eRzeZ6jXgiYTuMIacuHOI7Agk84Q
         /EqGu8oBcu0EPNuoFAiQuSJKYV61YqkH23yEvB8gadt3EGDYNx7DqA1r7P5qUmqJEEld
         mLCeOrbo1nSD3wVfre9ST4vF2Q7dHDbNvEpQKR0fdUlOz46fHVxsu7B8etms0FiNNoqi
         jwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5ADrbIYYdkQ2THetWVdXFRMGM/F7dNAyZUNR6Ura+J8=;
        b=P2x51zNBi91E0R9SgrlwIvP6dJsxvUSBvvqpaDo6v+rIiGb2iaOzA2HZ2330VwL768
         3eib1YgyoexbYyGFxqrG/iOshj2kf3Se8dIqUujsA6Ff4gFqpC3TKYFxr3Tqcjvwbm3E
         9KB+iKil7m4CCyY8SkYwv2cpytrRv3EFucg0WpIcdgynUGNautMBxlRTBS9SyUzCIug2
         Bs5/fgb89g7K2ECDtYWS914WUmfFw8KRxo0BrnczfgsbYFi2eiNr8IkUi0tnCW5pLe/r
         VX5xVCUDlZAJTqxcPSMc0R3mJTQF+HvtIx3o7Mxmd4DCl2gAimLOWcn4vPsC8UZR6H+g
         q7yQ==
X-Gm-Message-State: AOAM533a5qUCmmMDpQQnLHMTeb12eDDUnMx03rs91OzJj8ay1Zic+bqH
        sD10xqV0bI3n3TVbNu7Q0TovnrAlbud3NmsXtpI=
X-Google-Smtp-Source: ABdhPJyEka8NWg0904uGqV+IPTNA4hO1MufGCj8cRerlSixJNEwhSMmuf5P+grySLqv5SKpAniKp5seVaNsVmut9k5g=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a63:ff63:: with SMTP id
 s35mr4883241pgk.14.1601416036594; Tue, 29 Sep 2020 14:47:16 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:21 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 19/29] PCI: Fix PREL32 relocations for LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With Clang's Link Time Optimization (LTO), the compiler can rename
static functions to avoid global naming collisions. As PCI fixup
functions are typically static, renaming can break references
to them in inline assembly. This change adds a global stub to
DECLARE_PCI_FIXUP_SECTION to fix the issue when PREL32 relocations
are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/pci.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..4e64421981c7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1909,19 +1909,28 @@ enum pci_fixup_pass {
 };
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
-				    class_shift, hook)			\
-	__ADDRESSABLE(hook)						\
+#define ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				    class_shift, hook, stub)		\
+	void stub(struct pci_dev *dev);					\
+	void stub(struct pci_dev *dev)					\
+	{ 								\
+		hook(dev); 						\
+	}								\
 	asm(".section "	#sec ", \"a\"				\n"	\
 	    ".balign	16					\n"	\
 	    ".short "	#vendor ", " #device "			\n"	\
 	    ".long "	#class ", " #class_shift "		\n"	\
-	    ".long "	#hook " - .				\n"	\
+	    ".long "	#stub " - .				\n"	\
 	    ".previous						\n");
+
+#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook, stub)		\
+	___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook, stub)
 #define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
 				  class_shift, hook)			\
 	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
-				  class_shift, hook)
+				  class_shift, hook, __UNIQUE_ID(hook))
 #else
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
-- 
2.28.0.709.gb0816b6eb0-goog

