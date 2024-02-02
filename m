Return-Path: <linux-pci+bounces-2981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802C846935
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B9E1F23AD2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 07:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562F31799F;
	Fri,  2 Feb 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="c7TQfoqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054917C64
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858721; cv=none; b=uLpuTATr+NhS+quvKpbqWWRnELDqWPrPfYggxpMOUAm0QmgyS2nEQVrTcGk9CP0iXtkZAgUsKBb6nEWwTbJwDNNB/2EHnCTWMvz2QasaO0mdMbfIdB8QHxD4vhH7V3N8KRWuLCjmfoqfC5jyfqL0TJRLUkXsnIfGZ334e3f5/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858721; c=relaxed/simple;
	bh=wNy7U7w8pWIL0zpi8DS9mnETjYx9lJhJ8VvkKcLixVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qoug9xN8AQ242nSOYveWFzEPBWHxOVPUOER+UIiU9CeGX65Q4gJ7LqAzb43qdpldrk1mHPiD350ScB+Eo9fQgv2taKLLa8kVbarzxfTLwXWVwK4Qvle2+wDkaw7goKPxjl9TZLZPVeAcm9NcK/gt4Rf7dkBfQhC+zyRNCmP9wY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=c7TQfoqV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1423148a12.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 23:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706858718; x=1707463518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZkIYyyqlYFNT1lqciy923TmN3UIp12qeGkpjnu4yVM=;
        b=c7TQfoqVEjujc+cnxMubtFZZHzW81mzAjzkPKKcXH/+FLWfYRsbWrPOyQuYK0hcTrp
         loyByqcPrHgIg49TzlGa8CnqJDtooLleJ+7fdiFoCDLIp8ewWQj8zuoKiJY55iasow6w
         z0AJF1qQt6mBzm/J42DIH2hgbP/QOp/4oOdyiqEZ6PODuJEylGBZeL9dmHFp27wJKotF
         NuXMk9YygR4SKjz1+Mmx53zyc6XIEi26YxBr5Ss9Lyf4R1K5kn1Lg6a8MEpmbGH3saE5
         a1gz0OOANHSX5AnbqBCz5dyAiIXXS6D9H8MdYUEFvIwpR/4CCVh3ly97v7icQMUaD7NH
         O5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858718; x=1707463518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZkIYyyqlYFNT1lqciy923TmN3UIp12qeGkpjnu4yVM=;
        b=Wkqi8zyzr7SWUHxzw7KwIksekNcAlteLq9R4Ytl4W5n8CYSziZ/c+36C0crZsUHg18
         xptdRMdt0+bktnwmtgv8OjkWuf4i0iIPmm8eJ6NXrlZZ2Aq2wXF754+/AvypSy0/nMB/
         cjmUEAMU6VcR+YQ+6WFiBbuY/BdXL6jQY+HQpz/+QKjiS18tNyHhcJYvxJXLL83Cen3w
         VNDDu+YQFRsEsF57IbBpDadt+OwpfHkgbQnxUgtnT+t0CIOGcaYNwk9De9+nP1pId/PP
         83ngykLCD0evZmdaFt6uZ3s4tDBBLEEJUh4yMLfN+Tz5fPYUEXQDQISH0cgXIBK89DWV
         QUVg==
X-Gm-Message-State: AOJu0YzyoaGCL2I5vu4469XcmAiq7nmIlkJoL9NC/L61p2irx23EfIVG
	eH+8d742F6WA1k7moVy3Z0lmMJQrF2OLweGxNSuqz21DlMWqkas0uC/361ZBhDw=
X-Google-Smtp-Source: AGHT+IEJICP5Kt00xzxFTrHW/mbD2AkdWkFafMz4a9vIcrRCJv8yrrFA8OaCURl7NBKvEOHShyIe3A==
X-Received: by 2002:a05:6a20:af89:b0:19c:88c1:1878 with SMTP id ds9-20020a056a20af8900b0019c88c11878mr4212107pzb.23.1706858718122;
        Thu, 01 Feb 2024 23:25:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW33KELekP8WYe+iZAXFFMvFoCBk0C5ZZtWotl0dqjYvtmozg13QTMdM/pGnDv/1JcKO0b7ZsfuW8a0Xsoi0UFKx4PuJO8witn5E7aL7ebOXdkXWWiPb0jzZFzaD4krM/UOQnxRQfwFD9DXgVc4WympW+kYpL9t3bQwfAwSp0u8h3ez1ibP83pZIbprpwMdEhPGFoNR1PA1BazQBgZAJTcCu2/a8pEFyW1pd5sNTdfMg4DYFwDQ/UdxEm1NpgGVupVKpz9xg6WAiYannEYX4x+g+atYU1sVnWIVmeWt8oJn212fTyX7a4hxmCRDU1ghXMFFGM4R7f33oWBg+PDQSf76tC2UCyKg3gIwTBHS9+sA7ms8/QzGbeqYE0vOTrnv3g==
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id fb36-20020a056a002da400b006de39de76adsm907240pfb.139.2024.02.01.23.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:25:17 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Fri,  2 Feb 2024 15:11:12 +0800
Message-ID: <20240202071110.8515-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remapped PCIe Root Port and NVMe have PCI PM L1 substates
capability, but they are disabled originally:

Here is an example on ASUS B1400CEAE:

Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

Power on all of the VMD remapped PCI devices and quirk max snoop LTR
before enable PCI-PM L1 PM Substates by following "Section 5.5.4 of PCIe
Base Spec Revision 6.0". Then, PCI PM's L1 substates control are
initialized & enabled accordingly. Also, update the comments of
pci_enable_link_state() and pci_enable_link_state_locked() for
kernel-doc, too.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2:
  - Power on the VMD remapped devices with pci_set_power_state_locked()
  - Prepare the PCIe LTR parameters before enable L1 Substates
  - Add note into the comments of both pci_enable_link_state() and
    pci_enable_link_state_locked() for kernel-doc.
  - The original patch set can be split as individual patches.

 drivers/pci/controller/vmd.c | 15 ++++++++++-----
 drivers/pci/pcie/aspm.c      | 10 ++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..66e47a0dbf1a 100644
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
+		goto out_enable_link_state;
 
 	/*
 	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
@@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
+		goto out_enable_link_state;
 
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
 
+out_enable_link_state:
+	/*
+	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
+	 * Section 5.5.4 of PCIe Base Spec Revision 6.0
+	 */
+	pci_set_power_state_locked(pdev, PCI_D0);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
+
 	return 0;
 }
 
@@ -926,7 +932,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 				   dev_get_msi_domain(&vmd->dev->dev));
 
 	vmd_acpi_begin();
-
 	pci_scan_child_bus(vmd->bus);
 	vmd_domain_reset(vmd);
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bc0bd86695ec..5f902c5552ca 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1164,6 +1164,8 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
 		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
+	if (state & ASPM_STATE_L1_2_MASK)
+		aspm_l1ss_init(link);
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
@@ -1182,6 +1184,10 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: The PCIe devices of the link must be in D0, if the PCI-PM L1 PM
+ * substates are going to be enabled. From Section 5.5.4 of PCIe Base Spec
+ * Revision 6.0.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1198,6 +1204,10 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: The PCIe devices of the link must be in D0, if the PCI-PM L1 PM
+ * substates are going to be enabled. From Section 5.5.4 of PCIe Base Spec
+ * Revision 6.0.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.43.0


