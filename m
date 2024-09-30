Return-Path: <linux-pci+bounces-13630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4274F989D37
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 10:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED6928130E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA218132A;
	Mon, 30 Sep 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Uw5jRHeU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D113C9D4
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686097; cv=none; b=ZxMAxmbMxKy8zTCDcldkcWCkRans9iwP8jeF+AfQt5h63KrhYlQeTCZSvXkw8paOhcDJMcMTUybzLrmlhOMkGWysi2uSGYUVjNiaWpkGEj1mx0vltbx7BIkGpl/4+1UFOtbuW/RDSDAO+73Lt3daLGdWudEPXry5sLBMIR5k39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686097; c=relaxed/simple;
	bh=U+N6fg/c5wFr1Ckfoil5ymH2MOioONxXMWOiMGSRb6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbQm3p6bHAGDoVarYDg4S+LICiE11xsesImJVIhwLemHYyKUJGhVx4GD0QJo5ZBZ24XuAIWJIcV9Qqz7sqnkW/Ck2saHqpxhuTnbqnDQCnVR6nlItKeZjQCAUydv0Ck/snOn9sLeAU+Aa9nyJHmnkkvMxfm6gqa5voVv+YGa7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Uw5jRHeU; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27b55c4b35eso1191992fac.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727686094; x=1728290894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/k2Ft8h3JSRNQa8sflgWnPU60S7BKrvPftgHnCSgfM=;
        b=Uw5jRHeUleKAcC6U3c5qB3j+Gcl9zBa5v1dpCIqA6v8/bHUjHzeMw+GHrGZYu5y0sy
         VaWFBmKBiOTJRTndIETOX34QU5TSERzGzWvkGaQYo+01opOomWO5FNiGqFxa1PXi+Y1I
         SbBWPdF66pjTpktNlNn9NnB76PYOc+KLDre0owxjCNnyVYgcKyFsG275T3n8w9UZCltD
         dPA3iGVwtxr4YjwGFkK8lMEeLAl/vxvG7LlY5RJ/7+WoCeTszcOhGz5EfQzUdp1uJM8A
         4O5q+BOqyjmws1iiE3oJBuU61ypLtAJ0ZQ6HohLAdGf4NP3eHSaMwZhQUEUkGWY4ex8B
         a9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686094; x=1728290894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/k2Ft8h3JSRNQa8sflgWnPU60S7BKrvPftgHnCSgfM=;
        b=A5oqiOgGEwv5PdqV86hGpFfOKp2kvHZhMVF8U9B6x6kgIXZ5+jXSOnIkF+PcyJ6d6e
         hqzkTLJKl/iLwN/QYsNFgl9WotulVubnoM7OUfEC+uwOW/OptQq6XQP5mAe81VdRLazH
         Fm2K6+mD1lcpifzFSsxzBlPEVD71k1ds4GN6NsLDjzW23uFV3XIjMnSUAqEEAOru1kA5
         kpwdzuXnTkHl48hLGT5AUO/D2GBLvNtzeTfRBayayyWfkU+1w2uuFs7hiSoMEb8vc4gj
         cnUl83VUmGkuPfTnoPTNRyBFTZyigMwpAwg9MebqC3blYB/COhYtVHRmhpLkxti51db0
         B3+w==
X-Forwarded-Encrypted: i=1; AJvYcCVRkqaRyxFQ3GLAlrlVFnaW94p2hya+GRdC01S7oXnUXXrjCKpUHGWik0EFoQX0mVhL5ec+rwgTtiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSlIUQ1NJVqRZ1Vtv0aydA3cOxMAoONm+KAxSP2T29ZEjemfI
	Uf7ehjMO4yGPTzfM6aSD+S2nCxwJ3DcjwQxBQmJ+x1Vbd+NTSYgm8pcDMfbnmic=
X-Google-Smtp-Source: AGHT+IEctgfFVEWe3ZkXkooElSMnX6+GspuiN7R7XD8Cqsgbc1F66DIhxam/a3LljXHHHb9R0Ru40w==
X-Received: by 2002:a05:6870:55cc:b0:270:2abd:4772 with SMTP id 586e51a60fabf-28710bdc836mr5800613fac.45.1727686093838;
        Mon, 30 Sep 2024 01:48:13 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e6db29278esm5922525a12.16.2024.09.30.01.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:48:13 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v11 1/3] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Mon, 30 Sep 2024 16:29:27 +0800
Message-ID: <20240930082926.12966-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930082530.12839-2-jhp@endlessos.org>
References: <20240930082530.12839-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remapped PCIe Root Port and the child device have PCI PM L1 substates
capability, but they are disabled originally.

Here is a failed example on ASUS B1400CEAE:

Capabilities: [900 v1] L1 PM Substates
	L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
		  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
	L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
		   T_CommonMode=0us LTR1.2_Threshold=101376ns
	L1SubCtl2: T_PwrOn=50us

Power on all of the VMD remapped PCI devices to D0 before enable PCI-PM L1
PM Substates by following "PCIe r6.0, sec 5.5.4".

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v2:
- Power on the VMD remapped devices with pci_set_power_state_locked()
- Prepare the PCIe LTR parameters before enable L1 Substates
- Add note into the comments of both pci_enable_link_state() and
  pci_enable_link_state_locked() for kernel-doc.
- The original patch set can be split as individual patches.

v3:
- Re-send for the missed version information.
- Split drivers/pci/pcie/aspm.c modification into following patches.
- Fix the comment for enasuring the PCI devices in D0.

v4:
- The same

v5:
- Tweak the commit title and message
- Change the goto label from out_enable_link_state to out_state_change

v6~8:
- The same

v9:
- Update L1 PM Substates information against kernel v6.11 in commit message

v10~11:
- The same

 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 264a180403a0..11870d1fc818 100644
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
2.46.2


