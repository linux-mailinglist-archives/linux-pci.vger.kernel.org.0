Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B091F6619F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfGKW0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35573 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfGKW01 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:27 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so16213972ioo.2;
        Thu, 11 Jul 2019 15:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DSl25R/ZCYqKafBqZ5mvbsP/zVmzOF+Tc2j+UihA1o=;
        b=POPW8k6csdMUuVmbWRit+VbrORLtWfDUBb3L/0NWXiay7PhXag0K3CkIXDrrQX7OkA
         apze0LwAAhm8ow2TTl3gpC5jR4MrKO6cq2MFbQmyhp1AAfrwxiXkVGQV3UZ+MH2nJPcb
         OfnjluoM55/X5F/1fl5xEE3HWEuWgdFBwRo8EmyucO6LtO7CGE3/hbws3Af5DnpPazpY
         ULgZq6t21EIlWG9gMrMVFg+38EaeYYg+vy0nFEXhixm5mESRUK55h4mqoAzAU+XraIQd
         uyZlgk9ZTmy0tNzRI/Pz1cWQ5ma4XKN/c8qiUEwhZWy5Hr6fHTDPh81Ng/FYQimKrIbb
         lqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DSl25R/ZCYqKafBqZ5mvbsP/zVmzOF+Tc2j+UihA1o=;
        b=nBosEHkDiz2QPxBbr3UDs31lvU8q+1EGIi//3bhaCA2CZDUBrvtLKWNkYPe/mt6anY
         cljh0GXTZ9c448ZzH00s4FfXzX+Ka+pb6zzfawimJ/rEF5ViwQPB0dkxot5ABeHDr/rJ
         bLJ286ExsO3+sWg4zQX3HWUqMXVAxC8rEPT20i+ypSjiEkKtHzb1JgtkHkG5slYfQc8z
         V7RlMf0nVt3OZ/putwOYEY7iy1a//xH3tv+2GKt8g/DcgZzmjRJel/Xtq1aCFTkRMlWC
         4IhNpap2jjQCtwG2oj9k0cAVslkITlgn75JoKN0MIIIz2fDhagaq6L91JnBP//opy/ui
         IvWg==
X-Gm-Message-State: APjAAAXnbMW4mRE0FZupBIGmyMHQWVU1Nt8TGd+Pp58twTFvtSFfDzHa
        XU+gRsL1huCQN+5ISOBXk0L0PyVk/FQCNA==
X-Google-Smtp-Source: APXvYqzaWkAsYLQgjdnEmj1l/5YVqCelq2Oy6oEsw76XTDvCCa1hFWtmV0LG6HXf5yvSy8O9Sj6DOA==
X-Received: by 2002:a02:a90a:: with SMTP id n10mr7208197jam.61.1562883986618;
        Thu, 11 Jul 2019 15:26:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:25 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 11/11] PCI: Move pci_*_node() declarations to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:41 -0600
Message-Id: <20190711222341.111556-12-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
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
 drivers/pci/pci.h   | 8 ++++++++
 include/linux/pci.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 95bca00ea85a..a8d04dac3430 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -588,6 +588,10 @@ struct device_node;
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
+void pci_set_of_node(struct pci_dev *dev);
+void pci_release_of_node(struct pci_dev *dev);
+void pci_set_bus_of_node(struct pci_bus *bus);
+void pci_release_bus_of_node(struct pci_bus *bus);
 
 #else
 static inline int
@@ -607,6 +611,10 @@ of_pci_get_max_link_speed(struct device_node *node)
 {
 	return -EINVAL;
 }
+static inline void pci_set_of_node(struct pci_dev *dev) { }
+static inline void pci_release_of_node(struct pci_dev *dev) { }
+static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
+static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
 #endif /* CONFIG_OF */
 
 #if defined(CONFIG_OF_ADDRESS)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ea4dfb6b6693..cf380544c700 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2206,10 +2206,6 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
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
@@ -2219,10 +2215,6 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
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

