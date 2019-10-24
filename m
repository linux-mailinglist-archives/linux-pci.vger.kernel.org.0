Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7CEFE3978
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436682AbfJXRMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:48 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48808 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405901AbfJXRMr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D651A438CE;
        Thu, 24 Oct 2019 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937165; x=1573751566; bh=Ay54PSF1F0jBkianHUfRLKAtYZp036FG1+X
        ImCOLkNA=; b=GKuAxZVH5Hu//GymgpYzy1uhYmT57w0I6z5koQ1Y0+KT8Q7aykk
        7n1FPSPoxVD9iAMFC8LuxjBIzJcDvaFNq9zaL5jgsjU8uc/3AdAx0d+5l6GOtA/z
        L8fPRJQGUkCVHs5Ei16M8qg5JrWZCfLhvHyg4XzC2M+to34J0bas0hzo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w401pJkLQ2_F; Thu, 24 Oct 2019 20:12:45 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 31EFC438D1;
        Thu, 24 Oct 2019 20:12:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:40 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v6 10/30] PCI: Prohibit assigning BARs and bridge windows to non-direct parents
Date:   Thu, 24 Oct 2019 20:12:08 +0300
Message-ID: <20191024171228.877974-11-s.miroshnichenko@yadro.com>
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
index ff33b47b1bb7..cf325daae1b1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1355,6 +1355,8 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 		while (b && !r->parent) {
 			assign_fixed_resource_on_bus(b, r);
 			b = b->parent;
+			if (!r->parent && pci_can_move_bars)
+				break;
 		}
 	}
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d8ca40a97693..a1657a8bf93d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -298,6 +298,18 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 
 	bus = dev->bus;
 	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
+		if (pci_can_move_bars) {
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
2.23.0

