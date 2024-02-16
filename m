Return-Path: <linux-pci+bounces-3569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E57E857603
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 07:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DA7B2199E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25AA1426D;
	Fri, 16 Feb 2024 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="C89MbVuj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E81D134AC
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064879; cv=none; b=olsQ8SG5BvNmLUlJ2Nirap+CzvtiOLZomQiG7egxSaY9TH6IvF8+m+KGYgPRCLq7TWPW5geNTHEBAx7VmioQJCWTEIQ6tDD6UhtoWsoO/I+j+noZVHQlQ45fHthf/OsPLFLlQFQcmKsfP5i6M93RXJa2aLDHnZylv6ImtDJmfwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064879; c=relaxed/simple;
	bh=V4uNwt9Wc1n7D0gczdUV5IjXzUJ6aFgDu2+Y0zcFv/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEwdaUan6rO1bBt7Q/O1MTITs1/HtvfxqcmYHvnRLnLfUQmGA8RyNjiOs6+8FlKUNVHGIeVcj2MDLeOoSgt1tL9Slk/AedM7J6USZy4PrTQAtrNdKQFOKCsUgoJBaDf5/z50TjGBTg7fLYpIf1bbtDvr3K3M9+e/lQwGlfnhm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=C89MbVuj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d94b222a3aso16140555ad.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 22:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1708064876; x=1708669676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygsa5jjvYZCtN9/8lPWOoYcNc8mXbDA6UyU77zh7EZg=;
        b=C89MbVujuQy1A2tc96ZJ8Htq+MnRxUkQZEwF7VWotHImUlGAas64QT/9Gr/vEtXSnG
         7OTyJZjiDuUpWUnJ4ugwgVzt4Ix8F6wGBtXi6K0zdMB+bGRNffWPuGyoD+tcCibbT1Y9
         XdDr+rzzFCXmhX352j6LceW67ZDqH531rSP1Ex/549u6KHeaC0WDBXmWpgccsWtL+l+b
         7l0KbhEeo2x2wvnwM8JXMkTbfT6xtzKhcuTf/K1YbaLO8zZ4mU4/T83dqJhBIwi7tlwk
         YG7iPXsvZ5lwWidS1T0xh4EFg1tcq+f608fBrauApyeKxXQvXdtQCA7Upv+D+O3PbxSv
         wsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708064876; x=1708669676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygsa5jjvYZCtN9/8lPWOoYcNc8mXbDA6UyU77zh7EZg=;
        b=c5I+ZfoBDhuvTovwIKBEL5Rqhf2qKRybxV9e83SdME/h0UJ//CC4nuPZBwiYjJW+aq
         M97n26LVMrlyOK8Y8M2khrh1EbhgjalS3SRgNa/A8Zm/xw5T3pI8swNCBcywTOqZd3aI
         07SMdtqP7kLUcmamTK2JSWYWnAVVZpvcka87PGoY2uFWG0HMrW5e9acr+52j6q/iwNSV
         IHfrUuXJjwyM3yop4YobsNlmnkAFD2xe8VfS3kJa0H/N95tYfYDDAfXyAsjG+9J+F18k
         rS/OdPIi8pUtyKv+XSlq8e6Ut6FJXzqjwNcI7E8zUtuXSu7v9xdLOKWH7epMYDcVkP7r
         RKBg==
X-Forwarded-Encrypted: i=1; AJvYcCUt7/rMCQ/mm7oyeFl8f+AzGKxWaBU7MBeqtzztp6Kn3Z9f2EtmqieBTL3l9ecGOt+dyutZGZktvh+31UEIZrVFY0GSgCljw9hu
X-Gm-Message-State: AOJu0Yz90XiOQ/RinKsvYauQ7io4y/KHIgFT/w1stqyWQ20T8TNKGdxL
	a09lcMil0PXA0nY1fUecK/qRGkfa1h/SWSe7Llk06mTteLF+dT3mK6Z4IBoGLT4=
X-Google-Smtp-Source: AGHT+IH6BiEOIjAhMJN5F26cW5Qq7hNEViQBghZAgtWU/71YbIxKcIQRKjVPhXAfQ6J3nmatFqcr+w==
X-Received: by 2002:a17:90b:23ce:b0:299:262b:554b with SMTP id md14-20020a17090b23ce00b00299262b554bmr2445542pjb.44.1708064876555;
        Thu, 15 Feb 2024 22:27:56 -0800 (PST)
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id sw16-20020a17090b2c9000b00296a23e407csm4572827pjb.7.2024.02.15.22.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 22:27:56 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v4 3/3] PCI/ASPM: Fix L1.2 parameters when enable link state
Date: Fri, 16 Feb 2024 14:26:44 +0800
Message-ID: <20240216062642.247504-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.2
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

This leads VMD enabled systems' L1.2 of the link between VMD remapped PCIe
Root Port and NVMe gets wrong configs when a caller tries to enabled it.

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

According to PCI Express Base Specification Revision 6.0, Section 5.5.4,
before enable ASPM L1.2 on the PCIe Root Port and the NVMe, they should be
programmed with the same LTR1.2_Threshold value. However, they have
different values in this case.

This patch invokes aspm_calc_l12_info() to program the L1.2 parameters
properly before enable L1.2 bits of L1 PM Substates Control Register in
__pci_enable_link_state(). Also, introduces aspm_get_l1ss_cap() shared
into aspm_l1ss_init() and __pci_enable_link_state() to get the PCIe
devices' L1SS capability for aspm_calc_l12_info().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2:
- Prepare the PCIe LTR parameters before enable L1 Substates

v3:
- Only enable supported features for the L1 Substates part

v4:
- Focus on fixing L1.2 parameters, instead of re-initializing whole L1SS

 drivers/pci/pcie/aspm.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a39d2ee744cb..42a8c4c194c1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -588,6 +588,18 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
+static u32 aspm_get_l1ss_cap(struct pci_dev *pdev)
+{
+	u32 l1ss_cap;
+
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CAP, &l1ss_cap);
+
+	if (!(l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
+		l1ss_cap = 0;
+
+	return l1ss_cap;
+}
+
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l12_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
@@ -698,15 +710,8 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 		return;
 
 	/* Setup L1 substate */
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-			      &parent_l1ss_cap);
-	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
-			      &child_l1ss_cap);
-
-	if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		parent_l1ss_cap = 0;
-	if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		child_l1ss_cap = 0;
+	parent_l1ss_cap = aspm_get_l1ss_cap(parent);
+	child_l1ss_cap = aspm_get_l1ss_cap(child);
 
 	/*
 	 * If we don't have LTR for the entire path from the Root Complex
@@ -1367,6 +1372,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
 static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u32 parent_l1ss_cap, child_l1ss_cap;
 
 	if (!link)
 		return -EINVAL;
@@ -1398,6 +1405,16 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
 		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
+	/*
+	 * Ensure L1.2 paramters: Common_Mode_Restore_Times, T_POWER_ON and
+	 * LTR_L1.2_THRESHOLD are programmed properly before enable bits for
+	 * L1.2, per PCIe r6.0, sec 5.5.4.
+	 */
+	if (state & link->aspm_capable & ASPM_STATE_L1_2_MASK) {
+		parent_l1ss_cap = aspm_get_l1ss_cap(parent);
+		child_l1ss_cap = aspm_get_l1ss_cap(child);
+		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
+	}
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
-- 
2.43.2


