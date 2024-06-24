Return-Path: <linux-pci+bounces-9170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E691445F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DEBB222A5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1524AED4;
	Mon, 24 Jun 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="BUF9lKrc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D814F201
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216944; cv=none; b=iy1BS1SijmVwC1TwGZdOi10KP/D0AqUHzbTgWc59tkZOT42trnwshOp+8OkR/VNoaxcNIXZH6lasmxYnQL32tFlK1ShOEKQwpaJLVBVRmNuNg174fHewaQqNsHjS2Zr4WxQJZYep8LotPmr3N0+f72v0h7AMe3MuHOQWoPocxbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216944; c=relaxed/simple;
	bh=CjLuYcz29twZ86M/ctQCbOvGSLYLZ2EmzaSKfiu4jBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQMZzCxsRiuXFC6xnVGNI3W4hNN4ePCCBlFWqZddI/8lEWgTZ+Vh3SEEbz4kR1O/lJbSFdC4waPzzLWqHTTJ3kjh3raxygyq8Y7jr0dHNjITffs5gcrS4C6N2nSTA/NmG3v2s+iELzP4zMG/NUQz78F9+4IqRfw50VQ9u4hOopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=BUF9lKrc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07acd3so32674575ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 01:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719216941; x=1719821741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bykc5Adp4kAKq+9EFQqxeEMKoB9hzt4fqeNrroz1JRY=;
        b=BUF9lKrc+b/mcwb+ks0nvrpw6gogmkPtwUjMJ+d5Mi2v9Zrpm1c3Gdl5Rbn7XfRTnM
         RnyPm3ci7zgFovFTjQGCCYn2Qw+LpCfcHkpZfdoqpQy89IoQd3vTEWeBeUcPSx8A9GI6
         3vOHdLx5V8W7S2CXLAE8n9ggKtCODtq4axdc0UxUJg4S5ESBOaD3jcQnI61mXtu98PBd
         xp/gLzqtiIokN6i+DZjX3Eu/wjq0Mcubeyn/5sQu8AMlDN0tD2KKfyeHXVb5trZsEeaF
         Zazch3S6ySoLUrBeS9IBUeWw8WZcykin1oa717Wh9+3tF0b8nJNgzmuPmcfK5ExQk9YT
         U0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216941; x=1719821741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bykc5Adp4kAKq+9EFQqxeEMKoB9hzt4fqeNrroz1JRY=;
        b=JyND6zY0Z1MmecQPB025GvI0JWe2cDbtm1fx4+Eg4+5PmNThDIkIhn1ksOTn3kknZV
         9v2HGYt6Wldg/S/ciNMBsHY7kQOtjLSjQSUwiM9+jHYxfouL9gbjLr6AniGBHkJQWYsb
         rBwTANnhzK2jRWQDUMXLkJk3QH55NK+2pMgr8InRfqrTHcW0/e8kfum3LZZAnoJBgHq+
         AvkdFRHnQJ70tINYPP2bsHadHATZTDgRg34VN10nzsgTC5AWAXXN2bwXw6MR5aGN3NlE
         eSGPiFQiI6IPFxaLeJMTjprZ2Uh8MuKNdfAS4JbPRsianmvtKyyYu37aJtIoT+I2mn36
         2Ouw==
X-Forwarded-Encrypted: i=1; AJvYcCUvJdzKkqgchYxhg0T68hszpFQ7MtSc4DUhyiTuPP3o4S3hFvWzpbF/wg3UT45/f8YNJwElwz1VI4H6FY2T4zToty/+kaXc003p
X-Gm-Message-State: AOJu0YxPQozrxw1HkLodXHCTVRdygZI7jTPL7A68tCFSCi5XTrQjkbRa
	8bysu9z3VbcN+cD//O6GCFl6dI3PqZfn77W8S3TmMmcQsSBqhKu52lHneRnEzK0=
X-Google-Smtp-Source: AGHT+IFIN5qwmK2F5vLzDXKBZU0Nd/r8LpTXxCp7IHSJVDsZnbBK2g6IJ1jps5xuEqKR+HKMLW9gtw==
X-Received: by 2002:a17:902:d4cd:b0:1f4:b43f:9c01 with SMTP id d9443c01a7336-1fa1d6a9349mr47525865ad.64.1719216940967;
        Mon, 24 Jun 2024 01:15:40 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9ebaba068sm56960035ad.248.2024.06.24.01.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:15:40 -0700 (PDT)
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
Subject: [PATCH v6 1/3] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Mon, 24 Jun 2024 16:12:49 +0800
Message-ID: <20240624081248.10177-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624081108.10143-2-jhp@endlessos.org>
References: <20240624081108.10143-2-jhp@endlessos.org>
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

v6:
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


