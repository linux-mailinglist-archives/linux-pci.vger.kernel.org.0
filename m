Return-Path: <linux-pci+bounces-9279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7B917C9B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 11:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84A71F21F3D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3816A930;
	Wed, 26 Jun 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="tIC3L1QW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A68BEF
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394534; cv=none; b=P/RB6rdUKiN1m0MrfeNmNDWF6AIEmaDO/OOr8CK4W/YYEWMBufPXor7BtbkJhQs8xB7E6p4xseuseCtusGu4WC2R32lyWlSRYI/pWgMGq2z1i0w7nm87TNdwsCRGbgP22dYHYDOx5DlEqzP1R/oMTcTrY+DJfPR+g0d2W8mT4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394534; c=relaxed/simple;
	bh=K78X87jtcDtrl1rBAgUC04sDiKheqNq5YAD6b2AkW5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HW+LJl5WywZFoTFTlbhivgiT7o28kPBF4fv56Wby6enopvPltnEthheZ8RynZ8HYM4MRyQxYH16l0zj9hWrzcIDwgRCiqUvTJMlfmdOGIzU0SMLEYUdFIjnw7o4wGo8vpXkAh/OoD8eahKAqFEAE5XO9iiyZ8/97D+AnqitPA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=tIC3L1QW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so4772961a12.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719394532; x=1719999332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpeNWWySkoOjmL9GG/yU7x4/CpRAcKWqGhNrfk1bvDE=;
        b=tIC3L1QWXUwdgLLXXTZbEgOCFjqA0hmmMeq3fD5UL8VtQEdIWJOWDuPyg3a4GLMmS0
         dxPUmyKA2grVEePoNu27vhZ2CqNErdvu5OdMSr2fcYDGVp6T1QMqtEY6y+XlLl4Pa7pH
         9/nWoYOatYuQ9sxz4K8XpVvO1Tdm0v8Lz/h1D3IUnpAMDiCCiEfUpltpvVRY9u5j/ZOM
         PwXhMwIQr605rLjRoBN1gjjLdJ09Cs08Fed4prBOEW8mvYj18x33BmYkEJg3kWeDKlf6
         XUPS1eUjHBmmkDumDzdzeyrHTwXBL8/3BZYLNAkYz3SN+gVJpXLQ1Wkko6q0gT+Sy5X+
         RBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394532; x=1719999332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpeNWWySkoOjmL9GG/yU7x4/CpRAcKWqGhNrfk1bvDE=;
        b=fbbQ9XDpzhHuZ5kvh35Dood9sOWmw7CVL9j+wgUOWoRt3hi5P//FkSyLoG0ht89Ppx
         agEK0C9gZQvjYku9Eflla335DtiMxSfR/6wyL/Q0uGd0LmxesN1lhciApoJSNBESf1LK
         /LYQNQW9WTz051Bzzuz5rb78cdDXZYu1X2unnZY0EMO1kf7lwwHHCyVNeS4GzgK3eivq
         Ubimfr55GEvPavY6ZRKxLDGrofxv1Qcl3Ty8A5m1SFa87p/XLBkH6eVEVlKcVJGmj0Xo
         urVNErj3sS9XiqFGM8hHUMpzu1PWSXPXtWj0hTD2BCSLW8cSnCdpnC0zaCaLef/QDXI5
         g7dA==
X-Forwarded-Encrypted: i=1; AJvYcCVZJFWivkSzb2xg0D8CQJIKEPercws9285B6+CyJgRDeDDeAR0Y2lJ7g3/xVPVw/SjAhMmRZ7M6XgW8USax0hnEGBSHuqU695ma
X-Gm-Message-State: AOJu0Yz6rkFhZCV6cTAdo0UaLCwBGBGH72ifVbZPmCnDRD1oWker+p/g
	Qim/aBmRBV2ZcSbJR8C9jrhN8J07PAl1KcpU90FQ9ZejVrUHIgkvBOdncg3z5rg=
X-Google-Smtp-Source: AGHT+IGj8QfzxmFDjPa6B3ZrPipsx8DPw9AmRrI7+EDboHGSILtWSRt9gEHH8rAFh/SzcNpUcGsI0g==
X-Received: by 2002:a17:90b:1043:b0:2c8:db8b:7247 with SMTP id 98e67ed59e1d1-2c8db8b72bemr1101586a91.9.1719394531645;
        Wed, 26 Jun 2024 02:35:31 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c8d7e58fb5sm1201499a91.12.2024.06.26.02.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:35:31 -0700 (PDT)
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
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v7 1/4] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Wed, 26 Jun 2024 17:34:15 +0800
Message-ID: <20240626093414.14226-2-jhp@endlessos.org>
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

v6, v7:
- The same

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
2.45.2


