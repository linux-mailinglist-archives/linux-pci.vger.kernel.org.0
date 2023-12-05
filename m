Return-Path: <linux-pci+bounces-519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7494805ADE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723A11F21514
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D81692A2;
	Tue,  5 Dec 2023 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiWzord3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EA69288
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 17:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DA0C433C7;
	Tue,  5 Dec 2023 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796288;
	bh=HTRqZd2oPNNCESbeb303NgbHA77C4zlrwiA3tsQYhYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AiWzord3m/BV+v7+SAdv3NamPdu+rDjCuz1XRZXd7KIoVvGSOYeU9wTJ6fiu298Nj
	 czSQ5aBxiv8IaKez6tZfaqvbZCmdT4xYpSp27TNZzFx+EYzpOC/j3L+x7H8F7tuq+q
	 UD/mfTcLXS4FaxFhulE3QENyflHdlJYPCkcKL5y79w/nkoZk0/c05uP1/j04BR+kv5
	 drzm7uOtrUOaY/0rgAKMqpbgioIpDjnH1zyXsG+4K6S1f5Ds/3ATyKVpRVT2luiyNU
	 GjDnHFIQ6QUSW04OkQ1RRRwWhPpFZEgghXQrzfTlugwYHz6Ue+7+xbdglzlm6rebgL
	 9KeK8hgf0WVtA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/7] PCI: Update BAR # and window messages
Date: Tue,  5 Dec 2023 11:11:14 -0600
Message-Id: <20231205171119.680358-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205171119.680358-1-helgaas@kernel.org>
References: <20231205171119.680358-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay12@gmail.com>

The PCI log messages print the register offsets at some places and BAR
numbers at other places. There is no uniformity in this logging mechanism.
It would be better to print names than register offsets.

Add a helper function that aids in printing more meaningful information
about the BAR numbers like "VF BAR", "ROM", "bridge window", etc.  This
function can be called while printing PCI log messages.

[bhelgaas: fold in Lukas' static array suggestion from
https://lore.kernel.org/all/20211106115831.GA7452@wunner.de/]
Link: https://lore.kernel.org/r/20211106112606.192563-2-puranjay12@gmail.com
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..af36a0bf3e42 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -850,6 +850,66 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
 }
 EXPORT_SYMBOL(pci_find_resource);
 
+/**
+ * pci_resource_name - Return the name of the PCI resource
+ * @dev: PCI device to query
+ * @i: index of the resource
+ *
+ * Return the standard PCI resource (BAR) name according to their index.
+ */
+const char *pci_resource_name(struct pci_dev *dev, unsigned int i)
+{
+	static const char *bar_name[] = {
+		"BAR 0",
+		"BAR 1",
+		"BAR 2",
+		"BAR 3",
+		"BAR 4",
+		"BAR 5",
+		"ROM",
+#ifdef CONFIG_PCI_IOV
+		"VF BAR 0",
+		"VF BAR 1",
+		"VF BAR 2",
+		"VF BAR 3",
+		"VF BAR 4",
+		"VF BAR 5",
+#endif
+		"bridge window",	/* "io" included in %pR */
+		"bridge window",	/* "mem" included in %pR */
+		"bridge window",	/* "mem pref" included in %pR */
+	};
+	static const char *cardbus_name[] = {
+		"BAR 1",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+#ifdef CONFIG_PCI_IOV
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+#endif
+		"CardBus bridge window 0",	/* I/O */
+		"CardBus bridge window 1",	/* I/O */
+		"CardBus bridge window 0",	/* mem */
+		"CardBus bridge window 1",	/* mem */
+	};
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS &&
+	    i < ARRAY_SIZE(cardbus_name))
+		return cardbus_name[i];
+
+	if (i < ARRAY_SIZE(bar_name))
+		return bar_name[i];
+
+	return "unknown";
+}
+
 /**
  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
  * @dev: the PCI device to operate on
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..fb9c94a1c0b5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -255,6 +255,8 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 
+const char *pci_resource_name(struct pci_dev *dev, unsigned int i);
+
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
-- 
2.34.1


