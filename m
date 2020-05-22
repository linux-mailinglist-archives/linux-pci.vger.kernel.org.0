Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6221DF339
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgEVXsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:50 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42427 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgEVXst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:49 -0400
Received: by mail-il1-f195.google.com with SMTP id 18so12526249iln.9
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2p41fcnPOx/cmrCAPQSy3Fo8KrPmpfN6+RkySuTptI=;
        b=pU6pC7fpK+mexpvjTKHkGk0kcMmyiHXNZaTL8zwqPgTPOLzm9/Ub9aqGrz6CbpFKjP
         wM1SrTitSotL2gHIwGKah62m1BmnskGehJBPC8BY+CYKs5sfgzH+kiXLpTd87Lwktz80
         94zfrLa6XJ/xeGYfBl941Uo5C10ykpBRLYt5AqWccIWk+xav3nbeCoU2p7DVCtQq/XOv
         mCChcoUy8mRhVOTFz+tESkItEgHzGqwWipuuXLDoEY8BAZ9nGw3OjfUU7sih9WBct245
         RQASY82kK4N81KnzkKD2Iyurt3FOLWmTKvekLYUhA+zQgZPWDsRlsudaGahefwQVe/ty
         g97w==
X-Gm-Message-State: AOAM5312WTzFBMFcN3rEJh7Lwxc4mR27Z+wPkoL6fhOwz1Mt6c7zTCv/
        0rgCD5BZCYndCAM/Pe46mg==
X-Google-Smtp-Source: ABdhPJxJb8uMVFTBmE5EjVEFecM8hhfGGfXlSi7Mekr5euEb9ImK+hXgQFJSBd65bfpss/2gmn1F4A==
X-Received: by 2002:a92:8d49:: with SMTP id s70mr15410384ild.54.1590191328942;
        Fri, 22 May 2020 16:48:48 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 14/15] PCI: xilinx-nwl: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:31 -0600
Message-Id: <20200522234832.954484-15-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The xilinx-nwl host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

The only difference is pci_assign_unassigned_bus_resources() was called
instead of pci_bus_size_bridges() and pci_bus_assign_resources(). This
should be the same.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 9bd1427f2fd6..32a0b08d6da5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -817,8 +817,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct nwl_pcie *pcie;
-	struct pci_bus *bus;
-	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	int err;
 
@@ -871,17 +869,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = pci_scan_root_bus_bridge(bridge);
-	if (err)
-		return err;
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
 
 static struct platform_driver nwl_pcie_driver = {
-- 
2.25.1

