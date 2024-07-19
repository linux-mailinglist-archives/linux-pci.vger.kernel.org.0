Return-Path: <linux-pci+bounces-10541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85293749C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 09:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41BAB225CF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5547959155;
	Fri, 19 Jul 2024 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Rg8ukAKS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E654765
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375793; cv=none; b=itZ0P7wVkD+zLNHqFV7Ykmt8Cc51T7uGCklb6w4qt+E58VJs0z2fLsnxo8oqHf4JzghXEN4yvNhd+tFtvRXPoWpHAfMPobROrQ9VGu9vte3ygWy5G1va36q2mekcnD3dFTiW+kcc1HWDdgdi10sTHke4zDhy/mOfwHZeVcPFcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375793; c=relaxed/simple;
	bh=VVLI7EBeuyh7YB4ZWYo4aVqSu8I3Wae6ccX9RaRy7wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlXxO4bIs1OEUCcma/10VVuiTqu90VxsdgOk4fdUuXw0iPvBuXmX/UQQ+jqswryd03IRcI/b6vjxGKmjzkeXvZMRUuAuWpekqGmtp/tUh6l4LNcxtQSvYjx9KLXGJDd+nhiouf9WJY0qr8U1ZGxb667DV4B4pu9SH70/Cyt7HRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Rg8ukAKS; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3856b7be480so6399865ab.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1721375790; x=1721980590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zkHaNFtXIQ/P4HLzQzvdxFcOV87v0OUt5zn/ONL6Gw=;
        b=Rg8ukAKS9ly1i/ZszdUIK5pRhGueH6PPe+ogOtylRNilh+2MzeVDnCAfr6f7U3g1Ds
         qNVbGiUrbWjdQTkgpi25fl3GB8HJsJ3cNe8m2P0+mgQsV1wFx/C7M22pgJCWlPpx82Fy
         G33AXk7TDt5NHW9f+Ca6UPZx7BW2XVEyNI5GZVaSFSxINo2ytdA7RxJIWx77I3YZpjP9
         uDRFOV52Gcc2pTsOExKdovPRJebDsJ3iHVRIuhYnZNNZKv++a/Ve8RHuKw+NM4Wl9KuL
         xgQdrI5PFaq6WbPgIlrX6PnXgB06QGE3+E/GBDa2I4WDhvxe5MpeZ28Wtu8rC2CLuPSh
         bueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721375790; x=1721980590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zkHaNFtXIQ/P4HLzQzvdxFcOV87v0OUt5zn/ONL6Gw=;
        b=agg/8NtnhQ4jWm13eVsnQnuvEW+wR218euV2LcR+DCYCWhnQ/05o0V//u2D5syAM/w
         vgjnhqBDPH96NrWqgNpNZGRqNwGERD5XUWS48QAFTkf+JzG0isSyb7GaDefd81QvigsT
         WRO6Acm6p6dxwk1C135b9GgrHiHxnFYMygWP4OYwXUqKpbuPQuWRKaGwJytGBprThp1l
         GIiwWAJLaF+NkOvSeNzYV9BR5k+HAsYNJu8NVjkNgvOudlQcILC+e1fmj41h0xewyShm
         5hSV02YFVMojjPw76JCjudxppwJYQ5dM3+43tlSnKk2nfBul0zrfd+XG3YEucGApLIr5
         x1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUFsZVXF1LeDMQl63XcM4mEVwmCydE/QjPkIvUKLnoHF3ADD2GuAu4kjCp7FmQ44TmvlJGqgHcKjf9ILg3uqVyaUzLf9sa0ZCQM
X-Gm-Message-State: AOJu0YxxrsOtaYIoOnQy45r4GzNhcw7VlbWHR8xOJfGIjxILuE+yuaNK
	zH/0taZ2Guavq5ZNItGlLStXRWGf/MA6xa84uxTCpW9LcnH0Gw7rUIWgQSwPuWk=
X-Google-Smtp-Source: AGHT+IE0wORkD6pr4U4z9t7gs611kg67MGiYa52JMh5ONOt3fIFRWAhH+wStlHElGCaFj5DbYOXlXA==
X-Received: by 2002:a92:cda8:0:b0:375:9dd4:d693 with SMTP id e9e14a558f8ab-395553328c2mr95714975ab.3.1721375789914;
        Fri, 19 Jul 2024 00:56:29 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff4914b2sm675676b3a.33.2024.07.19.00.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:56:29 -0700 (PDT)
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
Subject: [PATCH v8 1/4] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Fri, 19 Jul 2024 15:55:31 +0800
Message-ID: <20240719075530.10852-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719075200.10717-2-jhp@endlessos.org>
References: <20240719075200.10717-2-jhp@endlessos.org>
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

v6~8:
- The same

 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a726de0af011..d021129d661c 100644
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


