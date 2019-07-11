Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5D6625E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 01:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfGKXoj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 19:44:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36865 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbfGKXoi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 19:44:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so3466635pfa.4
        for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2019 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hScIZHsJmciYgxW3aaEACdipTjQ9ZhOMfEnTUSyg1Q=;
        b=kUZQBreXwSQ3LNMpnqWvxcf4z6FWwsyIribYH6vlDIlwsM/srzaOqB8hIC628Mxbpi
         sTEAQ/xS3ImmQx1BNXkDBgZwF5VYl6hRzaTcO42erW/MK6aBa4x3s17KPW5cbQUHnjAY
         AwCUMvXSnmIzqwu3/UeH7anXY4KB+DD3eYa0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hScIZHsJmciYgxW3aaEACdipTjQ9ZhOMfEnTUSyg1Q=;
        b=k+Mg9zuM8XrZ9Z8CbB1qQWaGs6AzkR0hN0JIIf0PBn5OOcSatYvOB5/RfOmt/vuAZ4
         GI8IPmCI/I35FI4xEHXZYu5dXIfsNNdr4wo7r+1ToL9VAFInjl669ARqp97p4SKhTYH/
         2PPoYl4CkbI5VnUB0ltf/6oby9ILkaBNOo4LKWSBEAhiip5aYlu+fVAlbnAxGe2bPZZh
         j9U/pVMmX6QGZ/qLC59T6mTBCGMwm00kfIN0R+kizh4l5rRGbECMWvlNv1S7afA0+ZKx
         9YGUHqeqR7TUadgPWt0SLDcqXL8f4uap1bkn8pmPPD3J09I3n9GGLVexqr/mI8WabOkX
         4KMw==
X-Gm-Message-State: APjAAAXusJXtZr2Q4FWxwaO5r5gle5jbpE1AESbmKy42bgee8gHWrZSD
        LEYQTSGOJI5egg4UmRpTiko=
X-Google-Smtp-Source: APXvYqxSDqyaeYYrrky8TWDPKqAGIx032RS1Jxow1lqnbITQYU3SZG4CMrefnUWSiviXF9o7KBA/IQ==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr7864165pjn.134.1562888677430;
        Thu, 11 Jul 2019 16:44:37 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t10sm6163450pjr.13.2019.07.11.16.44.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:44:36 -0700 (PDT)
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
Subject: [PATCH v1 6/6] acpi: Use built-in RCU list checking for acpi_ioremaps list
Date:   Thu, 11 Jul 2019 19:44:01 -0400
Message-Id: <20190711234401.220336-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711234401.220336-1-joel@joelfernandes.org>
References: <20190711234401.220336-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

list_for_each_entry_rcu has built-in RCU and lock checking. Make use of
it for acpi_ioremaps list traversal.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/acpi/osl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..c8b5d712c7ae 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/lockdep.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
@@ -94,6 +95,7 @@ struct acpi_ioremap {
 
 static LIST_HEAD(acpi_ioremaps);
 static DEFINE_MUTEX(acpi_ioremap_lock);
+#define acpi_ioremap_lock_held() lock_is_held(&acpi_ioremap_lock.dep_map)
 
 static void __init acpi_request_region (struct acpi_generic_address *gas,
 	unsigned int length, char *desc)
@@ -220,7 +222,7 @@ acpi_map_lookup(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
 		if (map->phys <= phys &&
 		    phys + size <= map->phys + map->size)
 			return map;
@@ -263,7 +265,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
 		if (map->virt <= virt &&
 		    virt + size <= map->virt + map->size)
 			return map;
-- 
2.22.0.410.gd8fdbe21b5-goog

