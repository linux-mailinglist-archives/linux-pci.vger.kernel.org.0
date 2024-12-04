Return-Path: <linux-pci+bounces-17673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC89E4215
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AF81689D4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435EF22E3E3;
	Wed,  4 Dec 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsWkIjs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D29206F0C;
	Wed,  4 Dec 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332334; cv=none; b=p/rLBNhzEDpG9A3oPyFGaQ95y0CrFLXDukPVCkumpGeOByY+esNyEZOVDwh7dqubymEh8Gwx7SpazLyRpCd8JjxM/xpgEbAOXGTEMQItuyVcaoo/7i9PN56quujPte58vCbCEIs5FKiqKESBUJLjGWI7dsuHeMtoH/biiFy6EsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332334; c=relaxed/simple;
	bh=/rIQyMQqx4zwzYiI7PjlycsFVukg5Xl3Bfy+I4W71vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqRxhLwb6lvYHJ6C+7ToNLb8nN9G4p39yVuDjOJAmWEDPD2f8CO9ZZ7o503Udy7XnOv/fcjf0/591lYbwfg7UEkvG0S5STdHXqMshTEwvWNbgv9/try+8r8EyQONXNQ53AxfqB+Y4nXN71ZjDo6AN8p/5yIJfpO0sPxR/J/rVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsWkIjs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEABC4CEE2;
	Wed,  4 Dec 2024 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332334;
	bh=/rIQyMQqx4zwzYiI7PjlycsFVukg5Xl3Bfy+I4W71vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsWkIjs9yi+yPFxwu93Ae0JLGdAImzJrkryRDgltfmfuy4e3oWVzkDcanshoNpQoD
	 X/jaPgqFk++E21yHdvQVBn7rC6l5I4EkGtN5D0GNqCmS8Aoly0g7m8jthWfKxEdS4n
	 7DwFNZiNZYm9GbWcLeXR68qwIl5noesGWXdNPF5syrC9ZxNBd2UVC16upOIzckXeUx
	 BilJi6xiwcyV4M20MZJl5TQvkA+zp9mdWRdmFoc5A4aXdACe+YL0HPvhadK4NwXFW9
	 ZXBX1x7BjWQS52epgtbj2cehdTkIlqPyJkMjuv/l7SccnjqOcaSUh2TIXjpB7Vdd9E
	 Kc3hn6iY84tNA==
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
Subject: [PATCH AUTOSEL 6.11 06/13] PCI: vmd: Set devices to D0 before enabling PM L1 Substates
Date: Wed,  4 Dec 2024 11:00:31 -0500
Message-ID: <20241204160044.2216380-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 4429a3ca1de17..73c672cb830f3 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -751,11 +751,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
@@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
+		goto out_state_change;
 
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -775,6 +773,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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


