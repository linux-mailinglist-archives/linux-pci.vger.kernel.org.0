Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3148A74241
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfGXXjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36553 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388748AbfGXXjg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:36 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so93396958iom.3;
        Wed, 24 Jul 2019 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+nfQZ2UdcSDgJjCDwmD/o1yYou6zHrnlrDckfQLhv48=;
        b=CZB+qQZ+IiCjqbrl3pG1VgfoIKlT1esq374rHCiwoSTr+htDGMMdB25C4Kju1ptnOv
         Sr0vWDqL1QJ8UxaHm3MSMXR8LZpxI8sSOFGwYpaXvbXoOaNpfJfY+8QnxMoy0sD4c5/G
         7qLcwiTTCg8VwoMBVrIn2Jjo3NIsaxQZU8ASK/EaGVoGZtibG80it6wU6C6lktP9f5Wt
         sSCIM70yBh8fL8rsrpffoHwj93kjzxv/1zN/Cv647ellh7AJiCG/dPXcCrWpJSP8U2lB
         tHP4E6gWavTvF+TOL0eTMooXt7XVQ3+ITlWaQuZTNGAIlCyXmIDsZO5E36ET0q1faLPK
         qv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+nfQZ2UdcSDgJjCDwmD/o1yYou6zHrnlrDckfQLhv48=;
        b=e58DkMqClxTc58FKiC/JFu66D9+cu1JIlmjyhUx7aVSQkUjUzx67el+kxWbQkVBQIC
         9dk3PMHKCNh70H1O6HutfvEddBbxaoY9tODg0+jnJR7/eswAmFsnGY6sj7IooZITmlJb
         jhit1cc/nHkRWA8AA/vCp8twUEvJcv0WjbDvjJmf6Ux3ZJ+yQJsZCSJyc15M4vbRsCVl
         OmiFC3nMBhoAxj3x8b+9hzsEKurUH8O7p+IR0XOFVh11iUu4ycxHgsdDY1/UXRy1XNWw
         rZAOyvbcOlCk3c4RwUiz1dtEAziYvgQDuOqlYBeJ514NrGkrm5lem5GyHawndpI48gvY
         fbAg==
X-Gm-Message-State: APjAAAXNl8uQVG3bnhjntXOZv8PDKNd64pv7MoeTrtbb1ZKUTJgynSIT
        s/dl7QhvLjrifNap4V+MMhU=
X-Google-Smtp-Source: APXvYqwz03eSee7Y8W5j7Athc2oOY1acyYH6BBqvdR5E7s99JkIF/tHtBs+1nL70YWEqwyLZFCaI/Q==
X-Received: by 2002:a6b:2cc7:: with SMTP id s190mr80038806ios.164.1564011576172;
        Wed, 24 Jul 2019 16:39:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:35 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 11/11] PCI: Move pci_*_node() declarations to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:48 -0600
Message-Id: <20190724233848.73327-12-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_*_node() is only called from drivers/pci/. Since these declarations do
not need to be visible to the rest of the kernel, move to
drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 9 +++++++++
 include/linux/pci.h | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6cdc3500de15..27089a87dfea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -592,6 +592,10 @@ struct device_node;
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
+void pci_set_of_node(struct pci_dev *dev);
+void pci_release_of_node(struct pci_dev *dev);
+void pci_set_bus_of_node(struct pci_bus *bus);
+void pci_release_bus_of_node(struct pci_bus *bus);
 
 #else
 static inline int
@@ -611,6 +615,11 @@ of_pci_get_max_link_speed(struct device_node *node)
 {
 	return -EINVAL;
 }
+
+static inline void pci_set_of_node(struct pci_dev *dev) { }
+static inline void pci_release_of_node(struct pci_dev *dev) { }
+static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
+static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
 #endif /* CONFIG_OF */
 
 #if defined(CONFIG_OF_ADDRESS)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a483b7598059..d354fbcee5a7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2264,10 +2264,6 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 #ifdef CONFIG_OF
 struct device_node;
 struct irq_domain;
-void pci_set_of_node(struct pci_dev *dev);
-void pci_release_of_node(struct pci_dev *dev);
-void pci_set_bus_of_node(struct pci_bus *bus);
-void pci_release_bus_of_node(struct pci_bus *bus);
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
 int pci_parse_request_of_pci_ranges(struct device *dev,
 				    struct list_head *resources,
@@ -2277,10 +2273,6 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
 
 #else	/* CONFIG_OF */
-static inline void pci_set_of_node(struct pci_dev *dev) { }
-static inline void pci_release_of_node(struct pci_dev *dev) { }
-static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
-static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
 static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline int pci_parse_request_of_pci_ranges(struct device *dev,
-- 
2.20.1

