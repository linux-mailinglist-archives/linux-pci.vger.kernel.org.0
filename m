Return-Path: <linux-pci+bounces-6618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A908B07DE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50E12828FA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF815A4A8;
	Wed, 24 Apr 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="qW/1ln0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498B15A4A4
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956384; cv=none; b=nNC91mpyN7L8+1O3EJsublzMVoXCODrcEToj2Lu3sORAQHGvJaocE48qSho81/5JhkUX9MciBVNj0wbAXx8AF+/BuHy3gOrwdx2FDMV+BsvUUgjtU4z5btVsjJEz89ZqQzTlPcti0Je8bJmBa2NmD62+lSICW7288+oMtMzWeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956384; c=relaxed/simple;
	bh=gslVWRhVguZAeE5MA5pJRksuEbRpbMCUE2vEnzXXAq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPBnPJFaQ7IGR712zAxDJAYuFhD66n1dg1h5iPMA7kT8+h1SACqKwRJHmsJkPbv7j2tBQY45n81DAy1PQ+G8irVa6c6LyvbWMIM1ld25YY3OgGto8ofZsnHdfHN9U1HjItUOV+0tWNiXPptl2JXGnhYhzIEjQg3iHKs+YVuK9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=qW/1ln0I; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eb797e10ceso3901007a34.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713956381; x=1714561181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZHK37+yvrDhIe6YElNn+NVZ9zPGe92/KcA9bWwPrXs=;
        b=qW/1ln0IUQN1BpZvLlfZXT3nNHV+zXRhjs+LYg9M9KY1adAU0/gXVec4MD416pHw4P
         KPgPFWsqyRiEAYcb2HWveIi+xaihcdFcjwPMrda9BIiXXVAl+QtZyIHlwjwYNWoemDUz
         NYvDn/G/xnshH1KUwkZ/DOinLd8/UygkcmYDu1+ycGXZGFuOufLELhWlami4uWkyy3TN
         YBtUtUs4tMaeQfwTkPFA4C50lw3l+dDR4OWmy558cJU5WyS6nB0+EchkQQcAYbRHdaQo
         JirXMDIULA4WnYYRo5kISpOUfFKzPEDMec+ikqIn4eadfrFyDcCoQ5b1QPOYx9Mo7WRz
         M00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956381; x=1714561181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZHK37+yvrDhIe6YElNn+NVZ9zPGe92/KcA9bWwPrXs=;
        b=YWkrgKzQOz/qoBCzTPDn3Is8n/MwW7xHlamGE2DKAiWX+vkJGUyPT7m+v64K97x2h9
         EBsvh1rTaSF5si2IH5A/DPFKSoUTI2wwyLm4k3QjmxQj79vG+DZ5yzUlzcXRxGc5KlCr
         1qQCfuv+jLeGkJkx3sM/AjshVMKnwojU1iSRPfUoWQgTdu+6EjK9ShCDKfSnx1euVE+M
         9vGT+l4L5X1RzTEFfI3pPQy2c6oagslz+fK7UwQhjkATduz5cPKgytCuHWlqPjCGEmlw
         KazMSV+PGz1eAxZ+guEalJtdCAy6ttfNGDQyXK7g4CHDyVBldXXeLxPQboJl9hrTK2Jd
         VLuw==
X-Forwarded-Encrypted: i=1; AJvYcCWzJrDbFYDql7gs4crhEbu+z3eFM8Pg2oX943fC7ftS1H2U/NMjX9mdFLKr2EApeonrZ+f1K7Xrw9odpJTFEu4ixBkDQKlsgJRv
X-Gm-Message-State: AOJu0YwiRnANQgodb73pjl0LVcIBNUt6T3ebTAq1QNn81llQeaarwqrh
	HRpchncP3GR5AhWQ5uqHHoomNyUqX7ey85cXR+XoHq75BHA5gazD5bkpb22qoVg=
X-Google-Smtp-Source: AGHT+IEpIS8FDcxzJZdXXPMUscLvqoePXQ0fFeAJ0ZikHn9/nTXolLKov94VE4RkDi6zFrIFthNvVw==
X-Received: by 2002:a05:6830:10d0:b0:6eb:8068:914f with SMTP id z16-20020a05683010d000b006eb8068914fmr2217974oto.37.1713956380393;
        Wed, 24 Apr 2024 03:59:40 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id t20-20020a63b254000000b0060069828aeasm4824104pgo.23.2024.04.24.03.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:59:40 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v5 1/4] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Wed, 24 Apr 2024 18:59:10 +0800
Message-ID: <20240424105909.21713-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
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
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

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

 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..5309afbe31f9 100644
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
2.44.0


