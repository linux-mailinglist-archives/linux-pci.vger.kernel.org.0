Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D911DF32E
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbgEVXsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42509 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgEVXsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:40 -0400
Received: by mail-io1-f68.google.com with SMTP id d5so3835108ios.9
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDGTHJtHoujJlH0xuipOO/+33SMsAgY/ZHK2re0dJMA=;
        b=pOYL+cVma5GK+8zc8ssnTtw+zaw7UXDjGEhmK3NMEAlunh1uyBdrAgfSPWwfYrbCp+
         xDf7vdSsEkwASOxE6M7VAAUH1gficeWC2MSWD+5F0EaA5AuxZrKYbB8Pe5t3V6TLEjzi
         lHalcEQShUxbkPrOpakmS/7B7o9iHtzYFf6dl77l8VrHhjWXE94OhGiYy7LjLxDAS1Tb
         a1nyXtumGxbHLyTnsJXo+Xz90EZRPemO1H80D1iE9bvTjCKkH1Fs547R+pzQa9R7nmXw
         8j8yPUI3qze18zow0HPlaRuf7/6ZBE5+ac04AEc4sQga/I9FTg15zgRRIK32GK2Ixbdr
         B8JA==
X-Gm-Message-State: AOAM532gtAbZi+g4jNAMQqVzSl7jVf7dranPQUDkvJKQlI0tt+hQcIUU
        ZDjM76+bBPy+9e45ZGsYNg==
X-Google-Smtp-Source: ABdhPJyqxau5tXcv4nxZOzDxI5Uzfaw3Xu8Y/R/qSeDfpABcMfVTrSAct3cO36GKdKu07xo63/tr1g==
X-Received: by 2002:a5d:8a01:: with SMTP id w1mr5106567iod.71.1590191319312;
        Fri, 22 May 2020 16:48:39 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:38 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 05/15] PCI: mobiveil: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:22 -0600
Message-Id: <20200522234832.954484-6-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The mobiveil host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/mobiveil/pcie-mobiveil-host.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 5907baa9b1f2..5974619811ec 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -569,8 +569,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	struct mobiveil_root_port *rp = &pcie->rp;
 	struct pci_host_bridge *bridge = rp->bridge;
 	struct device *dev = &pcie->pdev->dev;
-	struct pci_bus *bus;
-	struct pci_bus *child;
 	int ret;
 
 	ret = mobiveil_pcie_parse_dt(pcie);
@@ -620,17 +618,5 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 		return ret;
 	}
 
-	/* setup the kernel resources for the newly added PCIe root bus */
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret)
-		return ret;
-
-	bus = bridge->bus;
-
-	pci_assign_unassigned_bus_resources(bus);
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-	pci_bus_add_devices(bus);
-
-	return 0;
+	return pci_host_probe(bridge);
 }
-- 
2.25.1

