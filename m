Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFF1F58C6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgFJQNA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:13:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35023 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726219AbgFJQNA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591805579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=kexTF+bb21B8QATwOuG1QvcMoAkYdNsoySmbLQ5tWFE=;
        b=LSfZZnlda1NlBXZ5pfz/7MTjfEH6+Qwc/5LxePjLTLrsQPvy/NW30vIZpFSgkmK5qL3fw1
        mWLYPri9OgNVchpB7/7hEBTvztKUb0q7o0nufSaTESCJBteaz4fedYjG6exeIxlDZ4+sYw
        32yZqXjqSBujPrq35pkbxkjE4DHimwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-3KDz_bx7Ob2K6akTQorBiQ-1; Wed, 10 Jun 2020 12:12:56 -0400
X-MC-Unique: 3KDz_bx7Ob2K6akTQorBiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25681A0BD8;
        Wed, 10 Jun 2020 16:12:55 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC362512FE;
        Wed, 10 Jun 2020 16:12:53 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: [Patch v1 3/3] net: restrict queuing of receive packets to housekeeping CPUs
Date:   Wed, 10 Jun 2020 12:12:26 -0400
Message-Id: <20200610161226.424337-4-nitesh@redhat.com>
In-Reply-To: <20200610161226.424337-1-nitesh@redhat.com>
References: <20200610161226.424337-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alex Belits <abelits@marvell.com>

With the existing implementation of store_rps_map() packets are
queued in the receive path on the backlog queues of other
CPUs irrespective of whether they are isolated or not. This could
add a latency overhead to any RT workload that is running on
the same CPU.
This patch ensures that store_rps_map() only uses available
housekeeping CPUs for storing the rps_map.

Signed-off-by: Alex Belits <abelits@marvell.com>
Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 net/core/net-sysfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e353b822bb15..16e433287191 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/if_arp.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/isolation.h>
 #include <linux/nsproxy.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
@@ -741,7 +742,7 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 {
 	struct rps_map *old_map, *map;
 	cpumask_var_t mask;
-	int err, cpu, i;
+	int err, cpu, i, hk_flags;
 	static DEFINE_MUTEX(rps_map_mutex);
 
 	if (!capable(CAP_NET_ADMIN))
@@ -756,6 +757,13 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 		return err;
 	}
 
+	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
+	cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
+	if (cpumask_weight(mask) == 0) {
+		free_cpumask_var(mask);
+		return -EINVAL;
+	}
+
 	map = kzalloc(max_t(unsigned int,
 			    RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
 		      GFP_KERNEL);
-- 
2.18.4

