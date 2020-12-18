Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015F92DE876
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgLRRmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:50 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38566 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbgLRRmt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9DCE64120A;
        Fri, 18 Dec 2020 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313283; x=1610127684; bh=yUQ/qeNM7/P1CLLD+3cl1iPEn6wC6ShgeR8
        iUomRcFU=; b=HtOZukoxQW96sAXc8+u1lwPp+bX7+KVJk4utowLFbFVMrONY169
        QS6lIK8ht5RZ5NYghJrOkDMXNXpnsJCqqmVhu8/oZi7v/p/7Mpo8yx0nUDMJv4vI
        DtJZGfwOhk2hFt68uz+UA7eNiqf4kIjZcHOfB27r+pMVh1rGUaL9zbzc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QAFJnZ6eNGvt; Fri, 18 Dec 2020 20:41:23 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8A24A413CF;
        Fri, 18 Dec 2020 20:41:09 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:09 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 18/26] PCI: pciehp: Trigger a domain rescan on hp events when enabled movable BARs
Date:   Fri, 18 Dec 2020 20:40:03 +0300
Message-ID: <20201218174011.340514-19-s.miroshnichenko@yadro.com>
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

With movable BARs, hot-adding a device is not a local event for its bridge,
but it affects the whole RC: BARs and bridge windows can be substantially
rearranged. So instead of trying to fit the new devices into pre-allocated
reserved gaps, initiate a full domain rescan.

The pci_rescan_bus() covers all the operations of the replaced functions:
 - assigning new bus numbers, as the pci_hp_add_bridge() does it;
 - allocating BARs -- pci_assign_unassigned_bridge_resources();
 - configuring MPS settings -- pcie_bus_configure_settings();
 - binding devices to their drivers -- pci_bus_add_devices().

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/hotplug/pciehp_pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index d17f3bf36f70..6d4c1ef38210 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -58,6 +58,11 @@ int pciehp_configure_device(struct controller *ctrl)
 		goto out;
 	}
 
+	if (pci_can_move_bars) {
+		pci_rescan_bus(parent);
+		goto out;
+	}
+
 	for_each_pci_bridge(dev, parent)
 		pci_hp_add_bridge(dev);
 
-- 
2.24.1

