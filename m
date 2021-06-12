Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC93A5075
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jun 2021 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhFLUCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Jun 2021 16:02:18 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:45665 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhFLUCP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jun 2021 16:02:15 -0400
Received: by mail-oo1-f50.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso1616050ooc.12
        for <linux-pci@vger.kernel.org>; Sat, 12 Jun 2021 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PZiW/ysJHqutGyR+JA9Mb4NbGdDS75dnVh/LnFW9ck4=;
        b=YUdmEvEB/INvD/EijLVHIog4P0gHkrEIDXWP+ZWLWKKMD/vRfwiJsBUYqSBhF4RVs+
         Pp3ZjQOXovWpuvOwQZzNNZUQdbtePlOPeYNENXD8aLCVxVmiahTDHE0dDK1V1deawCff
         wKuZMbkITTKPss4kuTyDdomrG9oqaFL36tQSju0mxatdKcL17qjuQbyUtmPwWOoaQ2iW
         3InFax00gitvHT3VcQtyIVAlg1dFxVqBcgQZ0DzhD6ygMIudmby9HMcP+vA/bxTSshvA
         XJ9aUlh9Fn0Xs8W4uEaCqz1vWsIvSQ51zVYBSmTeKAX4We6bdW+190F2gLpNcs3qojZM
         LDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PZiW/ysJHqutGyR+JA9Mb4NbGdDS75dnVh/LnFW9ck4=;
        b=mcRZsTCP3YSki1WfZudQQYL3Aa2AAINUiQt+1jBvFBcVWyXiQ8N2YxyRrc0+1E3Vqp
         JOev7/0HYcN3jXj9EQ5wrpjilR092DZtCW3az+5V14srOhPgw3E83NY9fi+MPC0ikl+b
         D4TIlw8dO1W4KY/4gtSE1PYC8qXDWLTkat1WzfPP36R/MqM9lxeq4U54yspkZ/2U2Tfn
         OLk+mh5gifkFUpl4W+x05hqdOYhiNiUrz7CakbgUNUMT7EjMFAxSVoPjc3Tdc6+dIm9H
         abV1y2d9CnxxCvFWAgtupU9xXHq6TO2IC8giJiPzqyZvXoxgaNvFhegM7jPgYL+JQbsQ
         eoEw==
X-Gm-Message-State: AOAM533mtGPhmcsQgz9tmg0NIwQGyTPAJps9A6kZ2T1XFzpfvS56hZtW
        SYFfwblEWhZ+VbRKHwx81JU=
X-Google-Smtp-Source: ABdhPJxKF9biY+MDR1mQp/kn69Y1wPTh1JxGBXEnG+J6IHywOd0dXmMH/S5hDNohcrbfGj8ndOtpig==
X-Received: by 2002:a4a:2242:: with SMTP id z2mr2867469ooe.90.1623527954625;
        Sat, 12 Jun 2021 12:59:14 -0700 (PDT)
Received: from fedora.. ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id l2sm2171150otn.32.2021.06.12.12.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 12:59:13 -0700 (PDT)
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     bhelgaas@google.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-pci@vger.kernel.org,
        Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH] acpi: pci_irq: Fixed a control flow style issue
Date:   Sat, 12 Jun 2021 13:57:31 -0600
Message-Id: <20210612195730.1069667-1-majortomtosourcecontrol@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixed coding style issue.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 drivers/acpi/pci_irq.c | 45 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 08e15774fb9f..6eea3cf7b158 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -260,30 +260,29 @@ static int bridge_has_boot_interrupt_variant(struct pci_bus *bus)
 static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
 				       struct acpi_prt_entry *entry)
 {
-	if (noioapicquirk || noioapicreroute) {
+	if (noioapicquirk || noioapicreroute)
 		return 0;
-	} else {
-		switch (bridge_has_boot_interrupt_variant(dev->bus)) {
-		case 0:
-			/* no rerouting necessary */
-			return 0;
-		case INTEL_IRQ_REROUTE_VARIANT:
-			/*
-			 * Remap according to INTx routing table in 6700PXH
-			 * specs, intel order number 302628-002, section
-			 * 2.15.2. Other chipsets (80332, ...) have the same
-			 * mapping and are handled here as well.
-			 */
-			dev_info(&dev->dev, "PCI IRQ %d -> rerouted to legacy "
-				 "IRQ %d\n", entry->index,
-				 (entry->index % 4) + 16);
-			entry->index = (entry->index % 4) + 16;
-			return 1;
-		default:
-			dev_warn(&dev->dev, "Cannot reroute IRQ %d to legacy "
-				 "IRQ: unknown mapping\n", entry->index);
-			return -1;
-		}
+
+	switch (bridge_has_boot_interrupt_variant(dev->bus)) {
+	case 0:
+		/* no rerouting necessary */
+		return 0;
+	case INTEL_IRQ_REROUTE_VARIANT:
+		/*
+		 * Remap according to INTx routing table in 6700PXH
+		 * specs, intel order number 302628-002, section
+		 * 2.15.2. Other chipsets (80332, ...) have the same
+		 * mapping and are handled here as well.
+		 */
+		dev_info(&dev->dev, "PCI IRQ %d -> rerouted to legacy "
+			 "IRQ %d\n", entry->index,
+			 (entry->index % 4) + 16);
+		entry->index = (entry->index % 4) + 16;
+		return 1;
+	default:
+		dev_warn(&dev->dev, "Cannot reroute IRQ %d to legacy "
+			 "IRQ: unknown mapping\n", entry->index);
+		return -1;
 	}
 }
 #endif /* CONFIG_X86_IO_APIC */
-- 
2.31.1

