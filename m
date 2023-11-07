Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B57E45C5
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 17:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjKGQSN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 11:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjKGQR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 11:17:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05351717;
        Tue,  7 Nov 2023 07:52:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B459BC433CA;
        Tue,  7 Nov 2023 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372347;
        bh=AJ60giNP+AH/cCyECe5rv18MhVuQSgTFA29ZeqFHnn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WD8+sPacdQeQM123resn0effztEBWYs+fF3uSho3yiV/WGm59piPQHOpunqXKybp2
         IvLy2jmZvrUDpzjxqN4mgm1FMnQ2Ub3MORTOvdf+sMC5jlE+9oKqhDJIJ9TqImiNst
         5qSDl4Vl3VZ8z0+D5RUGKZyMGx/i1uw5X8lfxeFcqYqhPRGAo95dewQIYavlZYXKV3
         M2DkXAYZK0C3Z7RqMzmKUTmFYOEH+B97VBuf0OddG3nSjQMXz9mJixu3oKv2XQvmr0
         efgFmCJHtNC9gcHReytylAFwmNYI+szd+xRQVkdSx765ozhAtQlk9uKGIVguuymQx0
         xH7ass5Cue5uw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 17/22] PCI: Extract ATS disabling to a helper function
Date:   Tue,  7 Nov 2023 10:51:26 -0500
Message-ID: <20231107155146.3767610-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bartosz Pawlowski <bartosz.pawlowski@intel.com>

[ Upstream commit f18b1137d38c091cc8c16365219f0a1d4a30b3d1 ]

Introduce quirk_no_ats() helper function to provide a standard way to
disable ATS capability in PCI quirks.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230908143606.685930-2-bartosz.pawlowski@intel.com
Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ec17d42c2a155..60724825e2524 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5377,6 +5377,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
+static void quirk_no_ats(struct pci_dev *pdev)
+{
+	pci_info(pdev, "disabling ATS\n");
+	pdev->ats_cap = 0;
+}
+
 /*
  * Some devices require additional driver setup to enable ATS.  Don't use
  * ATS for those devices as ATS will be enabled before the driver has had a
@@ -5390,14 +5396,10 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 		    (pdev->subsystem_device == 0xce19 ||
 		     pdev->subsystem_device == 0xcc10 ||
 		     pdev->subsystem_device == 0xcc08))
-			goto no_ats;
-		else
-			return;
+			quirk_no_ats(pdev);
+	} else {
+		quirk_no_ats(pdev);
 	}
-
-no_ats:
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
 }
 
 /* AMD Stoney platform GPU */
-- 
2.42.0

