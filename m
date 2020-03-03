Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF555176D9D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 04:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCCDl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 22:41:56 -0500
Received: from yyz.mikelr.com ([170.75.163.43]:57132 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgCCDl4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 22:41:56 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2020 22:41:56 EST
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id B2DFA3CF22;
        Mon,  2 Mar 2020 22:35:02 -0500 (EST)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Mikel Rychliski <mikel@mikelr.com>
Subject: [PATCH 1/4] drm/radeon: Stop directly referencing iomem
Date:   Mon,  2 Mar 2020 22:34:54 -0500
Message-Id: <20200303033457.12180-2-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200303033457.12180-1-mikel@mikelr.com>
References: <20200303033457.12180-1-mikel@mikelr.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_platform_rom returns an __iomem pointer which should not be accessed
directly. Change radeon_read_platform_bios to use memcpy_fromio instead of
calling kmemdup on the __iomem pointer.

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

