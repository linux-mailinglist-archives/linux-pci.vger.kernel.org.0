Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2E2044B1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 01:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgFVXqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 19:46:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730766AbgFVXqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 19:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592869566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=iVIcd3LbDjZaO4XgTYyXw6k60oAbIn90LRL9W8RewGA=;
        b=N8nYIkfQ7fQuNn2wVwgkY6gxHMaukLExLNUS1Qv2LGZDtJ3HQd0AAU3zy1ZSMlxpii18bU
        4PQWAkLFaV4skk7OnG1yBu8bv8U1+1E9RBmS1TajojcsdKm8/AmScZDSwiuVRx5xpCYl9T
        lVByW/REVskHE/QIBDQU2Cw9uxXscZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-papsVCsWPwW1MD1oUFl9tg-1; Mon, 22 Jun 2020 19:45:59 -0400
X-MC-Unique: papsVCsWPwW1MD1oUFl9tg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E33B218585A1;
        Mon, 22 Jun 2020 23:45:56 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FF655C290;
        Mon, 22 Jun 2020 23:45:55 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com
Subject: [Patch v2 3/3] net: Restrict receive packets queuing to housekeeping CPUs
Date:   Mon, 22 Jun 2020 19:45:10 -0400
Message-Id: <20200622234510.240834-4-nitesh@redhat.com>
In-Reply-To: <20200622234510.240834-1-nitesh@redhat.com>
References: <20200622234510.240834-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

