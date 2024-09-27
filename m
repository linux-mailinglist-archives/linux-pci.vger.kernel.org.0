Return-Path: <linux-pci+bounces-13597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8F9882A7
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67F9B20AA7
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0913698F;
	Fri, 27 Sep 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="THo3CLOd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE7185956
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433477; cv=none; b=oYwDY6KLDGWUDU6hnDOPVcvZMo8F+vFWuDMsf1tsobyPrN6oNsn+Qrg0AafAML0Qy1LtczXgYmo1SqAvubQydWPHEhE679BssKQtFZbgOn+xdOVYQV0n14EWWJGx/ILuayBQXquJnNBMKNnPecJMw2sbN0Ysb0vMNOdXdqiAIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433477; c=relaxed/simple;
	bh=4sYaIuJdFSnuaqpKZ8kyV5lKO+ffPujUYfy81/wM48Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeifKdNaUOiMiRVsaCB1Fd9XOQFALMWBvZy8RRB2YKWyaF8d6w/WjV2zP9j3cVyW1ngSC5ZtJfxSEoMwJLUfN3aZltcZvY1pGZDj63D10rAgv3bRkiBNSTi5isx9JSM5069SXhZTPicF/N0Q/gdRXyNMEKCfDDPasxgPim/l1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=THo3CLOd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71b8d10e990so316455b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727433476; x=1728038276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Hwiyozneamu3/XcerF5d5b//JQF69xFvep1o7r1rVc=;
        b=THo3CLOd4ZZPMMUYymmExspo14VmE6r6racDn8LErIHIgCrcsH2hvQ3i3DGqMqHxBb
         9CPfvZjdrSOMoTT0Ar8Egv9KTeg52NU8PogNMVhucnbU6HX3eTPWwdUtt+lViXDWt2Zm
         54uIwA41cADHc2KYMalpi6AL9MXZXcSUje4Gd4i0S0rjwvopq88TYVt77QMCcPuNo7bb
         LAGpszpbLTMZDmIkGagC4vj+YFl6qCsDNaQt8ycqW/HaEjk7UqyCu/8t8uX+w+gmDHDK
         dGe/7A5FoqeRxRQLQLU3yF/ka4kNnnZztYn6vIsg2x1trAAUxWkV+IGy0Or5ZSzli1ba
         nMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433476; x=1728038276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Hwiyozneamu3/XcerF5d5b//JQF69xFvep1o7r1rVc=;
        b=aThqQtRBg9joYH93SZu0v1kioXXY1BzEMsP1rHfnLWpqOPDXvHbMLddsD5tKwN8jq0
         O5ACJBSmMBiyQNb1nWtxUGe/MUS7qKOZdLZDvEekzCLxDfRzetVOJV8oqzqTeaaNN2Ir
         MUu0fKLOR62WLyj0RAxW3imbWPDrByvUI0jbHpOPRZIp0xjBk+C+vALZiUOwyQ0hYq7l
         //tbnmhAVadpdZVgMSD63ku3IrW5Xa9QsdKuhrgkNJ0MzznKLpO0DfsEA4AuuQZiH7l0
         gf8qWGYPlW0HSz+lWAQEYfmhdRbBrEH2ZS6RTp8B/NVmP+Nxak8jRqN8ut+OIsk4uqyg
         Z0SA==
X-Forwarded-Encrypted: i=1; AJvYcCWlwTzle1AJ2G9LEOacv3+ghGJloG47zx+1Xclm7gW7phhXd4JjV5oo1r0OaI3ZK4ZfNLPqblT9A3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy087X+s7PhaaOmoP10VXqQ0tX/GvayAeqzqRrXWmCdD+pZwoWI
	cMLjE7Env1xP+eZ9ykrUb5BV6LYgfKVgbbZnP7h34+S85JqWibMnhq2/5MwKetM=
X-Google-Smtp-Source: AGHT+IGXZCssJYEkklvlhujoOLGGBkezQMy0CB2mqfDO5qE0T5PwaTCgyumVMWcnPVuQWf6l9lWzmQ==
X-Received: by 2002:a05:6a00:2191:b0:717:88eb:824d with SMTP id d2e1a72fcca58-71b25f356a3mr4502012b3a.7.1727433475631;
        Fri, 27 Sep 2024 03:37:55 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b265249b7sm1342779b3a.148.2024.09.27.03.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:37:55 -0700 (PDT)
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
Subject: [PATCH v10 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save both child and parent's L1SS configuration
Date: Fri, 27 Sep 2024 18:37:24 +0800
Message-ID: <20240927103723.24622-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927103231.24244-2-jhp@endlessos.org>
References: <20240927103231.24244-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI devices' parameters on the VMD bus have been programmed properly
originally. But, cleared after pci_reset_bus() and have not been restored
correctly. This leads the link's L1.2 between PCIe Root Port and child
device gets wrong configs.

Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
bridge and NVMe device should have the same LTR1.2_Threshold value.
However, they are configured as different values in this case:

10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
  ...
  Capabilities: [200 v1] L1 PM Substates
    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
      PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
      T_CommonMode=0us LTR1.2_Threshold=0ns
    L1SubCtl2: T_PwrOn=0us

10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
  ...
  Capabilities: [900 v1] L1 PM Substates
    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
      PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
      T_CommonMode=0us LTR1.2_Threshold=101376ns
    L1SubCtl2: T_PwrOn=50us

Here is VMD mapped PCI device tree:

-+-[0000:00]-+-00.0  Intel Corporation Device 9a04
 | ...
 \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
              \-17.0  Intel Corporation Tiger Lake-LP SATA Controller

When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
restores NVMe's state before and after reset. Because bus [e1] has only one
device: 10000:e1:00.0 NVMe. The PCIe bridge is missed. However, when it
restores the NVMe's state, it also restores the ASPM L1SS between the PCIe
bridge and the NVMe by pci_restore_aspm_l1ss_state(). The NVMe's L1SS is
restored correctly. But, the PCIe bridge's L1SS is restored with the wrong
value 0x0 [1]. Because, the parent device (PCIe bridge)'s L1SS is not saved
by pci_save_aspm_l1ss_state() before reset. That is why
pci_restore_aspm_l1ss_state() gets the parent device (PCIe bridge)'s saved
state capability data and restores L1SS with value 0.

So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
the parent's L1SS configuration, too. This is symmetric on
pci_restore_aspm_l1ss_state().

[1]: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v9:
- Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.

v10:
- Drop the v9 fix about drivers/pci/controller/vmd.c
- Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_state()
  and pci_restore_aspm_l1ss_state()

 drivers/pci/pcie/aspm.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bd0a8a05647e..823aaf813978 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -81,24 +81,47 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
 
 void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 l1ss = pdev->l1ss;
+	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
+	struct pci_dev *parent;
 	u32 *cap;
 
 	/*
 	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
 	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
 	 */
-	if (!l1ss)
+	if (!pdev->l1ss)
 		return;
 
-	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
+	cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!cl_save_state)
 		return;
 
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
+	cap = &cl_save_state->cap.data[0];
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
+
+	/*
+	 * If here is a parent device and it has not saved state, save parent's
+	 * L1 substate configuration, too. This is symmetric on
+	 * pci_restore_aspm_l1ss_state().
+	 */
+	if (!pdev->bus || !pdev->bus->self)
+		return;
+
+	parent = pdev->bus->self;
+	if (!parent->l1ss)
+		return;
+
+	pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
+	if (!pl_save_state)
+		return;
+
+	if (parent->state_saved)
+		return;
+
+	cap = &pl_save_state->cap.data[0];
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++);
 }
 
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
-- 
2.46.2


