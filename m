Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE61ECEE9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgFCLsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:48:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:13358 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgFCLsI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:48:08 -0400
IronPort-SDR: BdnOEOPnJd3uBiSUErbHSR/0hRz2r8PjP8XRxZL4oapi8q0rkNgpnhmdKMuwVNF6wnzAVBFIQ5
 UfdM03VU5iVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:48:08 -0700
IronPort-SDR: xXYWtr/kEXDZu+jrLaPS+U4SfPyMrwiW2AyCAfH434gXKsVZc5Pcqvl1FGLYNTu8aFWuS3ueXz
 /+5EBJfP76eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="416537955"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga004.jf.intel.com with ESMTP; 03 Jun 2020 04:48:04 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        shaoyunl <shaoyun.liu@amd.com>, Lyude Paul <lyude@redhat.com>,
        Emily Deng <Emily.Deng@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] drm/amdgpu: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Wed,  3 Jun 2020 13:47:56 +0200
Message-Id: <20200603114758.13295-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5ed4227f304b..2588dd1015db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -249,15 +249,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 
 	if (amdgpu_msi_ok(adev)) {
 		int nvec = pci_msix_vec_count(adev->pdev);
-		unsigned int flags;
 
-		if (nvec <= 0) {
-			flags = PCI_IRQ_MSI;
-		} else {
-			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
-		}
 		/* we only need one vector */
-		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
+		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1,
+					     PCI_IRQ_MSI_TYPES);
 		if (nvec > 0) {
 			adev->irq.msi_enabled = true;
 			dev_dbg(adev->dev, "amdgpu: using MSI/MSI-X.\n");
-- 
2.17.2

