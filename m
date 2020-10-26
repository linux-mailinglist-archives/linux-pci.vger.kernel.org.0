Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DE42985FE
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 04:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421974AbgJZD5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 23:57:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37896 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390748AbgJZD5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2020 23:57:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id i26so5009778pgl.5;
        Sun, 25 Oct 2020 20:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFh2Lr0XEODcuO/5eEhXYo6ujJqSuhoSt0JRaqXHBrw=;
        b=Wa70fFapxofBjbhZgCQIFfK8r0CVuHZoKDVi/nECHs/bpa4iJci5+2tiBeVo++IR7f
         1lZ1ByFGbvSCijbRC+ZnMN4Ey7GQvlNYrKi/DiPNqOh4SNuJFrNVRenNzCG9mRm0Lkrk
         FEJjGle4qZPKB2dr8YLCTto07htNtKv5eZ3EytWv/fyRQxDEgfzHD16y2u/mHNmfLdT+
         X+v+riyNRCL3rAW9ph7Hi6JOAxnqMVQuHT0vIVSkQ6hINgXdu/DCVzeMteH84fzPCmUO
         +8lc0rl0nurwZfkKQQX+w9cgzvI7pY5LDpGKNtH/GcrzFL8pZXyWRarRSXG1XctDi+Dz
         rJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFh2Lr0XEODcuO/5eEhXYo6ujJqSuhoSt0JRaqXHBrw=;
        b=BGW575QiNYiX4cR6s/kbQTU1x/YPbhmzWskyUpW9M/9uPtlOr4tuKirX4r5HSU3fLI
         9Q9ljwbx8bduLcAnXudzqQj0QG5LSJMl8Qti4hG6sBy4VHF46fXRFqC6oh7TDMcO+jmV
         DSBL/bl+ta+SYi8yMfzIZxyjU10SNyyKLXz8VQFXFdjQFbqT0U5DiCiJzmw35qtP878p
         V9YsjMFa5r1FvlSLacDjKRU95lGzwGuUckboZJGyirkdiUVzxThpXmP8FKDSnMrCS0OW
         7oPSqAMnsXbJkLAacuDD78o0gL0+uuH3YfCdSy8Yy+xMpVGdBymfMAV0rKMdk3xy0c+1
         s7Ng==
X-Gm-Message-State: AOAM533Z2ra+ceUR46aYjp8kuQDOnsrDzjo25rhuHs7hl17xk3ZTHAiB
        02p5f+bUW2zBOYSs3DJJ0rNOYyQiALI=
X-Google-Smtp-Source: ABdhPJxtZqepsU8GXws73KGOFWrwqWLMbT+7B6avX+GCKkFdMEnTz++tcjj38aYs5BZQKiR3x8D/yw==
X-Received: by 2002:a63:1604:: with SMTP id w4mr11713757pgl.148.1603684654153;
        Sun, 25 Oct 2020 20:57:34 -0700 (PDT)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id p8sm9302684pgs.34.2020.10.25.20.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 20:57:33 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, hch@infradead.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH v2] PCI: check also dynamic IDs for duplicate in new_id_store()
Date:   Mon, 26 Oct 2020 11:57:10 +0800
Message-Id: <20201026035710.593-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a device ID data is writen to /sys/bus/pci/drivers/.../new_id,
only static ID table is checked for duplicate and multiple dynamic ID
entries of same kind are allowed to exist in a dynamic linked list.

Fix it by calling pci_match_device() which checks both dynamic and static
IDs.

After fix, it shows below result which is expected.

echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
-bash: echo: write error: File exists

Drop the static specifier and add a prototype to avoid build error.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
v2: revert the export of pci_match_device() per Christoph
    combind PATCH1 and PATCH2 into one.

 drivers/pci/pci-driver.c | 4 ++--
 include/linux/pci.h      | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8b587fc..cdc7d13 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -125,7 +125,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 		pdev->subsystem_device = subdevice;
 		pdev->class = class;
 
-		if (pci_match_id(pdrv->id_table, pdev))
+		if (pci_match_device(pdrv, pdev))
 			retval = -EEXIST;
 
 		kfree(pdev);
@@ -250,7 +250,7 @@ const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
  * system is in its list of supported devices.  Returns the matching
  * pci_device_id structure or %NULL if there is no match.
  */
-static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
+const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 						    struct pci_dev *dev)
 {
 	struct pci_dynid *dynid;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a7..ec57312 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1409,6 +1409,8 @@ int pci_add_dynid(struct pci_driver *drv,
 		  unsigned long driver_data);
 const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
 					 struct pci_dev *dev);
+const struct pci_device_id *pci_match_device(struct pci_driver *drv,
+					     struct pci_dev *dev);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 		    int pass);
 
-- 
1.8.3.1

