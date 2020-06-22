Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012D9204496
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 01:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgFVXp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 19:45:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59136 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728775AbgFVXp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 19:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592869557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=qsEcJR/Z1zWhjEwFy+c1G0isIWJ9+FDcjerWFAR8WtI=;
        b=V22oKBjLh4O5EpcIVm7odCRWFGoQFZufQu5DfWFbQFP9VFmat8yQVM5kokoiTSj8kLyHjb
        MMxpW11wvTmelkzQrwDm7i7BvXly9PYLlLBPN1LHSH+Xyd21jPZQAiozgrU1f+T42N0Yru
        +8wk/WnEuNr7nEKaGH46aNLavmhHUls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-MxV-Nwm-OrSGPScBNX0p6w-1; Mon, 22 Jun 2020 19:45:55 -0400
X-MC-Unique: MxV-Nwm-OrSGPScBNX0p6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 229958014D4;
        Mon, 22 Jun 2020 23:45:53 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7269D5C290;
        Mon, 22 Jun 2020 23:45:51 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com
Subject: [Patch v2 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
Date:   Mon, 22 Jun 2020 19:45:08 -0400
Message-Id: <20200622234510.240834-2-nitesh@redhat.com>
In-Reply-To: <20200622234510.240834-1-nitesh@redhat.com>
References: <20200622234510.240834-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alex Belits <abelits@marvell.com>

The current implementation of cpumask_local_spread() does not respect the
isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
it will return it to the caller for pinning of its IRQ threads. Having
these unwanted IRQ threads on an isolated CPU adds up to a latency
overhead.

Restrict the CPUs that are returned for spreading IRQs only to the
available housekeeping CPUs.

Signed-off-by: Alex Belits <abelits@marvell.com>
Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 lib/cpumask.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index fb22fb266f93..cc4311a8c079 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/numa.h>
+#include <linux/sched/isolation.h>
 
 /**
  * cpumask_next - get the next cpu in a cpumask
@@ -205,28 +206,34 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  */
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-	int cpu;
+	int cpu, m, n, hk_flags;
+	const struct cpumask *mask;
 
+	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
+	mask = housekeeping_cpumask(hk_flags);
+	m = cpumask_weight(mask);
 	/* Wrap: we always want a cpu. */
-	i %= num_online_cpus();
+	n = i % m;
+	while (m-- > 0) {
+		if (node == NUMA_NO_NODE) {
+			for_each_cpu(cpu, mask)
+				if (n-- == 0)
+					return cpu;
+		} else {
+			/* NUMA first. */
+			for_each_cpu_and(cpu, cpumask_of_node(node), mask)
+				if (n-- == 0)
+					return cpu;
 
-	if (node == NUMA_NO_NODE) {
-		for_each_cpu(cpu, cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
-	} else {
-		/* NUMA first. */
-		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
+			for_each_cpu(cpu, mask) {
+				/* Skip NUMA nodes, done above. */
+				if (cpumask_test_cpu(cpu,
+						     cpumask_of_node(node)))
+					continue;
 
-		for_each_cpu(cpu, cpu_online_mask) {
-			/* Skip NUMA nodes, done above. */
-			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
-				continue;
-
-			if (i-- == 0)
-				return cpu;
+				if (n-- == 0)
+					return cpu;
+			}
 		}
 	}
 	BUG();
-- 
2.18.4

