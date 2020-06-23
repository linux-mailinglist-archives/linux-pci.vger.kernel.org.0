Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876CC205BBC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgFWTYe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 15:24:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387442AbgFWTYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 15:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592940272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=JMv4mx6+Se3DWeaSHcRU/xuepCBk94gqg4Zktde6+Q4=;
        b=HaZEsF4L8iKg+RGZ+rqc31N8+o4B/tzkw33TyuUGcW3KhuUpixRG4zlbnSA39r7DwmQZN1
        +JlXrCeN/UT6OMhpIMmsAvSnnuto3iP/FU+AsU8o5VzRhAq0G2hRD1UZTZXPOfSfMIJNAl
        PlDdOpx0ivyGvX3y5rH2gbCwwqHGUKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-JJ-Gaaw_PySYA97Xu5ihQg-1; Tue, 23 Jun 2020 15:24:28 -0400
X-MC-Unique: JJ-Gaaw_PySYA97Xu5ihQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E195E1009610;
        Tue, 23 Jun 2020 19:24:25 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 257E2610F3;
        Tue, 23 Jun 2020 19:24:24 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com
Subject: [Patch v3 2/3] PCI: Restrict probe functions to housekeeping CPUs
Date:   Tue, 23 Jun 2020 15:23:30 -0400
Message-Id: <20200623192331.215557-3-nitesh@redhat.com>
In-Reply-To: <20200623192331.215557-1-nitesh@redhat.com>
References: <20200623192331.215557-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alex Belits <abelits@marvell.com>

pci_call_probe() prevents the nesting of work_on_cpu() for a scenario
where a VF device is probed from work_on_cpu() of the PF.

Replace the cpumask used in pci_call_probe() from all online CPUs to only
housekeeping CPUs. This is to ensure that there are no additional latency
overheads caused due to the pinning of jobs on isolated CPUs.

Signed-off-by: Alex Belits <abelits@marvell.com>
Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/pci/pci-driver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index da6510af1221..449466f71040 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/sched/isolation.h>
 #include <linux/cpu.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -333,6 +334,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
 	int error, node, cpu;
+	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 	struct drv_dev_and_id ddi = { drv, dev, id };
 
 	/*
@@ -353,7 +355,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	    pci_physfn_is_probed(dev))
 		cpu = nr_cpu_ids;
 	else
-		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
+		cpu = cpumask_any_and(cpumask_of_node(node),
+				      housekeeping_cpumask(hk_flags));
 
 	if (cpu < nr_cpu_ids)
 		error = work_on_cpu(cpu, local_pci_probe, &ddi);
-- 
2.18.4

