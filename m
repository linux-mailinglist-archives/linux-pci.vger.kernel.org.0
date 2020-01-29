Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2331B14CD68
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgA2PaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:05 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55864 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727095AbgA2PaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 181DA47638;
        Wed, 29 Jan 2020 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311803; x=1582126204; bh=OICdl3GBMIlvtb7uIInZqvKfC5xFfg9XVrz
        HEXhee6U=; b=OdfbiGPpH3LR1/Mgzz67hM4AwJavC/H2QWrZ03YiQYhFPjUzINI
        8FYyqsR6GmhBEuFIm2GMmmkXQXzdKnhMxAa3CwknHmUDx4NvL0qDh50ghS749Tqg
        JFC3X1F/PLxt7H4YlQQf5oK/ebww45XpZ2d0FSLBxaLcwwivam4rPpLY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bJqwttwmifqX; Wed, 29 Jan 2020 18:30:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6CF1747606;
        Wed, 29 Jan 2020 18:29:54 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:53 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 19/26] PCI: hotplug: Configure MPS for hot-added bridges during bus rescan
Date:   Wed, 29 Jan 2020 18:29:30 +0300
Message-ID: <20200129152937.311162-20-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Assure that MPS settings are set up for bridges which are discovered during
manually triggered rescan via sysfs. This sequence of bridge init (using
pci_rescan_bus()) will be used for pciehp hot-add events when BARs are
movable.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b810d28ebf96..5f809ddd72b4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3440,7 +3440,7 @@ static void pci_reassign_root_bus_resources(struct pci_bus *root)
 unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
-	struct pci_bus *root = bus;
+	struct pci_bus *root = bus, *child;
 
 	while (!pci_is_root_bus(root))
 		root = root->parent;
@@ -3461,6 +3461,9 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		pci_assign_unassigned_bus_resources(bus);
 	}
 
+	list_for_each_entry(child, &root->children, node)
+		pcie_bus_configure_settings(child);
+
 	pci_bus_add_devices(bus);
 
 	return max;
-- 
2.24.1

