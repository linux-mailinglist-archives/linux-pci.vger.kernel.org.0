Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4115294933
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 10:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502172AbgJUIKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 04:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502070AbgJUIKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2020 04:10:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350AFC0613CE;
        Wed, 21 Oct 2020 01:10:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t22so816428plr.9;
        Wed, 21 Oct 2020 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcdoMsGY0YFqco0umtOzbIh9g8YuJDqwapW339hxwqo=;
        b=QVx+YmTWTik+z9lV5QfwGP5w4Zp9ET5FUsBAJs80s9NZ5gMSf0gcdK1mu5mA0HoRjn
         WvBijjbjGXrJ0yIvbg/F+V23CrMNYCxET6cAd5HfRIdL55Py4HeQk+3aN5lCIxHZf/1G
         ljrw6Z28eZgyfu3bvIc6fgCulPBV/biYqBtDKLKUNwws+HfVRbZES9ES5g+B0YnhZSdX
         hiXY54fw7VcRBqqMx7jMeLzz9okbtacKsfMtwshVsp0DToWB9uRqgtXhVOov450gDzAQ
         Bpcr4ynXUSCaeubJbO51G3eRzeVJc2s+7s0hV4jU4gVlPu/JpCwkJFACMrX1z7hWbYE5
         LaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcdoMsGY0YFqco0umtOzbIh9g8YuJDqwapW339hxwqo=;
        b=pSh9z+jpdCiGovKwpS9B4tg9eFApR2NbdUacG4jkk/qMYyW2gY5REpWffeSYz8jycg
         D7bht1wpjST0urBHE5cIITlZNJ2+jAlOYbPwdsmYtJT4XbMjDAW4Fi98kt94Yc3Keyjo
         7+FhTGkMt0emxCBz4+exAomcgSbxz+4YtDl6nS9DXFbX10/+NTYKRhoBiNoC8/35AzNQ
         OT7gi1gedE6F/YGM/zitSxZ6L+uu8rfJNFv4MmXPyUx/Vs0GA+cghJq29zgptHZeH3yE
         KnSC5xP0ggTcl3ZeEDjkCDdNVz8xostmt4DQ1wFFA7cKVMrnZpV6HdcxHMaqlGrYlu2t
         wItA==
X-Gm-Message-State: AOAM532qhJm/cEOM2EoDbSzdQ61jukjsRxHcsy72NK2EpqEpI7bpGTMN
        3Tb59up5ymtD1yWsuY7Th8uuyHWjJFM=
X-Google-Smtp-Source: ABdhPJyziluZpm00Hc5eEBfIMhDC9GMe9wEY/QjpEEu0O4fw/xUaZC1Hqi8ekDx2lEWVbLcj+4jPaw==
X-Received: by 2002:a17:90b:30d2:: with SMTP id hi18mr2292339pjb.86.1603267842386;
        Wed, 21 Oct 2020 01:10:42 -0700 (PDT)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id q23sm466075pfg.192.2020.10.21.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 01:10:41 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH 1/2] PCI: export pci_match_device()
Date:   Wed, 21 Oct 2020 16:10:29 +0800
Message-Id: <20201021081030.160-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_match_id() is deprecated as it doesn't catch any dynamic ids that
a driver might want to check for.

Export pci_match_device() as a replacement which supports both dynamic
and static ids.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/pci/pci-driver.c | 3 ++-
 include/linux/pci.h      | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d1b7169..bd9cfd1 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -250,7 +250,7 @@ const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
  * system is in its list of supported devices.  Returns the matching
  * pci_device_id structure or %NULL if there is no match.
  */
-static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
+const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 						    struct pci_dev *dev)
 {
 	struct pci_dynid *dynid;
@@ -279,6 +279,7 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 
 	return found_id;
 }
+EXPORT_SYMBOL(pci_match_device);
 
 struct drv_dev_and_id {
 	struct pci_driver *drv;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8355306..6f947c4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1406,6 +1406,8 @@ int pci_add_dynid(struct pci_driver *drv,
 		  unsigned long driver_data);
 const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
 					 struct pci_dev *dev);
+const struct pci_device_id *pci_match_device(struct pci_driver *drv,
+					     struct pci_dev *dev);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 		    int pass);
 
-- 
1.8.3.1

