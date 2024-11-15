Return-Path: <linux-pci+bounces-16829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD69CD9D6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89E5281270
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47634174EE4;
	Fri, 15 Nov 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="OPlKUeEO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA68185B78
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655477; cv=none; b=GhuTCCRh4VXUEHWjY9PGIFdH7Zo93UtZ6ziW3P5PnFfqpv6ub3wCZm4kOyDWiz4X0KmA1czsYsLX+eWLWdSR4t1+pzczVOimCLCtm70rQ/CiVSo/vwOYO8aY95pw0MVmv4+JSdMTolsFFgU8QkjWzSCeh9uL5yn6W+NUfHFOzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655477; c=relaxed/simple;
	bh=NL5xVxsuzvL3vH8bbRzYLv+5EaPNoZfot6E1kNnXNvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGgfyHw7G9CUjaz9eIgedU4RBS0Q92NSsUj+dF7yczBL80+St0RY52AI3xXtkN3xPbcrA5mg41yvs25fohb19V/gqUqezCNyU/RzeDENttdoP0ZUCyGJa/Hi/m6B3qXDsFV0erBAwh8LL928TPzx6ZbbYc75QaggZY2ohFEpE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=OPlKUeEO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720d01caa66so422917b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 23:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1731655474; x=1732260274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb+RffXXFUXRR+60cUKB6Fw/MnIHpohg44rBpl2XD8g=;
        b=OPlKUeEOEtis6//6CEXw3E48G7lFCZbMbfSdhx0CYtcKdwEEXDuUEJSwgA1uko68eo
         rkP8qqHsLdkd1+NXQtDadI8GLxGdMUih41PuQznU5sRXHfSNS0wFQ6uybzf+ycbww03g
         Ju28S7Ht9knQE9Ik8d56ucGgYBiFElZMPcPOoeeJeo7fDgwd1UdEXt6MWz8Wz8oSi8IT
         0EN4RBa88a/+NOakY5CZRgplszdCiTcJlhg9syuu4NZ9mUbcqFU+SV0IBJ27iiNclHcl
         B0umfBlnsOOPr5uu0wBVdG39U95Sb0+8dNP6km7BW5SAzJlgNlrdJDt+jk+rBzdMAzu6
         U4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655474; x=1732260274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nb+RffXXFUXRR+60cUKB6Fw/MnIHpohg44rBpl2XD8g=;
        b=HzF7aGj0bKK8kBS7e57+D8ic2h4X4QVqeUowpS+ER1ySQfqycLI7SNrNtUH/mPCiPz
         Mftv7ddxIo1Tl6UKC+uDJEyC4Ey13GD2pvbSgOiOoHm5+xS/d70WgzLHWYZ6as8m247z
         3qUU2RWpMR9OX6Y4a8MwQJhlsddPGOocOPKTDozCZObQD7e1+xf0HCXqasYdWKh8h0Bd
         ct97hm5qeufkL8yhLDS9VtaK/3jczw6Q1wLeVbbnFlGhWw0qfGUhdqXfe4f6TTA1sJ8S
         w9z8TiSrwPEBlh8sL0KwdUBrSGaQg8KYRdSy6ExjGHP/nME29ymTBXaq8BTxk7HL4JjE
         kAXA==
X-Forwarded-Encrypted: i=1; AJvYcCVjK4mPq5u91HO8/n+bjDTsacxo92e2smbz8/WiopRjRdufLfcM3OG8NRrCo/dDc8KTZ0fE6eU0FlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwiCQvVYdIBE8zr9wxoMlS3wLcDIJSOPGBUsfVEJEg9goFKqdQ
	0RbbcBpsU1bdQCd6RmlTsTmwO4DahUJIpodwmMRTmZX4WAgjzKlR1tyjKVnRuD+Owu7Jc0Vl+9t
	T86E=
X-Google-Smtp-Source: AGHT+IE/129tVOmbMdhuBPXaY/T2Fqs6kV2/8QP2wxNSSFmLjdIbTfYG1v8hd30zA7v2zr2y5GBmYA==
X-Received: by 2002:a05:6a00:c91:b0:71e:693c:107c with SMTP id d2e1a72fcca58-72476baf03bmr2019990b3a.11.1731655474096;
        Thu, 14 Nov 2024 23:24:34 -0800 (PST)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-724771c0d37sm756766b3a.104.2024.11.14.23.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:24:33 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH v13] PCI/ASPM: Make pci_save_aspm_l1ss_state save both child and parent's L1SS configuration
Date: Fri, 15 Nov 2024 15:22:02 +0800
Message-ID: <20241115072200.37509-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.47.0
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

To avoid pci_restore_aspm_l1ss_state() restore wrong value to the parent's
L1SS config like this example, make pci_save_aspm_l1ss_state() save the
parent's L1SS config, if the PCI device has a parent.

Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: David E. Box <david.e.box@linux.intel.com>
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

v13:
- Tweak the commit message to make it more like a general fix
- When pci_alloc_dev() prepares the pci_dev, it sets the pci_dev's bus.
  So, let pci_save_aspm_l1ss_state() access pdev's bus directly.
- Add comment in pci_save_aspm_l1ss_state() to describe why it does not
  save both the PCIe device and the parent's L1SS config like
  pci_restore_aspm_l1ss_state() directly.

 drivers/pci/pcie/aspm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 28567d457613..0bcd060aab32 100644
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
@@ -101,6 +101,22 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
 }
 
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev->bus->self;
+
+	__pci_save_aspm_l1ss_state(pdev);
+
+	/*
+	 * Save parent's L1 substate configuration, if the parent has not saved
+	 * state. It avoids pci_restore_aspm_l1ss_state() restore wrong value to
+	 * parent's L1 substate configuration. However, the parent might be
+	 * nothing, if pdev is a PCI bridge.
+	 */
+	if (parent && !parent->state_saved)
+		__pci_save_aspm_l1ss_state(parent);
+}
+
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
-- 
2.47.0


