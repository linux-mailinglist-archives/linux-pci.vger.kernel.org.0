Return-Path: <linux-pci+bounces-6616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B8C8B079A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 12:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F87A2838AE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C932D13D530;
	Wed, 24 Apr 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="J46VXLfo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471C142900
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955475; cv=none; b=hfRpCT07WgavbvMRunZ98kUUPLk3ntbYztZqiNrZpwFVdZM9qE5Fi3Ycx0bsxrXe7dwInnq835PmN2hj/uHmdcvLURPj6QZbkW0AZiy6D1T8CPqE7cqwWN1Q+JIT9vFVK67fOzeb29xlt05XmX/SBOGjaduO4PIk0xApli6iYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955475; c=relaxed/simple;
	bh=R9JJYC0dK1ddeRZ4rVrFhpWZCg2gCCHhi2kjq3Re2v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebWwZNPAh3tFy8nJJ4BagiFByWUR3t3kfrlm61autxEYGKYotjjEa0LVgFW9Ju03aP3TsSjUKPm2p/f0aiazV7qBoYUukIidqWFWekXSJ5WOVayU5ckMzOeXiGD3+g+h5y1sxCB9fXHQ1prUvSs0b/mwpoI/hAjA7V2LJ5Va9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=J46VXLfo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ff14f249so5650065ad.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713955474; x=1714560274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fj4GdB8jdjIhSjBzZ4VPKirLDL+NYuZXZoe/YHNDTM=;
        b=J46VXLfoySlFclBvaHHIM71ke7UWzE9IzpCyXHXm5e2LUQCW9Qlax4lqPpDzI6b/8h
         iJO5sSs8+VQfTwNUGmk5sqEnmu9ZrHksIXkzJOYFpnGIhtT7B4jD53zKalJEfkddrmgk
         d4A+zSoKeE1Rcf+V6SBwrV5MBE+VmSq0KW/Q2U1zWgk4FLMBDm7wlfnk1SlV5b4OAvUJ
         VGGcFJRmweArRwrPtn+0vRps+3PCQTNx4ZKRjKmQyOQOgz1zmAZfr+1IuLsLdgII4uw+
         tbbs03AWhGI4TBuIyJNUVIeMbypc4rfnnxD89ZVv0BsmPgFdedZV1ggDuiZ+Y8WMd5IB
         6o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955474; x=1714560274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fj4GdB8jdjIhSjBzZ4VPKirLDL+NYuZXZoe/YHNDTM=;
        b=ZgdzcPQZzSO3oNDnTXxyngWCfRugm90Zi7K0JojYm621JYE/y6+bOPaA/d4JEFU3HY
         1jtN7ixCGiLzevRJCPIHXuzK6RjkfHGHOG2TCt9DLX6bUHr9e4xnHSl91+rQu3wtITqJ
         yMTl/GA9eHaxrsOYmJy5WR0e9dF0yqZP8e7uo980UbGe6ZwFWGG2gxDK5ukMfjx4L5Ay
         kphw204D0urbwXxnnw/vTtE9rQutCiTOxuJZa/b7fP4C+B5V+d8yaFtwkuydT3XOCzgI
         /SDvxKUxzBe9w8aoJr4ILiOBQAS0VeOpgHhS0ykSjyqfVB+FvtSOsS/fMKqWNHZ+32+Y
         xMtg==
X-Forwarded-Encrypted: i=1; AJvYcCXvkyxdH0RQ5TEq2bDFcrje9fY55YcRi8xDaShrCLlis0paFnVr6ozPx3GGtKaKI9/m1Kc2wURnDaJQcnFQCfcmvT/y/A0bnwUs
X-Gm-Message-State: AOJu0Yy2ThWCtaWr+G4a1KxN1Av8/1qj6nCHR23JqpwjdmiLb258PaGr
	9GmVFx6uMFcf6GB5YPfPHp8m+XbTWUFc5Vqn8Ns0R8jCmG9CgSjZ6Ft+iPk5Osc=
X-Google-Smtp-Source: AGHT+IGEAi+UAWq4kjv7EBzgY8zPxYDcoTYvhZp3G7O+ZOdU4JPXBbFSYptOKPEu5xOcEz23Chhvpw==
X-Received: by 2002:a17:902:c40d:b0:1e2:bb09:6270 with SMTP id k13-20020a170902c40d00b001e2bb096270mr2644851plk.28.1713955473686;
        Wed, 24 Apr 2024 03:44:33 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id w8-20020a170902a70800b001dd82855d47sm11586455plq.265.2024.04.24.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:44:33 -0700 (PDT)
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
Subject: [PATCH 1/4] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Wed, 24 Apr 2024 18:43:39 +0800
Message-ID: <20240424104338.21027-2-jhp@endlessos.org>
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


