Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A66E39BD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503526AbfJXRWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:22:10 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49526 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503467AbfJXRWK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:22:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 8357742F15;
        Thu, 24 Oct 2019 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937728; x=1573752129; bh=9SNqmukav0eCCSo00z1QsS5PHaStBZ2+oc5
        w2+I+b5Q=; b=XruQ3mxswY0DbF3dYfH6GQJ4WVJoHwn8c8MgMm/k/MgwDm2+teV
        LO3gPPEODb9ATg6Sjvaw20ZkfX0XYvcthw9xMoqAb0SRrDzt9HQS5J/RDzfRu5lq
        g9WbmT0hBEDVi9S/5NZW9RPz/BeciL6k4rVVWoommOBfIh5SR1VSNpK0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LvjXVHojmpkz; Thu, 24 Oct 2019 20:22:08 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 00664437FA;
        Thu, 24 Oct 2019 20:22:05 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:22:05 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 08/11] PCI: Allow expanding the bridges
Date:   Thu, 24 Oct 2019 20:21:54 +0300
Message-ID: <20191024172157.878735-9-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
References: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
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

When hotplugging a bridge, the parent bus may not have [enough] reserved
bus numbers. So before rescanning the bus, set its subordinate number to
the maximum possible value: it is 255 when there is only one root bridge
in the domain.

During the PCI rescan, the subordinate bus number of every bus will be
contracted to the actual value.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 539f5d39bb6d..3494b5d265d5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3195,20 +3195,22 @@ static unsigned int pci_dev_count_res_mask(struct pci_dev *dev)
 	return res_mask;
 }
 
-static void pci_bus_rescan_prepare(struct pci_bus *bus)
+static void pci_bus_rescan_prepare(struct pci_bus *bus, int last_bus_number)
 {
 	struct pci_dev *dev;
 
 	if (bus->self)
 		pci_config_pm_runtime_get(bus->self);
 
+	bus->busn_res.end = last_bus_number;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *child = dev->subordinate;
 
 		dev->res_mask = pci_dev_count_res_mask(dev);
 
 		if (child)
-			pci_bus_rescan_prepare(child);
+			pci_bus_rescan_prepare(child, last_bus_number);
 
 		if (dev->driver &&
 		    dev->driver->rescan_prepare)
@@ -3439,7 +3441,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 	if (pci_can_move_bars) {
 		pcibios_root_bus_rescan_prepare(root);
-		pci_bus_rescan_prepare(root);
+		pci_bus_rescan_prepare(root, root->busn_res.end);
 		pci_bus_update_immovable_range(root);
 		pci_bus_release_root_bridge_resources(root);
 
-- 
2.23.0

