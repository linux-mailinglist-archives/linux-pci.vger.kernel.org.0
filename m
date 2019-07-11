Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA898661A8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfGKW0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37777 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfGKW0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:19 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so16168311iog.4;
        Thu, 11 Jul 2019 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6C8gOL/gtuVuIQHsRRX9/x6z/r3bgy+YX1I9PN/BOZU=;
        b=GuF+xPzq4LSpuE2uxDHIOBij3fhmGP9ykR+0TcJhLmXX+KMkco3hoBkcGRi0gEVzy9
         ttkal8e2g3EFZGk9goaLOsJE1X+RQdtSnUwzlHSsL+W8sbgBOprbQ6E97yUodnosLEHr
         tNsEJ+l1Q5Fu8Jy3NKIjXhF71gtrtjSLWF+vSEQXtQVuqPvZ1ofnoK5QOnb/DBPFD/sk
         6lOVyWjusnu7P4eGzsnUNTor7NKAQDtEV3eJ1Tpn6VBFzf9Zvu3k0fe6JPdSZ0q/Ak9+
         Yc02ex4cwvoGhuh8rudmo5KV2YaA59srvHcGGP9BOUYPjObod5Y54ei9PnAdYrwTcfiT
         9zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6C8gOL/gtuVuIQHsRRX9/x6z/r3bgy+YX1I9PN/BOZU=;
        b=ul0/qEYja9tEXUyhIHuTtDjCxkwmVwiqrYSDPNUFPc43Zjp0/L+4ev0tLmR6BNGbkF
         b+mMnbP99I6kQJQZyi8zR81rEhNcH1uWNPurYtXboITxDLFEz4QjS2ihEjqIVAylXWMa
         kYknIc7orOzDNarEX7aufdyr8tGFegOlWNXdLeSO+wrH8uO8BMSUVFuc90bmTzRw7XPE
         nHAtfpOhcWsbgQk4sdNDYOHQKVqX+A7kqlHcocSXUDP+SBSWudKyEvFvRLtXWRf3NgBu
         LvFNfDDk0iekHDDgix2/4djJqfzZ7u4b8kd0ZAWjwgujoHDoSN6d6TUNMwh28gkbqmE6
         0WuA==
X-Gm-Message-State: APjAAAWJR7Lxb8DNSOViaw1pRlfzWN9k35BhR6u9/nTNfuBJG71ZMW73
        4ig5H8L4leW073pgT3eF85vxZy3dItQc0g==
X-Google-Smtp-Source: APXvYqwwpXtbyuHvI2vT6Wh2p81PzzOTHXLApB03nwZ1VuJmzZlUiQjwOPovu2mv7VlJVikr1WXw1g==
X-Received: by 2002:a02:37d6:: with SMTP id r205mr7272845jar.57.1562883977615;
        Thu, 11 Jul 2019 15:26:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:16 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 05/11] PCI: Move pci_hotplug_*_size declarations to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:35 -0600
Message-Id: <20190711222341.111556-6-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_hotplug_*_size declarations are only called within drivers/pci/pci/.
Since declarations do not need to be seen by the rest of the kernel, move
to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 3 +++
 include/linux/pci.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6ba790a77be4..ee7b7383e497 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -206,6 +206,9 @@ extern const struct attribute_group *pcibus_groups[];
 extern const struct device_type pci_dev_type;
 extern const struct attribute_group *pci_bus_groups[];
 
+extern unsigned long pci_hotplug_io_size;
+extern unsigned long pci_hotplug_mem_size;
+extern unsigned long pci_hotplug_bus_size;
 
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c5609b5782e..ead399b8d136 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1957,10 +1957,6 @@ extern unsigned long pci_cardbus_mem_size;
 extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
-extern unsigned long pci_hotplug_io_size;
-extern unsigned long pci_hotplug_mem_size;
-extern unsigned long pci_hotplug_bus_size;
-
 /* Architecture-specific versions may override these (weak) */
 void pcibios_disable_device(struct pci_dev *dev);
 void pcibios_set_master(struct pci_dev *dev);
-- 
2.20.1

