Return-Path: <linux-pci+bounces-13674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4856798B71E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 10:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965C7B22D2C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E419B587;
	Tue,  1 Oct 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ARtI2gQc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D1A199FD7
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771814; cv=none; b=mFAj9wext5bX8hkluZqFIPfx8+87O+fom4YZxREiIQRhowOzfrlaQnaiJGIay5iIPR1m6V4vLCJCjBrY6azXmN+HRxkt2CrnzvKJlbtLkBX7RZXZH9AvydLcfBaGvo/0Xd2slRzv6JvP+XFO/Whuh6Mti9YVvEkptaxYKS0eD9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771814; c=relaxed/simple;
	bh=YHdjDc5QvQTv8dnV4uC66vaWOywXjzF86Je+wGkstBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6yECbGFw6tUerj1P5wFZ8Ch38UKEHyEzwOihZVm2+rbFdYq0fI1H1AHuPEhxzqQOtiiZPfQSFz6nTKpfVcz4nnNFa4RDBCxHrGBsjoVqS6N01raOTB/GIWz7xdFBc+GB55xMQgar2gHLwNx3iDjv1scMQYcdTHPYwb1+xtZX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ARtI2gQc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71970655611so4861930b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727771812; x=1728376612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z8NJ9hl39zdRTB+NTLcPqploqSnWXD1+zopcYnbALw=;
        b=ARtI2gQcMgKPmZ9OGkN8dtW8Nal73fVZJFK6MsJZlCkDhftoLNtUfZWeJhrQ7P4U51
         WkUu7HwYed0XUsPpSIWYBCN8GL5q6spwXaUdwrGxGaFwOqrabElD0U3DR4Hn1ksJD8B/
         zwNbcqdx/e8Gq7ufHeWem4+/huBgFX9XXmi/blpzBcl6nJ5lUJOsMRaUwcGTayb92wEw
         19CTkEaz79Pj1jCk6Uk/7WtR7jFtW7x6eT/PDBvPWOh+YVTCVKgbm2Uqa4vzYcOtMTf9
         jsFAzNkT51aBJdXGxjjSbaIXNS7eGXtf6+I4VjSOvpMnpa+BA45Gk7UZUF+M+u053uE7
         psJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771812; x=1728376612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z8NJ9hl39zdRTB+NTLcPqploqSnWXD1+zopcYnbALw=;
        b=rMYvTXohPCtbuT1OtUtIfDIwmIRfzKEYIRpRNhbmBMsV2eX0bppnJr1NGpE08ieKDY
         ie9THh08NrFBCD1iJmk5t4kbBFPZdxgijqpXia0neLEvG0VXDSmQ0GSeqHWcjVho8Xyi
         Qx0hK1Rac2s+HZ8PpWR492zzslRVX5WL7vlYytl/tduUMTMMC2a8Kg+H/7jYgoJ5dn/G
         jjDAqi4Yf+1UuWUiSi0rFpmzKLKKrHiwKpXxKUcSrsg54GoepyRKKBjMdfE7ZpsAfaLI
         7Ykz+2gIZ/hTm6KWm+ImTUcZMqo30zXuuR6+U190wFVact4AVZvAHTyjjqu+1imJdUEo
         dSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH0yKwg0wD73cWgTJHa0ovHqsX9NxiehBj4rouxqXrfjAnNDz0S41OTaTb2kDQYvLNTce48seAlOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6Ay5muN/+PzEWC58O2xczGdoSp4viBvhI0zp42w7jxZ/te4J
	aaDexjazLvB1KRgN2+b16BuCVhXCDe4xPUYzq5Evx2wWsYfUZqZX+oWeWz7XD0o=
X-Google-Smtp-Source: AGHT+IHicMH52afTHUITowduriNVU2SjBxq7UkdTpUK5KcNuYFt1T1q2ODACpF5e9RkCC942eEKIZw==
X-Received: by 2002:a05:6a00:1ac6:b0:70d:2b95:d9c0 with SMTP id d2e1a72fcca58-71b25f6b4f2mr23654157b3a.14.1727771811736;
        Tue, 01 Oct 2024 01:36:51 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b26516148sm7521573b3a.110.2024.10.01.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:36:51 -0700 (PDT)
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
Subject: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save both child and parent's L1SS configuration
Date: Tue,  1 Oct 2024 16:34:42 +0800
Message-ID: <20241001083438.10070-8-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001083438.10070-2-jhp@endlessos.org>
References: <20241001083438.10070-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
restores NVMe's state before and after reset. Then, when it restores the
NVMe's state, ASPM code restores L1SS for both the parent bridge and the
NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
correctly. But, the parent bridge's L1SS is restored with a wrong value 0x0
because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_state()
before reset.

So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
the parent's L1SS configuration, too. This is symmetric on
pci_restore_aspm_l1ss_state().

Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v9:
- Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.

v10:
- Drop the v9 fix about drivers/pci/controller/vmd.c
- Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_state()
  and pci_restore_aspm_l1ss_state()

v11:
- Introduce __pci_save_aspm_l1ss_state as a resusable helper function
  which is same as the original pci_configure_aspm_l1ss
- Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
  both child and parent devices
- Smooth the commit message

v12:
- Update the commit message

 drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bd0a8a05647e..17cdf372f7e0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
 			ERR_PTR(rc));
 }
 
-void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
+static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
 	u16 l1ss = pdev->l1ss;
@@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
 }
 
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_dev *parent;
+
+	__pci_save_aspm_l1ss_state(pdev);
+
+	/*
+	 * To be symmetric on pci_restore_aspm_l1ss_state(), save parent's L1
+	 * substate configuration, if the parent has not saved state.
+	 */
+	if (!pdev->bus || !pdev->bus->self)
+		return;
+
+	parent = pdev->bus->self;
+	if (!parent->state_saved)
+		__pci_save_aspm_l1ss_state(parent);
+}
+
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
-- 
2.46.2


