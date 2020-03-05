Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE59179E5B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 04:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgCEDlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 22:41:46 -0500
Received: from yyz.mikelr.com ([170.75.163.43]:57182 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgCEDlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Mar 2020 22:41:46 -0500
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 84B523D087;
        Wed,  4 Mar 2020 22:41:44 -0500 (EST)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Mikel Rychliski <mikel@mikelr.com>
Subject: [PATCH v2 1/2] drm/radeon: Stop directly referencing iomem
Date:   Wed,  4 Mar 2020 22:41:25 -0500
Message-Id: <20200305034126.6989-2-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200305034126.6989-1-mikel@mikelr.com>
References: <20200305034126.6989-1-mikel@mikelr.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_platform_rom() returns an __iomem pointer which should not be
accessed directly. Change radeon_read_platform_bios() to use
memcpy_fromio() instead of calling kmemdup() on the __iomem pointer.

Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index c42f73fad3e3..c3ae4c92a115 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -118,11 +118,14 @@ static bool radeon_read_platform_bios(struct radeon_device *rdev)
 		return false;
 	}
 
-	if (size == 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
+	rdev->bios = kzalloc(size, GFP_KERNEL);
+	if (!rdev->bios)
 		return false;
-	}
-	rdev->bios = kmemdup(bios, size, GFP_KERNEL);
-	if (rdev->bios == NULL) {
+
+	memcpy_fromio(rdev->bios, bios, size);
+
+	if (size == 0 || rdev->bios[0] != 0x55 || rdev->bios[1] != 0xaa) {
+		kfree(rdev->bios);
 		return false;
 	}
 
-- 
2.13.7

