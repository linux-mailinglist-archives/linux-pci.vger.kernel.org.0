Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740D1340B24
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhCRRLj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhCRRLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:11:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FACC06174A
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 131so49623283ybp.16
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D5aIIw6ZgnQjO2LtKhTG0SnhlhRc7naBZb5HRsoPMYM=;
        b=DJs3PpKGZT5abgDxmLr20bRHSgWSXko38GVppWq5gA7qETnUgw0bw1lS6eKo3WFfko
         eAOZfq1smTFvIJOqfLkfTgwT4IQsV0telQvn0vGMyfw2yLTgzy8zulsGkDko+Wr94eVd
         R9bvyDRw0x6920hAolwlIsKRpDU4dsmS/kGGsKqFSuew1E2FLbM4OYgfHXGESRlJlvO0
         nm2nTQhXGxw/QP5qx+9mb8RX37C7kICUl3sUZfQnPG/LnLB/Yv5y6sC+sDSXnH4r5rMW
         v9Q1TPupu6griqvZD2j2qc0nAa5fRI/yinH70Q08aajflrVhE6iYA50ugnXHLsPdr6HX
         Sn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D5aIIw6ZgnQjO2LtKhTG0SnhlhRc7naBZb5HRsoPMYM=;
        b=FcbY5gYYxrFZBnksEwKkcyNWXo0QZhwHLMRCXaGfETMZXXVBuVgZpLuopync+SyHdz
         wiMbuY/5NVCRJOE04dAfVoFH4fxXpii6cTZlksBx15b0KTk6b9ReTrRKbYPOp60TSR79
         D7kfIqG33CzwAohkwMln5QMXee4cUhhcMynQZpbuGWo0VTMvyy20UJDIy4q28SvDahW2
         whPt0p8kWTW+cP7g+cVt+JY7ARFbQ2APqOhLjOjN8VJ5uPPx2py9f1k8OkQyrcgvcymu
         IM0cY5S5obZnc39pqQi4gbEdQn9cRMWYCcwdy+yK6gws2TK+y0eUU37ErYESHMA09DqP
         o0/g==
X-Gm-Message-State: AOAM531VOS7Ik2NqFwOhEJnTgKrQP/20PAgtd4WdJ4qhTZ0W1DfhiEPg
        E/wsKKejnfZQ2CRCcA47lyLqejkRW0sONCTgd9I=
X-Google-Smtp-Source: ABdhPJyPBt6MH4faEqf0AYmhZmuTW6b6F0vtOC0nIFwVJkoD535hPrMSE+Vii/iaUNCDzOi8rgltoGh+k3M7Eul0cOI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a25:804e:: with SMTP id
 a14mr496516ybn.206.1616087484769; Thu, 18 Mar 2021 10:11:24 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:10:58 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 04/17] module: ensure __cfi_check alignment
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

CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
aligned and at the beginning of the .text section. While Clang would
normally align the function correctly, it fails to do so for modules
with no executable code.

This change ensures the correct __cfi_check() location and
alignment. It also discards the .eh_frame section, which Clang can
generate with certain sanitizers, such as CFI.

Link: https://bugs.llvm.org/show_bug.cgi?id=46293
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/module.lds.S | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..93518579cf5d 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,10 +3,19 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+#include <asm/page.h>
+
+#ifdef CONFIG_CFI_CLANG
+# define ALIGN_CFI ALIGN(PAGE_SIZE)
+#else
+# define ALIGN_CFI
+#endif
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
+		*(.eh_frame)
 	}
 
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -40,7 +49,14 @@ SECTIONS {
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
 }
 
 /* bring in arch-specific sections */
-- 
2.31.0.291.g576ba9dcdaf-goog

