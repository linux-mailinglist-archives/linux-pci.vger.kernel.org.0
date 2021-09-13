Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B565D409C10
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhIMS1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 14:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235943AbhIMS1T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 14:27:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5EC610CF;
        Mon, 13 Sep 2021 18:26:03 +0000 (UTC)
Received: from [198.52.44.129] (helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mPqeY-00AYPD-0T; Mon, 13 Sep 2021 19:26:02 +0100
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
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: [PATCH v3 01/10] irqdomain: Make of_phandle_args_to_fwspec generally available
Date:   Mon, 13 Sep 2021 19:25:41 +0100
Message-Id: <20210913182550.264165-2-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913182550.264165-1-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 198.52.44.129
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_phandle_args_to_fwspec() can be generally useful to code
extracting a DT of_phandle and using an irq_fwspec to use the
hierarchical irqdomain API.

Make it visible the the rest of the kernel, including modules.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 4 ++++
 kernel/irq/irqdomain.c    | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 23e4ee523576..cfd442316f39 100644
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
index 19e83e9b723c..5a698c1f6cc6 100644
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

