Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68C3331221
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 16:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhCHP1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 10:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231571AbhCHP0j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Mar 2021 10:26:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D05436526A;
        Mon,  8 Mar 2021 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615217199;
        bh=Y5COv6YVXEpvFCb0uNokbziozo2rYLvioVJb3NmKXXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvRK8TaMzxNKHhx2tYdLswzAW9t6Aw6EWI+MwceDnbx+tk1V24s2ZWoZmpsz1Kmdt
         fG10PDrY20DVa0a4DDlAoqHFjAfCcLoRxPvax4718zaKeAIO1DtFtT+T9reMeogaUY
         Azm/AZUkfgVQLex7QEvlfdV6iRQaRKvdJj1tJkSyxxYQA+FAvWetDAPkHFV4hxpeo9
         nBZevnZ+ihSBBQQO4dLPTAHquxXkGqsuYELU6sH6rWEfYNcVAneBy2S2HV0BauT1t8
         2KHTKpHRuZddebYo+n66bzc/EKYdESby1mKbBZfMWHe2UrftJ4rC0ITR2YNbTfoG+2
         JWa3eH3Bvj/Xg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Robert Richter <rric@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [RESEND] PCI: controller: avoid building empty drivers
Date:   Mon,  8 Mar 2021 16:24:48 +0100
Message-Id: <20210308152501.2135937-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308152501.2135937-1-arnd@kernel.org>
References: <20210308152501.2135937-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are harmless warnings when compile testing the kernel with
CONFIG_TRIM_UNUSED_KSYMS:

drivers/pci/controller/dwc/pcie-al.o: no symbols
drivers/pci/controller/pci-thunder-ecam.o: no symbols
drivers/pci/controller/pci-thunder-pem.o: no symbols

The problem here is that the host drivers get built even when the
configuration symbols are all disabled, as they pretend to not be drivers
but are silently enabled because of the promise that ACPI based systems
need no drivers.

Add back the normal symbols to have these drivers built, and change the
logic to otherwise only build them when both CONFIG_PCI_QUIRKS and
CONFIG_ACPI are enabled.

As a side-effect, this enables compile-testing the drivers on other
architectures, which in turn needs the acpi_get_rc_resources()
function to be defined.

Reviewed-by: Robert Richter <rric@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/Makefile     | 7 ++++++-
 drivers/pci/controller/dwc/Makefile | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index e4559f2182f2..6d24a163033f 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -11,10 +11,13 @@ obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
 obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
+obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
+obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
 obj-$(CONFIG_PCIE_XILINX_CPM) += pcie-xilinx-cpm.o
 obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
+obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
 obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
 obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
@@ -47,8 +50,10 @@ obj-y				+= mobiveil/
 # ARM64 and use internal ifdefs to only build the pieces we need
 # depending on whether ACPI, the DT driver, or both are enabled.
 
-ifdef CONFIG_PCI
+ifdef CONFIG_ACPI
+ifdef CONFIG_PCI_QUIRKS
 obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
 obj-$(CONFIG_ARM64) += pci-thunder-pem.o
 obj-$(CONFIG_ARM64) += pci-xgene.o
 endif
+endif
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a751553fa0db..ba7c42f6df6f 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -31,7 +31,12 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 # ARM64 and use internal ifdefs to only build the pieces we need
 # depending on whether ACPI, the DT driver, or both are enabled.
 
-ifdef CONFIG_PCI
+obj-$(CONFIG_PCIE_AL) += pcie-al.o
+obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+
+ifdef CONFIG_ACPI
+ifdef CONFIG_PCI_QUIRKS
 obj-$(CONFIG_ARM64) += pcie-al.o
 obj-$(CONFIG_ARM64) += pcie-hisi.o
 endif
+endif
-- 
2.29.2

