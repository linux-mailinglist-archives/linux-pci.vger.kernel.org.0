Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39592A7A60
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 06:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfIDEqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 00:46:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38368 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfIDEqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 00:46:39 -0400
Received: by mail-io1-f66.google.com with SMTP id p12so41323391iog.5;
        Tue, 03 Sep 2019 21:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iv0qLpuR7sLWwOR4i5Pjgd55i1xxcdakcMdY3Zu+Myg=;
        b=s5nPjsg7Z3oXHjd99cvFXQcA2JoqYRob7b6+TkOKdPkWoXkXEp0tAmvgfyND2sqPOg
         nJHYruAT7jjAGpMhw60qkQfiDvxYP9Ofr46OZy4v32PQAJtKLWy7PesRBaHCx/pG6HB4
         OivEUOzAdZGouKV2MhmbwRTTZymfb+6myyhHWR4rjX2Xqk+iL1LwuK1+C99OV7WgiKCs
         wri5M5a/fmXcYVhuAkU1C1G4OJ9uvuEcYpxhrkIec+DDXbRkZFYx46hN96ODKYYMsql6
         KmeyrYxDncoXFiDoxTBxth+dkrIOGU/VUjCistU2MO7CbJl+AzV9c24LXCQXy+qP+dmZ
         6ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iv0qLpuR7sLWwOR4i5Pjgd55i1xxcdakcMdY3Zu+Myg=;
        b=nNM+ctWmiCrst8ViCXs4ePp+HaS7Vtkt/Ub3RoVyFrA3glVjOZlccmpIZVF7yfOd92
         w77of5x8p6TINl5MT6GV4ieG7kpMNPopjHOZ18a6/oLYwqXGbbFgAzsZWVeVjIBRDHxR
         rwvAeVBiAFwERp3SW1FbillXGLmJAy74yb5rXPCWbw8qf8hHQm+bv+VEYJv7fgEa6BMn
         sJ1DRMz4H7mrjPAacGw+AmkeSUxn6TPykFJ+gHj9ON9JdKwZ/arudoaPyOCfD7rd7EiT
         CMAQGp5dQw9sX0sPSTmkUX7iyF/94pnervWgBxtNvuZVo4uQO7EkZIrqejY0R3JgHHlW
         ti5A==
X-Gm-Message-State: APjAAAXpzGQQG9IqnA3htJkNm61+HS+++v/tO3J08Kqr1VdoFIWHNU+s
        6bM3MVpzjz0ixS7OcirV/vDyrDo0MYU=
X-Google-Smtp-Source: APXvYqxys+cUKvwWqzLmuAoYeZPyTanlWNts40Uy6h0/VS05YBdQ0JWCAbphM7EhKTgO1byu8nsvvw==
X-Received: by 2002:a5d:81cc:: with SMTP id t12mr3110186iol.157.1567571993732;
        Tue, 03 Sep 2019 21:39:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s5sm16471411iol.88.2019.09.03.21.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:39:53 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Cc:     skhan@linuxfoundation.org, rafael.j.wysocki@intel.com,
        keith.busch@intel.com
Subject: [PATCH 2/2] PCI: Unify pci_dev_is_disconnected() and pci_dev_is_inaccessible()
Date:   Tue,  3 Sep 2019 22:36:35 -0600
Message-Id: <20190904043633.65026-3-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904043633.65026-1-skunberg.kelsey@gmail.com>
References: <20190904043633.65026-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Combine pci_dev_is_disconnected() with pci_dev_is_inaccessible() so only
one function is used to learn if we should avoid accessing a device that's
inaccessible due to surprise removal or an error condition.

The use cases for pci_dev_is_disconnected() do not need to distinguish
between a device being inaccessible due to a surprise removal or an error
condition. This provides the opportunity to unify
pci_dev_is_disconnected() and pci_dev_is_inaccessible() to reduce multiple
functions used for the same task.

