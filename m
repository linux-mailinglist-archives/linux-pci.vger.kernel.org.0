Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A37BFC48
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfI0AZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:25:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33271 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfI0AZO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id e18so3767601oii.0;
        Thu, 26 Sep 2019 17:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvE1OjQp2Eo5TOhHCna2F9pDoURrQBiIlsatoh/ojtA=;
        b=KqYGlp4pnmNRkjgrtDJgECRHf1rpz2lNXLgnDrdZTmWoQOC+25/QKZtUkGcGBZ2MuG
         +1x0fm1hlBsfW5UNwdciNVoIxhvFoLj0slGnorylKWqjR960G+fgqUfylYBaBtnLrEK8
         BvA59sYp08yFmC61qmHiujPvI4aGdJVivsF9vnZVGiqLtWYG3zATyAsQwn8JPze4b1hS
         4tKA94mxv/Vvpk32tlwmP1JpQnKx5PpNRlnHP5/TnMfxIaHNZ4RaOqo0JBU8AdntxtTn
         hNXqTSnwdep+F+QLxG4vFvSPHt3XQerAcY+9zpnPZ84CFKIdzhyQPDxSXGViljO2oB6b
         85aQ==
X-Gm-Message-State: APjAAAXIHkETXzCMwxGJlQpNnmK+FX7+eCBnqF/zKARK2svJyUm2/YtN
        QPEXH1JaPw0RNhjzMgz3OPEqBrs=
X-Google-Smtp-Source: APXvYqymzzkGngPSfklXZDXctIqAbqktZ7y7sWXPpqKuwMptW/o1ke/+OGivC0alJNA1OSSWMEbpfg==
X-Received: by 2002:a05:6808:b0d:: with SMTP id s13mr4936115oij.52.1569543912890;
        Thu, 26 Sep 2019 17:25:12 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:25:12 -0700 (PDT)
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
Subject: [PATCH 11/11] of/address: Fix of_pci_range_parser_one translation of DMA addresses
Date:   Thu, 26 Sep 2019 19:24:55 -0500
Message-Id: <20190927002455.13169-12-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_pci_range_parser_one() has a bug when parsing dma-ranges. When it
translates the parent address (aka cpu address in the code), 'ranges' is
always being used. This happens to work because most users are just 1:1
translation.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       | 15 ++++++++++++---
 include/linux/of_address.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 5b835d332709..54011a355b81 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -243,6 +243,7 @@ static int parser_init(struct of_pci_range_parser *parser,
 	parser->node = node;
 	parser->pna = of_n_addr_cells(node);
 	parser->np = parser->pna + na + ns;
+	parser->dma = !strcmp(name, "dma-ranges");
 
 	parser->range = of_get_property(node, name, &rlen);
 	if (parser->range == NULL)
@@ -281,7 +282,11 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	range->pci_space = be32_to_cpup(parser->range);
 	range->flags = of_bus_pci_get_flags(parser->range);
 	range->pci_addr = of_read_number(parser->range + 1, ns);
-	range->cpu_addr = of_translate_address(parser->node,
+	if (parser->dma)
+		range->cpu_addr = of_translate_dma_address(parser->node,
+				parser->range + na);
+	else
+		range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
@@ -294,8 +299,12 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 
 		flags = of_bus_pci_get_flags(parser->range);
 		pci_addr = of_read_number(parser->range + 1, ns);
-		cpu_addr = of_translate_address(parser->node,
-				parser->range + na);
+		if (parser->dma)
+			cpu_addr = of_translate_dma_address(parser->node,
+					parser->range + na);
+		else
+			cpu_addr = of_translate_address(parser->node,
+					parser->range + na);
 		size = of_read_number(parser->range + parser->pna + na, ns);
 
 		if (flags != range->flags)
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index ddda3936039c..eac7ab109df4 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -12,6 +12,7 @@ struct of_pci_range_parser {
 	const __be32 *end;
 	int np;
 	int pna;
+	bool dma;
 };
 
 struct of_pci_range {
-- 
2.20.1

