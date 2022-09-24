Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3CA5E8ABB
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 11:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiIXJY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiIXJYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 05:24:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB2139BE8;
        Sat, 24 Sep 2022 02:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC02CB80B3C;
        Sat, 24 Sep 2022 09:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58685C433C1;
        Sat, 24 Sep 2022 09:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664011460;
        bh=sHPgm7Bf+Utqg2hFFou3EDhEcuSIIzXwSlAILmNgHAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIuYjPB/+Rt6i6qzAkLmJ9X2HVFB/WRMRrv+JBkqDg8om4pdGFwvK0uUG8Y4JHst+
         O8wSAC8d6qFurbDaseuyKqnoX02Smx9RULumCegYwjiIaaNand/QVwdxaz3JHW/3tq
         EsGcq14MwISCbCIhbuYgYMArXUq8qqAu+MO0eqxd6Njtlhc3jY78NDh3PB/rRucA7H
         54exG+Q29BfXcQMYf9DUBUdUs6d4kxeco2xvV9LEch6GNtMRIeKQHXCOnmR8Y2SMBz
         ftYhKyateVlYVtKNT7aJL9j4EAx7Gdj8aeTpa+WUjFk8LWE6qyXQErW4JupafxOCaM
         Wvrl72I4sJ7nA==
Received: by pali.im (Postfix)
        id C5F871231; Sat, 24 Sep 2022 11:24:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: ftpci100: Use PCI_CONF1_ADDRESS() macro
Date:   Sat, 24 Sep 2022 11:24:03 +0200
Message-Id: <20220924092404.31776-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220924092404.31776-1-pali@kernel.org>
References: <20220924092404.31776-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify pci-ftpci100.c driver code and use new PCI_CONF1_ADDRESS() macro
for accessing PCI config space.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-ftpci100.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 88980a44461d..0cfd9d5a497c 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -103,13 +103,6 @@
 #define FARADAY_PCI_DMA_MEM2_BASE	0x00000000
 #define FARADAY_PCI_DMA_MEM3_BASE	0x00000000
 
-/* Defines for PCI configuration command register */
-#define PCI_CONF_ENABLE		BIT(31)
-#define PCI_CONF_WHERE(r)	((r) & 0xFC)
-#define PCI_CONF_BUS(b)		(((b) & 0xFF) << 16)
-#define PCI_CONF_DEVICE(d)	(((d) & 0x1F) << 11)
-#define PCI_CONF_FUNCTION(f)	(((f) & 0x07) << 8)
-
 /**
  * struct faraday_pci_variant - encodes IP block differences
  * @cascaded_irq: this host has cascaded IRQs from an interrupt controller
@@ -190,11 +183,8 @@ static int faraday_raw_pci_read_config(struct faraday_pci *p, int bus_number,
 				       unsigned int fn, int config, int size,
 				       u32 *value)
 {
-	writel(PCI_CONF_BUS(bus_number) |
-			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
-			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
-			PCI_CONF_WHERE(config) |
-			PCI_CONF_ENABLE,
+	writel(PCI_CONF1_ADDRESS(bus_number, PCI_SLOT(fn),
+				 PCI_FUNC(fn), config),
 			p->base + FTPCI_CONFIG);
 
 	*value = readl(p->base + FTPCI_DATA);
@@ -225,11 +215,8 @@ static int faraday_raw_pci_write_config(struct faraday_pci *p, int bus_number,
 {
 	int ret = PCIBIOS_SUCCESSFUL;
 
-	writel(PCI_CONF_BUS(bus_number) |
-			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
-			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
-			PCI_CONF_WHERE(config) |
-			PCI_CONF_ENABLE,
+	writel(PCI_CONF1_ADDRESS(bus_number, PCI_SLOT(fn),
+				 PCI_FUNC(fn), config),
 			p->base + FTPCI_CONFIG);
 
 	switch (size) {
-- 
2.20.1

