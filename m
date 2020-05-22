Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C361DF33A
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgEVXsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34652 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbgEVXsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:50 -0400
Received: by mail-io1-f68.google.com with SMTP id f3so13379897ioj.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jGQ2qLaDHXWpsTIu58oRNqkVRMoBCOunQH7NWW7la4=;
        b=Qlvnfh922FtfUyuYgA3cwoh7HgVi1+PrBIo2BHst7Yzg4czpYDrmiDJ1dq1BgoYn5T
         mjes2aofIUDUGrPYhiMfbNSSNYQi3aEVYR0Zdn1Zywio2+TbFVkCIiKnqw2bgzpQQcGz
         tFXEdGRZ8/a3GNGDM2oQvVuS2L3Ge4tA7zL4Dx+VA69342XiC0M7FXmaW9geka7LmjOw
         q7b4yVVg3xyM3A+WNvAM7gWrw3HyieRbY8yfA2879tqLsMx06LcpLAEW/pCNT+QC09oa
         V6+idiUR9ttbxFHbQE8sCGr5+qpz6O+KsiqzDXfMewjv/bBSzK5LCbIINVmvuU83uR9p
         zpkg==
X-Gm-Message-State: AOAM530ekscd+IMkB/Yz57DbKGXAX4WJt6wF5t2HxysuI4DDBQisxaRc
        O2N4If4XzcchXCgTU5w+eA==
X-Google-Smtp-Source: ABdhPJwZp9OVv7GaJiib7zatMqtlUftLOWe6s4BgpqKdDy0qd/frFOVmsmEYghU2qvA8+UlgAn3+0g==
X-Received: by 2002:a05:6602:44b:: with SMTP id e11mr5183523iov.62.1590191329933;
        Fri, 22 May 2020 16:48:49 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 15/15] PCI: xilinx: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:32 -0600
Message-Id: <20200522234832.954484-16-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The xilinx host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

The only difference is pci_assign_unassigned_bus_resources() was called
instead of pci_bus_size_bridges() and pci_bus_assign_resources(). This
should be the same.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-xilinx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 98e55297815b..05547497f391 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -616,7 +616,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct xilinx_pcie_port *port;
-	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	int err;
 
@@ -663,17 +662,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	xilinx_pcie_msi_chip.dev = dev;
 	bridge->msi = &xilinx_pcie_msi_chip;
 #endif
-	err = pci_scan_root_bus_bridge(bridge);
-	if (err < 0)
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
 
 static const struct of_device_id xilinx_pcie_of_match[] = {
-- 
2.25.1

