Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4518E3973
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405917AbfJXRMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:45 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48798 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408021AbfJXRMp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id E266F43E07;
        Thu, 24 Oct 2019 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937162; x=1573751563; bh=03Gd2zXei/2YVqAgwHE1WQSBVHfa/dXqAQ0
        t5M0opgg=; b=HhZBdrmDOr2TM39pzhh+ZTPVAtEDS1Dk78BQOXXT1xTBf8+6ONH
        ap3ZfaMg1kObCG//5WNo3RkffKpsjkeCjJgLV642ovh6OYK1Cv6zZyTonkePNJgF
        nIkiS/j/AxmBXx2unVtHDpdWpaL27iyspEGwIT38uTsriqqwPGdw9Xrs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6JcBIMhHLZ5w; Thu, 24 Oct 2019 20:12:42 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1BD46437F3;
        Thu, 24 Oct 2019 20:12:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:39 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v6 05/30] PCI: hotplug: movable BARs: Fix reassigning the released bridge windows
Date:   Thu, 24 Oct 2019 20:12:03 +0300
Message-ID: <20191024171228.877974-6-s.miroshnichenko@yadro.com>
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

When a bridge window is temporarily released during the rescan, its old
size is not relevant anymore - it will be recreated from pbus_size_*(), so
it's start value should be zero.

If such window can't be reassigned, don't apply reset_resource(), so the
next retry may succeed.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2c02eb1acf5d..f2f02e6c9000 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -295,7 +295,8 @@ static void assign_requested_resources_sorted(struct list_head *head,
 						    0 /* don't care */,
 						    0 /* don't care */);
 			}
-			reset_resource(res);
+			if (!pci_can_move_bars)
+				reset_resource(res);
 		}
 	}
 }
@@ -1579,8 +1580,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		pci_info(dev, "resource %d %pR released\n",
 			 PCI_BRIDGE_RESOURCES + idx, r);
-		/* Keep the old size */
-		r->end = resource_size(r) - 1;
+		/* Don't keep the old size if the bridge will be recalculated */
+		r->end = pci_can_move_bars ? 0 : (resource_size(r) - 1);
 		r->start = 0;
 		r->flags = 0;
 
-- 
2.23.0

