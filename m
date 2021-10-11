Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C34295FC
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhJKRrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJKRre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:47:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09F7C061570;
        Mon, 11 Oct 2021 10:45:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y1so11780549plk.10;
        Mon, 11 Oct 2021 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvyIILinTPLJ5IGz12ZGgmNprHQpAgzhPfKruj1QRTQ=;
        b=JrP1Ohv+cYjrx5Jh/JaA7MwB/9gvY+X1vWCy+bHL75WvvGHkjD9CJL50NjhZAIFjel
         W5Vd5bG4LFgS3+ZaYLS/EccdCLVOWQmE8zFXKq9L9XxrEpD9Ed9OBzeOpnYV8MWVt5m7
         RovxeDrvhFMwn64Ldcfe+yGWQSQFgoqFSBOUS5wMtlPZCeU6300+7LyIS5TCDPt/CuPV
         Z3c+Xrw5aDYy7ivX6Mwnx6Hs79JA+/O1VJyrmjMtNG7vgfCyYpC41G+WQDwijKoIxiLC
         bgJYonkUnoYeHr/pMqT80xLaX/Zv3upaDGR6IG3ul+W3X++nwnJbyRcvjNMSuijQGKSN
         dzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvyIILinTPLJ5IGz12ZGgmNprHQpAgzhPfKruj1QRTQ=;
        b=FEZvf4lpkzvj6R8RuVn7fpKv+FzvFsrvRckvyWXYOmF32bhYuMfez2u43ZyoijO/Pj
         e4Yxdr8YTeSNqL4qpSy5N1T+avqQou0c3KEvmqEMR4hx4JEp3uEvHtOW9ZBcOkHZqZls
         94kYkNuWv9VCkjNaCyPvUIOeQecwUX3Qyg9NNfIt+Q8VZ7y6em3IRTUaX6i1kuKRZfCR
         6Yftkjb4UylWeRuuejhrtuzrU5shnmDDLMF3bx6MAq0DTPiKLq7IwGx9ye7qipP5bNnx
         wYSCZcSl9aYlzDB1Lh3owOSGWp6R6zFCEJFHoITn4gWDALuVBeejmqtTSbGO6xKYvLYS
         iu8A==
X-Gm-Message-State: AOAM533+PrRZPunrodmPItJSHx28729ZfkNs2rIWBs1GlGtWLlaYDeny
        JaOhEKVv3XwYR7tfjoh8nr27LOnTBlda07a0
X-Google-Smtp-Source: ABdhPJxj6ob2ZpfsVy9xfdI99KTdNW8a1qGjYI7I2upgWYUEMQtqA6qVYw3yibmKLLl8AKLPxR4CHQ==
X-Received: by 2002:a17:903:2451:b0:13e:f1ef:d819 with SMTP id l17-20020a170903245100b0013ef1efd819mr25566918pls.85.1633974333299;
        Mon, 11 Oct 2021 10:45:33 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id k22sm8395232pfi.149.2021.10.11.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:45:32 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Richter <rric@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/22] PCI: thunder: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:15:10 +0530
Message-Id: <c5f9e140106cd6a38026300a4e5e5e6ad9257fb3.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-thunder-ecam.c | 20 ++++++++++----------
 drivers/pci/controller/pci-thunder-pem.c  |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index ffd84656544f..4c57ad2aa9aa 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -42,7 +42,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 	if (where_a == 0x4) {
 		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
 		if (!addr) {
-			*val = ~0;
+			SET_PCI_ERROR_RESPONSE(val);
 			return PCIBIOS_DEVICE_NOT_FOUND;
 		}
 		v = readl(addr);
@@ -57,7 +57,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 
 		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
 		if (!addr) {
-			*val = ~0;
+			SET_PCI_ERROR_RESPONSE(val);
 			return PCIBIOS_DEVICE_NOT_FOUND;
 		}
 		barl_orig = readl(addr + 0);
@@ -73,7 +73,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 	if (where_a == 0xc) {
 		addr = bus->ops->map_bus(bus, devfn, bar + 4); /* BAR 1 */
 		if (!addr) {
-			*val = ~0;
+			SET_PCI_ERROR_RESPONSE(val);
 			return PCIBIOS_DEVICE_NOT_FOUND;
 		}
 		v = readl(addr); /* EA entry-3. Base-H */
@@ -105,7 +105,7 @@ static int thunder_ecam_p2_config_read(struct pci_bus *bus, unsigned int devfn,
 
 	addr = bus->ops->map_bus(bus, devfn, where_a);
 	if (!addr) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
@@ -136,7 +136,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 
 	addr = bus->ops->map_bus(bus, devfn, 0xc);
 	if (!addr) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
@@ -147,7 +147,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 
 	addr = bus->ops->map_bus(bus, devfn, 8);
 	if (!addr) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
@@ -177,7 +177,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 
 	addr = bus->ops->map_bus(bus, devfn, 0);
 	if (!addr) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
@@ -197,7 +197,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 
 		addr = bus->ops->map_bus(bus, devfn, 0x70);
 		if (!addr) {
-			*val = ~0;
+			SET_PCI_ERROR_RESPONSE(val);
 			return PCIBIOS_DEVICE_NOT_FOUND;
 		}
 		/* E_CAP */
@@ -212,7 +212,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 		if (where_a == 0xb0) {
 			addr = bus->ops->map_bus(bus, devfn, where_a);
 			if (!addr) {
-				*val = ~0;
+				SET_PCI_ERROR_RESPONSE(val);
 				return PCIBIOS_DEVICE_NOT_FOUND;
 			}
 			v = readl(addr);
@@ -269,7 +269,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 		if (where_a == 0x70) {
 			addr = bus->ops->map_bus(bus, devfn, where_a);
 			if (!addr) {
-				*val = ~0;
+				SET_PCI_ERROR_RESPONSE(val);
 				return PCIBIOS_DEVICE_NOT_FOUND;
 			}
 			v = readl(addr);
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 0660b9da204f..a463a1b61f23 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -42,7 +42,7 @@ static int thunder_pem_bridge_read(struct pci_bus *bus, unsigned int devfn,
 	struct thunder_pem_pci *pem_pci = (struct thunder_pem_pci *)cfg->priv;
 
 	if (devfn != 0 || where >= 2048) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
2.25.1

