Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F658320F4
	for <lists+linux-pci@lfdr.de>; Sun,  2 Jun 2019 00:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfFAW2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Jun 2019 18:28:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34774 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfFAW2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jun 2019 18:28:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id h2so2810239pgg.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2019 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4Z5Q8yj6p64Y2o7Spib8gfVriUeNJkKQsEzc/+Hzz0=;
        b=tn0zxaPZcEF0gzwva8HqnPjJia9DDhSQmHjOrC5LIgyWnnOofGPjmYj/hXfVZ8L0em
         XP3bB8/bqiw1eHWRAsDs+Eo+KMd0muYlR7W1IGD9w2kQhutp6W3nJjVkUHo/gqw0gscT
         hSNuQPr6j2Tn6vwct85U2AwqZoqgLSmSxBAAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4Z5Q8yj6p64Y2o7Spib8gfVriUeNJkKQsEzc/+Hzz0=;
        b=pUhO1NHwtzHkKQvGHjMN68s00odv6paAyL3zt0cKKYdLdAInq/DimfZWJXYO0otk9b
         vSNsOlIYkggQOfrkOjkU2bVfNAnzjwWsH6wCn81hwT5Go56XmkBCgreLMsqw+HnC9kOI
         CE83JmLsFcUSLBIoorhbTUA8BywHrGb1BJFDRNS/WXXcic4qL/KKSANBWzeQifIyEpIv
         sm3DCFWsDjekYHMomQKAG/uz1F8/znOmTZk7PtPRmtyOEex9H7mTshhSBoAmbN2zuHYk
         Mp1GOu+nqA1+AgPF2vZ+/tEv/7/nWwq9ROs3US/6ofJVcsQ7tV+tB0CeT8sDHfyf6+UY
         CmBw==
X-Gm-Message-State: APjAAAXfqtECmtrRKv2jbhGrI2Ec/F6pDyZ5iLzduMUyS1kU+drYTbBZ
        2oLYLMAaXkzN8PFZK7/9q+kOlA==
X-Google-Smtp-Source: APXvYqyQL17LnHVw1B3g7pCMzLSsO7wfuWCIia7ACIsUpOs3uzhXYItiAbtRvGIh4rUXLEb0jWXqzQ==
X-Received: by 2002:a63:a34c:: with SMTP id v12mr17850914pgn.198.1559428087981;
        Sat, 01 Jun 2019 15:28:07 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t33sm9908018pjb.1.2019.06.01.15.28.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 01 Jun 2019 15:28:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [RFC 6/6] acpi: Use built-in RCU list checking for acpi_ioremaps list
Date:   Sat,  1 Jun 2019 18:27:38 -0400
Message-Id: <20190601222738.6856-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190601222738.6856-1-joel@joelfernandes.org>
References: <20190601222738.6856-1-joel@joelfernandes.org>
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
2.22.0.rc1.311.g5d7573a151-goog

