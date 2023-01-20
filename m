Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ECE6749DA
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 04:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjATDPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 22:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjATDP3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 22:15:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155E79F394;
        Thu, 19 Jan 2023 19:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674184528; x=1705720528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JekCCMDvu3Vw1jKwH0W0YN6B08jNIg7G5QXeYb9gH0g=;
  b=h8hhQ1OftxcLERppST1vf3fLvS1hs/OmS6/tNR/Nf2BJmjQysCQ7GSRx
   oUoLd5s5Zn/p+mp8cDppLwvRPN0QcCYa2WBcOd/BpFidedfsOeZeIJOYj
   GPLuRnc466GoYR4fEbGoQMSTvl3nhpeMe+fSHS5QGaZiBlzTycVDR7fzw
   Sd+Cu1AM7dtxwSTMdAPJvt4djkWpw4L0iHZhhdEYEvLxnqnB7Bmfj//vW
   oP7Nx56ByKgI2lAMawDRuPS9LW04SEIDoYK2TZHr+uzBgtDijI8HXAAzU
   oXTrbVU5s/v64ZOJm3J0KUEqb7gfqZJ6koIhoGEuFM4TCOWtcQ1ch6lqM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="390012704"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="390012704"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638009323"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="638009323"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 19:15:23 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.255.207])
        by linux.intel.com (Postfix) with ESMTP id AE58A580C4A;
        Thu, 19 Jan 2023 19:15:23 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 4/4] PCI: vmd: Add quirk to configure PCIe ASPM and LTR
Date:   Thu, 19 Jan 2023 19:15:22 -0800
Message-Id: <20230120031522.2304439-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120031522.2304439-1-david.e.box@linux.intel.com>
References: <20230120031522.2304439-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe ports reserved for VMD use are not visible to BIOS and therefore not
configured to enable PCIe ASPM or LTR values (which BIOS will configure if
they are not set). Lack of this programming results in high power
consumption on laptops as reported in bugzilla.  For affected products use
pci_enable_link_state to set the allowed link states for devices on the
root ports. Also set the LTR value to the maximum value needed for the SoC.

This is a workaround for products from Rocket Lake through Alder Lake.
Raptor Lake, the latest product at this time, has already implemented LTR
configuring in BIOS. Future products will move ASPM configuration back to
BIOS as well.  As this solution is intended for laptops, support is not
added for hotplug or for devices downstream of a switch on the root port.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212355
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215063
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213717

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 V10
  - No change
 V9
  - Added BIOS quirk flag to VMD_FEATS_CLIENT flag, suggested by Sathya.
 V8
  - Removed struct vmd_device_data patch. Instead use #define for the LTR
    value which is the same across all products needing the quirk.
 V7
  - No change
 V6
  - Set ASPM first before setting LTR. This is needed because some
    devices may only have LTR set by BIOS and not ASPM
  - Skip setting the LTR if the current LTR in non-zero.
 V5
  - Provide the LTR value as driver data.
  - Use DWORD for the config space write to avoid PCI WORD access bug.
  - Set ASPM links firsts, enabling all link states, before setting a
    default LTR if the capability is present
  - Add kernel message that VMD is setting the device LTR.
 V4
  - Refactor vmd_enable_apsm() to exit early, making the lines shorter
    and more readable. Suggested by Christoph.
 V3
  - No changes
 V2
  - Use return status to print pci_info message if ASPM cannot be enabled.
  - Add missing static declaration, caught by lkp@intel.com

 drivers/pci/controller/vmd.c | 55 +++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 47fa3e5f2dc5..990630ec57c6 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -66,11 +66,22 @@ enum vmd_features {
 	 * interrupt handling.
 	 */
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
+
+	/*
+	 * Enable ASPM on the PCIE root ports and set the default LTR of the
+	 * storage devices on platforms where these values are not configured by
+	 * BIOS. This is needed for laptops, which require these settings for
+	 * proper power management of the SoC.
+	 */
+	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
 };
 
+#define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
+
 #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
 				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
-				 VMD_FEAT_OFFSET_FIRST_VECTOR)
+				 VMD_FEAT_OFFSET_FIRST_VECTOR |		\
+				 VMD_FEAT_BIOS_PM_QUIRK)
 
 static DEFINE_IDA(vmd_instance_ida);
 
@@ -713,6 +724,46 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 	vmd_bridge->native_dpc = root_bridge->native_dpc;
 }
 
+/*
+ * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
+ */
+static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
+{
+	unsigned long features = *(unsigned long *)userdata;
+	u16 ltr = VMD_BIOS_PM_QUIRK_LTR;
+	u32 ltr_reg;
+	int pos;
+
+	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
+		return 0;
+
+	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
+	if (!pos)
+		return 0;
+
+	/*
+	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
+	 * so the LTR quirk is not needed.
+	 */
+	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
+	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
+		return 0;
+
+	/*
+	 * Set the default values to the maximum required by the platform to
+	 * allow the deepest power management savings. Write as a DWORD where
+	 * the lower word is the max snoop latency and the upper word is the
+	 * max non-snoop latency.
+	 */
+	ltr_reg = (ltr << 16) | ltr;
+	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
+	pci_info(pdev, "VMD: Default LTR value set by driver\n");
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -885,6 +936,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
+	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
+
 	/*
 	 * VMD root buses are virtual and don't return true on pci_is_pcie()
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
-- 
2.34.1

