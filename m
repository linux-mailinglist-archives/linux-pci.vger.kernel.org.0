Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1335A70B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 21:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhDITZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 15:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbhDITZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 15:25:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AACDC061763;
        Fri,  9 Apr 2021 12:24:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s7so6541671wru.6;
        Fri, 09 Apr 2021 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saGJ8MOGoMsUyv5kls1YdVGYFyRu0m+lWIn5KG+KbKE=;
        b=Bf3qXx8McRkiJzeQlYuOimN5oXnsdZnkSA5dPptUOe+H5ck09dUofAMZGLH+yeSf5H
         BxPJFnQp8A4CQvUARQG/YsgWISZgzTtl7TXrvLMb2EpiqF9sPPH712qZxpE6A7prtybs
         SyxqRv5JwCLC5E6SCFatnrvTuULQLxyJtpgMlpTI70LmA7hOHysVwBZABRCmb6bGnzh4
         1ZtQH+jluZ4o/BhluN4/jtPaTYvDKHrl3lqohyb2bT0NZKMyzCTC2spZ3jdUURDwvgmz
         iraknqVec+VWGQa3WDTcW6GJb43zOG/tUGr5pDTsSyFWkclWqgGX0b0NBjkjzSHKCI5l
         Gb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saGJ8MOGoMsUyv5kls1YdVGYFyRu0m+lWIn5KG+KbKE=;
        b=GOC1vW2qlzaXbx9jYIUJgzJeBYhgvfhSeXJVRVuuZNzkf+Sxlcbnf7Kn5DAbUX7+9L
         4u/b8e1isxf4zOiXALM8WL0MXqtn5izKgNOAW8upB0zyeWgbPLCGZUW7u+f6tYJKLZ4B
         2nyVKbiCVNp1lWUdBHNmBmamN3YxuIu1UKZ4bAPQchnduzPI7F7wFa8Zdj0WtXO1bob8
         /5fTAxCcIVOSNnqvNyt9v0MIP6mLIbhrZRknh8jNWW8uHkbXo8J5iS23E9uy2WCCc607
         WCA6bvtIAZz6eVH+TdQqj/KXoJq/T56fGkVR9BR0a7N7uEGY/6cy9PThI1KfxT4klEH+
         PPPA==
X-Gm-Message-State: AOAM531Z0zmGsMJOx/FfIZ+Ea3gFsThoGbHJlVG1ZH/lAO6c5Tyf+HcA
        7sv8TM9E8I5U9HXj+TLvkkI=
X-Google-Smtp-Source: ABdhPJwSayyyxESgwpcEKZg78pOTgXetdGmwYeTMPx48o3h1qNuAc9AeFQKUiw0eSofr9U/+O6cUMg==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr4215921wrv.41.1617996296458;
        Fri, 09 Apr 2021 12:24:56 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.176])
        by smtp.googlemail.com with ESMTPSA id j6sm6618573wru.18.2021.04.09.12.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:24:56 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2 1/5] PCI: merge slot and bus reset implementations
Date:   Sat, 10 Apr 2021 00:53:20 +0530
Message-Id: <20210409192324.30080-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210409192324.30080-1-ameynarkhede03@gmail.com>
References: <20210409192324.30080-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

Slot resets are bus resets with additional logic to prevent a device
from being removed during the reset. Currently slot and bus resets have
separate implementations in pci.c, complicating higher level logic. As
discussed on the mailing list, they should be combined into a generic
function which performs an SBR. This change adds a function,
pci_reset_bus_function(), which first attempts a slot reset and then
attempts a bus reset if -ENOTTY is returned, such that there is now a
single device agnostic function to perform an SBR.

This new function is also needed to add SBR reset quirks and therefore
is exposed in pci.h.

Link: https://lkml.org/lkml/2021/3/23/911

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 drivers/pci/pci.c   | 19 +++++++++++--------
 include/linux/pci.h |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f..a8f8dd588 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4982,6 +4982,15 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
+int pci_reset_bus_function(struct pci_dev *dev, int probe)
+{
+	int rc = pci_dev_reset_slot_function(dev, probe);
+
+	if (rc != -ENOTTY)
+		return rc;
+	return pci_parent_bus_reset(dev, probe);
+}
+
 static void pci_dev_lock(struct pci_dev *dev)
 {
 	pci_cfg_access_lock(dev);
@@ -5102,10 +5111,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	rc = pci_pm_reset(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
-	rc = pci_dev_reset_slot_function(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, 0);
+	return pci_reset_bus_function(dev, 0);
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
@@ -5135,13 +5141,10 @@ int pci_probe_reset_function(struct pci_dev *dev)
 	if (rc != -ENOTTY)
 		return rc;
 	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
 
-	return pci_parent_bus_reset(dev, 1);
+	return pci_reset_bus_function(dev, 1);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97..979d54335 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1228,6 +1228,7 @@ int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
+int pci_reset_bus_function(struct pci_dev *dev, int probe);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
-- 
2.31.1

