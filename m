Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160817A1DE9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 14:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjIOMC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjIOMC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 08:02:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D68E139;
        Fri, 15 Sep 2023 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694779335; x=1726315335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWLIDmT8V8yYTYSf+Z4MKL980NvQzXj0f/SDHZh0VdQ=;
  b=Y9159pSIuvrK4qQhk+Q8PvaF+vtuq4B5y1syorMmjmbqT6cmS1eRa18U
   HQhHHvw3xLahBS9JBnUpg774hbIl95AkFtJlZ9+byPB6tOPudJZ5/Uocy
   1RiNI2HLWaReBdzuNIGNanTPjsZPiPXtMGP3HNH1ZBFWHkXNJoreAU4QE
   JAAto/Mq8/ZVYDhL4EFY/3ZbI3yYFNhHlGNgU9oqKBt7KRvbdICm/FIBn
   Hvqkc6HuPU/ST0NYgKDTkvsLqbQZJuFzjlAAW//hB/QQnSBKlRmyCxeuh
   2UXRdUA4WNFIcNkIgL/6ZNL6sGZLb2805WIByIm4LaT/2kRrFqbDLVJvs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378145982"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="378145982"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="774292805"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="774292805"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:02:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 03/10] drm/amdgpu: Use RMW accessors for changing LNKCTL2
Date:   Fri, 15 Sep 2023 15:01:35 +0300
Message-Id: <20230915120142.32987-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915120142.32987-1-ilpo.jarvinen@linux.intel.com>
References: <20230915120142.32987-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't assume that only the driver would be accessing LNKCTL2. In the
case of upstream (parent), the driver does not even own the device it's
changing the registers for.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value. This change is also useful as
a cleanup.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 41 ++++++++++++--------------------
 drivers/gpu/drm/amd/amdgpu/si.c  | 41 ++++++++++++--------------------
 2 files changed, 30 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index e63abdf52b6c..7bcd41996927 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1638,28 +1638,18 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
-							  &tmp16);
-				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN);
-				tmp16 |= (bridge_cfg2 &
-					  (PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pcie_capability_write_word(root,
-							   PCI_EXP_LNKCTL2,
-							   tmp16);
-
-				pcie_capability_read_word(adev->pdev,
-							  PCI_EXP_LNKCTL2,
-							  &tmp16);
-				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN);
-				tmp16 |= (gpu_cfg2 &
-					  (PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pcie_capability_write_word(adev->pdev,
-							   PCI_EXP_LNKCTL2,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL2,
+								   PCI_EXP_LNKCTL2_ENTER_COMP |
+								   PCI_EXP_LNKCTL2_TX_MARGIN,
+								   bridge_cfg2 &
+								   (PCI_EXP_LNKCTL2_ENTER_COMP |
+								    PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL2,
+								   PCI_EXP_LNKCTL2_ENTER_COMP |
+								   PCI_EXP_LNKCTL2_TX_MARGIN,
+								   gpu_cfg2 &
+								   (PCI_EXP_LNKCTL2_ENTER_COMP |
+								    PCI_EXP_LNKCTL2_TX_MARGIN));
 
 				tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
 				tmp &= ~PCIE_LC_CNTL4__LC_SET_QUIESCE_MASK;
@@ -1674,16 +1664,15 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 	speed_cntl &= ~PCIE_LC_SPEED_CNTL__LC_FORCE_DIS_SW_SPEED_CHANGE_MASK;
 	WREG32_PCIE(ixPCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
-
+	tmp16 = 0;
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
-	pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL2, tmp16);
+	pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL2,
+					   PCI_EXP_LNKCTL2_TLS, tmp16);
 
 	speed_cntl = RREG32_PCIE(ixPCIE_LC_SPEED_CNTL);
 	speed_cntl |= PCIE_LC_SPEED_CNTL__LC_INITIATE_LINK_SPEED_CHANGE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 4b81f29e5fd5..8ea60fdd1b1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2331,28 +2331,18 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 								   gpu_cfg &
 								   PCI_EXP_LNKCTL_HAWD);
 
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
-							  &tmp16);
-				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN);
-				tmp16 |= (bridge_cfg2 &
-					  (PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pcie_capability_write_word(root,
-							   PCI_EXP_LNKCTL2,
-							   tmp16);
-
-				pcie_capability_read_word(adev->pdev,
-							  PCI_EXP_LNKCTL2,
-							  &tmp16);
-				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN);
-				tmp16 |= (gpu_cfg2 &
-					  (PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pcie_capability_write_word(adev->pdev,
-							   PCI_EXP_LNKCTL2,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL2,
+								   PCI_EXP_LNKCTL2_ENTER_COMP |
+								   PCI_EXP_LNKCTL2_TX_MARGIN,
+								   bridge_cfg2 &
+								   (PCI_EXP_LNKCTL2_ENTER_COMP |
+								    PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL2,
+								   PCI_EXP_LNKCTL2_ENTER_COMP |
+								   PCI_EXP_LNKCTL2_TX_MARGIN,
+								   gpu_cfg2 &
+								   (PCI_EXP_LNKCTL2_ENTER_COMP |
+								    PCI_EXP_LNKCTL2_TX_MARGIN));
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp &= ~LC_SET_QUIESCE;
@@ -2365,16 +2355,15 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 	speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
-
+	tmp16 = 0;
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
-	pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL2, tmp16);
+	pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL2,
+					   PCI_EXP_LNKCTL2_TLS, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
 	speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
-- 
2.30.2

