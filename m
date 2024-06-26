Return-Path: <linux-pci+bounces-9282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A4917CC6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 11:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF72B23322
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D416DC37;
	Wed, 26 Jun 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="vwpfgZQe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54716CD14
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395008; cv=none; b=d6RKZSnPH+w3epOTz4HNNg502SihluGjRR8H8Kgzb4uxurH+LyH/MacLOOOsBv0185hNylL7uLVjanM05395a191u/m0KWswEkfq+86yL5fngSOPE0C7/cbtTCAkNm8RDycyTn4Lhc7M+OeTJfxd1qDjOyYGYhiBxZSxrZnDaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395008; c=relaxed/simple;
	bh=vDLv0eUVGJMmwyg+4UxkWlAksU175EmQrjDIno/a+Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se+CBTyiKXh4YPchytjF/sTMafiztJLI16fAFH/bJMCbD/VG1gqPAgES/LgbN8AbkySaX9nfeQGX8j5zpWeiH5+7T3FJFqG4GCp+B8FFqIpIgp/Upeq8WadgwCOdnyxDPAX2ECEr97oMcnJxllp3C17mnX6czqyu6+JA5teARDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=vwpfgZQe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f480624d10so53974375ad.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719395006; x=1719999806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWFJ83bKSjpBaUA+SG/yPoduHd16W9GZx5KqGR4AgEA=;
        b=vwpfgZQeL49q6ymP0Kpc4x4eSMcAgLK+4DK6siPxGI2rrqqD38Hb0IyQZCAs+EwhB+
         ZzSlEArQj1AE1RzTSYetjRvmXQ6VqBFE1LEis13WUE6PCLtJ9mnbNEpbutt0SlSeAoXt
         F1OH/iDOZxJkt9TSIKrBSwc1dWSGUi95mAeMmO13EIbvH/SYKF7PqmNJmAHgoSUDEO8T
         mRIRIGNgxBM1g4LwDjLYUxh25ku3Lgzrk7BJTsht+TETRWogr1qmkF5+cih+nHfVAoEP
         y8iGYH5nRWgSQonc8Dlko6skMXdqrmQLkqx0b4K6IQbG/ZH3gBICbw71FO7IRQMDFXWj
         fMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395006; x=1719999806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWFJ83bKSjpBaUA+SG/yPoduHd16W9GZx5KqGR4AgEA=;
        b=ms4Kr097P45MafIbP9LnaNJdWS6jhP4zFmlAhi9EVWTK21rM3yNKDAzvhp/O0xpIVH
         uLWLFpWTezMcBRzE8uIIcVy6nn/Pkl8K6ulz88a8dxJ/+Cg1WY/4aqJkQBm7+QbtwYN4
         AFapK2O+g/vzhQcAb1Meg0SnvhZaF+UevgjU3Xt6QSif7e6S+ngSYc/rJ8DCKwYYDTHT
         ikbJBepqn0l/3bAB+hJ0injiGRpwWSi4SIyZXzE39qICDHOXvHxrAUcSVLC/tn8PGiKN
         iqCQ1YNpR646GGFWYO93Ehof7GwkmZTLn+EDjK3UVdmZL5NO/d+9TwlmjV1GRMoJWooN
         LWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe5VnsAdIVRBla8eBM3Ah6LAekS5BCNbzzttXdXprIHqmkdSmxhh1pIWzzXNbZLAGi0g+Gp06wE1btztkzYLR4skzZlsXDgQm9
X-Gm-Message-State: AOJu0YzOLcy7jnPF3QU3CrmCakb9ZdctHsmXmW3gAcJZulXmBzI1Qhal
	ynK+6LR+q7dDBT5m8snz+mePVAs9Ob59OOU1fyIWjsx9sd9XzZN9gbLD7yrSRDw=
X-Google-Smtp-Source: AGHT+IE2etjp6SLgpYIk6NOvVt25jF7m5xfwbrxRBUDv9rWsMCAEdZz8pW2+kWTCkFtQsPXiOao3DA==
X-Received: by 2002:a17:902:ecc8:b0:1f9:c289:737c with SMTP id d9443c01a7336-1fa1d683c1emr116520375ad.60.1719395006080;
        Wed, 26 Jun 2024 02:43:26 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb5e030dsm95700375ad.218.2024.06.26.02.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:43:25 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v7 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
Date: Wed, 26 Jun 2024 17:41:16 +0800
Message-ID: <20240626094115.14470-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626092821.14158-2-jhp@endlessos.org>
References: <20240626092821.14158-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when enable link's L1.2 features with __pci_enable_link_state(),
it configs the link directly without ensuring related L1.2 parameters, such
as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have been
programmed.

This leads the link's L1.2 between PCIe Root Port and child device gets
wrong configs when a caller tries to enabled it.

Here is a failed example on ASUS B1400CEAE with enabled VMD:

10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe Controller (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
        	  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
        	   T_CommonMode=45us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the PCIe
Root Port and the child NVMe, they should be programmed with the same
LTR1.2_Threshold value. However, they have different values in this case.

Invoke aspm_calc_l12_info() to program the L1.2 parameters properly before
enable L1.2 bits of L1 PM Substates Control Register in
__pci_enable_link_state().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2:
- Prepare the PCIe LTR parameters before enable L1 Substates

v3:
- Only enable supported features for the L1 Substates part

v4:
- Focus on fixing L1.2 parameters, instead of re-initializing whole L1SS

v5:
- Fix typo and commit message
- Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
  aspm_get_l1ss_cap()"

v6:
- Skipped

v7:
- Pick back and rebase on the new version kernel
- Drop the link state flag check. And, always config link state's timing
  parameters

 drivers/pci/pcie/aspm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5db1044c9895..7f2cdda259dc 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1411,6 +1411,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
 static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u32 parent_l1ss_cap, child_l1ss_cap;
 
 	if (!link)
 		return -EINVAL;
@@ -1428,6 +1430,15 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 	if (!locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
+	/*
+	 * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON and
+	 * LTR_L1.2_THRESHOLD are programmed properly before enable bits for
+	 * L1.2, per PCIe r6.0, sec 5.5.4.
+	 */
+	parent_l1ss_cap = aspm_get_l1ss_cap(parent);
+	child_l1ss_cap = aspm_get_l1ss_cap(child);
+	aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
+
 	link->aspm_default = pci_calc_aspm_enable_mask(state);
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
-- 
2.45.2


