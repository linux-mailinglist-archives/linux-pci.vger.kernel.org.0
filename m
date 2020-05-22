Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72F11DF333
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgEVXsp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46669 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgEVXso (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:44 -0400
Received: by mail-io1-f65.google.com with SMTP id j8so13282692iog.13
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esB6b61apNwpYj2Ii2qJBKmfmJ2cKVbjKA7d7D0yxhA=;
        b=KMAXyptnOOV365s46hLTHSJ/N4D0wcAkoPvpeBpl3O75WqWvmLSyLfyGwVC0wDf0Xm
         OWODfjyGLTck76RMFi0f/vAbMGV+AKXW8EC9c5SDBvjVKuo++hrCQYJwOSm0YKcu7JJX
         vs3IF3tCPrqq4luhrl6tQ33YVsn9ypfTHW0LiNS1l88rKKmnwDugwh36LCtIdoCXUem4
         9WMbARaUZKN+Ui2Ms/Ge9dPFENLPf9OVGfzViw5eWfW9qJqxB9Ll79f95JsNDKCS1sGE
         zA80h5k4QuKUR4FRcE9uTC2SF5+8m7oSoeES3PzY0kIzJzWr3DcKtmAXKxe6OP+lEgQI
         uQyQ==
X-Gm-Message-State: AOAM530kUuI8gmf9VqbcWa/8X4nyTIWY3D3f54VVg2bd8EVveAN50ybZ
        riAocRyHCDaGCcfKvNg+8w==
X-Google-Smtp-Source: ABdhPJyNYc9vzogrqFrsqVMURFj3X5uQdcgBg6RgjMS5Fz1B6QbL79L43BEqeIa+lFhIECyX99pQFw==
X-Received: by 2002:a6b:5008:: with SMTP id e8mr5162852iob.161.1590191323471;
        Fri, 22 May 2020 16:48:43 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Toan Le <toan@os.amperecomputing.com>
Subject: [PATCH 09/15] PCI: xgene: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:26 -0600
Message-Id: <20200522234832.954484-10-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The xgene host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

Cc: Toan Le <toan@os.amperecomputing.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-xgene.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index d1efa8ffbae1..5aee802946cb 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -591,7 +591,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
 	struct xgene_pcie_port *port;
-	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	int ret;
 
@@ -632,17 +631,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0)
-		return ret;
-
-	bus = bridge->bus;
-
-	pci_assign_unassigned_bus_resources(bus);
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-	pci_bus_add_devices(bus);
-	return 0;
+	return pci_host_probe(bridge);
 }
 
 static const struct of_device_id xgene_pcie_match_table[] = {
-- 
2.25.1

