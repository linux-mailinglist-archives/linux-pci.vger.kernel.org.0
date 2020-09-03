Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839F525CABF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgICUfB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgICUcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:32:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D579C061A01
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w38so2044184ybi.20
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3q7TZ5J5xqKWdUS4X8SiQHdlDi3K3u69bSPkIoNlqR8=;
        b=ufRzOZtYYauSzvxZUBKz1JVbuUwKqmAJdSrdtsdAtyClxzQSdbUMjMfIMupNHjnLGB
         WO4ZqGFWI4GoHdfXhHBAF+P/jv072mNJPl0sQzhOhWjmxcDeq8t/wGGp/8OanND4USfj
         LhikjLiJG9jAk0+cvkHoOwClvc4d+s/6mEvmHU+7r2wfgvpCQERcCjQH7zsDH2517Ogk
         GD3ZV/LG3aSx/OdpXy0Szz6VTm1uw47NfsFGVYKWXK4IlQH2y+9jyGDbrxKpkAqRVQ6l
         TgM50rxrgjBcqFMaRVrmvkVprT/6WaCjwoJLbBtb5rXpbpl2VQ2HuV9qu5Jf7aVs2fRs
         o+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3q7TZ5J5xqKWdUS4X8SiQHdlDi3K3u69bSPkIoNlqR8=;
        b=is5rkln0aRwBF2YXf0XpNqsWrm8P1KgJ41hFCzKDr1HycTv3oimb/1Rb7Pj0MgYO4S
         nN7tOhXywYkp/ltvQo3oSV+EF9ChHh2v9gV2dX5fWjaFwjDJN0n94PDwpboIvX4gOXWg
         6ZGsnKa4PiuZkrNesIoEg7b7PSWGWazqGDink9YNZP8ZWlTcqdjqCQ9jn3FD98z4QC5o
         jUpkmdjZmj7tbacsHijOtZXHdbyZ4Jy1Ycoy5oi51m46G2LJZnhpZriCTWZbxcujlpvy
         D2iMx5zFpv0HbB6ALFMgGoRs968KhI8+6Zgutvu1bz7M1rMMH704Qmjry8Esg9Njk+UB
         e7Fw==
X-Gm-Message-State: AOAM530rs4gUkzbe9IozOfmOLGajp+Qo8+m/LS+NX484L2xNVC/+sn6D
        BJIK8gra7pnfsqBRprr8B/9Z4D1JwcAT1oeXFD0=
X-Google-Smtp-Source: ABdhPJzSHh4NCUcdQaWfXuHL4xXV+3Gzu7YAUpxYnKR7xzXHL7k1OIFuYPArBmNIqbbqiPyK+SQbqhBjAf2rbEmrgrI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:6555:: with SMTP id
 z82mr6003281ybb.472.1599165098726; Thu, 03 Sep 2020 13:31:38 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:46 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 21/28] drivers/misc/lkdtm: disable LTO for rodata.o
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

Disable LTO for rodata.o to allow objcopy to be used to
manipulate sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..dd4c936d4d73 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,6 +13,7 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.28.0.402.g5ffc5be6b7-goog

