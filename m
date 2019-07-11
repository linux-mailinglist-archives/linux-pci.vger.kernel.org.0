Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7066251
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 01:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfGKXoX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 19:44:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfGKXoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 19:44:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so3671324pgn.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2019 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GuW47+ITVwlHRyFWoit77iH8wSxBVV56wbG/AJ8g+A=;
        b=POP2I6vcsX7mrpLNszrDZ3jHjn5JeGjYvt0TIBarOc+TTSSHTMCxN8ZJl3umrbGe13
         LL/K6XJbcw8liWBMr5VJm7tJsyYXkpeSHOo93Z5cFDVSa8Vym2EQZ+vSjFXjz8J4Wkoy
         ABgjJP8Cfel0JsMbqaLz7L8BjEej7RSdpehss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GuW47+ITVwlHRyFWoit77iH8wSxBVV56wbG/AJ8g+A=;
        b=ozFArlWp4frBlcXu/awFiowHl+zAYzboyFYEGQL8ss6zlC+tbraZOjOCnVfQsrsTvP
         FKbVzKHtXo2BgPMAl1IgfUU7Xbn8NZIGCbev+HBV5exYzjQkTgu4h88aERs2O88ZtaEk
         gRcDD8WJG6fRxUml2uoRLwvlK1Iq2sZBPDaU1efbj7Ujm8hdDS7LeL0M1Nn06AqK99Ho
         azm4nPPp0h3CiIo/2APtl+Tz4inz/QfJXS2UTi1Qbsoy74vY52YJwRPaXnkbHoWDp6tt
         5wk+lP5S+Cc3rYvhQPnAsAwQjU1TjXovZAsAXX4kogfg2AZKHCicNu9zU2HRXAFTug3E
         oG3Q==
X-Gm-Message-State: APjAAAWO+8LL4QU3enUMdNFRr0oyPtvYB0UehpmdEWsj2MWhIUT1fBel
        KSiCSCsRTLI3CvEz2BeOAkM=
X-Google-Smtp-Source: APXvYqwL3radJMAbdECmS/G+TOrWXAIf4q3T6x0oa7czoYNYGbVr9jTCwdHXMM+5nal4G43CSaqnjQ==
X-Received: by 2002:a63:3f48:: with SMTP id m69mr7029829pga.17.1562888662320;
        Thu, 11 Jul 2019 16:44:22 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t10sm6163450pjr.13.2019.07.11.16.44.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:44:21 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v1 2/6] ipv4: add lockdep condition to fix for_each_entry
Date:   Thu, 11 Jul 2019 19:43:57 -0400
Message-Id: <20190711234401.220336-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711234401.220336-1-joel@joelfernandes.org>
References: <20190711234401.220336-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/ipv4/fib_frontend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index b298255f6fdb..ef7c9f8e8682 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -127,7 +127,8 @@ struct fib_table *fib_get_table(struct net *net, u32 id)
 	h = id & (FIB_TABLE_HASHSZ - 1);
 
 	head = &net->ipv4.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb_hlist) {
+	hlist_for_each_entry_rcu(tb, head, tb_hlist,
+				 lockdep_rtnl_is_held()) {
 		if (tb->tb_id == id)
 			return tb;
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

