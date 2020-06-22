Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C9204499
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 01:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgFVXqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 19:46:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45202 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728873AbgFVXqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 19:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592869559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=JMv4mx6+Se3DWeaSHcRU/xuepCBk94gqg4Zktde6+Q4=;
        b=E1ggOYb+QWXR/Rf3QLrmcfFTFZqAw2/xPGsfuXgoPHkGZbvRfPLydXoiavTnA4BPk5vAsQ
        v4d2U2PVBKzuG6ugWc+BWHfOAJzjnbyPZ9lJzt485pMNvR4WXVhZxDlchkA5sxeTF8lQsN
        7DYw4w1TG/a287kfVPdrF01642N4NJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-Tpn6uXKuPfW8Pya9396Lsw-1; Mon, 22 Jun 2020 19:45:57 -0400
X-MC-Unique: Tpn6uXKuPfW8Pya9396Lsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECCBF8031D3;
        Mon, 22 Jun 2020 23:45:54 +0000 (UTC)
Received: from virtlab423.virt.lab.eng.bos.redhat.com (virtlab423.virt.lab.eng.bos.redhat.com [10.19.152.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4959A5C221;
        Mon, 22 Jun 2020 23:45:53 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com
Subject: [Patch v2 2/3] PCI: Restrict probe functions to housekeeping CPUs
Date:   Mon, 22 Jun 2020 19:45:09 -0400
Message-Id: <20200622234510.240834-3-nitesh@redhat.com>
In-Reply-To: <20200622234510.240834-1-nitesh@redhat.com>
References: <20200622234510.240834-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

