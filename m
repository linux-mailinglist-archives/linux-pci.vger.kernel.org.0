Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A538220A84E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 00:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407526AbgFYWjm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 18:39:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22083 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406817AbgFYWjb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2020 18:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593124770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=cUfz3o3YYU3sytCUwyBAIKiRdwfoDCo4v+fG8cImphQ=;
        b=VgfoO4fhREyJDSxaMGG7o49zSedhx/y5dqysZtxvm32DtQuNb8wkPiqK8X6psnm6bdx+qf
        vLoImxMquBKprQX7bCAinYTJoo21Ol7NNDqVQwvkd7UcOfl7+LVTqFUaaTxESmEdHH+MUJ
        yV9/wtKHStnDtz/k/MyHFi44EnUns6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-U4NzPTVeN52i0_fvhm98PA-1; Thu, 25 Jun 2020 18:39:26 -0400
X-MC-Unique: U4NzPTVeN52i0_fvhm98PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A48E800C60;
        Thu, 25 Jun 2020 22:39:23 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D98A57FEA6;
        Thu, 25 Jun 2020 22:39:21 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
Subject: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
Date:   Thu, 25 Jun 2020 18:34:41 -0400
Message-Id: <20200625223443.2684-2-nitesh@redhat.com>
In-Reply-To: <20200625223443.2684-1-nitesh@redhat.com>
References: <20200625223443.2684-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index fb22fb266f93..85da6ab4fbb5 100644
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
 
+	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
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

