Return-Path: <linux-pci+bounces-6621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056668B07F7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 13:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293FF1C21A72
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC8159906;
	Wed, 24 Apr 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Ow7zLLXf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B051428F9
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956596; cv=none; b=nVlkJal51aUa7mbNUIOwB9TDsC/bj/aRBg1Yfoky6rVdfTJI8v5aZvebc08uGtGvuCSsk7TT5+pfeUTJpg/MpbK4vPaCyX3osCHNzEj/fsdzkEiG42g+EGkXmX6abJCICyQpm5Y3kUPWGxCyoDb3whrenNfjGdcZnPq+SYxh6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956596; c=relaxed/simple;
	bh=uV0/1aSVVcRIoF8efqTChlHildc7U8iR42Xo+0S+bPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WP3aEdN5+NzCWXJsbWvDIXU07MoegS9Vp+eXS9PgsiV2/c/6r98/CSBOBCDjO+jaN3TkZsQER5TKJ97LscYqnc6kLK8hX8SFpaIqJf6t7CTSQ2rrQyue7jGRmWULc2S4Sg1iK6c4Fjr+0XKASqJHT3drEK1IJY5eahW7SPdZUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Ow7zLLXf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f074520c8cso6426666b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713956594; x=1714561394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViRbv3+94h9HjFBDUVRxRf1hCf57UQ+V86PhnGFbsxM=;
        b=Ow7zLLXfVVeT8oiGPskEQCGP3m190TxDiuU1G/wWEptygtCCmfvqa81TCUWDtWEGfq
         kaIrkyb9Epn30zeBIUPDg0h9AeKZrVqAyER5RqllvUEY9BOisIF6wCK/WzO/N5igpk2D
         SN7p9EWns0rFoUBohaiQzJi50Rg6akTJUexY07vE7Ct3Xe6SqCXHsCLXgi8+fJmIEywh
         WHvY4gEOApKCaBBqSmGi/Sql5ebGb9tqSU6ZbwA3Tqk7EXCJMG5tAP5PVFFpHtqDBX3F
         Ikgn8QhhhbAD2NAVC8fh+OtE1t82X+xFP3DZzFoRcDq4PisVSoPvyeM9V+Luo2onLhcz
         bn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956594; x=1714561394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViRbv3+94h9HjFBDUVRxRf1hCf57UQ+V86PhnGFbsxM=;
        b=f/aZxdKshTAOrYqyXKJ4Pi7xJf+4+RR7fVavP5bRNfjcQYbbYpRgFN13KiF32qnLsm
         GiJnQlNLpzq/7HjxNQywDbC0aAdqWhwYpzSrUaARbDL1mx7Jhf5sgO5atjIS1x/EOaVx
         S9wrA66mNWqKxZyz7YpLKD2oc7aezBjaNKSuwfm+mT6HG6oiRdLwjv9MiaEvtS1G3GGX
         wRDCmK5OdsHiU7NMqGTdOGCNBzjtue5mpLMU6/bBVomL4R3DOWbf+RcxYU285WEhPacK
         lT8F740ckDCJ26TlFZiiBK+k2biXmufFmbm5Vu1yBlR0PskGQStYiK6n/+x/95ZTTIZt
         IYpg==
X-Forwarded-Encrypted: i=1; AJvYcCVghJ5ve03R4ivHS9tIC2Piukp4Bdv7QgcbKfwJCU5qPLvZA7wtzozToML7XiLNykj21FtmKnpRRfEN7CPy4ztCmL/r4/A0MIGL
X-Gm-Message-State: AOJu0YwZgwrJnCcbTxRYvfHt7snmLYj1DowYA81XoN12DhKllV4TXtRu
	tfzsa45NkKExFAPc2CN9lrjg/jw5eRUdqSIBd3zGrjBcRD5Ey91PT/jHfIiwqPI=
X-Google-Smtp-Source: AGHT+IExdGa5rGS/22T53uS80/g8TO4jGAJIp46+PqMsXAM1a+dNmdOR9XUe5M3Ut5BW90bUdVCchg==
X-Received: by 2002:a05:6a20:6a0b:b0:1a7:aa08:16de with SMTP id p11-20020a056a206a0b00b001a7aa0816demr2218545pzk.40.1713956593648;
        Wed, 24 Apr 2024 04:03:13 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id it4-20020a056a00458400b006e623639a80sm11592482pfb.19.2024.04.24.04.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:03:13 -0700 (PDT)
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
Subject: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
Date: Wed, 24 Apr 2024 19:02:24 +0800
Message-ID: <20240424110223.21799-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
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

 drivers/pci/pcie/aspm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c55ac11faa73..553327dee991 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1402,6 +1402,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
 static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u32 parent_l1ss_cap, child_l1ss_cap;
 
 	if (!link)
 		return -EINVAL;
@@ -1433,6 +1435,16 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
 		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
+	/*
+	 * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON and
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
2.44.0


