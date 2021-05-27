Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D33393694
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 21:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhE0Trj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 15:47:39 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35463 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbhE0Trf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 15:47:35 -0400
Received: by mail-ot1-f54.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so1345185otg.2;
        Thu, 27 May 2021 12:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaVILIIQRpAt4fcQqCQzkC7Wo1WpArLqF54tXrfeHEk=;
        b=iA38o8+DaGlZxZIptoJ4OEV7oS9tMKSdQmoE7mYbptLt+EXcqusE/C8WrvDLfOBBMq
         O8DZygsI1p7R2drzwalspn2vsjCWHoQxazf4SYkg3/weC0dybRAYXDtUr4mmd5shdYz0
         sA+CbA6ImLGYCQ9w6uUPzYShJkeUoVQTXUnUgSMhHsc0S5JPBsWfFtx1/1q1roYqVITA
         LVzCoiwhzNPeb1d0EydOG5Grag27YfUzJY0jEMtM8iKrk6Ii0zndBwZegmxH2QJb32Qb
         vlwPPd1lMdv1GVYS38U4A2TghVR/5OjPrVl5Jwjqy8g/8qYsUy3aoQNMn/SJrrbYQqd+
         YimA==
X-Gm-Message-State: AOAM532U8rt1TKiveEwl6zRh94NiwmV6luE+G2MEJQG/ttkKTRo0Ykh5
        bVAYSOFlW0rM+cC5pVrQayHpuvYPxw==
X-Google-Smtp-Source: ABdhPJxsAV9DnsZkTkzog9FHmjg+bEejEyf9p9gCoy4QJ0+VWzhuApSAzpE0JKzM+T7GVe6yF2qOIg==
X-Received: by 2002:a05:6830:1013:: with SMTP id a19mr4045932otp.21.1622144759587;
        Thu, 27 May 2021 12:45:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m74sm665162oig.33.2021.05.27.12.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:45:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4/4] of: Merge of_address_to_resource() and of_pci_address_to_resource() implementations
Date:   Thu, 27 May 2021 14:45:47 -0500
Message-Id: <20210527194547.1287934-5-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527194547.1287934-1-robh@kernel.org>
References: <20210527194547.1287934-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_address_to_resource() and of_pci_address_to_resource() are almost the
same except the former takes an index and the latter takes a BAR number.
Now that __of_get_address() can take either one, refactor the functions
to use a common implementation.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e643f999743a..3b2acca7e363 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -23,9 +23,8 @@
 #define OF_CHECK_COUNTS(na, ns)	(OF_CHECK_ADDR_COUNT(na) && (ns) > 0)
 
 static struct of_bus *of_match_bus(struct device_node *np);
-static int __of_address_to_resource(struct device_node *dev,
-		const __be32 *addrp, u64 size, unsigned int flags,
-		const char *name, struct resource *r);
+static int __of_address_to_resource(struct device_node *dev, int index,
+		int bar_no, struct resource *r);
 static bool of_mmio_is_nonposted(struct device_node *np);
 
 /* Debug utility */
@@ -203,17 +202,11 @@ static int of_bus_pci_translate(__be32 *addr, u64 offset, int na)
 int of_pci_address_to_resource(struct device_node *dev, int bar,
 			       struct resource *r)
 {
-	const __be32	*addrp;
-	u64		size;
-	unsigned int	flags;
 
 	if (!IS_ENABLED(CONFIG_PCI))
 		return -ENOSYS;
 
-	addrp = of_get_pci_address(dev, bar, &size, &flags);
-	if (addrp == NULL)
-		return -EINVAL;
-	return __of_address_to_resource(dev, addrp, size, flags, NULL, r);
+	return __of_address_to_resource(dev, -1, bar, r);
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
 
@@ -804,11 +797,22 @@ static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
 	return port;
 }
 
-static int __of_address_to_resource(struct device_node *dev,
-		const __be32 *addrp, u64 size, unsigned int flags,
-		const char *name, struct resource *r)
+static int __of_address_to_resource(struct device_node *dev, int index, int bar_no,
+		struct resource *r)
 {
 	u64 taddr;
+	const __be32	*addrp;
+	u64		size;
+	unsigned int	flags;
+	const char	*name = NULL;
+
+	addrp = __of_get_address(dev, index, bar_no, &size, &flags);
+	if (addrp == NULL)
+		return -EINVAL;
+
+	/* Get optional "reg-names" property to add a name to a resource */
+	if (index >= 0)
+		of_property_read_string_index(dev, "reg-names",	index, &name);
 
 	if (flags & IORESOURCE_MEM)
 		taddr = of_translate_address(dev, addrp);
@@ -846,19 +850,7 @@ static int __of_address_to_resource(struct device_node *dev,
 int of_address_to_resource(struct device_node *dev, int index,
 			   struct resource *r)
 {
-	const __be32	*addrp;
-	u64		size;
-	unsigned int	flags;
-	const char	*name = NULL;
-
-	addrp = of_get_address(dev, index, &size, &flags);
-	if (addrp == NULL)
-		return -EINVAL;
-
-	/* Get optional "reg-names" property to add a name to a resource */
-	of_property_read_string_index(dev, "reg-names",	index, &name);
-
-	return __of_address_to_resource(dev, addrp, size, flags, name, r);
+	return __of_address_to_resource(dev, index, -1, r);
 }
 EXPORT_SYMBOL_GPL(of_address_to_resource);
 
-- 
2.27.0

