Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15BD0673DE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfGLRBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 13:01:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35178 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfGLRAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jul 2019 13:00:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so4569400pfn.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2019 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5MSBvyW+UnMIf1PMXwWQpclTkJPOBVtLcNCxIfokXY=;
        b=W4pcI9yzebCS/ajeXGrdH4WDZbUsJndTMc7qtATG156f3ffkoMMnM+27/wia2nKDJk
         8+5mV67a7LLoP3HBFS64qyErr1wWta5bAaSdftnGrTPpiVb4PMfGdj4gRSASKJrtE/bk
         y6MZeHXSPOQSGLoKr4GkENL9AUyzztzIy9lqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5MSBvyW+UnMIf1PMXwWQpclTkJPOBVtLcNCxIfokXY=;
        b=iwE+z829qGY3FFdIy+cZty4+R42T+/wBcsKw+QTasSKkWZsPwGQfWx4k2P/8EukaRe
         ySfu3miL9m58Qzc6JGOL7P8bc2Xhtftmlhd53Y9+RzVNvMgLhA/Wn6uSb2jyc89I88dZ
         C3nASbxrQt+juF5z7x8ZikAW0kW3sD4qqR/DtddTZXA1dH7OFRKg3BSuFjDmkoKfusrL
         z3A3Rw/2PnGaF4qAOjPyCKj+P45SjBilYe0914DFY7Wylpjdlu3wTo8ukRBRRC++7Qkq
         H0uVSF+hMMt8U2mnCuLASsnWQtq5KP03uVLlNghJHRtq3osPViKl+fpPwZ9vrh+1ciLg
         +dEA==
X-Gm-Message-State: APjAAAWAT+At+ULUynQCx4lfs6qFtgIKP92hUp2aUOkmJW9Yt+tcc2xb
        qlOAt1fRwYL0YAR2fKHd+MQ=
X-Google-Smtp-Source: APXvYqzuhVtiWBYlZH/aw0dkC1YS/lLyobD9k2bBGXEKSZ5NHGo/6vz/hQ+QEQLkxRGkEG+1756i7A==
X-Received: by 2002:a65:4489:: with SMTP id l9mr12246140pgq.207.1562950850333;
        Fri, 12 Jul 2019 10:00:50 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm7127385pgw.3.2019.07.12.10.00.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:00:49 -0700 (PDT)
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
Subject: [PATCH v2 4/9] ipv4: add lockdep condition to fix for_each_entry
Date:   Fri, 12 Jul 2019 13:00:19 -0400
Message-Id: <20190712170024.111093-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190712170024.111093-1-joel@joelfernandes.org>
References: <20190712170024.111093-1-joel@joelfernandes.org>
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
2.22.0.510.g264f2c817a-goog

