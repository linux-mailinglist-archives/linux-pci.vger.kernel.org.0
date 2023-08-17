Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B411277F0F0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 09:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348373AbjHQHKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbjHQHKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 03:10:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A8272B
        for <linux-pci@vger.kernel.org>; Thu, 17 Aug 2023 00:10:03 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRGK226mwzFqs0;
        Thu, 17 Aug 2023 15:07:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 15:10:00 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] PCI: endpoint: Use helper function IS_ERR_OR_NULL()
Date:   Thu, 17 Aug 2023 15:09:31 +0800
Message-ID: <20230817070932.341667-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use IS_ERR_OR_NULL() instead of open-coding it
to simplify the code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a4a8b0be626..fe421d46a8a4 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -38,7 +38,7 @@ static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
  */
 void pci_epc_put(struct pci_epc *epc)
 {
-	if (!epc || IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc))
 		return;
 
 	module_put(epc->ops->owner);
@@ -660,7 +660,7 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 	struct list_head *list;
 	u32 func_no = 0;
 
-	if (!epc || IS_ERR(epc) || !epf)
+	if (IS_ERR_OR_NULL(epc) || !epf)
 		return;
 
 	if (type == PRIMARY_INTERFACE) {
@@ -691,7 +691,7 @@ void pci_epc_linkup(struct pci_epc *epc)
 {
 	struct pci_epf *epf;
 
-	if (!epc || IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc))
 		return;
 
 	mutex_lock(&epc->list_lock);
@@ -717,7 +717,7 @@ void pci_epc_linkdown(struct pci_epc *epc)
 {
 	struct pci_epf *epf;
 
-	if (!epc || IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc))
 		return;
 
 	mutex_lock(&epc->list_lock);
@@ -743,7 +743,7 @@ void pci_epc_init_notify(struct pci_epc *epc)
 {
 	struct pci_epf *epf;
 
-	if (!epc || IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc))
 		return;
 
 	mutex_lock(&epc->list_lock);
@@ -769,7 +769,7 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 {
 	struct pci_epf *epf;
 
-	if (!epc || IS_ERR(epc))
+	if (IS_ERR_OR_NULL(epc))
 		return;
 
 	mutex_lock(&epc->list_lock);
-- 
2.34.1

