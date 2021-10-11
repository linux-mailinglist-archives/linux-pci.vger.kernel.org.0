Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD5A4295E8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhJKRlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhJKRlA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:41:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C965C06161C;
        Mon, 11 Oct 2021 10:39:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23-20020a17090a591700b001976d2db364so515824pji.2;
        Mon, 11 Oct 2021 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uG5YGH1HQhNqI6Rs9B6rHyRWKh0Ji0hRKGqWlkWjVmw=;
        b=ZTMkXOs4RrOGSszqIfzgTMk40on6vGxBESpWNkSlxPsTuOrMYLrvfRIOBcjzBYwjBF
         aEWCeQto/K909hUQpon72h6xYWPfgfQnh8n738ZsmlTUjbVGzakQkeevSVhF/zWXEDQY
         Daw/NL19GwHuG5WCyhdmciQcFgh7ldoE/QHbDRP9mC5l5Cb6LnQI9fAcDrlJri5664CC
         s/PqtGapp06/k2acCLHkBF/k02bb+uWDc9S9o1pWMlSbOZkXWWdZ4A21Lyz6cxXUbIeo
         NCGxaPdtidgdRPEL4rm5ZtbD2TdiBi73ulmPim/QXXhqKaYtMU2skRz9S9HcEKQVCcl3
         0oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uG5YGH1HQhNqI6Rs9B6rHyRWKh0Ji0hRKGqWlkWjVmw=;
        b=4J7alUrSGVBQpXodD4mw8nLoOFhv7fcmhqKeLOD9hxIUn651PTz2A8sEJOSP89BdzR
         C3HHTakV+LdQour6ZR+UMGUFha2aMgeLBwgvPIN30M1E5M/g3xAt7IZmHcddVn/w5BHm
         Ri9LGW5VZyr9C1R3/R19XR4dA5LT5gqm+0HKz0vYBuGZX9cWT4K8jQ/UWwpzoJRFXU7s
         6EN/1H1pnlb6yLNz5ViA2Uydc8yKQ0dKuCPfcFmp0RQM6WdfcO3Mnr8aWyu16H7s4wec
         od4aX4rdskaJQM2/c9LrsIhSxfFmUg9ay3Lg3aUeRUe1Wxuqsu0Ry0Z0PL0g5CBP7hpf
         xhCA==
X-Gm-Message-State: AOAM532GVTsjNNUy+DUBhxdyYm5i/EjnOPAwjenLUbaaD96leR6ToKW9
        fDp+8vXA8j0Xdct2MboZEg/APDSfJQgZTSPW
X-Google-Smtp-Source: ABdhPJxKbI/iqEe2pHkz+/Uc7eaiYQWFEaZEu4mQ1/aniGv566n8kDeeJO20tnAmbtimzV8JFOvZRA==
X-Received: by 2002:a17:90a:190:: with SMTP id 16mr379232pjc.152.1633973939735;
        Mon, 11 Oct 2021 10:38:59 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id b23sm8804907pgn.83.2021.10.11.10.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:38:59 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/22] PCI: Unify PCI error response checking
Date:   Mon, 11 Oct 2021 23:08:32 +0530
Message-Id: <c632b07eb1b08cc7d4346455a55641436a379abd.1633972263.git.naveennaidu479@gmail.com>
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

Use SET_PCI_ERROR_RESPONSE() to set the error response and
RESPONSE_IS_PCI_ERROR() to check the error response during hardware
read.

These definitions make error checks consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..e1954bbbd137 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -81,7 +81,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 
 	addr = bus->ops->map_bus(bus, devfn, where);
 	if (!addr) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
@@ -123,7 +123,7 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
 
 	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
 	if (!addr) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
@@ -411,10 +411,10 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
 		/*
 		 * Reset *val to 0 if pci_read_config_word() fails, it may
-		 * have been written as 0xFFFF if hardware error happens
-		 * during pci_read_config_word().
+		 * have been written as 0xFFFF (PCI_ERROR_RESPONSE) if hardware error
+		 * happens during pci_read_config_word().
 		 */
-		if (ret)
+		if (RESPONSE_IS_PCI_ERROR(val))
 			*val = 0;
 		return ret;
 	}
@@ -446,10 +446,10 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
 		/*
 		 * Reset *val to 0 if pci_read_config_dword() fails, it may
-		 * have been written as 0xFFFFFFFF if hardware error happens
-		 * during pci_read_config_dword().
+		 * have been written as 0xFFFFFFFF (PCI_ERROR_RESPONSE) if hardware
+		 * error happens during pci_read_config_dword().
 		 */
-		if (ret)
+		if (RESPONSE_IS_PCI_ERROR(val))
 			*val = 0;
 		return ret;
 	}
@@ -523,7 +523,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
@@ -533,7 +533,7 @@ EXPORT_SYMBOL(pci_read_config_byte);
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
@@ -544,7 +544,7 @@ int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
-- 
2.25.1

