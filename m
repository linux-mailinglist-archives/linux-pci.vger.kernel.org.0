Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38027DA24
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgI2Vb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2Vb4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 17:31:56 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9802075E;
        Tue, 29 Sep 2020 21:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601415115;
        bh=gzFmxT/6qmRw+vWd7neiLPEnz55xC18T5I9oR0epPQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=biK92FkJ5NO8eo4zPyCqvnlWe1Yt3MLOicMFgBva2Q03CECFAc/BCvqfLEgK7xyZS
         n/xueHrZ4FMwD3oxXt2YgJZuUawZVQGCl2Lqv1pXVTYUpiPe3xLqhJOt2MUvHNc+tE
         zxrnAEpq7sJsCVijoI3emJcmeU1S6W2xMBeD4y4A=
Date:   Tue, 29 Sep 2020 16:31:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build
 time
Message-ID: <20200929213153.GA2578412@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928194651.5393-2-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> The Kconfig is modified so that the pcie_bus_config setting can be done at
> build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> pci_bus_config setting may still be overridden by the bootline param.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Applied to pci/enumeration for v5.10, thanks!

I tweaked the help texts and made the Kconfig stuff depend on
CONFIG_EXPERT.  Will that still be enough for what you need?  I'm
worried that users will get themselves in trouble if they fiddle with
things without really understanding what's going on.

Here's what I applied:


commit 2a87f534d198 ("PCI: Add Kconfig options for pcie_bus_config")
Author: Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon Sep 28 15:46:51 2020 -0400

    PCI: Add Kconfig options for pcie_bus_config
    
    Add Kconfig options for changing the default pcie_bus_config in the same
    manner as the CONFIG_PCIEASPM_XXXX choice.  The pci_bus_config setting may
    still be overridden by kernel command-line parameters, e.g.,
    "pci=pcie_bus_tune_off".
    
    [bhelgaas: depend on EXPERT, tweak help texts]
    Link: https://lore.kernel.org/r/20200928194651.5393-2-james.quinlan@broadcom.com
    Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4bef5c2bae9f..d323b25ae27e 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -187,6 +187,68 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+choice
+	prompt "PCI Express hierarchy optimization setting"
+	default PCIE_BUS_DEFAULT
+	depends on PCI && EXPERT
+	help
+	  MPS (Max Payload Size) and MRRS (Max Read Request Size) are PCIe
+	  device parameters that affect performance and the ability to
+	  support hotplug and peer-to-peer DMA.
+
+	  The following choices set the MPS and MRRS optimization strategy
+	  at compile-time.  The choices are the same as those offered for
+	  the kernel command-line parameter 'pci', i.e.,
+	  'pci=pcie_bus_tune_off', 'pci=pcie_bus_safe',
+	  'pci=pcie_bus_perf', and 'pci=pcie_bus_peer2peer'.
+
+	  This is a compile-time setting and can be overridden by the above
+	  command-line parameters.  If unsure, choose PCIE_BUS_DEFAULT.
+
+config PCIE_BUS_TUNE_OFF
+	bool "Tune Off"
+	depends on PCI
+	help
+	  Use the BIOS defaults; don't touch MPS at all.  This is the same
+	  as booting with 'pci=pcie_bus_tune_off'.
+
+config PCIE_BUS_DEFAULT
+	bool "Default"
+	depends on PCI
+	help
+	  Default choice; ensure that the MPS matches upstream bridge.
+
+config PCIE_BUS_SAFE
+	bool "Safe"
+	depends on PCI
+	help
+	  Use largest MPS that boot-time devices support.  If you have a
+	  closed system with no possibility of adding new devices, this
+	  will use the largest MPS that's supported by all devices.  This
+	  is the same as booting with 'pci=pcie_bus_safe'.
+
+config PCIE_BUS_PERFORMANCE
+	bool "Performance"
+	depends on PCI
+	help
+	  Use MPS and MRRS for best performance.  Ensure that a given
+	  device's MPS is no larger than its parent MPS, which allows us to
+	  keep all switches/bridges to the max MPS supported by their
+	  parent.  This is the same as booting with 'pci=pcie_bus_perf'.
+
+config PCIE_BUS_PEER2PEER
+	bool "Peer2peer"
+	depends on PCI
+	help
+	  Set MPS = 128 for all devices.  MPS configuration effected by the
+	  other options could cause the MPS on one root port to be
+	  different than that of the MPS on another, which may cause
+	  hot-added devices or peer-to-peer DMA to fail.  Set MPS to the
+	  smallest possible value (128B) system-wide to avoid these issues.
+	  This is the same as booting with 'pci=pcie_bus_peer2peer'.
+
+endchoice
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a458c46d7e39..49b66ba7c874 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
+
+/* PCIE bus config, can be overridden by bootline param */
+#ifdef CONFIG_PCIE_BUS_TUNE_OFF
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
+#elif defined CONFIG_PCIE_BUS_SAFE
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
+#elif defined CONFIG_PCIE_BUS_PERFORMANCE
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
+#elif defined CONFIG_PCIE_BUS_PEER2PEER
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
+#else
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
+#endif
 
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
