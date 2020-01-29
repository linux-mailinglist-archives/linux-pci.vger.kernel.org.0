Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F614CD6C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgA2PaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:06 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55864 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727095AbgA2PaG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id BA11D47619;
        Wed, 29 Jan 2020 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311804; x=1582126205; bh=gDv30ZBnDuev6B5U+AY0bSdQ5WW45y7Ff6t
        zLvcRW4A=; b=KE+088j06DgckyoYv+3J+kue46iYFvCOmFxz/VtxzUXFR/yja0z
        EBvcsZQDht4P8eePoUX3SQdn+RrPn1r4JlOZCu2ideDvCd3B2cxU7Q1LEFQMz7h6
        2cKwDmlEnbVl4BOAk58Upc7K9wGJZwbiZcz1Y08kHS6j3R5Shp3b2aMI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VRy_W7xXAqdh; Wed, 29 Jan 2020 18:30:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0F2EE4761E;
        Wed, 29 Jan 2020 18:29:55 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:54 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v7 22/26] PCI: pciehp: Trigger a domain rescan on hp events when enabled movable BARs
Date:   Wed, 29 Jan 2020 18:29:33 +0300
Message-ID: <20200129152937.311162-23-s.miroshnichenko@yadro.com>
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

With movable BARs, adding a hotplugged device is not local to its bridge
anymore, but it affects the whole RC: BARs, bridge windows and bus numbers
can be substantially rearranged. So instead of trying to fit the new
devices into preallocated reserved gaps, initiate a full domain rescan.

The pci_rescan_bus() covers all the operations of the replaced functions:
 - assigning new bus numbers, as the pci_hp_add_bridge() does it;
 - allocating BARs (pci_assign_unassigned_bridge_resources());
 - cofiguring MPS settings (pcie_bus_configure_settings());
 - binding devices to their drivers (pci_bus_add_devices()).

CC: Lukas Wunner <lukas@wunner.de>
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

