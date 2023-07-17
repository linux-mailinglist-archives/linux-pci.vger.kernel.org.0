Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A35756266
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 14:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjGQMHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGQMHH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 08:07:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383CB1706;
        Mon, 17 Jul 2023 05:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689595598; x=1721131598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Dt11mJGY3uST81NgKzX3Wy33nGbeSvB9w1sz8eDsQc=;
  b=O9k65nRzmEeEi0ddeHsatk1jsa7IJDgvKCIkFzxk2QYFE2kLpki8XCyo
   v/GWCirw5RgyEjLnRX/8+XdWHc9awk8HQhWgjL5EQZI4GmXVOTHiUo7H4
   KHxwFnypQxAH7TvH29huzUCIzvVGu1Kt1cdd98JsNWh5cGidWSS8Ok9GH
   PXj5XOQpxRNNx1lNdIUoP7gU1it7VKHk2nzDLXIYgjhAgEXySFhNpNoXx
   1lax65pmkTizCOHzGd7eNDH+2hp5wICivN45EO0et9MKdXc/z4+4f0AOO
   V6Qt2ZSPFYLopkVGL94hdmobn91J6gaMup8XFeiRvFATmoc7xWJ+Tbeej
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="432081759"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432081759"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="752876238"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752876238"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:06:28 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 06/11] drm/radeon: Use RMW accessors for changing LNKCTL
Date:   Mon, 17 Jul 2023 15:04:58 +0300
Message-Id: <20230717120503.15276-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
References: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't assume that only the driver would be accessing LNKCTL. ASPM
policy changes can trigger write to LNKCTL outside of driver's control.
And in the case of upstream bridge, the driver does not even own the
device it's changing the registers for.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value.

Fixes: 8a7cd27679d0 ("drm/radeon/cik: add support for pcie gen1/2/3 switching")
Fixes: b9d305dfb66c ("drm/radeon: implement pcie gen2/3 support for SI")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/cik.c | 36 ++++++++++-------------------------
 drivers/gpu/drm/radeon/si.c  | 37 ++++++++++--------------------------
 2 files changed, 20 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 5819737c21c6..a6f3c811ceb8 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9534,17 +9534,8 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-						  &bridge_cfg);
-			pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL,
-						  &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL,
-						   tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(rdev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE_PORT(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -9591,21 +9582,14 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 				msleep(100);
 
 				/* linkctl */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
-							   tmp16);
-
-				pcie_capability_read_word(rdev->pdev,
-							  PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(rdev->pdev,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
 				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 8d5e4b25609d..a91012447b56 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -7131,17 +7131,8 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-						  &bridge_cfg);
-			pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL,
-						  &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL,
-						   tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(rdev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -7188,22 +7179,14 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 				msleep(100);
 
 				/* linkctl */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(root,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
-
-				pcie_capability_read_word(rdev->pdev,
-							  PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(rdev->pdev,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
 				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
-- 
2.30.2

