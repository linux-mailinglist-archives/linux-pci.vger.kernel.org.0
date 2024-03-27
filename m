Return-Path: <linux-pci+bounces-5297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2984D88F143
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 22:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B46B1C270EC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9261F15382D;
	Wed, 27 Mar 2024 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtiVL/C0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68206153823;
	Wed, 27 Mar 2024 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576119; cv=none; b=CBGtahS+c+v8TShXu+gEZ8/Gs2RLOyhpTuyIZwQYRAgO7lQ3FGdXaIvUZFvhTR+aRVCuv1Idi/THLK3U3ry93JaqPM9Xjc+m+evDxXQVRlaj3PTBXCPRmTAWitedsXi43dCHP5gZU+E56HaxfgVcnjuKFYo7s/NIJm5pbXAPNxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576119; c=relaxed/simple;
	bh=JhM7uD+0y9lsMj8Ti7Upt2hgdOSgQZ9r3BnntyFvl+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEThtVlzGHQ3GD+jfkcWrAeFSp/rCn5ctucrQUSgkLZgRRoW9sY4iuVTj7rQ/5DtKHBLhEgy4Q6IGXsVUfl50uomBcAYWXDyibOAaSx72oCqWg1GlTIR/cSzo5AxMP0/sWfLWX5w8CIiIUWAO2/GytIQtelfNg2E+8nyN6GYB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtiVL/C0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF5BC433C7;
	Wed, 27 Mar 2024 21:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711576118;
	bh=JhM7uD+0y9lsMj8Ti7Upt2hgdOSgQZ9r3BnntyFvl+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtiVL/C0fh453RGWFRbhL/C3fV0BGa4axK6035RH03+TgUrT/Cb+L1aozk5Ievoa4
	 fzskSDP6L5+BLM8ZdLxjIpyfc+lAYE9WJVyS4EitA3tIlNg+XlnhYzviPiDID5hAlu
	 s2HFbl006lsrci74MMxB0MRU9NnOJZf0dXwLDoQLNtucA9D8xU7QIoe8fyNuPMjRXS
	 fD3u9EbDVKIaoEuORHrFaNJ84WVu+qFd/Ng5dA4VesNMLxeTHT+562d03K5AjI5MoP
	 FC+rBW9ZRKTUoozoEVQYGyKJvMBw/ysWfyZTPj7xeuoMzJeAEEvASa7+tEIPSsJQv9
	 yq8t3lve5DPGQ==
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
Subject: [PATCH 1/2] mmc: sdhci-pci-gli: Use PCI AER definitions, not hard-coded values
Date: Wed, 27 Mar 2024 16:48:30 -0500
Message-Id: <20240327214831.1544595-2-helgaas@kernel.org>
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

015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of
AER") added PCI_GLI_9750_CORRERR_MASK, the offset of the AER Capability in
config space, and PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT, the
Replay Timer Timeout bit in the AER Correctable Error Status register.

Use pci_find_ext_capability() to locate the AER Capability and use the
existing PCI_ERR_COR_REP_TIMER definition to mask the bit.

This removes a little bit of unnecessarily device-specific code and makes
AER-related things more greppable.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 77911a57b12c..3d5543581537 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -28,9 +28,6 @@
 #define PCI_GLI_9750_PM_CTRL	0xFC
 #define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
 
-#define PCI_GLI_9750_CORRERR_MASK				0x214
-#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
-
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -155,9 +152,6 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
-#define PCI_GLI_9755_CORRERR_MASK				0x214
-#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
-
 #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
 #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
 
@@ -547,6 +541,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev;
+	int aer;
 	u32 value;
 
 	pdev = slot->chip->pdev;
@@ -568,9 +563,12 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
-	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
-	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
 
 	gl9750_wt_off(host);
 }
@@ -745,6 +743,7 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
+	int aer;
 	u32 value;
 
 	gl9755_wt_on(pdev);
@@ -782,9 +781,12 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
 
 	/* mask the replay timer timeout of AER */
-	pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
-	value |= PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
-	pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
 
 	gl9755_wt_off(pdev);
 }
-- 
2.34.1


