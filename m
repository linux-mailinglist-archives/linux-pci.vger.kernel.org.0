Return-Path: <linux-pci+bounces-13672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A898B70C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157F01F21BF9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88F19AD6C;
	Tue,  1 Oct 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="MuCVceCD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58519ABC4
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771740; cv=none; b=ctLkJs9Vh9x8btEn9MPc0/pqgdOSoRWCTZvbJZi2JiBfZ+6EB1aa8IcbbR0bb6OVe84crIqVQ4ZVR0kgQH7QA6+4uUIkZ1xIAmckApKTuRxHMPMGq/G5AdfTdrMM73hdbjxit4kWp78VLBtxUmrWa/Tw1e9IXLETQLg2PIe0vKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771740; c=relaxed/simple;
	bh=BWMkhzEh6lpnZXzCb4xgOx6TwYjnZdmi3ryFFcevWsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVPMtdHJDHvIHK7t8AT9VVZa0MsN8Rlhq3ohRDUHo0YackYpD9f8WPEHuIIRRL7/5lQgoAlj3bEqWeUEh9rofczeCJVuPwG3/bor6m/PkE7cRDnzCC9yT5a+jdiOC3KNFonhBi6a0Gak5tscEqmBq7HHURsDxrw2syB9th/4rIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=MuCVceCD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71db62281aeso839339b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727771738; x=1728376538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y8hsdN8SedF9rTxGC/1IRk82j7hLWsvR2mtT1iPaYo=;
        b=MuCVceCDzpcEmj7LW544foLLD3oOEBeceRIsUM4oSIWDbm+JPtdTLQN7F9KWs5RgEH
         aiGqFW7bjYZ96arCwjM7dNm9uO55x8h/fJRvFjTHhQ7rmw5tLrfJEjuUuEYMXftZJvpQ
         g2qQ4wFAS1LfAWAakHOvLQcX5t5BMwa3tUXYbHxw11pCNv+7s20UIOLR2IeoWwk9KX88
         0GlyQTrQknkobcmvkXbHEKDMpsU9AURdnqcSylrt7H5hsjzRXXyzwRI+OoDk4ka0mpZT
         gQPRRWugj80+VeUL6J4sbLlDGTBBqnH4kOBOrb4rwt8ODD7nUWHiz7wvu224Y7lF442i
         JYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771738; x=1728376538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y8hsdN8SedF9rTxGC/1IRk82j7hLWsvR2mtT1iPaYo=;
        b=RSlmhecB2TJhzY6KZaHJND7Q3Cf/Dow3Khc2J2rBCc/QZOxFAjeZWecfb4fH4Sntsq
         QXLl5vnWE48SRLwb1BetfsMUp+BCkZrexDj1A9asJagcvZ+0nn38ZgDZEqd6kmgzncdX
         UvBmYTNe8FE09o9MZ+ZTI9CtDavpaCjvBwbm6NDypXmSXmVhFQ6/Ofuv4IJU9+7JxK73
         VxEw/BAcFQfWYDv5N2UPNJ76PbLws7ortx7VhtupIVdMC2sDCpSNhcS636qT3a96/dGM
         RgC9KrC7gEQp5P35wHZ/d3H0m2dTaHysiraNC5G/ifo51jOOZRtsGv0aPTdFqxo62fU4
         nY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPtLHHtrydSJahQey0XX4XSmFqehg5gQJLc8EzgpHOv7pAmqrLs82aq4S8pEiFk3rKjFY7U5o6gR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbvk7+lPjmrcpc+xpNAiUdeRx5ZcMiHbcnJ0XQJRiUGYDnyrMf
	oIrp6xDoH90IuvB66i9W6zfksPe+GV1fd2PO4aAUk1qP0cAYCpWG5t9ilMZnj68=
X-Google-Smtp-Source: AGHT+IH9G+MfxrojB8phcCD1N5/Snag/pVEgMjttCtEBMh9QOUWC+VYONC08uOzAV+qBVihgGlHZzQ==
X-Received: by 2002:a62:f241:0:b0:71d:c192:173a with SMTP id d2e1a72fcca58-71dc1921797mr281837b3a.10.1727771737616;
        Tue, 01 Oct 2024 01:35:37 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b26516148sm7521573b3a.110.2024.10.01.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:35:37 -0700 (PDT)
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
Subject: [PATCH v12 1/3] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Tue,  1 Oct 2024 16:34:38 +0800
Message-ID: <20241001083438.10070-4-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001083438.10070-2-jhp@endlessos.org>
References: <20241001083438.10070-2-jhp@endlessos.org>
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

v10~12:
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