Change pci_dev_is_disconnected() call inside pci_dev_is_inaccessible() to:

	pdev->error_state == pci_channel_io_perm_failure

Change remaining pci_dev_is_disconnected() calls to
pci_dev_is_inaccessible() calls.

Remove pci_dev_is_disconnected() from /pci/pci.h which would now no longer
be used.

Demonstration of changes to pci_dev_is_disconnected() and
pci_dev_is_inaccessible():

Before combining:

	static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
	{
		return dev->error_state == pci_channel_io_perm_failure;
	}

	bool pci_dev_is_inaccessible(struct pci_dev *pdev)
	{
		u32 v;

		if (pci_dev_is_disconnected(pdev))
			return true;
		return !pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
	}

After combining:

	bool pci_dev_is_inaccessible(struct pci_dev *pdev)
	{
		u32 v;

		if (pdev->error_state == pci_channel_io_perm_failure)
			return true;
		return !pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
	}

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/access.c            | 12 ++++++------
 drivers/pci/msi.c               |  4 ++--
 drivers/pci/pci.c               |  2 +-
 drivers/pci/pci.h               |  5 -----
 drivers/pci/pcie/portdrv_core.c |  2 +-
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 544922f097c0..c096340afb8c 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -535,7 +535,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
-	if (pci_dev_is_disconnected(dev)) {
+	if (pci_dev_is_inaccessible(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -545,7 +545,7 @@ EXPORT_SYMBOL(pci_read_config_byte);
 
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
-	if (pci_dev_is_disconnected(dev)) {
+	if (pci_dev_is_inaccessible(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -556,7 +556,7 @@ EXPORT_SYMBOL(pci_read_config_word);
 int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
-	if (pci_dev_is_disconnected(dev)) {
+	if (pci_dev_is_inaccessible(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -566,7 +566,7 @@ EXPORT_SYMBOL(pci_read_config_dword);
 
 int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
 {
-	if (pci_dev_is_disconnected(dev))
+	if (pci_dev_is_inaccessible(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
 }
@@ -574,7 +574,7 @@ EXPORT_SYMBOL(pci_write_config_byte);
 
 int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
 {
-	if (pci_dev_is_disconnected(dev))
+	if (pci_dev_is_inaccessible(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
 }
@@ -583,7 +583,7 @@ EXPORT_SYMBOL(pci_write_config_word);
 int pci_write_config_dword(const struct pci_dev *dev, int where,
 					 u32 val)
 {
-	if (pci_dev_is_disconnected(dev))
+	if (pci_dev_is_inaccessible(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
 }
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0884bedcfc7a..4680043aa315 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -311,7 +311,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
 
-	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
+	if (dev->current_state != PCI_D0 || pci_dev_is_inaccessible(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
@@ -1008,7 +1008,7 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
 
-	if (pci_dev_is_disconnected(dev)) {
+	if (pci_dev_is_inaccessible(dev)) {
 		dev->msix_enabled = 0;
 		return;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7b4e248db5f9..e5f46d98dbe1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5910,7 +5910,7 @@ bool pci_dev_is_inaccessible(struct pci_dev *pdev)
 {
 	u32 v;
 
-	if (pci_dev_is_disconnected(pdev))
+	if (pdev->error_state == pci_channel_io_perm_failure)
 		return true;
 	return !pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1be03a97cb92..f0dc86dc8aab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -363,11 +363,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	return 0;
 }
 
-static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
-{
-	return dev->error_state == pci_channel_io_perm_failure;
-}
-
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 308c3e0c4a34..8bf6b47dd2c6 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -416,7 +416,7 @@ static void wait_for_downstream_link(struct pci_dev *pdev)
 	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
 		return;
 
-	if (pci_dev_is_disconnected(pdev))
+	if (pci_dev_is_inaccessible(pdev))
 		return;
 
 	if (!pdev->subordinate || list_empty(&pdev->subordinate->devices) ||
-- 
2.20.1

