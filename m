Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFBBFC54
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfI0AZf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:25:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43244 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbfI0AZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so3722739oih.10;
        Thu, 26 Sep 2019 17:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKCh970cxpKTSE4xQt8EA5TvLAg6lDEOHEZjgVQOiEg=;
        b=m5XwqiFEPWtXzRHdhcmEuQygNUQouhsLrY2JHWTLwtqq5PoobZbYBbU+pvp6Pv86T4
         zKFmmaHDMIJdNrKNWILK2YLfjpagh6NpNpKk+geYxGfbyntI5DJ3lR57bAmQggJWaFNe
         fikGPltp5EMOy7riafYjMByhlXTfAqVaLKhMym5d84S2/CTBFDHvnVzTUjF4tG0SCMfO
         bTz5A6xsOi8EoYWqLJbOk/B47XR0KubRoCjwJfZtGVsznsBUcqtzuj/8q5H2DSvkcRsy
         zh9JTBZSoP8alAq8/dVcF6FumlTwfBSMsXi2SX9PLhowuI945KqN6mRMPxN629ktANF7
         wJrg==
X-Gm-Message-State: APjAAAW5ClND+nq5icmAYJQmaMe0cnWvML1G/wTJEQ1TferFYIMleKJp
        wvDrmcy+vbmlie1Iy0Z+i7RI+6w=
X-Google-Smtp-Source: APXvYqy1CQ/pJ4u81ZjOTBygjp0HyvnzRjfsumqlZMQhMMHtdm91xx5NicQ33wJ1JMQxCbhI++4dWg==
X-Received: by 2002:a05:6808:316:: with SMTP id i22mr4935938oie.18.1569543908911;
        Thu, 26 Sep 2019 17:25:08 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:25:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH 08/11] of: Factor out #{addr,size}-cells parsing
Date:   Thu, 26 Sep 2019 19:24:52 -0500
Message-Id: <20190927002455.13169-9-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

In some cases such as PCI host controllers, we may have a "parent bus"
which is an OF leaf node, but still need to correctly parse ranges from
the point of view of that bus. For that, factor out variants of the
"#addr-cells" and "#size-cells" parsers which do not assume they have a
device node and thus immediately traverse upwards before reading the
relevant property.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[robh: don't make of_bus_n_{addr,size}_cells() public]
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c    |  2 ++
 drivers/of/base.c       | 32 ++++++++++++++++++++++----------
 drivers/of/of_private.h |  3 +++
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 3fd34f7ad772..887c0413f648 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -14,6 +14,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include "of_private.h"
+
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
 #define OF_CHECK_ADDR_COUNT(na)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS)
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 55e7f5bb0549..12b2e9287117 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -86,34 +86,46 @@ static bool __of_node_is_type(const struct device_node *np, const char *type)
 	return np && match && type && !strcmp(match, type);
 }
 
-int of_n_addr_cells(struct device_node *np)
+int of_bus_n_addr_cells(struct device_node *np)
 {
 	u32 cells;
 
-	do {
-		if (np->parent)
-			np = np->parent;
+	for (; np; np = np->parent)
 		if (!of_property_read_u32(np, "#address-cells", &cells))
 			return cells;
-	} while (np->parent);
+
 	/* No #address-cells property for the root node */
 	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
 }
+
+int of_n_addr_cells(struct device_node *np)
+{
+	if (np->parent)
+		np = np->parent;
+
+	return of_bus_n_addr_cells(np);
+}
 EXPORT_SYMBOL(of_n_addr_cells);
 
-int of_n_size_cells(struct device_node *np)
+int of_bus_n_size_cells(struct device_node *np)
 {
 	u32 cells;
 
-	do {
-		if (np->parent)
-			np = np->parent;
+	for (; np; np = np->parent)
 		if (!of_property_read_u32(np, "#size-cells", &cells))
 			return cells;
-	} while (np->parent);
+
 	/* No #size-cells property for the root node */
 	return OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
 }
+
+int of_n_size_cells(struct device_node *np)
+{
+	if (np->parent)
+		np = np->parent;
+
+	return of_bus_n_size_cells(np);
+}
 EXPORT_SYMBOL(of_n_size_cells);
 
 #ifdef CONFIG_NUMA
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f8c58615c393..66294d29942a 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -158,6 +158,9 @@ extern void __of_sysfs_remove_bin_file(struct device_node *np,
 #define for_each_transaction_entry_reverse(_oft, _te) \
 	list_for_each_entry_reverse(_te, &(_oft)->te_list, node)
 
+extern int of_bus_n_addr_cells(struct device_node *np);
+extern int of_bus_n_size_cells(struct device_node *np);
+
 #ifdef CONFIG_OF_ADDRESS
 extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 			    u64 *paddr, u64 *size);
-- 
2.20.1

