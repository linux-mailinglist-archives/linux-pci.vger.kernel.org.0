Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240F99E9E6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfH0NsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 09:48:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37100 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfH0NsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 09:48:07 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2bpN-0005tS-6V; Tue, 27 Aug 2019 13:48:05 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com, tiwai@suse.com
Cc:     linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] ALSA: hda: Allow HDA to be runtime suspended when dGPU is not bound
Date:   Tue, 27 Aug 2019 21:47:56 +0800
Message-Id: <20190827134756.10807-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827134756.10807-1-kai.heng.feng@canonical.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's a common practice to let dGPU unbound and use PCI port PM to
disable its power through _PR3. When the dGPU comes with an HDA
function, the HDA won't be suspended if the dGPU is unbound, so the dGPU
power can't be disabled.

Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
discrete GPU") only allows HDA to be runtime-suspended once GPU is
bound, to keep APU's HDA working.

However, HDA on dGPU isn't that useful if dGPU is unbound. So let relax
the runtime suspend requirement for dGPU's HDA function, to save lots of
power.

BugLink: https://bugs.launchpad.net/bugs/1840835
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 99fc0917339b..d4ee070e1a29 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1285,7 +1285,8 @@ static void init_vga_switcheroo(struct azx *chip)
 		dev_info(chip->card->dev,
 			 "Handle vga_switcheroo audio client\n");
 		hda->use_vga_switcheroo = 1;
-		hda->need_eld_notify_link = 1; /* cleared in gpu_bound op */
+		/* cleared in gpu_bound op */
+		hda->need_eld_notify_link = !pci_pr3_present(p);
 		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
 		pci_dev_put(p);
 	}
-- 
2.17.1

