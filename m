Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1A393691
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhE0Trg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 15:47:36 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39758 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhE0Trd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 15:47:33 -0400
Received: by mail-ot1-f45.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so1325313otc.6;
        Thu, 27 May 2021 12:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymrb9ey0Xq/bAo/fEanTrmIhj8wD4Qny297we0IGR+o=;
        b=dc8ibMbJwNkiRj0CPbUNvuLH5I2khZUGb2VXMSOVlijYN4yVwzcVxs2PliL0aByEPR
         YJLE08snnArf6qXLeKRkR7Ll//lkOt8bdBhAx++3L7AFPI+7M+yUY1ndNXqZz+ehxfXF
         6A2Ou5GPkJhwkhvTgNMhjI7boey5BYcOUfYjuv81CteCH1y3VbAne6+Fo3zymAWEvTrX
         XSgm5pQgFyWvtfIPnY2FPFgmZqFOn3Yi9ZQRFH9Uk5NooN31QDQFZZOCQqdJLKw7uDEw
         MMedoM8RxABrqAGItyuUv1GWp8JnzPgmkwdC12+9ofnnkE5nUXylTodbXgCrdnc/jnoo
         z95Q==
X-Gm-Message-State: AOAM531S+admJZOxcSoFe2bCEHNdf1LKH5mAYO4IJ6anUFJxDhi16E7r
        MlJ6QQZe/MMucuRzmIhUpzu1Y5mDvg==
X-Google-Smtp-Source: ABdhPJw4oeb+tN2H6lYx9/h31oeKD5pF9Jfu3cVA44eH0KolP67ge4kWoHArhWwmYTk9lwET2Fqx8g==
X-Received: by 2002:a9d:4b9c:: with SMTP id k28mr4269155otf.183.1622144757056;
        Thu, 27 May 2021 12:45:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m74sm665162oig.33.2021.05.27.12.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:45:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 3/4] of: address: Use IS_ENABLED() for !CONFIG_PCI
Date:   Thu, 27 May 2021 14:45:46 -0500
Message-Id: <20210527194547.1287934-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527194547.1287934-1-robh@kernel.org>
References: <20210527194547.1287934-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert address.c to use IS_ENABLED() instead of ifdefs for the
public PCI functions. This simplifies the ifdefs in of_address.h.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       |  8 +++++++-
 include/linux/of_address.h | 39 ++++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index aa766437995c..e643f999743a 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -198,6 +198,7 @@ static int of_bus_pci_translate(__be32 *addr, u64 offset, int na)
 {
 	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
+#endif /* CONFIG_PCI */
 
 int of_pci_address_to_resource(struct device_node *dev, int bar,
 			       struct resource *r)
@@ -206,6 +207,9 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 	u64		size;
 	unsigned int	flags;
 
+	if (!IS_ENABLED(CONFIG_PCI))
+		return -ENOSYS;
+
 	addrp = of_get_pci_address(dev, bar, &size, &flags);
 	if (addrp == NULL)
 		return -EINVAL;
@@ -236,6 +240,9 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 	res->parent = res->child = res->sibling = NULL;
 	res->name = np->full_name;
 
+	if (!IS_ENABLED(CONFIG_PCI))
+		return -ENOSYS;
+
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long port;
 		err = pci_register_io_range(&np->fwnode, range->cpu_addr,
@@ -266,7 +273,6 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 	return err;
 }
 EXPORT_SYMBOL(of_pci_range_to_resource);
-#endif /* CONFIG_PCI */
 
 /*
  * ISA bus specific translator
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index b72807faf037..45598dbec269 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -61,6 +61,11 @@ extern int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range);
+extern int of_pci_address_to_resource(struct device_node *dev, int bar,
+				      struct resource *r);
+extern int of_pci_range_to_resource(struct of_pci_range *range,
+				    struct device_node *np,
+				    struct resource *res);
 extern bool of_dma_is_coherent(struct device_node *np);
 #else /* CONFIG_OF_ADDRESS */
 static inline void __iomem *of_io_request_and_map(struct device_node *device,
@@ -100,6 +105,19 @@ static inline struct of_pci_range *of_pci_range_parser_one(
 	return NULL;
 }
 
+static inline int of_pci_address_to_resource(struct device_node *dev, int bar,
+				             struct resource *r)
+{
+	return -ENOSYS;
+}
+
+static inline int of_pci_range_to_resource(struct of_pci_range *range,
+					   struct device_node *np,
+					   struct resource *res)
+{
+	return -ENOSYS;
+}
+
 static inline bool of_dma_is_coherent(struct device_node *np)
 {
 	return false;
@@ -124,27 +142,6 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
 #endif
 #define of_range_parser_init of_pci_range_parser_init
 
-#if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
-extern int of_pci_address_to_resource(struct device_node *dev, int bar,
-				      struct resource *r);
-extern int of_pci_range_to_resource(struct of_pci_range *range,
-				    struct device_node *np,
-				    struct resource *res);
-#else /* CONFIG_OF_ADDRESS && CONFIG_PCI */
-static inline int of_pci_address_to_resource(struct device_node *dev, int bar,
-				             struct resource *r)
-{
-	return -ENOSYS;
-}
-
-static inline int of_pci_range_to_resource(struct of_pci_range *range,
-					   struct device_node *np,
-					   struct resource *res)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_OF_ADDRESS && CONFIG_PCI */
-
 static inline const __be32 *of_get_address(struct device_node *dev, int index,
 					   u64 *size, unsigned int *flags)
 {
-- 
2.27.0

