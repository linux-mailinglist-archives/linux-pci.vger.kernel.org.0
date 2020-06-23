Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD92205BBF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbgFWTYk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 15:24:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31600 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387454AbgFWTYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 15:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592940274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=tVsDsAmElVtmSpleihdn/aqK002mWcZ5/rdoWS26sdI=;
        b=Kl5VAhN3IxPHjGbI5xEZ2wrTlZc3aFEaz+Tj0x5NsF3+WUVFB5qsMW2mGk15oR8neMot7f
        du0Th0idL58J9eRqPmUbp4sclUx/xz/zgH8dvY4Vc1vCq5dLiZpYJiX4fU2EK1QjsafTLx
        P0eROTzW/gQsiyRnm3gDwEOJ9kjrX/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-tFqb6DVYPzynQ5ElJ40RHw-1; Tue, 23 Jun 2020 15:24:29 -0400
X-MC-Unique: tFqb6DVYPzynQ5ElJ40RHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B90868031D3;
        Tue, 23 Jun 2020 19:24:27 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13CCE610F3;
        Tue, 23 Jun 2020 19:24:25 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com
Subject: [Patch v3 3/3] net: Restrict receive packets queuing to housekeeping CPUs
Date:   Tue, 23 Jun 2020 15:23:31 -0400
Message-Id: <20200623192331.215557-4-nitesh@redhat.com>
In-Reply-To: <20200623192331.215557-1-nitesh@redhat.com>
References: <20200623192331.215557-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alex Belits <abelits@marvell.com>

With the existing implementation of store_rps_map(), packets are queued
in the receive path on the backlog queues of other CPUs irrespective of
whether they are isolated or not. This could add a latency overhead to
any RT workload that is running on the same CPU.

Ensure that store_rps_map() only uses available housekeeping CPUs for
storing the rps_map.

Signed-off-by: Alex Belits <abelits@marvell.com>
Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 net/core/net-sysfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e353b822bb15..677868fea316 100644
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
+	if (cpumask_empty(mask)) {
+		free_cpumask_var(mask);
+		return -EINVAL;
+	}
+
 	map = kzalloc(max_t(unsigned int,
 			    RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
 		      GFP_KERNEL);
-- 
2.18.4

