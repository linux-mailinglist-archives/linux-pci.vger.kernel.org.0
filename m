Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CAD280CE8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 06:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgJBEtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 00:49:01 -0400
Received: from mx.socionext.com ([202.248.49.38]:24379 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgJBEtB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 00:49:01 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Oct 2020 13:48:58 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C684A180B3C;
        Fri,  2 Oct 2020 13:48:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 2 Oct 2020 13:48:58 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 144CC1A0509;
        Fri,  2 Oct 2020 13:48:58 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/3] PCI: endpoint: Add 'started' to pci_epc to set whether the controller is started
Date:   Fri,  2 Oct 2020 13:48:45 +0900
Message-Id: <1601614127-13837-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601614127-13837-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1601614127-13837-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds a member 'started' as a boolean value to struct pci_epc to set
whether the controller is started, and also adds a function to get the
value.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 2 ++
 include/linux/pci-epc.h             | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index cadd3db..155be574 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -148,6 +148,7 @@ void pci_epc_stop(struct pci_epc *epc)
 
 	mutex_lock(&epc->lock);
 	epc->ops->stop(epc);
+	epc->started = false;
 	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_stop);
@@ -170,6 +171,7 @@ int pci_epc_start(struct pci_epc *epc)
 
 	mutex_lock(&epc->lock);
 	ret = epc->ops->start(epc);
+	epc->started = true;
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index cc66bec..d875d2d 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -107,6 +107,7 @@ struct pci_epc_mem {
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
  * @notifier: used to notify EPF of any EPC events (like linkup)
+ * @started: true if this EPC is started
  */
 struct pci_epc {
 	struct device			dev;
@@ -121,6 +122,7 @@ struct pci_epc {
 	struct mutex			lock;
 	unsigned long			function_num_map;
 	struct atomic_notifier_head	notifier;
+	bool				started;
 };
 
 /**
@@ -167,6 +169,11 @@ pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
 	return atomic_notifier_chain_register(&epc->notifier, nb);
 }
 
+static inline bool pci_epc_is_started(struct pci_epc *epc)
+{
+	return epc->started;
+}
+
 struct pci_epc *
 __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		      struct module *owner);
-- 
2.7.4

