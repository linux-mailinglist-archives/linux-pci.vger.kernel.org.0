Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD19187A9D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 08:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQHnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 03:43:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57300 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQHnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 03:43:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02H7gsAX067054;
        Tue, 17 Mar 2020 02:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584430974;
        bh=7JK5jurkiOzB4xeZ63mZpS0c84gUOTRe8SmMmit+kWg=;
        h=From:To:CC:Subject:Date;
        b=U7REZ17/GAzBO2tifO8dcluceWeBq+xj+idXeg68v2ToKSq3hJcJvfFf6zSooAGST
         4oXDiTW4RiYH0o74KCqn3iGEPhd1iqUYzmlE+UQpXLZ68xUor4zskRLQST2zfieOv6
         ucq3r0TV46wWchn1U9dgmx/P8RsF7QfTYAHXvwzI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02H7gsKk091655;
        Tue, 17 Mar 2020 02:42:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Mar 2020 02:42:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Mar 2020 02:42:54 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02H7gpax019783;
        Tue, 17 Mar 2020 02:42:52 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Vidya Sagar <vidyas@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] PCI: endpoint: functions/pci-epf-test: Fix compiler error
Date:   Tue, 17 Mar 2020 13:17:19 +0530
Message-ID: <20200317074719.10668-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 812828eb5072 ("PCI: endpoint: Fix ->set_msix() to take BIR
and offset as arguments") was created before adding deferred
core initialization support in commit 5e50ee27d4a5 ("PCI: pci-epf-test:
Add support to defer core initialization").
However since deferred core initialization was merged before
re-designing MSI-X support, it caused the following compiler error.

drivers/pci/endpoint/functions/pci-epf-test.c:697:12: error: ‘epf_test’ undeclared (first use in this function);

Fix the compilation error here.

Fixes: 812828eb5072 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Lorenzo,

This patch can be squashed with
"PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments"

Thanks
Kishon

 drivers/pci/endpoint/functions/pci-epf-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index eaf192be02bb..3b4cf7e2bc60 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -660,6 +660,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 static int pci_epf_test_core_init(struct pci_epf *epf)
 {
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
 	const struct pci_epc_features *epc_features;
 	struct pci_epc *epc = epf->epc;
-- 
2.17.1

