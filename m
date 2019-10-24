Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E237E398D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439955AbfJXRM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:59 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48808 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439951AbfJXRM7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5541043597;
        Thu, 24 Oct 2019 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937177; x=1573751578; bh=WoAGswMD0jcTKXY/it96M1aTyTP0ATGaJ8r
        2Yos5H2Q=; b=hmU0M1g41x6vEfQPw5xHcLxC9h3WP7gvi3IHdFTDnisYPAjz2DD
        ohjsb/HzrLr/cDv6yQR/L8ZD4J1NP+/ygQCJPR9eajrPWAo6qbx6xQzX6GcHhwxs
        malwQtTiHiySjs4VMjl/hqOFJJP7xEhRAM+3CgSu4XWYiK5oznNeNcz8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2GSjhsYQarjV; Thu, 24 Oct 2019 20:12:57 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 74F5843E18;
        Thu, 24 Oct 2019 20:12:45 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:45 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v6 30/30] Revert "powerpc/powernv/pci: Work around races in PCI bridge enabling"
Date:   Thu, 24 Oct 2019 20:12:28 +0300
Message-ID: <20191024171228.877974-31-s.miroshnichenko@yadro.com>
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

This reverts commit db2173198b9513f7add8009f225afa1f1c79bcc6.

The root cause of this bug is fixed by the following two commits:

  1. "PCI: Fix race condition in pci_enable/disable_device()"
  2. "PCI: Enable bridge's I/O and MEM access for hotplugged devices"

The x86 is also affected by this bug if a PCIe bridge has been hotplugged
without pre-enabling by the BIOS.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 37 -----------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 33d5ed8c258f..f12f3a49d3bb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3119,49 +3119,12 @@ static void pnv_pci_ioda_create_dbgfs(void)
 #endif /* CONFIG_DEBUG_FS */
 }
 
-static void pnv_pci_enable_bridge(struct pci_bus *bus)
-{
-	struct pci_dev *dev = bus->self;
-	struct pci_bus *child;
-
-	/* Empty bus ? bail */
-	if (list_empty(&bus->devices))
-		return;
-
-	/*
-	 * If there's a bridge associated with that bus enable it. This works
-	 * around races in the generic code if the enabling is done during
-	 * parallel probing. This can be removed once those races have been
-	 * fixed.
-	 */
-	if (dev) {
-		int rc = pci_enable_device(dev);
-		if (rc)
-			pci_err(dev, "Error enabling bridge (%d)\n", rc);
-		pci_set_master(dev);
-	}
-
-	/* Perform the same to child busses */
-	list_for_each_entry(child, &bus->children, node)
-		pnv_pci_enable_bridge(child);
-}
-
-static void pnv_pci_enable_bridges(void)
-{
-	struct pci_controller *hose;
-
-	list_for_each_entry(hose, &hose_list, list_node)
-		pnv_pci_enable_bridge(hose->bus);
-}
-
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
 	pnv_pci_ioda_setup_iommu_api();
 	pnv_pci_ioda_create_dbgfs();
 
-	pnv_pci_enable_bridges();
-
 #ifdef CONFIG_EEH
 	pnv_eeh_post_init();
 #endif
-- 
2.23.0

