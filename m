Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD69061C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfHPQvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:16 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51338 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbfHPQvQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C0A8C42EF3;
        Fri, 16 Aug 2019 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974274; x=1567788675; bh=kub9kFo40DhaU3JHJRULNGlExW4BAfTjWiH
        IJegjDRI=; b=Vi1j512rMHhMMocEblI+bUBxmczAvExHmh2Qtmdn5ZiWDWOKU9e
        nDpwqGq39RBIzMkAPOXgu3CS+0EAndI3anCyfD+NVJXVPIQzObZa8LvMZnl9gdcn
        8/s9z1OmqeD5EQpDH7pQLIvo2l6Y6G9pmGAAJIixiA7PSpR9Cu1YM5dk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uTAXHYZF1kWA; Fri, 16 Aug 2019 19:51:14 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id BBC9242ED2;
        Fri, 16 Aug 2019 19:51:10 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:10 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 09/23] PCI: Prohibit assigning BARs and bridge windows to non-direct parents
Date:   Fri, 16 Aug 2019 19:50:47 +0300
Message-ID: <20190816165101.911-10-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816165101.911-1-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When movable BARs are enabled, the feature of resource relocating from
commit 2bbc6942273b5 ("PCI : ability to relocate assigned pci-resources")
is not used. Instead, inability to assign a resource is used as a signal
to retry BAR assignment with other configuration of bridge windows.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c |  2 ++
 drivers/pci/setup-res.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2c250efca512..aee330047121 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1356,6 +1356,8 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 		while (b && !r->parent) {
 			assign_fixed_resource_on_bus(b, r);
 			b = b->parent;
+			if (!r->parent && pci_movable_bars_enabled())
+				break;
 		}
 	}
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d8ca40a97693..732d18f60f1b 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -298,6 +298,18 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 
 	bus = dev->bus;
 	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
+		if (pci_movable_bars_enabled()) {
+			if (resno >= PCI_BRIDGE_RESOURCES &&
+			    resno <= PCI_BRIDGE_RESOURCE_END) {
+				struct resource *res = dev->resource + resno;
+
+				res->start = 0;
+				res->end = 0;
+				res->flags = 0;
+			}
+			break;
+		}
+
 		if (!bus->parent || !bus->self->transparent)
 			break;
 		bus = bus->parent;
-- 
2.21.0

