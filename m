Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A853226D420
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIQHE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 03:04:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbgIQHEI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 03:04:08 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B753530BBAD9E1F7EDF3;
        Thu, 17 Sep 2020 14:48:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 14:48:09 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] PCI/IOV: use module_pci_driver to simplify the code
Date:   Thu, 17 Sep 2020 15:10:42 +0800
Message-ID: <20200917071042.1909191-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the module_pci_driver() macro to make the code simpler
by eliminating module_init and module_exit calls.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/pci/pci-pf-stub.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
index a0b2bd6c918a..45855a5e9fca 100644
--- a/drivers/pci/pci-pf-stub.c
+++ b/drivers/pci/pci-pf-stub.c
@@ -37,18 +37,6 @@ static struct pci_driver pf_stub_driver = {
 	.probe			= pci_pf_stub_probe,
 	.sriov_configure	= pci_sriov_configure_simple,
 };
-
-static int __init pci_pf_stub_init(void)
-{
-	return pci_register_driver(&pf_stub_driver);
-}
-
-static void __exit pci_pf_stub_exit(void)
-{
-	pci_unregister_driver(&pf_stub_driver);
-}
-
-module_init(pci_pf_stub_init);
-module_exit(pci_pf_stub_exit);
+module_pci_driver(pf_stub_driver);
 
 MODULE_LICENSE("GPL");
-- 
2.25.1

