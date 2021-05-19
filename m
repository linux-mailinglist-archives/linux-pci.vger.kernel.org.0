Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215ED389A20
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 01:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhESX4B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 19:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhESX4B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 19:56:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046FEC061574;
        Wed, 19 May 2021 16:54:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 10so11052294pfl.1;
        Wed, 19 May 2021 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saGJ8MOGoMsUyv5kls1YdVGYFyRu0m+lWIn5KG+KbKE=;
        b=AuJP2W4sui0Jz23E73840AgKtN5T4+Ui1HltUsoW6gcogkb5i4/wgaiHvFNu19xHzg
         +KgRxMPWNUUYuAndR8X4SGFjPiwWUuMcvZaI61aQnjb3FU5WbqavR/N2hmF/Ao8nO+oW
         XkUi4Cik7zckY+9XizE6WCLhvvhnQLd4ID1rBz/VuSsnVndH37VBcFF7tFWVno+Tyu64
         zNYnulegzNkTk30DGC1Ca+4iui/Gyo+pbDTz5rBhzPKZ9rjNmDdQDPavpmN13Y+ILu3z
         1Bn5FEbKl0zQCPCFnI3HOEczQbTrlQYiZbWp4RaKS/t+9fnJ9AOmPfEKCLkN3GBhuC3x
         pLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saGJ8MOGoMsUyv5kls1YdVGYFyRu0m+lWIn5KG+KbKE=;
        b=tfbUeK6kuFGO/vv+3Pnr7E9iAgBU0Ixys5gfmg9or+qoakwYIB1/Nq0zwWTW045IhQ
         6/Xkwdb7VHWySk3S6RwtkXWN7liiAA65xsOauF/uJ4bG8nNUbl0JE09bEqoRgJv8j1WE
         ULLkO+bYJpRPEEsh5s4+Kgw9KOsEvnNdkX1lQUv8Mzg9s63PSCJNnf2h7w54amCd+/8V
         9b4UUyHmBzo7XI6Wfpf1OtzydIC/8HCtIc30BIIloM7NpEa/qubJD1NfY/5fgny/73eZ
         eEC8v69cNAhe/B/NDmujKUl6mEn2MQKiG40BrV4KuN6hw925+Lw467exS422t89vfLSm
         Cl+A==
X-Gm-Message-State: AOAM530L4QONb66dFeCYpJCoex2l7xv6w9ZSWae6qeKL88GYujUiqNMH
        Tr7UVldOD5lxBhZdBSCF/0U=
X-Google-Smtp-Source: ABdhPJxXfQSxitBWipKKPmKnPeu94pbmbr+c/34GKq1ITLPe4jMUtzYHuy2lCcaUrX7xWD8UX6Cmsw==
X-Received: by 2002:a65:53c8:: with SMTP id z8mr1692570pgr.192.1621468480580;
        Wed, 19 May 2021 16:54:40 -0700 (PDT)
Received: from localhost.localdomain ([94.140.8.39])
        by smtp.googlemail.com with ESMTPSA id z12sm397670pfk.45.2021.05.19.16.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:54:40 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH RESEND v2 1/7] PCI: merge slot and bus reset implementations
Date:   Thu, 20 May 2021 05:24:20 +0530
Message-Id: <20210519235426.99728-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519235426.99728-1-ameynarkhede03@gmail.com>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
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

