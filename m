Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75915325250
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 16:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBYPY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 10:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhBYPYV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 10:24:21 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD84864F11;
        Thu, 25 Feb 2021 15:23:39 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lFIII-00Fscv-RS; Thu, 25 Feb 2021 15:11:11 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 12/13] PCI: MSI: Document the various ways of ending up with NO_MSI
Date:   Thu, 25 Feb 2021 15:10:22 +0000
Message-Id: <20210225151023.3642391-13-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225151023.3642391-1-maz@kernel.org>
References: <20210225151023.3642391-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, bhelgaas@google.com, frank-w@public-files.de, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have now 4 ways of ending up with NO_MSI being set.
Document them.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/msi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d9c73c173c14..425abcdfcaca 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -871,8 +871,16 @@ static int pci_msi_supported(struct pci_dev *dev, int nvec)
 	 * Any bridge which does NOT route MSI transactions from its
 	 * secondary bus to its primary bus must set NO_MSI flag on
 	 * the secondary pci_bus.
-	 * We expect only arch-specific PCI host bus controller driver
-	 * or quirks for specific PCI bridges to be setting NO_MSI.
+	 *
+	 * The NO_MSI flag can either be set directly by:
+	 * - arch-specific PCI host bus controller drivers (deprecated)
+	 * - quirks for specific PCI bridges
+	 *
+	 * or indirectly by platform-specific PCI host bridge drivers by:
+	 * - unconditionally advertising the 'no_msi' property
+	 * - advertising the 'msi_domain' property, which results in
+	 *   the NO_MSI flag when no MSI domain is found for this bridge
+	 *   at probe time.
 	 */
 	for (bus = dev->bus; bus; bus = bus->parent)
 		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-- 
2.29.2

