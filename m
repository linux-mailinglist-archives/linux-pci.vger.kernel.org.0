Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96711DFC2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 09:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLMIs2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 03:48:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45413 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfLMIs1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 03:48:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id bc8so943796plb.12;
        Fri, 13 Dec 2019 00:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPnTIRMILPqM0UWzvBdt6uVoOYvVzYGaVnz/AEQ+U64=;
        b=rLyeugVoRkoz0+Y06IdS4Wvj9dz3kH+OIbgNdfHC9yIGa3u21GzMr6ebQ+/spw5NL8
         T4JsouxJ5/nenY7TSf/8u+jxvvDelNJFFAx/qthYc3UEVoDaYOf1kyUbN3ABNGkgFyF8
         n5q3zbhI2px3oFghB7KFH7Sfi1nVSLGgN3xGxrtqk9bGH3guYHeVBQRtsFUBZktDEm9i
         j7pm72vvgeWvvo5qppTXv1/rkXkkFD8tEtdyUUSuud+XjCSTneFTmeb6McaQLhEPPUj6
         rPXePpFahsxF7SSb1JOnfGWLWy57Z+NpW2RLNcRMC+XfPRc6C6JO9+vSj9Jpev3w5yOz
         uCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPnTIRMILPqM0UWzvBdt6uVoOYvVzYGaVnz/AEQ+U64=;
        b=oUij1tKMC41XtpygHUc3xrMfXCCD0Kb1p408Pr0E4L/qowO2MTUPIyQqPEJiQGoFNF
         Kj+eU0P93SvJeJLVnEl6ZX+EjBnxz8bPEjy6fyGMDEwKe/bCtptdcmgAdvs+3nRbfeQJ
         XjZhJVVRUPnfQusAXonUXAtoAst+QVxmUPf1/Xt9sPjNPd+rMXb2Pn1ujWyjKiChI//d
         1gDxYA3tbDdRIexRM6btxc7vctx9RmGNxaZXWin/FMaMX5oCrobKtn+2ek9pNXVxq1+w
         ao01R3hb8Lozdyg883mjUrulatMfa9S7PWadqi7e+wJd7xDCs9KBk01S32/UmYzkRS7D
         6NQg==
X-Gm-Message-State: APjAAAUvMiwi5Tpo+VsUunzlO6AjHKEpAZNe0V0MVkhGmxmfnp4pyUpb
        wytVAMwQcxTHpLMwItice94=
X-Google-Smtp-Source: APXvYqzwxhAdN8PIyYKjnZsJFAh7Bv/fqcmv6xcJ6UgbSFsLrvOIj5VeKYAqdC0FsVvdvWEhwz3COA==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr14490650plb.223.1576226906585;
        Fri, 13 Dec 2019 00:48:26 -0800 (PST)
Received: from prasmi.domain.name ([103.219.60.167])
        by smtp.gmail.com with ESMTPSA id 68sm9985632pge.14.2019.12.13.00.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 00:48:25 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [v2 3/6] of: address: add support to parse PCI outbound-ranges
Date:   Fri, 13 Dec 2019 08:47:45 +0000
Message-Id: <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>

this patch adds support to parse PCI outbound-ranges, the
outbound-regions are similar to pci ranges except it doesn't
have pci address, below is the format for bar-ranges:

outbound-ranges = <flags upper32_cpuaddr lower32_cpuaddr
                   upper32_size lower32_size>;

Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/of/address.c       | 44 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/of_address.h | 21 +++++++++++++++++++++
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 978427a..ca4643c 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -233,9 +233,9 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
 
 static int parser_init(struct of_pci_range_parser *parser,
-			struct device_node *node, const char *name)
+		       struct device_node *node, const char *name,
+		       const int na, const int ns)
 {
-	const int na = 3, ns = 2;
 	int rlen;
 
 	parser->node = node;
@@ -254,17 +254,30 @@ static int parser_init(struct of_pci_range_parser *parser,
 int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 				struct device_node *node)
 {
-	return parser_init(parser, node, "ranges");
+	const int na = 3, ns = 2;
+
+	return parser_init(parser, node, "ranges", na, ns);
 }
 EXPORT_SYMBOL_GPL(of_pci_range_parser_init);
 
 int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 				struct device_node *node)
 {
-	return parser_init(parser, node, "dma-ranges");
+	const int na = 3, ns = 2;
+
+	return parser_init(parser, node, "dma-ranges", na, ns);
 }
 EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
 
+int of_pci_outbound_range_parser_init(struct of_pci_range_parser *parser,
+				      struct device_node *node)
+{
+	const int na = 1, ns = 2;
+
+	return parser_init(parser, node, "outbound-ranges", na, ns);
+}
+EXPORT_SYMBOL_GPL(of_pci_outbound_range_parser_init);
+
 struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 						struct of_pci_range *range)
 {
@@ -310,6 +323,29 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 }
 EXPORT_SYMBOL_GPL(of_pci_range_parser_one);
 
+struct of_pci_outbound_range
+*of_pci_outbound_range_parser_one(struct of_pci_range_parser *parser,
+				  struct of_pci_outbound_range *range)
+{
+	const int na = 1, ns = 2;
+
+	if (!range)
+		return NULL;
+
+	if (!parser->range || parser->range + parser->np > parser->end)
+		return NULL;
+
+	range->flags = be32_to_cpup(parser->range);
+	range->cpu_addr = of_translate_address(parser->node,
+					       parser->range + na);
+	range->size = of_read_number(parser->range + parser->pna + na, ns);
+
+	parser->range += parser->np;
+
+	return range;
+}
+EXPORT_SYMBOL_GPL(of_pci_outbound_range_parser_one);
+
 /*
  * of_pci_range_to_resource - Create a resource from an of_pci_range
  * @range:	the PCI range that describes the resource
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 30e40fb..93b3be3 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -22,9 +22,18 @@ struct of_pci_range {
 	u32 flags;
 };
 
+struct of_pci_outbound_range {
+	u32 flags;
+	u64 cpu_addr;
+	u64 size;
+};
+
 #define for_each_of_pci_range(parser, range) \
 	for (; of_pci_range_parser_one(parser, range);)
 
+#define for_each_of_pci_outbound_range(parser, range) \
+	for (; of_pci_outbound_range_parser_one(parser, range);)
+
 /* Translate a DMA address from device space to CPU space */
 extern u64 of_translate_dma_address(struct device_node *dev,
 				    const __be32 *in_addr);
@@ -52,9 +61,14 @@ extern int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node);
 extern int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node);
+extern int of_pci_outbound_range_parser_init(struct of_pci_range_parser *parser,
+					     struct device_node *node);
 extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range);
+extern struct of_pci_outbound_range
+*of_pci_outbound_range_parser_one(struct of_pci_range_parser *parser,
+				  struct of_pci_outbound_range *range);
 extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 				u64 *paddr, u64 *size);
 extern bool of_dma_is_coherent(struct device_node *np);
@@ -97,6 +111,13 @@ static inline int of_pci_dma_range_parser_init(struct of_pci_range_parser *parse
 	return -ENOSYS;
 }
 
+static inline int
+of_pci_outbound_range_parser_init(struct of_pci_range_parser *parser,
+				  struct device_node *node)
+{
+	return -ENOSYS;
+}
+
 static inline struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range)
-- 
2.7.4

