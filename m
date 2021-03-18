Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76529340B45
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhCRRMJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhCRRLg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:11:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58657C061762
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j19so3401166ybg.5
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=79m/4wCgeIzY0Vch1mQ9hDd2/YXny1QOhs6kFFYl+qs=;
        b=Zik1d3CnZxputVsmGGlAexPLSHJF1N30aQsZC+A49EjAjI41rgMguWULbVHOZuBdPg
         OQ23FZI5e5lc19k+4wnAGEPbO8ubc3ZLNnH9lf488/mljubW7d/4qBvIEQToXTW14lVr
         j0ydpHrAO7UAeKBGZTfKjWqNRXa/+aUW3W/Q9xyReJ+HkSh4ZyfQQVf2jl2YoJPNmYgP
         U8ED0ly++E/R2SKQ5gcXdYQm5bK3aQwaQuAnd0Qz5u7IAaAg9I7S+5U/IZnXR62c9V5n
         WF5Km9LoVXhtHm9tlACHHs0O6slXVTwziecp89dN+AoViSwFfPOMP88Mo91j0UqUKlOJ
         Dbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=79m/4wCgeIzY0Vch1mQ9hDd2/YXny1QOhs6kFFYl+qs=;
        b=h5Cp30u8xGqLrQUy5047xCJSb10TR+VAmnTsf4sfb0hkmiLybb5dyZ5L0dmjNetwA9
         BCYMqR+CTMex7ZTda3ks0hNwc/5ylyXC0fCpDgS9PeTQOsbXGQEf9D20kCBZff+aNtZn
         GHcNCJllPrMi3WSsRi++IAQLx+U5Jjmf5EzgjqrupDAWE1V0A432cVgmlOAPfLjmseXo
         eqijqS9Ue+wYyAuGJQjPv+lhAQpAaF3ApJDMaWjcmbwdxY4DfqK7s2ZhBDGNfE4WWvYl
         JjFOiwkBedq+RQdTd+MK63sorHust9CKN25mu4urzUgPLaTlFNrbP/jbKkvl452N0hYc
         fNug==
X-Gm-Message-State: AOAM530wsjAOmIzPgTEi/ClDKF1Wmb9qVROzt64quuXexs02LLSWriCH
        NPPSNMLx+gk7k4Op2p+tKs+z0vgKGDltytTV0WI=
X-Google-Smtp-Source: ABdhPJyhrd+ijbcKHuUHxkloDz8fmR6k/s2L31mWKV23xRXPA0zTKRcjoj602FSIswWJW0IQy4bbshoZ/FsRp3uVBzQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a25:ab11:: with SMTP id
 u17mr494297ybi.192.1616087495554; Thu, 18 Mar 2021 10:11:35 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:03 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 09/17] lib/list_sort: fix function type mismatches
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

Casting the comparison function to a different type trips indirect
call Control-Flow Integrity (CFI) checking. Remove the additional
consts from cmp_func, and the now unneeded casts.

Fixes: 043b3f7b6388 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 lib/list_sort.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 52f0c258c895..b14accf4ef83 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -8,7 +8,7 @@
 #include <linux/list.h>
 
 typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
-		struct list_head const *, struct list_head const *);
+		struct list_head *, struct list_head *);
 
 /*
  * Returns a list organized in an intermediate format suited
@@ -227,7 +227,7 @@ void list_sort(void *priv, struct list_head *head,
 		if (likely(bits)) {
 			struct list_head *a = *tail, *b = a->prev;
 
-			a = merge(priv, (cmp_func)cmp, b, a);
+			a = merge(priv, cmp, b, a);
 			/* Install the merged result in place of the inputs */
 			a->prev = b->prev;
 			*tail = a;
@@ -249,10 +249,10 @@ void list_sort(void *priv, struct list_head *head,
 
 		if (!next)
 			break;
-		list = merge(priv, (cmp_func)cmp, pending, list);
+		list = merge(priv, cmp, pending, list);
 		pending = next;
 	}
 	/* The final merge, rebuilding prev links */
-	merge_final(priv, (cmp_func)cmp, head, pending, list);
+	merge_final(priv, cmp, head, pending, list);
 }
 EXPORT_SYMBOL(list_sort);
-- 
2.31.0.291.g576ba9dcdaf-goog

