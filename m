Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1839368E
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 21:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhE0Trc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 15:47:32 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36858 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhE0Tra (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 15:47:30 -0400
Received: by mail-ot1-f54.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so1347853otl.3;
        Thu, 27 May 2021 12:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pi/H1lXjgfAQTnfvqaLMcay9EXPe4HtbT57LknC592A=;
        b=LOqQgyU+uLyzYhNxOUcw3+QZe23my2Jp0Pbu2dd96TcUNMpZH2UsfwHSclTQiNJ2Rv
         83V9Ic1h9h3Mi6XA1vEwBKVaKAnOBxYgCX6hYYY0no5EmTF5i7PFOFF8RH5kAdQqHKPl
         A7FuXWRnb9FykZS1Je6L8+HA5Q0j/0HjcjculxyjQrCezod6lIz/33JxK8OIq34rBmPg
         4sLxOalzBIqMiOCWDgc2HbVZv0qGypSuP6wWea+kZ8x74leZCfu3jkXK1GgFh67sweF1
         jtIgcm5gXSTlVsNh7u08NV2L2rNxJPJ/7VOa+VSenQSW9/dKFqQnvrTQLYpjwaZoyGD3
         zX4Q==
X-Gm-Message-State: AOAM531FtpfTs+riQOMImwaCKELO9omUyJNXLdwRIszVv+eA1M8Dm0Xz
        z2s/eINDkJX0AiryzpkAR14WP3NdLQ==
X-Google-Smtp-Source: ABdhPJz8d7lXTCrm2c6ZH6WV0tiVxOdbyZOY3H5VzgeePbJTR9Xe6fIUxTihiQ/NFNlp5svXmJjaUA==
X-Received: by 2002:a05:6830:1256:: with SMTP id s22mr3918924otp.333.1622144754150;
        Thu, 27 May 2021 12:45:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m74sm665162oig.33.2021.05.27.12.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:45:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/4] of: Merge of_get_address() and of_get_pci_address() implementations
Date:   Thu, 27 May 2021 14:45:45 -0500
Message-Id: <20210527194547.1287934-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527194547.1287934-1-robh@kernel.org>
References: <20210527194547.1287934-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_get_address() and of_get_pci_address() are the same implementation
except of_get_pci_address() takes the PCI BAR number rather than an
index. Modify the of_get_address() implementation to work on either
index or BAR and provide wrapper functions for the existing functions.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       | 62 ++++++++------------------------------
 include/linux/of_address.h | 27 ++++++++++-------
 2 files changed, 29 insertions(+), 60 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index aca94c348bd4..aa766437995c 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -199,50 +199,6 @@ static int of_bus_pci_translate(__be32 *addr, u64 offset, int na)
 	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
 
-const __be32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
-			unsigned int *flags)
-{
-	const __be32 *prop;
-	unsigned int psize;
-	struct device_node *parent;
-	struct of_bus *bus;
-	int onesize, i, na, ns;
-
-	/* Get parent & match bus type */
-	parent = of_get_parent(dev);
-	if (parent == NULL)
-		return NULL;
-	bus = of_match_bus(parent);
-	if (strcmp(bus->name, "pci")) {
-		of_node_put(parent);
-		return NULL;
-	}
-	bus->count_cells(dev, &na, &ns);
-	of_node_put(parent);
-	if (!OF_CHECK_ADDR_COUNT(na))
-		return NULL;
-
-	/* Get "reg" or "assigned-addresses" property */
-	prop = of_get_property(dev, bus->addresses, &psize);
-	if (prop == NULL)
-		return NULL;
-	psize /= 4;
-
-	onesize = na + ns;
-	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++) {
-		u32 val = be32_to_cpu(prop[0]);
-		if ((val & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
-			if (size)
-				*size = of_read_number(prop + na, ns);
-			if (flags)
-				*flags = bus->get_flags(prop);
-			return prop;
-		}
-	}
-	return NULL;
-}
-EXPORT_SYMBOL(of_get_pci_address);
-
 int of_pci_address_to_resource(struct device_node *dev, int bar,
 			       struct resource *r)
 {
@@ -675,8 +631,8 @@ u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 }
 EXPORT_SYMBOL(of_translate_dma_address);
 
