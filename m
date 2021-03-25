Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3326349AEB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 21:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCYUTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 16:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhCYUTe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 16:19:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1142F61A0F;
        Thu, 25 Mar 2021 20:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616703574;
        bh=V+kflpqTpSB+V3oqvN9jcmu75KWvgN5QDpVmHHhdrS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o2NoDQ1ukgEiwLNIKp2wUV9UgOLX2GtQKqr2DfybDZ1jNWD+FOHNY9pq7AG0BwrWK
         S9xUrHJNQ6cIxelFobWQ6Et1mmBAh3UBE/cqHZNZNU1m9RNQqvkScbj88kRxsgpTHD
         GsSKx5mspmIp/X8EnHA7+d6/hWsQ/9q8hA0u1dxIIymfCM/VN/yZSL9g6dUrq/17LL
         xd2YbUy2/NCOV6jVLJod3ZF+EmvhiFkAdmEwRxC9oYZiVLZa5cCh1OJ5iFJKwUPLCb
         SeR7fEkAjq4bh99lkOLckAaUmg9DBL+vqG56SYgJPfAKBj6DTbyLsrkQ9lBQP9Ot4Z
         PtNGgDzTWG4rQ==
Date:   Thu, 25 Mar 2021 15:19:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        =?utf-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
Message-ID: <20210325201932.GA808102@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21daa79d-cdb3-f31c-0fbf-5d653de02517@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 10:24:28AM +0100, Marek Szyprowski wrote:
> On 25.01.2021 05:48, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > In the dw_pcie_ep_init(), it depends on the detected iATU region
> > numbers to allocate the in/outbound window management bit map.
> > It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
> > of iATU windows").
> >
> > So this patch move the iATU region detection into a new function,
> > move forward the detection to the very beginning of functions
> > dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
> > from the dw_pcie_setup(), since it's more like a software
> > perspective initialization step than hardware setup.
> >
> > Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch causes exynos-pcie to hang during the initialization. It 
> looks that some resources are not enabled yet, so calling 
> dw_pcie_iatu_detect() much earlier causes a hang. When I have some time, 
> I will try to identify what is needed to call it properly.

Thanks, I dropped it for now.  We can add it back after we figure out
what the exynos issue is.

For reference, here's the patch I dropped (I had made some minor
corrections to the commit log):

commit fd4162f05194 ("PCI: dwc: Move iATU detection earlier")
Author: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Date:   Mon Jan 25 12:48:03 2021 +0800

    PCI: dwc: Move iATU detection earlier
    
    dw_pcie_ep_init() depends on the detected iATU region numbers to allocate
    the in/outbound window management bitmap.  It fails after 281f1f99cf3a
    ("PCI: dwc: Detect number of iATU windows").
    
    Move the iATU region detection into a new function, move the detection to
    the very beginning of dw_pcie_host_init() and dw_pcie_ep_init().  Also
    remove it from the dw_pcie_setup(), since it's more like a software
    initialization step than hardware setup.
    
    Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
    Link: https://lore.kernel.org/r/20210125044803.4310-1-Zhiqiang.Hou@nxp.com
    Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Cc: stable@vger.kernel.org	# v5.11+

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1c25d8337151..8d028a88b375 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -705,6 +705,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		}
 	}
 
+	dw_pcie_iatu_detect(pci);
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
 		return -EINVAL;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7e55b2b66182..52f6887179cd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -319,6 +319,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			return PTR_ERR(pci->dbi_base);
 	}
 
+	dw_pcie_iatu_detect(pci);
+
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 004cb860e266..a945f0c0e73d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -660,11 +660,9 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 	pci->num_ob_windows = ob;
 }
 
-void dw_pcie_setup(struct dw_pcie *pci)
+void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
-	u32 val;
 	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 
 	if (pci->version >= 0x480A || (!pci->version &&
@@ -693,6 +691,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
 
 	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound",
 		 pci->num_ob_windows, pci->num_ib_windows);
+}
+
+void dw_pcie_setup(struct dw_pcie *pci)
+{
+	u32 val;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 
 	if (pci->link_gen > 0)
 		dw_pcie_link_set_max_speed(pci, pci->link_gen);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7247c8b01f04..7d6e9b7576be 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -306,6 +306,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 			 enum dw_pcie_region_type type);
 void dw_pcie_setup(struct dw_pcie *pci);
+void dw_pcie_iatu_detect(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
