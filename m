Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF44241CA56
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345985AbhI2Qki (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 12:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344376AbhI2Qkg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 12:40:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE3B60F6E;
        Wed, 29 Sep 2021 16:38:55 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mVcbe-00DmcL-2i; Wed, 29 Sep 2021 17:38:54 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>, kernel-team@android.com
Subject: [PATCH v5 01/14] irqdomain: Make of_phandle_args_to_fwspec generally available
Date:   Wed, 29 Sep 2021 17:38:34 +0100
Message-Id: <20210929163847.2807812-2-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929163847.2807812-1-maz@kernel.org>
References: <20210929163847.2807812-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, joey.gouly@arm.com, joro@8bytes.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_phandle_args_to_fwspec() can be generally useful to code
extracting a DT of_phandle and using an irq_fwspec to use the
hierarchical irqdomain API.

Make it visible the the rest of the kernel, including modules.

Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 4 ++++
 kernel/irq/irqdomain.c    | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9ee238ad29ce..553da4899f55 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -64,6 +64,10 @@ struct irq_fwspec {
 	u32 param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
 };
 
+/* Conversion function from of_phandle_args fields to fwspec  */
+void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
+			       unsigned int count, struct irq_fwspec *fwspec);
+
 /*
  * Should several domains have the same device node, but serve
  * different purposes (for example one domain is for PCI/MSI, and the
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 4d8fc65cf38f..e14adda218b7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -744,9 +744,8 @@ static int irq_domain_translate(struct irq_domain *d,
 	return 0;
 }
 
-static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
-				      unsigned int count,
-				      struct irq_fwspec *fwspec)
+void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
+			       unsigned int count, struct irq_fwspec *fwspec)
 {
 	int i;
 
@@ -756,6 +755,7 @@ static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 	for (i = 0; i < count; i++)
 		fwspec->param[i] = args[i];
 }
+EXPORT_SYMBOL_GPL(of_phandle_args_to_fwspec);
 
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 {
-- 
2.30.2

