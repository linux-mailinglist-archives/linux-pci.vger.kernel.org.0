Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769AE4C0B90
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 06:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiBWFQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 00:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiBWFQT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 00:16:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7715BD2C;
        Tue, 22 Feb 2022 21:15:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so2782796pjb.1;
        Tue, 22 Feb 2022 21:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9X2+n6KpehChnxp9Tmr1fZodcY/pATSFKo49PZQzwo=;
        b=k574kVhYSfhs2DWwMEDbrHsvrqIW0+aaLPJq1etRIjE/u48bb+8A8BDFoV4U4lHkQv
         LqBzrHvwM5MTiopD28tV4xjllOpq7/DItVI8qC0lRhtVgM0GwIecvYwgAqwL5nDBhwKT
         VxVybKr1hVblKHgMzY4OSw8A6txxLAzqFQDZk8zY1ymwFPXSCXQ/O61+mze30QSiWB41
         b28/eA7CgYxyhL4TqnSoE029e14EhZBCvUQ/kPewVzaJkt/NIl8SynhloVmzS8iu7g36
         HB5i2efoCr1XmjCmXhcimX1Dv65dnTJDaAZRHDl99OgPdbx8O3u6Lbe4SzlRiPr1Nonb
         Z3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9X2+n6KpehChnxp9Tmr1fZodcY/pATSFKo49PZQzwo=;
        b=rddoVwrpWTw0a6Ucogz+x/G8EJlBKXhXP0qdNjgkjYCMfmOoL/VGqSUzfIYGxHWpHC
         QxTWGBepLmRux7bvmabf+js4/mqMOvMv0MdC/dXnHu0l38NxOC/Q5CDGj36gKA4wULV5
         0BS0oGuudIWHirudK5Q1LHeNLwkwRcNWo/jvkTziAA5rbzYcptVfq7yd2Vxty4tb+zvf
         zCZ8yfKUzeWi/bIv1bgonMTiaO7SJ0ncnuUr9OyOi/dntgYk5i/UEH63jk3YEWHlX69D
         nGGknGQg3DLKObOhavRZQLmBoPS20jCZAoLby2WpOncoTjrEyLjJmQ4SZNlpQnLAh4+f
         ZX9Q==
X-Gm-Message-State: AOAM531cMNazyMca/ioi6frUGf9B5/OplmL35gFK52FEwFtiiUA12Bh4
        f3GmPm9sIMZCJKMneL7fo4eiDS1bWBnf0Eo4
X-Google-Smtp-Source: ABdhPJxrG3DsbCwd9Vb5y+rszL2ndDj9F/tggumUkZ8XkIFacRXlfciOX0sa2oh1KdKvhkXsDzS/DA==
X-Received: by 2002:a17:90a:178d:b0:1b9:75ce:34d8 with SMTP id q13-20020a17090a178d00b001b975ce34d8mr7549693pja.228.1645593352238;
        Tue, 22 Feb 2022 21:15:52 -0800 (PST)
Received: from yusufkhan-a.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id a22sm15191334pfv.73.2022.02.22.21.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 21:15:51 -0800 (PST)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, tiwai@suse.com, perex@perex.cz,
        alex.bou9@gmail.com, mporter@kernel.crashing.org,
        logang@deltatee.com, kurt.schwemmer@microsemi.com,
        bhelgaas@google.com, kw@linux.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        nirmal.patel@linux.intel.com, Yusuf Khan <yusisamerican@gmail.com>
Subject: [PATCH] Removed some usages of the deprecated "pci-dma-compat.h" KPI
Date:   Tue, 22 Feb 2022 21:15:45 -0800
Message-Id: <20220223051545.572235-1-yusisamerican@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The inspiration for this commit comes from Christophe
JAILLET in [1], you can find reasons for why this was removed
linked there. This removes the use of the KPI in some pci
components and rapidio(whatever that is) devices.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux
-next.git/patch/?id=ada3caabaf6135150077c3f729bb06e8f3b5b8f6

Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
---
 drivers/pci/controller/vmd.c     | 1 +
 drivers/pci/switch/switchtec.c   | 1 +
 drivers/rapidio/devices/tsi721.c | 8 ++++----
 sound/pci/asihpi/hpios.c         | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cc166c683638..244dc0f2f71e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -17,6 +17,7 @@
 #include <linux/srcu.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/irqdomain.h>
 
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index c36c1238c604..05a876ec1463 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -15,6 +15,7 @@
 #include <linux/wait.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/nospec.h>
+#include <linux/dma-mapping.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
 MODULE_VERSION("0.1");
diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 4dd31dd9feea..b3134744fb55 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2836,17 +2836,17 @@ static int tsi721_probe(struct pci_dev *pdev,
 	}
 
 	/* Configure DMA attributes. */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
 			tsi_err(&pdev->dev, "Unable to set DMA mask");
 			goto err_unmap_bars;
 		}
 
-		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)))
+		if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)))
 			tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
 	} else {
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 		if (err)
 			tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
 	}
diff --git a/sound/pci/asihpi/hpios.c b/sound/pci/asihpi/hpios.c
index 6fe60d13e24b..08757c92aee5 100644
--- a/sound/pci/asihpi/hpios.c
+++ b/sound/pci/asihpi/hpios.c
@@ -10,6 +10,7 @@ HPI Operating System function implementation for Linux
 (C) Copyright AudioScience Inc. 1997-2003
 ******************************************************************************/
 #define SOURCEFILE_NAME "hpios.c"
+#include <linux/dma-mapping.h>
 #include "hpi_internal.h"
 #include "hpidebug.h"
 #include <linux/delay.h>
-- 
2.25.1