-const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
-		    unsigned int *flags)
+const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
+			       u64 *size, unsigned int *flags)
 {
 	const __be32 *prop;
 	unsigned int psize;
@@ -689,6 +645,10 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
 	if (parent == NULL)
 		return NULL;
 	bus = of_match_bus(parent);
+	if (strcmp(bus->name, "pci") && (bar_no >= 0)) {
+		of_node_put(parent);
+		return NULL;
+	}
 	bus->count_cells(dev, &na, &ns);
 	of_node_put(parent);
 	if (!OF_CHECK_ADDR_COUNT(na))
@@ -701,17 +661,21 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
 	psize /= 4;
 
 	onesize = na + ns;
-	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
-		if (i == index) {
+	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++) {
+		u32 val = be32_to_cpu(prop[0]);
+		/* PCI bus matches on BAR number instead of index */
+		if (((bar_no >= 0) && ((val & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0))) ||
+		    ((index >= 0) && (i == index))) {
 			if (size)
 				*size = of_read_number(prop + na, ns);
 			if (flags)
 				*flags = bus->get_flags(prop);
 			return prop;
 		}
+	}
 	return NULL;
 }
-EXPORT_SYMBOL(of_get_address);
+EXPORT_SYMBOL(__of_get_address);
 
 static int parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node, const char *name)
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 88bc943405cd..b72807faf037 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -51,8 +51,8 @@ void __iomem *of_io_request_and_map(struct device_node *device,
  * the address space flags too. The PCI version uses a BAR number
  * instead of an absolute index
  */
-extern const __be32 *of_get_address(struct device_node *dev, int index,
-			   u64 *size, unsigned int *flags);
+extern const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
+				      u64 *size, unsigned int *flags);
 
 extern int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node);
@@ -75,8 +75,8 @@ static inline u64 of_translate_address(struct device_node *np,
 	return OF_BAD_ADDR;
 }
 
-static inline const __be32 *of_get_address(struct device_node *dev, int index,
-					u64 *size, unsigned int *flags)
+static inline const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
+					     u64 *size, unsigned int *flags)
 {
 	return NULL;
 }
@@ -125,8 +125,6 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
 #define of_range_parser_init of_pci_range_parser_init
 
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
-extern const __be32 *of_get_pci_address(struct device_node *dev, int bar_no,
-			       u64 *size, unsigned int *flags);
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
 extern int of_pci_range_to_resource(struct of_pci_range *range,
@@ -139,11 +137,6 @@ static inline int of_pci_address_to_resource(struct device_node *dev, int bar,
 	return -ENOSYS;
 }
 
-static inline const __be32 *of_get_pci_address(struct device_node *dev,
-		int bar_no, u64 *size, unsigned int *flags)
-{
-	return NULL;
-}
 static inline int of_pci_range_to_resource(struct of_pci_range *range,
 					   struct device_node *np,
 					   struct resource *res)
@@ -152,4 +145,16 @@ static inline int of_pci_range_to_resource(struct of_pci_range *range,
 }
 #endif /* CONFIG_OF_ADDRESS && CONFIG_PCI */
 
+static inline const __be32 *of_get_address(struct device_node *dev, int index,
+					   u64 *size, unsigned int *flags)
+{
+	return __of_get_address(dev, index, -1, size, flags);
+}
+
+static inline const __be32 *of_get_pci_address(struct device_node *dev, int bar_no,
+					       u64 *size, unsigned int *flags)
+{
+	return __of_get_address(dev, -1, bar_no, size, flags);
+}
+
 #endif /* __OF_ADDRESS_H */
-- 
2.27.0

