Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D44358C4D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 20:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhDHS3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhDHS3I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 14:29:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FFFC0613DC
        for <linux-pci@vger.kernel.org>; Thu,  8 Apr 2021 11:28:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y13so2821998ybk.20
        for <linux-pci@vger.kernel.org>; Thu, 08 Apr 2021 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eRIdrbJ2jhHVLL9Tut/j9YYL8eIOqR89a+xPlg5BO0U=;
        b=nmyke+h8npDMiaqZwmNe2cMGG5hnU/u86z+9PT3d46wvKA7EcCFmI0rQdqzR05Y94d
         x+FoWT2ztku/VLu13xl6nOzxWcgAQBZNzaVQoRT/BZKY/QCn5viNJODflkqOHL2h8bIc
         aXPxyU21LsZKarOM3mV+jnfOkvN12Im/BNNAstmefU7NUVKXda8sDV56EdzQGZkRH6HI
         Ge28ESdL5igzDlIGSLdtjCKbzqfFWKAA99mnu1WYMj3ofZprEP9yhJ6F5n03KpOYXGRd
         9RB68j79aY/kCAHYgMOUSzHniKYM03/nbKN1xwcZ+T/TTnJ7hc/Hh/o5UhWr0z4dfbls
         JpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eRIdrbJ2jhHVLL9Tut/j9YYL8eIOqR89a+xPlg5BO0U=;
        b=ivv+2GOd1MJn5RP/+jsUtBDPKZMCeI23jbs6H28jiyOh/k1f2fD52w1awennrO0vxE
         Ip2D++JGqpCCz4A5XjcJizwL+DHwURNT601e1FZGPddPEbXuZ4sUPc2xVvcEMoS6EGki
         xfKNZGBHe1lbccPPVkUJpTwmRNXjOzrmDgblHuqI0G0vpcNGIkcmzG3HW7SmygO1MOD3
         sITRXFEb20ysR717O174R5GDgJbU6k+p8JpfzeuxtU8ekOGiWqqfCg5QWmozlif8X3Xq
         7igq/3iE8W47y0AooimTO9h3lleHnDLmWE2Npb3VrroBONfwX5EPJV8a51+LP1VgTNls
         Fmbw==
X-Gm-Message-State: AOAM532ri9tzZ8rK2pgrl0qqQscwhORALodw4DITPqPI5QINtq0jz5o0
        hfIBaexAh2oDGwW48ehXwiddyxVju0awamR7//Y=
X-Google-Smtp-Source: ABdhPJyMT0E4fOxaTOJdEe713UBqERQEDC7/usw7J6XiontVMo/EZlk1EZRRx22SXnar09N3hws8MrTfLQISf5YJ/HU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a25:3c9:: with SMTP id
 192mr14007073ybd.319.1617906533406; Thu, 08 Apr 2021 11:28:53 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:29 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 04/18] module: ensure __cfi_check alignment
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

CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
aligned and at the beginning of the .text section. While Clang would
normally align the function correctly, it fails to do so for modules
with no executable code.

This change ensures the correct __cfi_check() location and
alignment. It also discards the .eh_frame section, which Clang can
generate with certain sanitizers, such as CFI.

Link: https://bugs.llvm.org/show_bug.cgi?id=46293
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/module.lds.S | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 2c52535f9b56..04c5685c25cf 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,10 +3,20 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+#ifdef CONFIG_CFI_CLANG
+# include <asm/page.h>
+# define ALIGN_CFI 		ALIGN(PAGE_SIZE)
+# define SANITIZER_DISCARDS	*(.eh_frame)
+#else
+# define ALIGN_CFI
+# define SANITIZER_DISCARDS
+#endif
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
+		SANITIZER_DISCARDS
 	}
 
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -41,7 +51,14 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
-	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+	/*
+	 * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
+	 * of the .text section, and is aligned to PAGE_SIZE.
+	 */
+	.text : ALIGN_CFI {
+		*(.text.__cfi_check)
+		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
+	}
 #endif
 }
 
-- 
2.31.1.295.g9ea45b61b8-goog

