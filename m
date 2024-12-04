Return-Path: <linux-pci+bounces-17666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BB09E41EE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49CE2879AC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8D204A13;
	Wed,  4 Dec 2024 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx0y9tfq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596EE20E312;
	Wed,  4 Dec 2024 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332300; cv=none; b=WHO633OC+ajJLkGdb46CpjaLfkh3tm6itZ3/0dPr/HmJBwDPAaMFjhlZzV0hQrAdkN6SvyGH9OSGYPkuPtU4PF5yUeo5Ra1OOEw6iwRU17ZeA8XE6KPAj0KHBu+PfggIGHqYSbkIBQTxX3IpwiGGaGZi6Hk19qUvn4PlKtNPD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332300; c=relaxed/simple;
	bh=gDVc5bOLfsLZNNNXnFs3ZX89Umzzv9H+xcfvBir/L2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mm3D8vU0fazxZQCZ4ULNToXMk65t5wmsb5gwsTKSHBZzdS/4KIcekMYGoa8Gm5cOa/p8FVeFYNsQi5hPoWS2AfJPkE/M+UVaQfUkoVOEXvewjnsbQ1OMQNNqn/84L63swdFd9oUcURLrrInEUnxjY0HNvhNNvZ3bldz/fhhKNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx0y9tfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F81C4CEE5;
	Wed,  4 Dec 2024 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332300;
	bh=gDVc5bOLfsLZNNNXnFs3ZX89Umzzv9H+xcfvBir/L2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sx0y9tfqttlMM4aYcTPafqZUZoskJmWAGaPpAUfYQTRY5kC6gy203clyzDbtf1cqP
	 FTEa5jdCx3vSEm59iChiwOCVcVpbGMjDOeEs5/qKxUMUYs7U224H4bIF65Uj80JiZ/
	 wT/BuVrDydTUmqjWjccPvIaoFO1jt+ThMcxOVFz09pA1mzfvtzBfAA42FtYvWJwqU6
	 iCyudMDC+gJ9f/bzA8/pFI1igp2uNdy/rPPo8xfejCHY1dMTJQ1shFAYgZwLvaG0V5
	 3TH4Lb+iM1sUtaK5ZOeSc9V6cCiC0Z7RaLKCb9jxaMTD20OZkrNDgqn7pDLxwpzmR1
	 QlFHuAg2Gnz3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jian-Hong Pan <jhp@endlessos.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	nirmal.patel@linux.intel.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 06/15] PCI: vmd: Set devices to D0 before enabling PM L1 Substates
Date: Wed,  4 Dec 2024 10:59:54 -0500
Message-ID: <20241204160010.2216008-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Jian-Hong Pan <jhp@endlessos.org>

[ Upstream commit d66041063192497a4a97d21dbf86b79a03a7f4fb ]

The remapped PCIe Root Port and the child device have PM L1 Substates
capability, but they are disabled originally.

Here is a failed example on ASUS B1400CEAE:

  Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

Enable PCI-PM L1 PM Substates for devices below VMD while they are in D0
(see PCIe r6.0, sec 5.5.4).

Link: https://lore.kernel.org/r/20241001083438.10070-4-jhp@endlessos.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8a036d6b7d497..9d9596947350f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -740,11 +740,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
-		return 0;
+		goto out_state_change;
 
 	/*
 	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
@@ -752,7 +750,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
+		goto out_state_change;
 
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -764,6 +762,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
 
+out_state_change:
+	/*
+	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+	 * PCIe r6.0, sec 5.5.4.
+	 */
+	pci_set_power_state_locked(pdev, PCI_D0);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
 
-- 
2.43.0


