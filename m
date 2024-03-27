Return-Path: <linux-pci+bounces-5298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3FB88F146
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 22:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB381C30A27
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 21:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2BC153BE1;
	Wed, 27 Mar 2024 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIrybzyx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214A153BD8;
	Wed, 27 Mar 2024 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576121; cv=none; b=aeMkFcwgynlswuYTyMfISIGFCOBlrdTt3fu1UG3S9KmZe0/XAJ8vw0JY5kv04Er0xtInfSyWbkOVsBS/mWVTuuNYcyPS35zL7aTQpbrUzT3Tw1IPYvNECXKx4vrsi5t8f2RP32+zLd5WzmPodCHa+1U5buOixS3P3ZY+WxP1qrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576121; c=relaxed/simple;
	bh=v2BT4UBipgbf5NwZ/1uQCPFkKMYGJLIBNZ8gTeusg0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MuccACsvOxB92lHf3bGD6GzqdgrusKXE5K2JpqW5MVc8uhM18HdH36jXjNVmf98pWrqL14RioVGaUmIA3HIP0j34DHGZBEn2T1QcWyVjjph3cyUdC186gEXk4BETMTLnCI6RU1koX1wbaKdSsPtn5hWr+AwN0vNFKUDFDKdnkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIrybzyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58A0C43394;
	Wed, 27 Mar 2024 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711576121;
	bh=v2BT4UBipgbf5NwZ/1uQCPFkKMYGJLIBNZ8gTeusg0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIrybzyxD/r6vPtLYB9RgY2NIjkmaNefdNocv+sRqxL7TYvpAt1r2qsMLgxvLElgW
	 MbU/19c/1c3LouFayMk2tH52ZwP5ZzYVeRbUX3YfTdxkwXikfVu3CZ6cpEBXzTYTqT
	 irv+wfY9JGhUMCxXMZgmNLWYtha6JWK1ZuhRU06FBXP4+/3TPGVzHK9zXLLXU0s3WM
	 jcoQVnbOzk/j8Nzn/Ezk2zHvbs17vMDxsn3ZYw0KZvoY4iuJmQ0S7rXGMoQmmv35Wx
	 SkYtjIMlaxyJYlnoIH3+0B7iyyrGmdyVX+nHZ5CC9U7nhZ3bXMt2X49iSmBhIcd70C
	 xZr98J0IgfSKw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Cc: Kai-Heng Feng <kai.heng.geng@canonical.com>,
	Sven van Ashbrook <svenva@chromium.org>,
	Stanislaw Kardach <skardach@google.com>,
	Brian Norris <briannorris@chromium.org>,
	Jason Lai <jasonlai.genesyslogic@gmail.com>,
	Renius Chen <reniuschengl@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] mmc: sdhci-pci-gli: Use pci_set_power_state(), not direct PMCSR writes
Date: Wed, 27 Mar 2024 16:48:31 -0500
Message-Id: <20240327214831.1544595-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327214831.1544595-1-helgaas@kernel.org>
References: <20240327214831.1544595-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

d7133797e9e1 ("mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter
ASPM L1.2") and 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allow
GL9755 to enter ASPM L1.2") added writes to the Control register in the
Power Management Capability to put the device in D3hot and back to D0.

Use the pci_set_power_state() interface instead because these are generic
operations that don't need to be driver-specific.  Also, the PCI spec
requires some delays after these power transitions, and
pci_set_power_state() takes care of those, while d7133797e9e1 and
36ed2fd32b2c did not.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 3d5543581537..0f81586a19df 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -25,9 +25,6 @@
 #define   GLI_9750_WT_EN_ON	    0x1
 #define   GLI_9750_WT_EN_OFF	    0x0
 
-#define PCI_GLI_9750_PM_CTRL	0xFC
-#define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
-
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -149,9 +146,6 @@
 #define PCI_GLI_9755_MISC	    0x78
 #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
 
-#define PCI_GLI_9755_PM_CTRL     0xFC
-#define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
-
 #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
 #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
 
@@ -556,11 +550,8 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
 
 	/* toggle PM state to allow GL9750 to enter ASPM L1.2 */
-	pci_read_config_dword(pdev, PCI_GLI_9750_PM_CTRL, &value);
-	value |= PCI_GLI_9750_PM_STATE;
-	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
-	value &= ~PCI_GLI_9750_PM_STATE;
-	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
+	pci_set_power_state(pdev, PCI_D3hot);
+	pci_set_power_state(pdev, PCI_D0);
 
 	/* mask the replay timer timeout of AER */
 	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
@@ -774,11 +765,8 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
 
 	/* toggle PM state to allow GL9755 to enter ASPM L1.2 */
-	pci_read_config_dword(pdev, PCI_GLI_9755_PM_CTRL, &value);
-	value |= PCI_GLI_9755_PM_STATE;
-	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
-	value &= ~PCI_GLI_9755_PM_STATE;
-	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
+	pci_set_power_state(pdev, PCI_D3hot);
+	pci_set_power_state(pdev, PCI_D0);
 
 	/* mask the replay timer timeout of AER */
 	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-- 
2.34.1


