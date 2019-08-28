Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6BA092D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfH1SBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 14:01:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51841 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfH1SBi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 14:01:38 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i32GF-0007ef-An; Wed, 28 Aug 2019 18:01:35 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com, tiwai@suse.com
Cc:     linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 2/2] ALSA: hda: Allow HDA to be runtime suspended when dGPU is not bound
Date:   Thu, 29 Aug 2019 02:01:28 +0800
Message-Id: <20190828180128.1732-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827134756.10807-2-kai.heng.feng@canonical.com>
References: <20190827134756.10807-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's a common practice to let dGPU unbound and use PCI platform power
management to disable its power through _OFF method of power resource,
which is listed by _PR3.
When the dGPU comes with an HDA function, the HDA won't be suspended if
the dGPU is unbound, so the power resource can't be turned off.

Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
discrete GPU") only allows HDA to be runtime-suspended once GPU is
bound, to keep APU's HDA working.

However, HDA on dGPU isn't that useful if dGPU is unbound. So let's
relax the runtime suspend requirement for dGPU's HDA function, to save
lots of power.

BugLink: https://bugs.launchpad.net/bugs/1840835
Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers”)
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Change wording.
- Rebase to Tiwai's branch.

 sound/pci/hda/hda_intel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 91e71be42fa4..c3654d22795a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1284,7 +1284,11 @@ static void init_vga_switcheroo(struct azx *chip)
 		dev_info(chip->card->dev,
 			 "Handle vga_switcheroo audio client\n");
 		hda->use_vga_switcheroo = 1;
-		chip->bus.keep_power = 1; /* cleared in either gpu_bound op or codec probe */
+
+		/* cleared in either gpu_bound op or codec probe, or when its
+		 * root port has _PR3 (i.e. dGPU).
+		 */
+		chip->bus.keep_power = !pci_pr3_present(p);
 		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
 		pci_dev_put(p);
 	}
-- 
2.17.1

