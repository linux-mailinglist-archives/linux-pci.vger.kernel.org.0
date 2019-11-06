Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2ABF219D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 23:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbfKFWZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 17:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfKFWZj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 17:25:39 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA62D2166E;
        Wed,  6 Nov 2019 22:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573079139;
        bh=kQtOLA3B3nA3S+jkpxr7YQP3yBSf6AdbgOlbifPGyrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsVwAkiesIZj/bchIhj2En3MwR2U034qRkJP3vGBrIhQ/DlB5hJ2MBFXcPX9M6H1b
         S4eyyz5uFoNJVr03aJPhKxR31szwe45vxve7hpoZW0Dd2N4HjpKJJHs+ovxuFE88ln
         TUMkkDE1MxmvZmTqnvDO9KQOf9KkLPrXVj8TbrLo=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/5] PCI: Remove PCIe Kconfig dependencies on PCI
Date:   Wed,  6 Nov 2019 16:24:20 -0600
Message-Id: <20191106222420.10216-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106222420.10216-1-helgaas@kernel.org>
References: <20191106222420.10216-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

drivers/pci/pcie/Kconfig is only sourced by drivers/pci/Kconfig, and only
when PCI is defined, so there's no need to depend on PCI again.  Remove the
unnecessary dependencies.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index b196ad816129..207dac2fd588 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -4,7 +4,6 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express Port Bus support"
-	depends on PCI
 	help
 	  This enables PCI Express Port Bus support. Users can then enable
 	  support for Native Hot-Plug, Advanced Error Reporting, Power
@@ -63,7 +62,6 @@ config PCIE_ECRC
 #
 config PCIEASPM
 	bool "PCI Express ASPM control" if EXPERT
-	depends on PCI
 	default y
 	help
 	  This enables OS control over PCI Express ASPM (Active State
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

