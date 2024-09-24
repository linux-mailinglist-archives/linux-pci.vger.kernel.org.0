Return-Path: <linux-pci+bounces-13417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90993983F06
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4701428214E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33AC145FE8;
	Tue, 24 Sep 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Z7Am/Vyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952A145B24
	for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162649; cv=none; b=H4dpKB79tNbwlud3UAOCOjB+4uQuRyG3KBjh6spQ1UNfwA4ax/wDq0SDCgA6uNjjJW+IiAJOiF1DFy6oBCdGl+RSuRk5j20zDh1qOYqqMmX2Eop1oo/l5qR/Rkw7TCjvpi9+GBOEFDA9c6qrJvK73HjdQ98I7wS0uqgetRBMgIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162649; c=relaxed/simple;
	bh=/kR8Y+aQ/hoCK+GI5dTp0cvDs3+d+f/zp1O4+MFbywU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTvgCWqj/b8MP9Dkw5IawSMMky9uvrmZvgInQIG0ymy0iNdehpMowAxcTw38nDC4AvnOZbzyc1N6W6sNDc3lkAopyVsqgxb7m7jlWitTehDPOdJnH9SaPMWD5CNIs8NQB215UXZOgQ2uvRajWOMbldPxDfJtdUlwUBsmFjlcYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Z7Am/Vyq; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e03f0564c6so3091394b6e.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2024 00:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727162647; x=1727767447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LU6Uewc0Mc72sE2KkcnJ2E4+BrFGvMvKo0jKAieZwk=;
        b=Z7Am/VyqG5eryauQHR/0K3VIVDkloYGRxBs3Sod+jwoKUu0hm1NMKYaJ7QkV+8rt2a
         J961QCjtB0MVyVNkmMd0enE8W7FSnxVflJKX/L6PfMLetYo101HyxIuUcn9Gk4bqvx7o
         g+W5z+AbOKRR14oSOztGdWkmnblBLD1yN0tKWUBVHlZPb40MlLAPXh3ehGBfkGQC+sPr
         FrVbhm4YJxSTGALVklzyHWfbIgxQE9ZgBvm8h/7XG8oNK0SUVG7hgfoEQmly95vW7pQ9
         4k7FrfwTBWVgMwmrNn4oIFJibzebhLyayQg/Cn+ktllepvn1LrDIReJloqzrstzxvTan
         68EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727162647; x=1727767447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LU6Uewc0Mc72sE2KkcnJ2E4+BrFGvMvKo0jKAieZwk=;
        b=jnUMtjvoI1lwDHl2zk0H0HZ0I20PdiJ7AMYvRAJRgpaPgIacvxgD4t8Rdi6pwW5/vh
         dphNzGTxfXk29ZuwMVPbsNsPJXz9Pn3degSH+hxBXmBvzwHFz3bn0xxYZMpfYuzjJcU9
         ilkSGGJPSWpehmVyQGhq1zwjrO2GkvDONghQO9S53tQajcnvmNZxOS9QGb1pC4ZQ0Wsc
         6Aw4VdyZfjPO/C8GFa+7W5Rplmm1Qhy4lCs+Chr8vjipVEhkJZa91SebzAWz4WDqyL0K
         FZgtbowqclVpeAsxn9Ust4OnZ5L4BVxDHDdjQV3i5BrDukYcWypTxs1eyQRncaUNKyBE
         3O5g==
X-Forwarded-Encrypted: i=1; AJvYcCXO3ttbJSTNoKYIDsqJc6PQP6ZIkPh27JqF/l4OUioe6hO8X3Duhc4krCF1t4gz+8azh6aZRHJyfok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vz/kogeDX5T1+x/3mkI+tFPUyNECTe+9IzVk3/nF1+ejRb3k
	WNEAvO9aptSpdhjAibHV3iPbMKz+6b3NJAiDK1fa1EyzQ88GI4uz2hlwHkV2tAI=
X-Google-Smtp-Source: AGHT+IGadQg5IXmezactvoif7KfUxM+L9h4qHNoX87Y/FzZtP8aQ7na2cHB8Cu0x/pJ33tZPRInQeg==
X-Received: by 2002:a05:6808:3389:b0:3e0:3547:b0a with SMTP id 5614622812f47-3e271ce046emr8037918b6e.35.1727162647220;
        Tue, 24 Sep 2024 00:24:07 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e6b7c8675esm599530a12.92.2024.09.24.00.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:24:06 -0700 (PDT)
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
Subject: [PATCH v9 1/3] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Tue, 24 Sep 2024 15:14:20 +0800
Message-ID: <20240924071419.15350-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924070551.14976-2-jhp@endlessos.org>
References: <20240924070551.14976-2-jhp@endlessos.org>
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
2.46.1


