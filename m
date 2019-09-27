Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0DC01A1
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfI0JCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 05:02:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38993 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfI0JCI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 05:02:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so1193063pff.6
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2019 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5yncGVIGcBUU0Qx4YQav5kcxHlI5UC4QRgpeQu8kNhA=;
        b=eA4FJinrODv+48zRVhxibGLLHEOxlVFW/vZ/iQUCgt9D7z+xhJ0mKf9Y/yweQGb6Gi
         9b3/F5nVfRNRhGrk7XW6ZpOQQfXbrKkW9MzUWT4mWbywdtMSW1cf5e0yvTKJ4RLE/NSe
         r6PySpwAEP+1c00R3YQWlElA25Ffak4X+Gg7oFDgxH1OplXQ1fAHOmeEOfQNJ5uqk4kU
         733VWHlCdU2j8YlEVSof1mqvANu4eqFMoFakCIkXALHk5OAL2FK+KMh12UbJAtLPfgJJ
         i/vWtAmPC/GWP4hnG/JsWFYgsczScO3V6kFbUVmNdWYRs1cv5lsToJ6yiirjH1bgXPlJ
         qRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5yncGVIGcBUU0Qx4YQav5kcxHlI5UC4QRgpeQu8kNhA=;
        b=omTd9tGamd4O7FBW/VRxApKHR+RI4q7ZImU38vzedIpNMkpJGTi+xOYsUj3jfPJs23
         xjTAfT2VZF7TgxPOb7XvUJfBBWDgMkxAnKym43+E7Vyqwy7G9UA0ThVxcKXIecVD6tDs
         0jEyXJdtVU+JsA7vESOL2qzhJ6t1JPYeHjdRosXRKZoiNoZWU70wRCCdnD6JTfgFvMTg
         5lEFwN7XkCJWVFulfH5yt6m0mD34A0xlLTbTH0fdUhq29edvSD15MWpOOGJOro1yDhwH
         bIlypYh79NcMQkrPVAipNO5hshJ6lxq9RXwhEx5uej8nt6d3ok1WdrD9HGr3rCgDAEVB
         2vOg==
X-Gm-Message-State: APjAAAVUdmTrj8cT7Vvvo4Un8A5Q+zGJz9DbaHA+PDWYM8zHz+9loOTF
        Irceqq+l+AUfazl4jYli9QubWg==
X-Google-Smtp-Source: APXvYqykU4OEAfFMMqT32a+dnqKs0fu/V96QsUOui8jICh8HwHMQ95/vS+ZuCIIq2kdfNGoIPguIfg==
X-Received: by 2002:aa7:874c:: with SMTP id g12mr2828560pfo.170.1569574927095;
        Fri, 27 Sep 2019 02:02:07 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id f62sm2178673pfg.74.2019.09.27.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 02:02:06 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     rafael@kernel.org, bhelgaas@google.com
Cc:     mathias.nyman@linux.intel.com, linux@endlessm.com,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: also apply D3 delay when leaving D3cold
Date:   Fri, 27 Sep 2019 17:02:02 +0800
Message-Id: <20190927090202.1468-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This delay is needed to fix resume from s2idle of the XHCI controller on
AMD Ryzen SoCs, where a 20ms delay is required (this will be quirked
in a followup patch), to avoid this failure:

  xhci_hcd 0000:03:00.4: WARN: xHC restore state timeout
  xhci_hcd 0000:03:00.4: PCI post-resume error -110!

The D3 delay is already being performed in a runtime resume from D3cold,
through the following sequence of events:

     pci_pm_runtime_resume
  -> pci_restore_standard_config
  -> pci_set_power_state(D0)
  -> __pci_start_power_transition
  -> pci_platform_power_transition
  -> pci_update_current_state

At this point, the device has been set to D0 at the platform level,
so pci_update_current_state() reads pmcsr and updates dev->current_state
to D3hot. Now when we reach pci_raw_set_power_state() the D3 delay will
be applied.

However, the D3cold resume from s2idle path is somewhat different, and
we arrive at the same function without hitting pci_update_current_state()
along the way:
     pci_pm_resume_noirq
  -> pci_pm_default_resume_early
  -> pci_power_up
  -> pci_raw_set_power_state

As dev->current_state is D3cold, the D3 delay is skipped and the XHCI
controllers fail to be powered up.

Apply the D3 delay in the s2idle resume case too, in order to fix
USB functionality after resume.

Link: http://lkml.kernel.org/r/CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e7982af9a5d8..ab15fa5eda2c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -883,7 +883,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	 * Mandatory power management transition delays; see PCI PM 1.1
 	 * 5.6.1 table 18
 	 */
-	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
+	if (state == PCI_D3hot || dev->current_state == PCI_D3hot
+			|| dev->current_state == PCI_D3cold)
 		pci_dev_d3_sleep(dev);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
-- 
2.20.1

