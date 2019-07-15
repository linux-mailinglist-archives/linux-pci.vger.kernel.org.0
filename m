Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF86936F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 16:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404107AbfGOOoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 10:44:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39619 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391842AbfGOOhj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 10:37:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so7811698pgi.6
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2019 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMymzQWyTMjq6dLEXUYHnnYNVQu32eRzbAFgwnIdCTM=;
        b=sb4sRCBHFXSE2cPqMR4+T5ZCDTZOXkYZvOefdmVbThG07/8ujO+ZMUI1qi0RzfQNtk
         L2SG3O8Wv6tkY7NUfEU97Sodrr0ncVViDxOuD+Tu+lrXlmz95G5bFlD4Z39OvL7tmZa8
         r01KC9K2ZD2d1/zC/71KGiI4hO6ZU/NWudwNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMymzQWyTMjq6dLEXUYHnnYNVQu32eRzbAFgwnIdCTM=;
        b=r2pta1Wf2/IY5WL4SoPNwQOA00XDaWcal0PCNcOcVvaD9tQ57XdbdrEIJMQdjnD8us
         NvdZmOrVqubqo9lu8DqXP7qKF77VOI7b9Oyq+CmgIDwXzA2iSasEHUf1rkgJWlSxAKtY
         +qhw/duKobZgr+mhpWPZGsPT933IslwucaqVGPHU9hoQsj+TrA3x/MzBRY+kKZG4Tm9f
         xiddYrkrYPQqyK7rQ/AfTQ3maoszIajAbylZgMU1ot7Fb27YvMpScQ7KoCy8NBCXhojq
         d69NI07paZFYsmZYd13HE6/1vwtdZY0rZwiZfUpjnMgfGgpXMPqWf1r4B3bs5vuzB7eQ
         yy/g==
X-Gm-Message-State: APjAAAX6L/de9gopA+wqZ+uiU5qIo1dHdrBzeftvOCmjjsO3N6jgi0np
        qw0wrm5csJjHIfyNxgSdjoQ=
X-Google-Smtp-Source: APXvYqwREOPm8jU5KaBh/4wpCriK+UOZQMzbDI3ea0SFjpipVn94p6ZbCr/TlFhUWr/4kL8J5e58FQ==
X-Received: by 2002:a17:90a:3270:: with SMTP id k103mr28578111pjb.54.1563201458425;
        Mon, 15 Jul 2019 07:37:38 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm18381852pfs.8.2019.07.15.07.37.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:37:37 -0700 (PDT)
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
Subject: [PATCH 6/9] workqueue: Convert for_each_wq to use built-in list check (v2)
Date:   Mon, 15 Jul 2019 10:37:02 -0400
Message-Id: <20190715143705.117908-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715143705.117908-1-joel@joelfernandes.org>
References: <20190715143705.117908-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

list_for_each_entry_rcu now has support to check for RCU reader sections
as well as lock. Just use the support in it, instead of explictly
checking in the caller.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 601d61150b65..e882477ebf6e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -364,11 +364,6 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU or wq_pool_mutex should be held")
 
-#define assert_rcu_or_wq_mutex(wq)					\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
-			 !lockdep_is_held(&wq->mutex),			\
-			 "RCU or wq->mutex should be held")
-
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			 !lockdep_is_held(&wq->mutex) &&		\
@@ -425,9 +420,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * ignored.
  */
 #define for_each_pwq(pwq, wq)						\
-	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
-		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
-		else
+	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
+				 lock_is_held(&(wq->mutex).dep_map))
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-- 
2.22.0.510.g264f2c817a-goog

