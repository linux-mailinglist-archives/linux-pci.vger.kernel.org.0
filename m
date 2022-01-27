Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA149EE15
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 23:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiA0W3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 17:29:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43052 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbiA0W3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 17:29:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D0661BE7;
        Thu, 27 Jan 2022 22:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0079DC340E4;
        Thu, 27 Jan 2022 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643322593;
        bh=2A1Qz0GfrPyGcogA96dHYkOffh2OD1gRCsT/yYZhCRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WQDfuj+H1ddbhDrcKs5pElGAYXWaeV06tQuylU55u+ZXetQSTaH8GNhDgqSeyv9dG
         2BfJwtJeTHLIylQkV5XAMMUYputYwpNQufwX+3p1Ip34ztsx9gcIH+qv6MVEo4w7Up
         WCWDW+fUulV6sP0rZVk5O8FB+qLVkSh6B85GivODMTnfDyK4rQ55BPIt3xxBriQpUI
         Nwxp6yBDM41a40bb6L2hd5btFdA/Nh5uu5bvtmhBNhFBvFOhDaJZEgO6OYuLzm4Q6g
         rsT0PjdG9xShjFKzUFEUEWzDJyUZfYGI4BTEqoWF67vVKRpFu0L7JDT502XCFPn+SQ
         6jrLkM0+THcXg==
Date:   Thu, 27 Jan 2022 16:29:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Revert "PCI: j721e: Drop redundant struct device *"
Message-ID: <20220127222951.GA144828@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124122132.435743-1-christian.gmeiner@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 24, 2022 at 01:21:22PM +0100, Christian Gmeiner wrote:
> This reverts commit 19e863828acf6d8ac8475ba1fd93c0fe17fdc4ef.
> 
> Fixes the following oops:
>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010

Hi Christian,

Would you mind trying this patch?

commit 9d36a93af8fe ("PCI: j721e: Initialize pcie->cdns_pcie before using it")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Jan 27 15:49:49 2022 -0600

    PCI: j721e: Initialize pcie->cdns_pcie before using it
    
    Christian reported a NULL pointer dereference in j721e_pcie_probe() caused
    by 19e863828acf ("PCI: j721e: Drop redundant struct device *"), which
    removed struct j721e_pcie.dev since there's another copy in struct
    cdns_pcie.dev reachable via j721e_pcie->cdns_pcie->dev.
    
    The problem is that j721e_pcie->cdns_pcie was dereferenced before being
    initialized:
    
      j721e_pcie_probe
        pcie = devm_kzalloc()             # struct j721e_pcie
        j721e_pcie_ctrl_init(pcie)
          dev = pcie->cdns_pcie->dev      <-- dereference cdns_pcie
        switch (mode) {
        case PCI_MODE_RC:
          cdns_pcie = ...                 # alloc as part of pci_host_bridge
          pcie->cdns_pcie = cdns_pcie     <-- initialize pcie->cdns_pcie
    
    Initialize pcie->cdns_pcie before it is used.
    
    Fixes: 19e863828acf ("PCI: j721e: Drop redundant struct device *")
    Reported-by: Christian Gmeiner <christian.gmeiner@gmail.com>
    Link: https://lore.kernel.org/r/20220124122132.435743-1-christian.gmeiner@gmail.com
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 489586a4cdc7..5d950c1d9fd0 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -372,10 +372,48 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	mode = (u32)data->mode;
 
+	switch (mode) {
+	case PCI_MODE_RC:
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
+			return -ENODEV;
+
+		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+		if (!bridge)
+			return -ENOMEM;
+
+		if (!data->byte_access_allowed)
+			bridge->ops = &cdns_ti_pcie_host_ops;
+		rc = pci_host_bridge_priv(bridge);
+		rc->quirk_retrain_flag = data->quirk_retrain_flag;
+		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
+
+		cdns_pcie = &rc->pcie;
+		break;
+	case PCI_MODE_EP:
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP))
+			return -ENODEV;
+
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep)
+			return -ENOMEM;
+
+		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
+
+		cdns_pcie = &ep->pcie;
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", mode);
+		return 0;
+	}
+
+	cdns_pcie->dev = dev;
+	cdns_pcie->ops = &j721e_pcie_ops;
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
+	pcie->cdns_pcie = cdns_pcie;
 	pcie->mode = mode;
 	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
 
@@ -426,28 +464,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case PCI_MODE_RC:
-		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)) {
-			ret = -ENODEV;
-			goto err_get_sync;
-		}
-
-		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
-		if (!bridge) {
-			ret = -ENOMEM;
-			goto err_get_sync;
-		}
-
-		if (!data->byte_access_allowed)
-			bridge->ops = &cdns_ti_pcie_host_ops;
-		rc = pci_host_bridge_priv(bridge);
-		rc->quirk_retrain_flag = data->quirk_retrain_flag;
-		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
-
-		cdns_pcie = &rc->pcie;
-		cdns_pcie->dev = dev;
-		cdns_pcie->ops = &j721e_pcie_ops;
-		pcie->cdns_pcie = cdns_pcie;
-
 		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 		if (IS_ERR(gpiod)) {
 			ret = PTR_ERR(gpiod);
@@ -497,23 +513,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		break;
 	case PCI_MODE_EP:
-		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP)) {
-			ret = -ENODEV;
-			goto err_get_sync;
-		}
-
-		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
-		if (!ep) {
-			ret = -ENOMEM;
-			goto err_get_sync;
-		}
-		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
-
-		cdns_pcie = &ep->pcie;
-		cdns_pcie->dev = dev;
-		cdns_pcie->ops = &j721e_pcie_ops;
-		pcie->cdns_pcie = cdns_pcie;
-
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
 			dev_err(dev, "Failed to init phy\n");
@@ -525,8 +524,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_pcie_setup;
 
 		break;
-	default:
-		dev_err(dev, "INVALID device type %d\n", mode);
 	}
 
 	return 0;
