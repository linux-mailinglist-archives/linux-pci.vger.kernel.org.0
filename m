Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864B1301CFE
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jan 2021 16:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbhAXPKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jan 2021 10:10:42 -0500
Received: from mx.socionext.com ([202.248.49.38]:26509 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbhAXPKb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Jan 2021 10:10:31 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Jan 2021 00:09:44 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 7693A205902B;
        Mon, 25 Jan 2021 00:09:44 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 25 Jan 2021 00:09:44 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id DABBDB1D40;
        Mon, 25 Jan 2021 00:09:43 +0900 (JST)
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
Subject: [PATCH v2 1/3] PCI: endpoint: Add 'started' to pci_epc to set whether the controller is started
Date:   Mon, 25 Jan 2021 00:09:35 +0900
Message-Id: <1611500977-24816-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611500977-24816-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1611500977-24816-1-git-send-email-hayashi.kunihiko@socionext.com>
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
index cc8f9eb..2904175 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -174,6 +174,7 @@ void pci_epc_stop(struct pci_epc *epc)
 
 	mutex_lock(&epc->lock);
 	epc->ops->stop(epc);
+	epc->started = false;
 	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_stop);
@@ -196,6 +197,7 @@ int pci_epc_start(struct pci_epc *epc)
 
 	mutex_lock(&epc->lock);
 	ret = epc->ops->start(epc);
+	epc->started = true;
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index b82c9b1..5808952 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -131,6 +131,7 @@ struct pci_epc_mem {
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
  * @notifier: used to notify EPF of any EPC events (like linkup)
+ * @started: true if this EPC is started
  */
 struct pci_epc {
 	struct device			dev;
@@ -145,6 +146,7 @@ struct pci_epc {
 	struct mutex			lock;
 	unsigned long			function_num_map;
 	struct atomic_notifier_head	notifier;
+	bool				started;
 };
 
 /**
@@ -191,6 +193,11 @@ pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
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

