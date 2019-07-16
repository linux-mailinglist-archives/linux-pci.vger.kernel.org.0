Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47E56A12E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 06:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfGPEH5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 00:07:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41810 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPEH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 00:07:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so8425924pff.8
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2019 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmC6wxi5sfJ1hgZ1T5d4GnYkV6yYjgLN1LSLJD9G/N4=;
        b=Kq0teeTexfzjIuo8X5x7eq1y/4O5B2Bmjf3Fma8qxHKz570TnWd5F41ARTOX+ZB9o5
         ZrA8d8qX6imHshG3/BIhlS9G3/USuQssQxWSRVgYqXyJ69AtXg6PA4i/A/poj8yG+f0m
         jjDlhK3uHe61XmDCNPq7CEmNnt62VWeTQWFEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmC6wxi5sfJ1hgZ1T5d4GnYkV6yYjgLN1LSLJD9G/N4=;
        b=T7+fSuHeD72aJViCJkM2QBOlLQvjwsXJcMlYFMFZQRACZxPRSnipPJY07HiFpF8tMv
         VFYhOhv1ZgaHlPDZhozazKb0Eqi9F5rXqcglg/dee+VUCxNXFf2T/4HiUK67t13lFWPr
         wroANvkTXSrnFxXaZi1hbzCtW22nDgF62J7sTBF3oSUgpQUMRITi9SR/eVjF+zvTadc3
         cV0QKKDlbGvdWQ2R65Jmy3mLbltNJ5Xc2unT2q8R9qNujhiOxueWu3p7cB2dif9CmZYZ
         F+5Gfn/WZw9HlFAixobd70VdsJhuNVirsXbUNc2m+ctmaVFcqnh8On90y+K8qtsZrUyh
         cg5Q==
X-Gm-Message-State: APjAAAX8wfxHm7FjuiNxyFFBO3tBQZIbYxZ/JsUNnLKo3Glyqpkpp2/y
        VlAPyR/HfF7wfotEGfbCDrg=
X-Google-Smtp-Source: APXvYqzgpmFKYjtDybWIlQwIoYF/PfoRh5ad2Zk33yjjz2GZk9FWUyWvHOfYTa/TTjzB9GZPuRionw==
X-Received: by 2002:a63:9249:: with SMTP id s9mr29860119pgn.356.1563250076442;
        Mon, 15 Jul 2019 21:07:56 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f14sm17867883pfn.53.2019.07.15.21.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 21:07:55 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] rculist: Add build check for single optional list argument
Date:   Tue, 16 Jul 2019 00:07:43 -0400
Message-Id: <20190716040743.78343-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In a previous patch series [1], we added an optional lockdep expression
argument to list_for_each_entry_rcu() and the hlist equivalent. This
also meant more than one optional argument can be passed to them with
that error going unnoticed. To fix this, let us force a compiler error
more than one optional argument is passed.

[1] https://lore.kernel.org/patchwork/project/lkml/list/?series=402150

Suggested-by: Paul McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rculist.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 1048160625bb..86659f6d72dc 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -44,14 +44,18 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  * Check during list traversal that we are within an RCU reader
  */
 
+#define check_arg_count_one(dummy)
+
 #ifdef CONFIG_PROVE_RCU_LIST
-#define __list_check_rcu(dummy, cond, ...)				\
+#define __list_check_rcu(dummy, cond, extra...)				\
 	({								\
+	check_arg_count_one(extra);					\
 	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
 			 "RCU-list traversed in non-reader section!");	\
 	 })
 #else
-#define __list_check_rcu(dummy, cond, ...) ({})
+#define __list_check_rcu(dummy, cond, extra...)				\
+	({ check_arg_count_one(extra); })
 #endif
 
 /*
-- 
2.22.0.510.g264f2c817a-goog

