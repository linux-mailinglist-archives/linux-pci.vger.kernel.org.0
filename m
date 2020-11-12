Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97872B0B41
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 18:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgKLR1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 12:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgKLR1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 12:27:31 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFADC0613D1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 09:27:31 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so6897036wrw.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 09:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdQvcURFwsT4l7FkNZGMaJPG7VZbHuOJPanEpQ8LxxA=;
        b=i98id30nh+dFbz+pe9N2iYQnuPXbKBCKo93QB7YI7doNcjjgZx+AZEGE5pDj5K9dgT
         9/cAXCKE7zB2QpsMPkLOQ1/SgqGQtJphi/krqu1S3el4FrUpeNogJXf9+BATNUOiIllW
         QW+ls37MLrV3+QCPB6tBj1JhW365vkosut/EHzz4tppCz+s/vNX8rjvkQaViHG7yHcJX
         zGeRcpHOeezxsa+7GsNJo2jtP/EB6Wz+wqW14bV8juxHrXYnGQstKHptIHflfsYB9+Vw
         herrkRgG6fSGl5nw0HYjWuA7vTWp0WwGIj43jUB5Nwn9FcK0o+yK8uYSyKwAnmTh2Hc7
         E/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdQvcURFwsT4l7FkNZGMaJPG7VZbHuOJPanEpQ8LxxA=;
        b=cE3G5Zk7OjTjHxzmCcwaQ1Fy/Q+Jw6ATb/epl6Qd5UiAKgyNt57c0L86zozjTOwDI3
         HGSXwldkDtuiLvGDbLap54RSIzwvgCnWqaxLf19Yid/aHK1UJ1IVF9Ampv0C1HyH10qr
         egW+1zsx65I/CSrC839VuuyrPF/LmNSmOU0Pl8m0O5MWLVOlZNnVKgRoRACq3d/r8/nl
         Qya4irWdj6wYthw+xkX32RPtD7Rtillq+4t9sTPfATk6COXn6QRGGC3MRiWDdwf54SVa
         NLcGqb3UT3a7HY12cdQebZUKbrOkWDMjjELxJrfaDSRpGGXL6lngKlJyNsVMC1c9L2MJ
         vzsQ==
X-Gm-Message-State: AOAM531i4LIM3gJP7uDkhbqllLUAja8AHLK5g5WXPvDt9OYeZpiQoueE
        +5mLrmeFemA9l89mUf+yBWRYxA==
X-Google-Smtp-Source: ABdhPJwlSENg0vTP8LIYYfaUqmYbgowfugVcd9UH3txXMnUZHu0YgeuURZoYosFEYPXMUwR+v/F61w==
X-Received: by 2002:a05:6000:4c:: with SMTP id k12mr656233wrx.59.1605202049897;
        Thu, 12 Nov 2020 09:27:29 -0800 (PST)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id p3sm1501507wrs.50.2020.11.12.09.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:27:29 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH v2] PCI: brcmstb: Restore initial fundamental reset
Date:   Thu, 12 Nov 2020 17:27:09 +0000
Message-Id: <20201112172709.1817-1-phil@raspberrypi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
replaced a single reset function with a pointer to one of two
implementations, but also removed the call asserting the reset
at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
used for USB booting but then need to be reset so that the kernel
can reconfigure them. The lack of a reset causes the firmware's loading
of the EEPROM image to RAM to fail, breaking USB for the kernel.

Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
Changes in v2:
  - Exclude BCM7278 from the initial reset
  - Ack from Nicolas
---
 drivers/pci/controller/pcie-brcmstb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bea86899bd5d..83aa85bfe8e3 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -869,6 +869,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
+
+	/* Assert the fundemental reset, except on BCM7278 */
+	if (pcie->type != BCM7278)
+		pcie->perst_set(pcie, 1);
+
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-- 
2.25.1

