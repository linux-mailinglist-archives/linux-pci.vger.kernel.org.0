Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D771F3523DF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Apr 2021 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhDAXdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 19:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbhDAXdK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 19:33:10 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8443FC061794
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 16:32:42 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id i1so4298547qvu.12
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h2cUBfrxKiLvUm4K3FiEqQsW7/CwbTTOloFCTdH2CHs=;
        b=WwXYJEUtzPp5OgieXNSDH1jlEl5JZ0W/R7AL0K533fvUhOWdAZ9AGUs2eGGOPAXoOV
         9ozbSMsvBM3fx5D5LtP6Wwj5vTRMKtVGliPsMJFstImK8hWqbNvneO11EFMHlgjN9j8E
         Gxgb+CYWv9/NMpO603YX/M1xglU8wTRB2je50aC09bt/Q+N13fSJMOHOutVU+FJW8VRH
         buFVQ6JhTKnPP9sHJSvuwhCmHBM3KlHMmvtXp8wtpQYRTn/+3gN0dNfz6qElxu5IW19P
         6wyJ5fhugbFhtzg1oHjkOAL/OAUuMNDm5YMcIesJpyOU9dDyMEApglZuAgeX/R91ZsV9
         QlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h2cUBfrxKiLvUm4K3FiEqQsW7/CwbTTOloFCTdH2CHs=;
        b=Ql0CqEI1/VAwKupa/YTJZw+s4QeWLriZ4Bcv7txhA32jXQgGEUKWZOhs2/W18NT7zG
         4t4KYL2KJWMOvKVzzuAkC1K9cN33dL09IOktvDh5YW0uql9zjvP1cMqfbTK/NenmgjdE
         WkcwUK12Rwn9UodexOCVIbxp2xbdRdAmpm/gySTjWw0dpC3QyjMkcHM9BJBtymPz14ca
         R5FYwka4tiq4lGfHCnYrZ+2V5cLtlFSmkM8qu/0CbUzidgosGcUW3aspwgQbaCYZ3Hzp
         otm+kQJJ2PrGupjQSaNRgXkN/SP7erA1cIp6LWn7YEH6iJOiJVzW7UyvDab5csuS7Q5a
         /7hQ==
X-Gm-Message-State: AOAM531g8L9rWdb8sBFbjLItChmaGEUNaI/TXx/k89M4eA5lM+iepj0+
        LwrAiVfnLhfUHjG8SSBw3OG0KKnezx+rHcdi3wc=
X-Google-Smtp-Source: ABdhPJziT3D45uCf3xMud/lYL8zWHTujTbizJ/biGPptb9CAf5S2oQq2ohDlzAjndytnNYlfJC1g6e8VKQiUGTMfQg8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:eb87:: with SMTP id
 x7mr10859482qvo.14.1617319961673; Thu, 01 Apr 2021 16:32:41 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:09 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 11/18] psci: use function_nocfi for cpu_resume
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which results in __pa_symbol returning the
physical address of the jump table entry. As the jump table contains
an immediate jump to an EL1 virtual address, this typically won't
work as intended. Use function_nocfi to get the actual address of
cpu_resume.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/psci/psci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429cae3f..64344e84bd63 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -325,8 +325,9 @@ static int __init psci_features(u32 psci_func_id)
 static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
+	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
 
-	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }
 
 int psci_cpu_suspend_enter(u32 state)
@@ -344,8 +345,10 @@ int psci_cpu_suspend_enter(u32 state)
 
 static int psci_system_suspend(unsigned long unused)
 {
+	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      pa_cpu_resume, 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.31.0.208.g409f899ff0-goog

