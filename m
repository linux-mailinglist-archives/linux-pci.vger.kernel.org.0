Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5744311D9F6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 00:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfLLXXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 18:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbfLLXXr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 18:23:47 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBFB3214AF;
        Thu, 12 Dec 2019 23:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576193026;
        bh=yk+/M0nJ4PfmvireB1Lja4UEYPIAhwz8DkV+s/A0xZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EuIwmU/xnrRRcxwco9wNhlRXdZzAeiqSVxr/7TPD+RJRhXxdDulLhbhee1UIvDlGZ
         RSGmxTciRWRT2O58h4FJscNT0UaeBq0Bfrjn9WSAxtEhVpisbZ6gVroMz3rZQgDnnO
         XFNZOpJe48Y97vdvRiIHf2esOu1952JNC2RMWvX4=
Date:   Thu, 12 Dec 2019 17:23:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, rjui@broadcom.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: iproc: move quirks to driver
Message-ID: <20191212232344.GA36928@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211223438.GA121846@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 04:34:38PM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 11, 2019 at 05:45:11PM +0000, Wei Liu wrote:
> > The quirks were originally enclosed by ifdef. That made the quirks not
> > to be applied when respective drivers were compiled as modules.
> > 
> > Move the quirks to driver code to fix the issue.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> 
> This straddles the core and native driver boundary, so I applied it to
> pci/misc for v5.6.  Thanks, I think this is a great solution!  It's
> always nice when we can encapsulate device-specific things in a
> driver.

OK, I moved this to pcie-iproc.c:

commit 574f29036fce ("PCI: iproc: Apply quirk_paxc_bridge() for module as well as built-in")
Author: Wei Liu <wei.liu@kernel.org>
Date:   Wed Dec 11 17:45:11 2019 +0000

    PCI: iproc: Apply quirk_paxc_bridge() for module as well as built-in
    
    Previously quirk_paxc_bridge() was applied when the iproc driver was
    built-in, but not when it was compiled as a module.
    
    This happened because it was under #ifdef CONFIG_PCIE_IPROC_PLATFORM:
    PCIE_IPROC_PLATFORM=y causes CONFIG_PCIE_IPROC_PLATFORM to be defined, but
    PCIE_IPROC_PLATFORM=m causes CONFIG_PCIE_IPROC_PLATFORM_MODULE to be
    defined.
    
    Move quirk_paxc_bridge() to pcie-iproc.c and drop the #ifdef so the quirk
    is always applied, whether iproc is built-in or a module.
    
    [bhelgaas: commit log, move to pcie-iproc.c, not pcie-iproc-platform.c]
    Link: https://lore.kernel.org/r/20191211174511.89713-1-wei.liu@kernel.org
    Signed-off-by: Wei Liu <wei.liu@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 0a468c73bae3..8c7f875acf7f 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1588,6 +1588,30 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804,
 			quirk_paxc_disable_msi_parsing);
 
+static void quirk_paxc_bridge(struct pci_dev *pdev)
+{
+	/*
+	 * The PCI config space is shared with the PAXC root port and the first
+	 * Ethernet device.  So, we need to workaround this by telling the PCI
+	 * code that the bridge is not an Ethernet device.
+	 */
+	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
+
+	/*
+	 * MPSS is not being set properly (as it is currently 0).  This is
+	 * because that area of the PCI config space is hard coded to zero, and
+	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
+	 * so that the MPS can be set to the real max value.
+	 */
+	pdev->pcie_mpss = 2;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
+
 MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
 MODULE_DESCRIPTION("Broadcom iPROC PCIe common driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..202837ed68c9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2381,32 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
 			 PCI_DEVICE_ID_TIGON3_5719,
 			 quirk_brcm_5719_limit_mrrs);
 
-#ifdef CONFIG_PCIE_IPROC_PLATFORM
-static void quirk_paxc_bridge(struct pci_dev *pdev)
-{
-	/*
-	 * The PCI config space is shared with the PAXC root port and the first
-	 * Ethernet device.  So, we need to workaround this by telling the PCI
-	 * code that the bridge is not an Ethernet device.
-	 */
-	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
-
-	/*
-	 * MPSS is not being set properly (as it is currently 0).  This is
-	 * because that area of the PCI config space is hard coded to zero, and
-	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
-	 * so that the MPS can be set to the real max value.
-	 */
-	pdev->pcie_mpss = 2;
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
-#endif
-
 /*
  * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
  * hide device 6 which configures the overflow device access containing the
