Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5A3BC47E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 03:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhGFBJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 21:09:08 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:42664 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFBJH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 21:09:07 -0400
Received: by mail-wm1-f45.google.com with SMTP id j16-20020a05600c1c10b0290204b096b0caso1045792wms.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 18:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z25jV3Lc+Jaa1XrFF2O29mwDomdRuLImlWbMu42JCcw=;
        b=VRcR+dU34ddDdYVV8oaKpwy9Vo2eul8I8vtdXOPP1ziHrFQaY5XBx+Pn+bK4chjdEk
         0KWdDTO0nn4KkaqdHJxqAkzs34tqpkicB3BuGLWmapV5QdmOtm4N21HxTTpWX84Hp5YT
         qs2zj933MoRMTbuxFpUPLIdvUON88jQaN48fXUxLuhi412YZ0j3zghNVJexIGU+FG9u6
         3wF4/+jF7oQV1dkkhQ1zFvuCXytOEQ+H9hplMHL/EDDHfvVP9Rh2NGoQAiJBJwC2Ol+o
         pOuEINFJV/ZKmCxbfAiZG0/oUQgMOavhRUYsi7o2pAzVjaL9AmTtzVwsjCLBG8uskG+m
         M1Qw==
X-Gm-Message-State: AOAM530Dei0B+QcjY7x6zUCU2Ll7W7kCZqBsWAaqsGqRMzsn+9URFUj1
        V3zDt+If9KeWTzEA6TWVeyU=
X-Google-Smtp-Source: ABdhPJy29D/kapi3QBnrARt5PTsnp6mp0ODbE04H5cqA4Uradm7R5k9/obJSnSSJOWT/oEHqBvXtiQ==
X-Received: by 2002:a05:600c:2288:: with SMTP id 8mr1719528wmf.96.1625533586616;
        Mon, 05 Jul 2021 18:06:26 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m12sm13379418wms.24.2021.07.05.18.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 18:06:26 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 4/4] PCI: Don't use the strtobool() wrapper for kstrtobool()
Date:   Tue,  6 Jul 2021 01:06:22 +0000
Message-Id: <20210706010622.3058968-4-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706010622.3058968-1-kw@linux.com>
References: <20210706010622.3058968-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The strtobool() function is a wrapper over the kstrtobool() function
that has been added for backward compatibility.

There is no reason to use the old API, thus rather than using the
wrapper use the kstrtobool() directly.

Related:
  commit ef951599074b ("lib: move strtobool() to kstrtobool()")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/p2pdma.c    | 6 +++---
 drivers/pci/pcie/aspm.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..1bd299cf3872 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -911,7 +911,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
  *
  * Parses an attribute value to decide whether to enable p2pdma.
  * The value can select a PCI device (using its full BDF device
- * name) or a boolean (in any format strtobool() accepts). A false
+ * name) or a boolean (in any format kstrtobool() accepts). A false
  * value disables p2pdma, a true value expects the caller
  * to automatically find a compatible device and specifying a PCI device
  * expects the caller to use the specific provider.
@@ -943,11 +943,11 @@ int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 	} else if ((page[0] == '0' || page[0] == '1') && !iscntrl(page[1])) {
 		/*
 		 * If the user enters a PCI device that  doesn't exist
-		 * like "0000:01:00.1", we don't want strtobool to think
+		 * like "0000:01:00.1", we don't want kstrtobool to think
 		 * it's a '0' when it's clearly not what the user wanted.
 		 * So we require 0's and 1's to be exactly one character.
 		 */
-	} else if (!strtobool(page, use_p2pdma)) {
+	} else if (!kstrtobool(page, use_p2pdma)) {
 		return 0;
 	}
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..ba8b17000d94 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1219,7 +1219,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 	bool state_enable;
 
-	if (strtobool(buf, &state_enable) < 0)
+	if (kstrtobool(buf, &state_enable) < 0)
 		return -EINVAL;
 
 	down_read(&pci_bus_sem);
@@ -1276,7 +1276,7 @@ static ssize_t clkpm_store(struct device *dev,
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 	bool state_enable;
 
-	if (strtobool(buf, &state_enable) < 0)
+	if (kstrtobool(buf, &state_enable) < 0)
 		return -EINVAL;
 
 	down_read(&pci_bus_sem);
-- 
2.32.0

