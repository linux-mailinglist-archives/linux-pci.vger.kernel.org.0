Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4909118A22
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 14:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLJNsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 08:48:36 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:58207 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJNsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2019 08:48:36 -0500
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 08:48:35 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id CC914101E692D;
        Tue, 10 Dec 2019 14:39:53 +0100 (CET)
Received: from localhost (pd95be530.dip0.t-ipconnect.de [217.91.229.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 545A661C7F8C;
        Tue, 10 Dec 2019 14:39:53 +0100 (CET)
X-Mailbox-Line: From 77aa6c01aefe1ebc4004e87b0bc714f2759f15c4 Mon Sep 17 00:00:00 2001
Message-Id: <77aa6c01aefe1ebc4004e87b0bc714f2759f15c4.1575985006.git.lukas@wunner.de>
In-Reply-To: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 10 Dec 2019 14:39:50 +0100
Subject: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nicholas Johnson reports a null pointer deref as well as a refcount
underflow upon hot-removal of a Thunderbolt-attached AMD eGPU.
He's bisected the issue down to commit 586bc4aab878 ("ALSA: hda/hdmi -
fix vgaswitcheroo detection for AMD").

The commit iterates over PCI devices using pci_get_class() and
unreferences each device found, even though pci_get_class()
subsequently unreferences the device as well.  Fix it.

Fixes: 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD")
Link: https://lore.kernel.org/r/PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM/
Reported-and-tested-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alexander Deucher <alexander.deucher@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
---
 sound/pci/hda/hda_intel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 35b4526f0d28..b856b89378ac 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1419,7 +1419,6 @@ static bool atpx_present(void)
 				return true;
 			}
 		}
-		pci_dev_put(pdev);
 	}
 	return false;
 }
-- 
2.24.0

