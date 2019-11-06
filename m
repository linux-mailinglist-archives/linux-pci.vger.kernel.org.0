Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F3F2199
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 23:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKFWZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 17:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfKFWZe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 17:25:34 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C81521848;
        Wed,  6 Nov 2019 22:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573079133;
        bh=38YTlOFF2LwXTtqqi0l0MmFmAxPVKs8CCcWEJ81Bo30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnBo0iM5B0woiOYVuklG9j/bVyoCK5feTzs5egucalAaCQ4o3ko0w+hPXwxti67Na
         eFDKNuWsJB3hbXvJp6BH4WprvhImPLtmerjHsNrn8n0Mb3zsL0sTWVljS3BxWR2ltg
         Cea9dR1KLyeV93EugjhoTJTA/QZrmFOtT1rXG8mo=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Yong <jonathan.yong@intel.com>
Subject: [PATCH 2/5] PCI/PTM: Remove dependency on PCIEPORTBUS
Date:   Wed,  6 Nov 2019 16:24:18 -0600
Message-Id: <20191106222420.10216-3-helgaas@kernel.org>
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

The PTM support does not depend on the portdrv, so remove the Kconfig
dependency.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Yong <jonathan.yong@intel.com>
---
 drivers/pci/pcie/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 362eb8cfa53b..b0d781d72d1b 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -135,7 +135,6 @@ config PCIE_DPC
 
 config PCIE_PTM
 	bool "PCI Express Precision Time Measurement support"
-	depends on PCIEPORTBUS
 	help
 	  This enables PCI Express Precision Time Measurement (PTM)
 	  support.
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

