Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1213013B3D7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 21:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANUzh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 15:55:37 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37799 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANUzh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 15:55:37 -0500
Received: by mail-yb1-f195.google.com with SMTP id o199so1931587ybc.4
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 12:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weBtekj458P/fqac5LHRcran27/PThoOX/Om762JNZI=;
        b=sx30CwAIbFhljiLbe8MA3aUlpLeJG8nh1ZpZKkKn/Y0PlE9Q9QbNZfgNbenrzVYNls
         PEI+hny3OBHW0r99iM01a1wdlIkAH5JDNQrJFnIWROStTZwgh1wZaP2K+gPsoKjqwg9p
         hpMLSfScbMpVun0a5jTWounGrM8c9ZYD4ZKpKuJFqAw8ofZNU1mqBG3FJkBPkhf/j6TC
         b7JKSawj26J3GBulWW7ejUg+wVq9fsHY8IP3dVtX3LX5z0rTZtiQwL9PBhzfGvZRj1ct
         8GzIq6WToDK62eNaq7//XGpY/u08WqAWtp5mvnNk925bOdG7GFXemLoEqfk3E8alt6U6
         UDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weBtekj458P/fqac5LHRcran27/PThoOX/Om762JNZI=;
        b=Cl7oPAFhhCCHAmLC2oWVmMn3NQUZ12zDTMIZbEvYUZ5bwDr0opfkCIr8HpLtHqfKHT
         i0MswUDHN0VyagNZry3OhDgtf1tvRouqzzTDy8g6S9f/bTLkqslrBSfvVSSWDhz6/ExA
         sqH39x4py1DfQpRlAXAS8af/AWNq3Uyu8N6NOpyIK+1o4I2Vo8t+kztfJ1ooWkLOIJMr
         KZ+nucOJdF+dCmV5pjku+p28WsGh3NGCY1A2a5eEU7TrQuIJ007+X3aWF8O3OGBvb5tE
         qu3D615Nlmdp304OUyPHyKYkLRisI4PJYIRRPO1IS4LBhQ3v5JZJ9zRyQiZV55iRB+0S
         YvtQ==
X-Gm-Message-State: APjAAAUYUhAR7inQW33lzSpGvLKFrDGubvAlpLo9XHk3lnDGlneeJ9kW
        MQ02tzStywO8F+yfG1H4WdLLy2T9
X-Google-Smtp-Source: APXvYqwVML13FHQQismSDXdkFq/reCdAXkxm+Syqknt5Z32mK0w0uTynDyu59oQ6i63ZTJpurMksIA==
X-Received: by 2002:a25:1f82:: with SMTP id f124mr15618363ybf.471.1579035336278;
        Tue, 14 Jan 2020 12:55:36 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
        by smtp.gmail.com with ESMTPSA id a189sm7440521ywh.92.2020.01.14.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 12:55:35 -0800 (PST)
From:   Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] pci: Clarify ATS quirk
Date:   Tue, 14 Jan 2020 15:55:22 -0500
Message-Id: <20200114205523.1054271-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114205523.1054271-1-alexander.deucher@amd.com>
References: <20200114205523.1054271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We finally root caused this to a GPU configuration issue.  On
some harvest configurations, a driver needs to properly initialize
some of the caches on the GPU for instances that are harvested
(parts of the chip that are disabled due to silicon flaws).

The necessary code to fix this up is too complex to add
as a quirk.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1015
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/pci/quirks.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..6569dacbb48b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5074,18 +5074,28 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
 /*
- * Some devices have a broken ATS implementation causing IOMMU stalls.
- * Don't use ATS for those devices.
+ * Some devices require additional driver setup to enable ATS.
+ * Don't use ATS for those devices as ATS will be enabled before
+ * the driver has had a chance to load and properly configure
+ * the device.
  */
-static void quirk_no_ats(struct pci_dev *pdev)
+static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 {
-	pci_info(pdev, "disabling ATS (broken on this device)\n");
-	pdev->ats_cap = 0;
+	switch (pdev->device) {
+	case 0x98e4:
+	case 0x6900:
+		pci_info(pdev, "disabling ATS\n");
+		pdev->ats_cap = 0;
+		break;
+	default:
+		break;
+	}
 }
 
 /* AMD Stoney platform GPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
+/* AMD Iceland dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.24.1

