Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2AF205BB9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbgFWTYd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 15:24:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387427AbgFWTYc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 15:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592940270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=TdM3UQkfMsN3V/UvtqwuaPyQU6d6l4GBM/lycOPWluc=;
        b=XpLfCokJ0DetfdXbCvlgKp6nYR+lgx6loqLRSoY1db889LvOywlPfRt8y/yKBh/JQX0ycZ
        g7tnyS7Z5gNvKKgOck3q6DImheBEEix7k4EztYtfTXuC0umRLWIDPirMJ1O2v7uOjLxkuc
        APZ0FMbpPWA8h4O8/VswRkkyjv2JnjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-jJdNqlG-OuqdtpPBIQeWoA-1; Tue, 23 Jun 2020 15:24:26 -0400
X-MC-Unique: jJdNqlG-OuqdtpPBIQeWoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F332E1005513;
        Tue, 23 Jun 2020 19:24:23 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D9E7610FD;
        Tue, 23 Jun 2020 19:24:22 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com
Subject: [Patch v3 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
Date:   Tue, 23 Jun 2020 15:23:29 -0400
Message-Id: <20200623192331.215557-2-nitesh@redhat.com>
In-Reply-To: <20200623192331.215557-1-nitesh@redhat.com>
References: <20200623192331.215557-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 lib/cpumask.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index fb22fb266f93..d73104995981 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/numa.h>
+#include <linux/sched/isolation.h>
 
 /**
  * cpumask_next - get the next cpu in a cpumask
@@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  */
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-	int cpu;
+	int cpu, hk_flags;
+	const struct cpumask *mask;
 
+	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
+	mask = housekeeping_cpumask(hk_flags);
 	/* Wrap: we always want a cpu. */
-	i %= num_online_cpus();
+	i %= cpumask_weight(mask);
 
 	if (node == NUMA_NO_NODE) {
-		for_each_cpu(cpu, cpu_online_mask)
+		for_each_cpu(cpu, mask) {
 			if (i-- == 0)
 				return cpu;
+		}
 	} else {
 		/* NUMA first. */
-		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
+		for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
 			if (i-- == 0)
 				return cpu;
+		}
 
-		for_each_cpu(cpu, cpu_online_mask) {
+		for_each_cpu(cpu, mask) {
 			/* Skip NUMA nodes, done above. */
 			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
 				continue;
-- 
2.18.4

