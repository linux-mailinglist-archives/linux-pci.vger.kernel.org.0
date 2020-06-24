Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BFB207D5C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406623AbgFXUdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406610AbgFXUdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 16:33:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51A0C061797
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:38 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id da10so2517925qvb.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tvg1Fbryi0kMABLSJZV+2LlG9cMfXZohRvKr2b10/ew=;
        b=qDi1kJQp6Ay8PowzBhvgcAgfJKyEY22DJ3SehuRqjn/jA9tuCP3XgBFwyavVII/8H8
         +qDUOb2y6OKXwsbI5cxksI3QZk1MHXAA03OHDhdjTbrRcF9EMaP1PLIUJPhY0/usboE5
         WysdzKDHLGBWRBK078rHZqlAErXt2qVt2sq358db2q+vTaEhfb2Ztz8s+Npc56SUR/GU
         zam+aC0Fi9TXcLLkm/vCwtmB9CZFKkHlUgIzUuWu5eMrmtKdAXKTOQSgFxHw8mPgwD7i
         VrVAm6xkIce/iluM0BjvQMvc/W7Io0XF/CLOQ/Xz7mhbTAKzZSonAVtghl5cbcwT3k0W
         qRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tvg1Fbryi0kMABLSJZV+2LlG9cMfXZohRvKr2b10/ew=;
        b=G/WCZBRGTEatNxKnMFFEpn9Zw+fWweNh8ydBJx0tP0DbVxhpK5c1IsZoTGbiyO8F/A
         hQmQywIIOGwj6a4r1qRF3BdLHhIg5Sfp/Kzu2Soy83/kXOLkzgioakKNELITUbTXXE2m
         jdVTUb9TZMnYx4l4WyIygihZr2HZRCMvIMkXSr4QU9jN/QmPAefAWwqKcne9qcmZWndm
         X4qagDaHKPCZwePkVvzod3a4b1eFu0EC8tK2Ee5zFUBOX9cmztJh4wPo86QAIDzDqYYc
         Wf/b2m+JED7hBiRoHgIQyb8UjW9h2mRyP07MpTdV/j9fAH0/JQLHyWvqRcjbb21PLNCO
         UJyg==
X-Gm-Message-State: AOAM5321xxgywn+QhpnGKmIjsWiYKQ5Yv2GGTGWa0Dwwgue6I2M5ndFR
        CeKEmCV63ZiBfCAYqY7Q/DsX4B6RrK+l1HnDJ4k=
X-Google-Smtp-Source: ABdhPJyl5JOyQAzphL8fSerF19PzJDrN7smlmqxmskm8wB3636prwAzfuisg2Ek7D9XrgzzDEO8QBVxE0nwET9TpJnI=
X-Received: by 2002:a05:6214:846:: with SMTP id dg6mr31350632qvb.210.1593030818021;
 Wed, 24 Jun 2020 13:33:38 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:32:00 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-23-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 22/22] x86, build: allow LTO_CLANG and THINLTO to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig  | 2 ++
 arch/x86/Makefile | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a0cc524882d..df335b1f9c31 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -92,6 +92,8 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_LTO_CLANG		if X86_64
+	select ARCH_SUPPORTS_THINLTO		if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378de8bc0..a1abc1e081ad 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -188,6 +188,11 @@ ifdef CONFIG_X86_64
 KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
 endif
 
+ifdef CONFIG_LTO_CLANG
+KBUILD_LDFLAGS	+= -plugin-opt=-code-model=kernel \
+		   -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
+endif
+
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
-- 
2.27.0.212.ge8ba1cc988-goog

