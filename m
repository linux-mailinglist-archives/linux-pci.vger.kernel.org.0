Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B46F358C8B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhDHSa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhDHSaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 14:30:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D5C06121F
        for <linux-pci@vger.kernel.org>; Thu,  8 Apr 2021 11:29:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d1so2833879ybj.15
        for <linux-pci@vger.kernel.org>; Thu, 08 Apr 2021 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vPR3ETOAeMW95pC8NAj24CpgqHEbd4yevcfxmcZ1/jA=;
        b=X+q7fW6iH/r7Id1WxE7msv5xTVPwRxH/FYjuCYgT4Moo6FV8A561Dq9/qDbuWOYoQy
         baU/9OXT+9MhCyfixUI7yCjK+ouetQotIr0A3byFRLhqfbDZwfq0jQeOgYcGZAVSXsJQ
         rPLDUKrO/h0fwc+Y23KNdHLXq7kpJvM/AJu180+tpnHtEUdNyCTbPYv+2c0evgyiiN/9
         DYuW8WvqrmguI16PEhoEl8kXGUOzNFzvOQMzRbvdY9vjeLBlXU2tFWIIpicfR7DHAKtW
         l85fWs5YCAXplevIrasowB3fIqDAD3r9GAVM2gPSRCq5P1neWWHzeeVd7klLc/lM1qYM
         sXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vPR3ETOAeMW95pC8NAj24CpgqHEbd4yevcfxmcZ1/jA=;
        b=YVq6end4oNt1Wa72ZKTR57RlUwoZcqbSLjpgrRy/1P5L45xwRms9prgh88ncAqNMk2
         nKpG0WEsQa7UJC5xtwvCwTNRNqRKTFTEV35zxsdLZt79XThl4PzqWW+/IpKilGlDLefz
         TK7c0wgFPtBeteR7DyRsVvzXdUEwsAd0vFVvgHTwmkb3uwLaiB2tK+vTZdjwbOPiGs8P
         v06tn7sQrho8f/RD795vIN0DzZ0deCLm2zKhpBKJe4ZLBL7kFoOzZWZFoVaa32hZZu/e
         Q67KV+QimwuYmJyeaOSV30snWGbhEa1L2aqMyBcRToAt+ZN4rkcK04c/vkWk6MHwEFP0
         p4Ug==
X-Gm-Message-State: AOAM5301+BZn56HSw0dBtDBb85tKi0kuowdgw5lNrM91lVpnliGMQHah
        6F1B+DIUeMRilp0fTtTAncH4/wHxYdsEZE5QVuE=
X-Google-Smtp-Source: ABdhPJz/su5s3FJ4/ClB/3zgcLUsgjK5PoygW68wgkC4KNGGvsbw78PuGtzLYwUALhEPddWcHuMOQsCUu2Cq7CZyhzI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a25:b90c:: with SMTP id
 x12mr13955922ybj.12.1617906554210; Thu, 08 Apr 2021 11:29:14 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:40 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 15/18] arm64: add __nocfi to __apply_alternatives
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

__apply_alternatives makes indirect calls to functions whose address
is taken in assembly code using the alternative_cb macro. With
non-canonical CFI, the compiler won't replace these function
references with the jump table addresses, which trips CFI. Disable CFI
checking in the function to work around the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 1184c44ea2c7..abc84636af07 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,8 +133,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region,  bool is_module,
-				 unsigned long *feature_mask)
+static void __nocfi __apply_alternatives(void *alt_region,  bool is_module,
+					 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-- 
2.31.1.295.g9ea45b61b8-goog

