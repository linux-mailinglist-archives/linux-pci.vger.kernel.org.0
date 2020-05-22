Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81B11DF32A
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgEVXsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:36 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:32777 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbgEVXsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:36 -0400
Received: by mail-il1-f196.google.com with SMTP id y17so10294108ilg.0
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGPS1/9t2DbdpX0irS4os0tkteUYvgsNTUcQ44RgQLA=;
        b=MAzGQPXpcPqfb1n9keVTxhWxPFSYJQZshRMjVv9QFUvYSDG50LceLrG6u9fVbenVLX
         V5fOydE53btfFa4LvSR8+6lPaUbZSzSvX/Hl6n+tEWrPRGKIa1jG71min6okzSG1ZCRL
         Gs4g0wlZOH06koJXh/fa+15ZHdBHLjZ4W7yLGhuobZQ2nwtH4UlnwzZWInqsjAa6D/ja
         fm9KOr6TdEL1839Brdz0o4tvNMYgmpsD/ocINRQd2FoMeIxEKQHZyGrJwhku/Em0h9sM
         RVQcS6KblTWlZ+5ZEBUmTDPyCpT7t0IXC7ZjYd6JvI3pNRsb2wlIaNpR0o4p7E6m4jrY
         llsw==
X-Gm-Message-State: AOAM533nUcttxtOoRSm6OtTYuwbIdOW4nonkQ33lmUfyRZfRSwxGgpKs
        +ILTqzU5r9ipqrz3Wp927g==
X-Google-Smtp-Source: ABdhPJyuqDfEj9pKyUgEYZRO+cysIrAtCQrOxTDCZeXzJp8d1Psmue13wAQH//FdOBy3lTptmkGmxw==
X-Received: by 2002:a92:d6c5:: with SMTP id z5mr15613014ilp.194.1590191315033;
        Fri, 22 May 2020 16:48:35 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH 01/15] PCI: cadence: Use struct pci_host_bridge.windows list directly
Date:   Fri, 22 May 2020 17:48:18 -0600
Message-Id: <20200522234832.954484-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's no need to create a temporary resource list and then splice it to
struct pci_host_bridge.windows list. Just use pci_host_bridge.windows
directly. The necessary clean-up is already handled by the PCI core.

Cc: Tom Joseph <tjoseph@cadence.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../controller/cadence/pcie-cadence-host.c    | 26 +++++--------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8c2543f28ba0..9f77e47983c3 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -169,14 +169,15 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 }
 
 static int cdns_pcie_host_init(struct device *dev,
-			       struct list_head *resources,
 			       struct cdns_pcie_rc *rc)
 {
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
 	struct resource *bus_range = NULL;
 	int err;
 
 	/* Parse our PCI ranges and request their resources */
-	err = pci_parse_request_of_pci_ranges(dev, resources, NULL, &bus_range);
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL,
+					      &bus_range);
 	if (err)
 		return err;
 
@@ -185,17 +186,9 @@ static int cdns_pcie_host_init(struct device *dev,
 
 	err = cdns_pcie_host_init_root_port(rc);
 	if (err)
-		goto err_out;
-
-	err = cdns_pcie_host_init_address_translation(rc);
-	if (err)
-		goto err_out;
-
-	return 0;
+		return err;
 
- err_out:
-	pci_free_resource_list(resources);
-	return err;
+	return cdns_pcie_host_init_address_translation(rc);
 }
 
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
@@ -204,7 +197,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
-	struct list_head resources;
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
@@ -248,11 +240,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	pcie->mem_res = res;
 
-	ret = cdns_pcie_host_init(dev, &resources, rc);
+	ret = cdns_pcie_host_init(dev, rc);
 	if (ret)
 		goto err_init;
 
-	list_splice_init(&resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->busnr = pcie->bus;
 	bridge->ops = &cdns_pcie_host_ops;
@@ -261,13 +252,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	ret = pci_host_probe(bridge);
 	if (ret < 0)
-		goto err_host_probe;
+		goto err_init;
 
 	return 0;
 
- err_host_probe:
-	pci_free_resource_list(&resources);
-
  err_init:
 	pm_runtime_put_sync(dev);
 
-- 
2.25.1

