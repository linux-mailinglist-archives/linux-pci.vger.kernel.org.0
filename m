Return-Path: <linux-pci+bounces-191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E027FACA2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 22:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC2CB21210
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491E46456;
	Mon, 27 Nov 2023 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9X870oi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A166C1
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 13:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701121075; x=1732657075;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Askn3CM4iN3poW4uYeY9hhNQm25R+3aeB5wZVwuF8Nk=;
  b=M9X870oibNzya0Z6WQ6pJC/40Hx6mzBhqf+fVBoHW6mMN7Iv/ldQVbif
   oxObOglFTiLJ+QASff/jsycx2is8Ilf+OFwOf4RNurTyw3Hh57dkodLq/
   1QCldPPskKLp89a1gBsXBMYRaLAq4bfbQZXoh4iatIa1u86Vepzlvq0XN
   Wp7Tc9BKhW7PJbHXASWo8mUSnsYSqCPm0ZWbqR6ghTeXqWxtc5NZHzmll
   G7A8n0esZycgtanr70aynSoCkzsCEt4qVa7IwUzPRt2AHNnBs0wGlGRPv
   7Og/f4SNoP248oe696j1N73DGA296RzddscU8T1xY7dEJhgDgPWO9prHN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="11491145"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="11491145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="16726085"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:37:54 -0800
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD rootports
Date: Mon, 27 Nov 2023 16:17:29 -0500
Message-Id: <20231127211729.42668-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently VMD copies root bridge setting to enable Hotplug on its
rootports. This mechanism works fine for Host OS and no issue has
been observed. However in case of VM, all the HyperVisors don't
pass the Hotplug setting to the guest BIOS which results in
assigning default values and disabling Hotplug capability in the
guest which have been observed by many OEMs.

VMD Hotplug can be enabled or disabled based on the VMD rootports'
Hotplug configuration in BIOS. is_hotplug_bridge is set on each
VMD rootport based on Hotplug capable bit in SltCap in probe.c.
Check is_hotplug_bridge and enable or disable native_pcie_hotplug
based on that value.

This patch will make sure that Hotplug is enabled properly in Host
as well as in VM while honoring _OSC settings as well as VMD hotplug
setting.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v1->v2: Updating commit message.
---
 drivers/pci/controller/vmd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..e39eaef5549a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -720,6 +720,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
 	struct pci_dev *dev;
+	struct pci_host_bridge *vmd_bridge;
 	int ret;
 
 	/*
@@ -886,8 +887,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
 	 * run on each of the real root ports.
 	 */
-	list_for_each_entry(child, &vmd->bus->children, node)
+	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
+	list_for_each_entry(child, &vmd->bus->children, node) {
 		pcie_bus_configure_settings(child);
+		/*
+		 * When Hotplug is enabled on vmd root-port, enable it on vmd
+		 * bridge.
+		 */
+		if (child->self->is_hotplug_bridge)
+			vmd_bridge->native_pcie_hotplug = 1;
+	}
 
 	pci_bus_add_devices(vmd->bus);
 
-- 
2.31.1


