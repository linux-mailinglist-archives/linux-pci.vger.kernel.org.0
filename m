Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F140525CAC2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgICUfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbgICUcv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:32:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F7C0619F2
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w38so2044086ybi.20
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iN3GbBjTX25viV6xW68a9oo3MkQJYWkKKPfs1TkAluY=;
        b=npSffdaieWFucXHDLr4mY6XgP2tHJEoOTVV6csT96vPOxvouZbo+xOm04baMS0+EN+
         ILt6v3wDsnQiQY1Dfffcie0xZpTFWaLYK6BzUM04xdyHxieJIvNOg6LNdFOj/3y0mBnH
         Jte3FAnXYcPxQddxr87OOvJEZ6dUuX9sLqI5aXpeyk3Ki59e1OAR1zKEEXG4Ifc9lR1Z
         LmZi20QOngtk5w17q0wIZkw3ahIXVLzoXpdRB96sntn1liwbbCydI+aZqLJTRszyPkgg
         aLXX8AB5Ds1j4EtaGcnjmp8w24YNv7D+M1DcDJJ9VXF0l9BS/QNTX03Rsdsi7XuPq2av
         wZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iN3GbBjTX25viV6xW68a9oo3MkQJYWkKKPfs1TkAluY=;
        b=oJb9cTSvk7cwwBc4pbJkA5+D97fd8QhTj3Q6zt+FcOkiI3ZpV2ckpCl2r2dsJqy7/r
         Vb+JoDY5fDjrq/8dp4EQ6jXshGfdH68esTbDF1AXXoVOF5n0JRIfFl1y68ioFSnsj3gb
         +RQm524bqayJVSlWXiub/8CEC8HJqmdLFip0JPIaO/WttWrQcJyFqpHCzlEg3MU9g6Ed
         cwr1akhLJO2rrTzSBI5LpWloZ4EipbZrOPBLdD4xlqEJ4YfzZI3AVBuYIz1rN+wS6apE
         TTZUSpveI3RIvl9zrZG9Fu/TOp1gAdUfd6vPZCO3BlZ/yhufYYvo+X5SSXbvzIvZMYQ8
         kf6Q==
X-Gm-Message-State: AOAM533eW7SGEMrpyljMX02LTiOG3bVri4hmuoHNbluUEqrlMXvqb1A8
        AxXma29yvxEykXF6rVtuZ/m8GO3BT7y7pklhkcw=
X-Google-Smtp-Source: ABdhPJyiG0zEVlMgXVpb6Zi8eshehY9Qj0OKZzrDehRr0ot1IUkMHErjz4cB8zqJtzXVoh7q4DtUcBhjwy1qLdSHusA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:1455:: with SMTP id
 82mr5771395ybu.274.1599165096721; Thu, 03 Sep 2020 13:31:36 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:45 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 20/28] efi/libstub: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
files. Since LTO is not really needed here and the Makefile assumes we
produce an object file, disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 296b18fbd7a2..0ea5aa52c7fa 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -35,6 +35,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.28.0.402.g5ffc5be6b7-goog

