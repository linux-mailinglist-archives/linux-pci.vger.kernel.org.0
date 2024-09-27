Return-Path: <linux-pci+bounces-13595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D7798829E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 12:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D020B2563D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBCE1891D4;
	Fri, 27 Sep 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="jSGCrRrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BDF156864
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433414; cv=none; b=O9k6QAt/j/RaQS2nkXBfRN9Rga3imLtpAP6DozY+ikmOf7IB4hOtzNwAIKOAY1K7LGxdHR2f9S6okK/Xr1FncHcQzXSjMcfoGPgsJNAjws7ilVPgfD8HWPT3UkVW7hVdQ2j9jvgBNIOBzt8nBIX81H7N6r8HfIjNdh/y7soSkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433414; c=relaxed/simple;
	bh=y3FXP+giOaa0bTHNOIiOqrz67Of+uUBaKr7xcqryCuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmRR6HDlI8gM5b0nAox4oJf7A5iZMPnT2+HhK4RfxLgufHIAImNnk1Iwq5r0oNHYMIwtMwWaTNrvLgzTsa4dzHLnc/ySjWJJnzHfyyTepZHHO/lzi4ljh4I5C8lI4fR6kY7WThK1OnK8sBFdxEDwnrkX8bV2j45qoksDfRlMObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=jSGCrRrA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e053f42932so1503287a91.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727433411; x=1728038211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G55JHJhI3qkxlwOlcFB2xhqazWP5g+D6GuyYd2HAN1Q=;
        b=jSGCrRrAOdE7/wjdcR20hhFGpGuuD/eAAqySx1LVLYIP/mOGevML0Lc1/EV74Y5nOJ
         PBDExRN501LK8WqEtm/eoUfu4+nrdhduVNns8yeNqZlQ0VmnmsOY3Tpr+Pui6FJV2MbZ
         DNSqwA9luvWFZsRcdfNzmG/TgtoK4vvw1oJ5URH4sLojLPtZSwY5Eola3MJfc38ySMb8
         WCVEHbGh89xd2dGJB34g7v1elf4+NWftq2CV5WsouJkdhrWNdTsuOH5wBhOxiUjlOLcy
         r+zh/i1mgblvjbwlhV+y5TLL6xqCY8cOM/c4HL535yAA7bIi6bcirRUbwg0veJGoCAfS
         8+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433411; x=1728038211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G55JHJhI3qkxlwOlcFB2xhqazWP5g+D6GuyYd2HAN1Q=;
        b=INVdBPRUztvYCPWF4J/FFvRIc4Ir3FK/vHf+cAAaKUGwphKlrqY4PIVRLPQ+pAEqUR
         gaPR30iD1POrgr2Yy62WvqL/YaCtwoDVEeERy0FgrOV27j4/ZkTIOwjyU7zZOyD3Phaz
         7dd6R/FaI4+g9N6NfXTWef8uH94NsPtiblZ9usMlntDFXHg1I08GcQfvKCPPZjfa2jIG
         Oo55duJDkcM4fQr3DjeiNT2h++8tRz5O2qjFU6b7RwPVYAWOC4L76fq1qRkunw8AbWFg
         ZBT+HcDZVMvkNZFc922GJTHB+4fNzABVQnSSlhLJwJPwMZ5zFGUXJrNq6+X+gb1ukJwb
         D7tw==
X-Forwarded-Encrypted: i=1; AJvYcCXoLSO/OppgfqsAtgJNByGIGAX+H6UKHrqkDWJLRjuFwUJ7JjabB6OX55qR1WGnMQVFGXzVHoalg1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbl8pYffUnCr2/32KTOIXgaCD5LBXmKdPAc150vSrHwgCFD28l
	yy1ACTQZRC3skZCdD2rnqeCpT4UmIRYf1ISidMpje4G8OuUZ2CX+RsVStSy+mmg=
X-Google-Smtp-Source: AGHT+IEOCmycZY2cGaK5utdLVzhwCqkIWWFB/+435nxWSLC1tqzJCayG612KqIrzMA24Q+k1herCcA==
X-Received: by 2002:a17:90b:360c:b0:2d3:c87e:b888 with SMTP id 98e67ed59e1d1-2e0b8ebcd31mr3051772a91.27.1727433411235;
        Fri, 27 Sep 2024 03:36:51 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e06e1cd35asm5177819a91.24.2024.09.27.03.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:36:50 -0700 (PDT)
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
Subject: [PATCH v10 1/3] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Fri, 27 Sep 2024 18:36:12 +0800
Message-ID: <20240927103612.24582-1-jhp@endlessos.org>
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

v10:
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


