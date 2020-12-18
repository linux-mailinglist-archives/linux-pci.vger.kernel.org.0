Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9572DE875
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgLRRmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:49 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38564 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgLRRms (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6EE98413BD;
        Fri, 18 Dec 2020 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313280; x=1610127681; bh=q35EItJkKAw72WYZwl9DiZGp7mbr5pR6nC2
        ozTHlueA=; b=OifHQ06ekQ0Vs1fe/NglwdExKO45lWV0aJgW2VA9Q5E7SJts9jb
        IRaokmcQuo0Amey6SVvNh0So6h3cqJXXz+4fIbI/rfRfCZxbeNlX40dXEQ+MIxY8
        FLWWc52k/eRsL/vd/GGKZlJmvAzDuywFYOgtPuJDwHlIj4A7DSFUfeUc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DB9o65GrG6ER; Fri, 18 Dec 2020 20:41:20 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 102ED412EC;
        Fri, 18 Dec 2020 20:41:09 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:08 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 16/26] PCI: hotplug: Configure MPS after manual bus rescan
Date:   Fri, 18 Dec 2020 20:40:01 +0300
Message-ID: <20201218174011.340514-17-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Assure that MPS settings are set up for bridges which are discovered during
manually triggered rescan via sysfs. This sequence of bridge init (using
pci_rescan_bus()) later will be used for pciehp hot-add events when BAR
movement is enabled.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 964dfa71af22..b8873ee82a4b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3578,7 +3578,7 @@ static void pci_reassign_root_bus_resources(struct pci_bus *root)
 unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
-	struct pci_bus *root = bus;
+	struct pci_bus *root = bus, *child;
 
 	while (!pci_is_root_bus(root))
 		root = root->parent;
@@ -3599,6 +3599,9 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		pci_assign_unassigned_bus_resources(bus);
 	}
 
+	list_for_each_entry(child, &root->children, node)
+		pcie_bus_configure_settings(child);
+
 	pci_bus_add_devices(bus);
 
 	return max;
-- 
2.24.1

