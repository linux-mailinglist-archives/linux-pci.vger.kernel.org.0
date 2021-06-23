Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B73B240F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 01:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWXsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 19:48:22 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:59898 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFWXsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 19:48:21 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5BB1B92009E; Thu, 24 Jun 2021 01:38:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5A1DD92009D;
        Thu, 24 Jun 2021 01:38:59 +0200 (CEST)
Date:   Thu, 24 Jun 2021 01:38:59 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] x86/PCI: Disambiguate SiS85C503 PIRQ router code
 entities
In-Reply-To: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106240058590.37803@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation to adding support for the SiS85C497 PIRQ router add `503' 
to the names of SiS85C503 PIRQ router code entities so that they clearly 
indicate which device they refer to.

Also restructure `sis_router_probe' such that new device IDs will be 
just new switch cases.

No functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/x86/pci/irq.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

linux-x86-pirq-router-sis85c503.diff
Index: linux-macro-ide/arch/x86/pci/irq.c
===================================================================
--- linux-macro-ide.orig/arch/x86/pci/irq.c
+++ linux-macro-ide/arch/x86/pci/irq.c
@@ -389,11 +389,12 @@ static int pirq_cyrix_set(struct pci_dev
  *				bit 6-4 are probably unused, not like 5595
  */
 
-#define PIRQ_SIS_IRQ_MASK	0x0f
-#define PIRQ_SIS_IRQ_DISABLE	0x80
-#define PIRQ_SIS_USB_ENABLE	0x40
+#define PIRQ_SIS503_IRQ_MASK	0x0f
+#define PIRQ_SIS503_IRQ_DISABLE	0x80
+#define PIRQ_SIS503_USB_ENABLE	0x40
 
-static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+static int pirq_sis503_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
 {
 	u8 x;
 	int reg;
@@ -402,10 +403,11 @@ static int pirq_sis_get(struct pci_dev *
 	if (reg >= 0x01 && reg <= 0x04)
 		reg += 0x40;
 	pci_read_config_byte(router, reg, &x);
-	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
+	return (x & PIRQ_SIS503_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS503_IRQ_MASK);
 }
 
-static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+static int pirq_sis503_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
 {
 	u8 x;
 	int reg;
@@ -414,8 +416,8 @@ static int pirq_sis_set(struct pci_dev *
 	if (reg >= 0x01 && reg <= 0x04)
 		reg += 0x40;
 	pci_read_config_byte(router, reg, &x);
-	x &= ~(PIRQ_SIS_IRQ_MASK | PIRQ_SIS_IRQ_DISABLE);
-	x |= irq ? irq: PIRQ_SIS_IRQ_DISABLE;
+	x &= ~(PIRQ_SIS503_IRQ_MASK | PIRQ_SIS503_IRQ_DISABLE);
+	x |= irq ? irq : PIRQ_SIS503_IRQ_DISABLE;
 	pci_write_config_byte(router, reg, x);
 	return 1;
 }
@@ -697,13 +699,14 @@ static __init int serverworks_router_pro
 
 static __init int sis_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
-	if (device != PCI_DEVICE_ID_SI_503)
-		return 0;
-
-	r->name = "SIS";
-	r->get = pirq_sis_get;
-	r->set = pirq_sis_set;
-	return 1;
+	switch (device) {
+	case PCI_DEVICE_ID_SI_503:
+		r->name = "SiS85C503";
+		r->get = pirq_sis503_get;
+		r->set = pirq_sis503_set;
+		return 1;
+	}
+	return 0;
 }
 
 static __init int cyrix_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
