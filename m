Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B42E5504
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 22:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJYUUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 16:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfJYUUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 16:20:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC94D21D81;
        Fri, 25 Oct 2019 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572034816;
        bh=n6IuL5NT84NRdDBMzq5N2XWRhRMjsUq7P3Szh+BtIGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gJ+2dxRDAfY9Kig49YlagePxiTr7gkDHH0fmrpH6UslJwD9yt26aEXnsJdGr0Rt3z
         TQPk/R0YYQ/PE2arNWMMM2yRacdmPkP/icnRG+HLt+TyuGx9lE3Y+03gyMhYbG4qy/
         ruUgemKAkWRE/TynwQ3uHOFmC2/Dc5aPVc5a8R2k=
Date:   Fri, 25 Oct 2019 15:20:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring
 back old behavior
Message-ID: <20191025202004.GA147688@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023192205.97024-1-olof@lixom.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 12:22:05PM -0700, Olof Johansson wrote:
> In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
> the behavior was changed such that native (kernel) handling of DPC
> got tied to whether the kernel also handled AER. While this is what
> the standard recommends, there are BIOSes out there that lack the DPC
> handling since it was never required in the past.

Some systems do not grant OS control of AER via _OSC.  I guess the
problem is that on those systems, the OS DPC driver used to work, but
after eed85ff4c0da7, it does not.  Right?

We should also update negotiate_os_control() to request control of DPC
via _OSC.  Kuppuswamy's patch [1] does that but hasn't been merged
yet.  That will conflict with this, but I can resolve that.

I applied this as below (with the nits Keith noticed) to pci/aer for
v5.5, thanks!

[1] https://lore.kernel.org/r/b638cbd3e122b4c7a58b949d7224230d2c4b34d4.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com

commit 35a0b2378c19
Author: Olof Johansson <olof@lixom.net>
Date:   Wed Oct 23 12:22:05 2019 -0700

    PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control
    
    Prior to eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
    Linux handled DPC events regardless of whether firmware had granted it
    ownership of AER or DPC, e.g., via _OSC.
    
    PCIe r5.0, sec 6.2.10, recommends that the OS link control of DPC to
    control of AER, so after eed85ff4c0da7, Linux handles DPC events only if it
    has control of AER.
    
    On platforms that do not grant OS control of AER via _OSC, Linux DPC
    handling worked before eed85ff4c0da7 but not after.
    
    To make Linux DPC handling work on those platforms the same way they did
    before, add a "pcie_ports=dpc-native" kernel parameter that makes Linux
    handle DPC events regardless of whether it has control of AER.
    
    [bhelgaas: commit log, move pcie_ports_dpc_native to drivers/pci/]
    Link: https://lore.kernel.org/r/20191023192205.97024-1-olof@lixom.net
    Signed-off-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7ac2f3ac99f..806c89f79be8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3540,6 +3540,8 @@
 			even if the platform doesn't give the OS permission to
 			use them.  This may cause conflicts if the platform
 			also tries to use these services.
+		dpc-native	Use native PCIe service for DPC only.  May
+				cause conflicts if firmware uses AER or DPC.
 		compat	Disable native PCIe services (PME, AER, DPC, PCIe
 			hotplug).
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a32ec3487a8d..e06f42f58d3d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -291,7 +291,7 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev))
+	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
 	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 944827a8c7d3..1e673619b101 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -25,6 +25,8 @@
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
 
+extern bool pcie_ports_dpc_native;
+
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
 #else
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 1b330129089f..5075cb9e850c 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -250,8 +250,13 @@ static int get_port_device_capability(struct pci_dev *dev)
 		pcie_pme_interrupt_enable(dev, false);
 	}
 
+	/*
+	 * With dpc-native, allow Linux to use DPC even if it doesn't have
+	 * permission to use AER.
+	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
+	    pci_aer_available() &&
+	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0a87091a0800..160d67c59310 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -29,12 +29,20 @@ bool pcie_ports_disabled;
  */
 bool pcie_ports_native;
 
+/*
+ * If the user specified "pcie_ports=dpc-native", use the Linux DPC PCIe
+ * service even if the platform hasn't given us permission.
+ */
+bool pcie_ports_dpc_native;
+
 static int __init pcie_port_setup(char *str)
 {
 	if (!strncmp(str, "compat", 6))
 		pcie_ports_disabled = true;
 	else if (!strncmp(str, "native", 6))
 		pcie_ports_native = true;
+	else if (!strncmp(str, "dpc-native", 10))
+		pcie_ports_dpc_native = true;
 
 	return 1;
 }
