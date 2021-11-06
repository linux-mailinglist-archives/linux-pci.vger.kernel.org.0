Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D43446D9C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 12:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhKFL3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFL3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 07:29:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82340C061570
        for <linux-pci@vger.kernel.org>; Sat,  6 Nov 2021 04:26:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id n85so6787719pfd.10
        for <linux-pci@vger.kernel.org>; Sat, 06 Nov 2021 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0npdG7kpsBIuyXnUFtec9A+3MP5lApVY+4YnlPHv18=;
        b=PimngPCAQa+O15HZN5AoGDnn0PKAWOjT9/d3VlwGahiHynZu5Pv7cP5aLawu8XQfPv
         yXDipATBNWb9agjyjSDAfmKdPUXhxB0pVMMf4KtrQSumd/xlqfcGJDKS4mKJnsBL2Cst
         0azQdbkkaQTuUNGc0Pb61lkeQjfUqJAjEshdxOUCEbPWgvDqe8cv4C48S1/qwJKLjC77
         VC305ki8sjQMYa7nKEB6vUhxbVT8F3H6eafTsNzRa4D4Njpi3iAvgfslZTfjFiWqbg9d
         wv1e4Z8AY3bbE7Z0iOL9R3kfpRpKhigU1+7PPfDCFbWBfse9H5zR8vG0QcWfzL17QdJz
         hEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0npdG7kpsBIuyXnUFtec9A+3MP5lApVY+4YnlPHv18=;
        b=khBjaw91hmKlxNpD/XxnJWeoHUjCZvSEf6WpAi/Vx28OUa0fhyU3wExycDr+1qrYHO
         Yw4URr/LQHlJ5n6THQTCUxskIYLaefqukKVkRbhBckxYP6NVIpLKrNHpqEAIuyOC9XzX
         Q6rbSTvXKv9/Mm/k4WwgNsEyDowB1bdyFOEJsMe2qijpFuo9qLUHdYw/DKZ6jqfr0KLT
         VhpZxFVGn5A57Z3mD21QTcDlo3svnEJNzseahZapT/NC65HO690P9XVVMDt5NCKmVKP8
         sPuhquvQuI/YOsqBkecac+zd2NHOnXE9bm1CvwOCvCJflMfN8Q0ybVOpvnEeQ5sa32Pa
         0vGA==
X-Gm-Message-State: AOAM532m5bORX+PNtMqNoFV5tI5mOjP2Crm9EvOuERzT/IMFlK755o3T
        SgJrU7tkDnon16cuA00c9TBA2CPkz8LFHQ==
X-Google-Smtp-Source: ABdhPJxJVSMBImKeY7lkbAV5x/LKWbKi7glK4AK+YvEHy9MbTHrDQ8bkDQhAJHVcxTVAF4XkEdYWhg==
X-Received: by 2002:a63:88c8:: with SMTP id l191mr37754521pgd.369.1636197985972;
        Sat, 06 Nov 2021 04:26:25 -0700 (PDT)
Received: from localhost.localdomain ([124.253.6.45])
        by smtp.googlemail.com with ESMTPSA id c21sm10971037pfl.15.2021.11.06.04.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 04:26:25 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 1/2] PCI: Update BAR # and window messages
Date:   Sat,  6 Nov 2021 16:56:05 +0530
Message-Id: <20211106112606.192563-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211106112606.192563-1-puranjay12@gmail.com>
References: <20211106112606.192563-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI logs messages print the register offsets at some places and
BAR numbers at other places. There is no uniformity in this logging
mechanism. It would be better to print names than register offsets.

Add a helper function that aids in printing more meaningful information
about the BAR numbers like "VF BAR", "ROM", "Bridge Window", etc.
This function can be called while printing PCI log messages.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/pci/pci.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..1c2dfb2b9754 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -800,6 +800,53 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
 }
 EXPORT_SYMBOL(pci_find_resource);
 
+/**
+ * pci_resource_name - Return the name of the PCI resource.
+ * @dev: PCI device to query
+ * @i: index of the resource
+ *
+ * Returns the standard PCI resource(BAR) names according to their index.
+ */
+const char *pci_resource_name(struct pci_dev *dev, int i)
+{
+	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+		switch (i) {
+		case 0: return "BAR 0";
+		case 1: return "BAR 1";
+		case 2: return "BAR 2";
+		case 3: return "BAR 3";
+		case 4: return "BAR 4";
+		case 5: return "BAR 5";
+		case PCI_ROM_RESOURCE: return "ROM";
+		#ifdef CONFIG_PCI_IOV
+		case PCI_IOV_RESOURCES + 0: return "VF BAR 0";
+		case PCI_IOV_RESOURCES + 1: return "VF BAR 1";
+		case PCI_IOV_RESOURCES + 2: return "VF BAR 2";
+		case PCI_IOV_RESOURCES + 3: return "VF BAR 3";
+		case PCI_IOV_RESOURCES + 4: return "VF BAR 4";
+		case PCI_IOV_RESOURCES + 5: return "VF BAR 5";
+		#endif
+		}
+	} else if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		switch (i) {
+		case 0: return "BAR 0";
+		case 1: return "BAR 1";
+		case PCI_BRIDGE_IO_WINDOW: return "bridge I/O window";
+		case PCI_BRIDGE_MEM_WINDOW: return "bridge mem window";
+		case PCI_BRIDGE_PREF_MEM_WINDOW: return "bridge mem pref window";
+		}
+	} else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
+		switch (i) {
+		case 0: return "BAR 0";
+		case PCI_CB_BRIDGE_IO_0_WINDOW: return "CardBus bridge I/O 0 window";
+		case PCI_CB_BRIDGE_IO_1_WINDOW: return "CardBus bridge I/O 1 window";
+		case PCI_CB_BRIDGE_MEM_0_WINDOW: return "CardBus bridge mem 0 window";
+		case PCI_CB_BRIDGE_MEM_1_WINDOW: return "CardBus bridge mem 1 window";
+		}
+	}
+	return "unknown";
+}
+
 /**
  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
  * @dev: the PCI device to operate on
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1cce56c2aea0..ee0738c7731a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -281,6 +281,8 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 
+const char *pci_resource_name(struct pci_dev *dev, int i);
+
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
-- 
2.30.1

