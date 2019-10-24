Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07E4E398E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439956AbfJXRNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:13:04 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49038 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439946AbfJXRNE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:13:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2337043611;
        Thu, 24 Oct 2019 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937177; x=1573751578; bh=Ly1PnEFeD8eqUYeDGQz6RzFYm/+hza4Wmd7
        9/emghxo=; b=sSU16cwMIvKkPcKFHziNyzbW4yXBUTk0MhmVLo4MN+CF6CHc1zs
        NxMJNhKC6BQt1ypZ5RIexaxkLKgsFYwLH1issHPKIToBcCEi2oTkCFzxXlE/+QGP
        9/FdDUn9qFrLjHiWPYKlO459o1qhf3Iu4KYM38A4JDmvTg4qurLb1VFQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id adOlb3e024Bv; Thu, 24 Oct 2019 20:12:57 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 44CD1437F8;
        Thu, 24 Oct 2019 20:12:45 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:44 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v6 29/30] PCI: pciehp: movable BARs: Trigger a domain rescan on hp events
Date:   Thu, 24 Oct 2019 20:12:27 +0300
Message-ID: <20191024171228.877974-30-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
References: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
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
anymore, but it affects the whole domain: BARs, bridge windows and bus
numbers can be substantially rearranged. So instead of trying to fit the
new devices into preallocated reserved gaps, initiate a full domain rescan.

The pci_rescan_bus() covers all the operations of the replaced functions:
 - assigning new bus numbers, as the pci_hp_add_bridge() does it;
 - allocating BARs (pci_assign_unassigned_bridge_resources());
 - cofiguring MPS settings (pcie_bus_configure_settings());
 - binding devices to their drivers (pci_bus_add_devices()).

CC: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
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
2.23.0

