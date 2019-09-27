Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F20BFC60
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfI0AZC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:25:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36434 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfI0AZB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:01 -0400
Received: by mail-oi1-f193.google.com with SMTP id k20so3749633oih.3;
        Thu, 26 Sep 2019 17:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFnIODxLI07lEZcLoD/U0DfHP6ZA4NBNR5sSatiO5f0=;
        b=Tmp8sZoJpBkcnHybmmcyW9scGfrjYcXWPKB3fPk7Z1CEjJmIqYcSfkIsjsbi8XF242
         5+5D+I4vbRglrv6ibY+memPOOUuReLDH68qtGiqob8jld5UT6enlWGY7c8YSrBWs7JHh
         K2qd7x+E6n5pVBId6aLpjk1EAPbM0PPHgzxdRlh89WeQRP4Wym3avv77ZZwon0ZFZJiJ
         9ATxEUHxn1Slt0SG5xU0tV97eeyY1cuSyypQNqq7FTMqgB7cvS0myTWqCfU7SkLp/c/Y
         p2fyQ8FKB6nQzDbfMUxndD2+zTGoo++aK+RKnH4mLSkCnKnSZlNA520nc6IKhsYQMUc+
         dXcg==
X-Gm-Message-State: APjAAAU2mSG9Sg7lJ9s8NL6OxVH7j1f0dUuAC0kanzh2ydCARKMpAwFZ
        I7Ap0zcQjk/1VbfjyXpiYFgm9/w=
X-Google-Smtp-Source: APXvYqwWVfPVt77YLh4Gv2K4ppvWZ2WTrZfJ1ydtavZRgfmvlui1t3teRXd2GNnOw0HXgwd3DJ7LBA==
X-Received: by 2002:aca:3ed7:: with SMTP id l206mr4922395oia.25.1569543900588;
        Thu, 26 Sep 2019 17:25:00 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:24:59 -0700 (PDT)
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
Subject: [PATCH 02/11] of: Make of_dma_get_range() private
Date:   Thu, 26 Sep 2019 19:24:46 -0500
Message-Id: <20190927002455.13169-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_dma_get_range() is only used within the DT core code, so remove the
export and move the header declaration to the private header.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       |  1 -
 drivers/of/of_private.h    | 11 +++++++++++
 include/linux/of_address.h |  8 --------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 0c3cf515c510..8e354d12fb04 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -972,7 +972,6 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_dma_get_range);
 
 /**
  * of_dma_is_coherent - Check if device is coherent
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 24786818e32e..f8c58615c393 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -158,4 +158,15 @@ extern void __of_sysfs_remove_bin_file(struct device_node *np,
 #define for_each_transaction_entry_reverse(_oft, _te) \
 	list_for_each_entry_reverse(_te, &(_oft)->te_list, node)
 
+#ifdef CONFIG_OF_ADDRESS
+extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
+			    u64 *paddr, u64 *size);
+#else
+static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
+				   u64 *paddr, u64 *size)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index e317f375374a..ddda3936039c 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -51,8 +51,6 @@ extern int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range);
-extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-				u64 *paddr, u64 *size);
 extern bool of_dma_is_coherent(struct device_node *np);
 #else /* CONFIG_OF_ADDRESS */
 static inline void __iomem *of_io_request_and_map(struct device_node *device,
@@ -92,12 +90,6 @@ static inline struct of_pci_range *of_pci_range_parser_one(
 	return NULL;
 }
 
-static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-				u64 *paddr, u64 *size)
-{
-	return -ENODEV;
-}
-
 static inline bool of_dma_is_coherent(struct device_node *np)
 {
 	return false;
-- 
2.20.1

