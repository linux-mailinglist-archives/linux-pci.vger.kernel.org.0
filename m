Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDFD3E3BE6
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhHHRXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhHHRXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 13:23:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3365C061760
        for <linux-pci@vger.kernel.org>; Sun,  8 Aug 2021 10:23:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i4so756418wru.0
        for <linux-pci@vger.kernel.org>; Sun, 08 Aug 2021 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCNpFG5aHGh4jGVccDghzCAzsVqauDMJguybpsCmQN0=;
        b=kW919A70yMe+70axQ99EwS/Uy+lxbXUNHsiGT/27xPP/B2XEI8oFzoRJdNF6eiYYY3
         tQId2vbcXD3HJjpK7TW/uO8BT/8gphOPynLIOjl3/Pza4yEeg3bieo/8d4AzUAUbLxsS
         tAGVX/VEEpccRv6NnAmb3KarYIqdeqpfgw6WnOmr165pjJjcbFTaYoZ/cVOywxwkoDVs
         3J3ochFHjsisCgQT41cwKzF2IIL5tRdaMjyJZxZRRmdKFLN74CQ+a3JJHdWI/aSsyMf2
         m2tXL7Ed7S8d/F9tB0pdcwKpcPs+ZjuSAkJxsRGwnGcMT3joHlYRR/R/gVTpYyMzOSNu
         RdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCNpFG5aHGh4jGVccDghzCAzsVqauDMJguybpsCmQN0=;
        b=ld/6EnYoVr2MJTtIMC8LLP3kxoysXoPqG0RovYxVekw1UxZ4XXyRN++tFkFjRP1xJ1
         SDeKZukXr9vF4daaI1LstvrhdT/Pqehormoggci1E8Alxm6VfwfYTLq+6WjGUlBSpr0i
         n2DXICGf+HmtRtGGE2rntaUn8jnnhFGVszE7p8XUjtnDL0dN2RkbSVkomjAAO+TqTV53
         mcBZuhbM7bvNJ3uEEseRjGN3XQf9KI6UDlLvbvZol/Fso9bopxQCru5Eaztz+Ki0FpHg
         Bjy1ec/M1HE7ebSZc4ioKhZHSvEeaH+SpxgaewlLRPQzPIAbUZTswCqMg5OUIgPxuXBS
         7lxg==
X-Gm-Message-State: AOAM5324GuMsmLAfld/BmvXTyLrtVmtibNXyE68ewp991oVBTkLDLi2K
        NSwXJ3sw/UrPnWNGNq2xhDV425XFS8dkAQ==
X-Google-Smtp-Source: ABdhPJxHy1lHcRNGHeJlulMuBh1r3+qZ6imAPaTKaQ6QLrkK0w/G4jxDZUNRUTEdE9MmbADP/JU3Jg==
X-Received: by 2002:a5d:45c2:: with SMTP id b2mr1172788wrs.188.1628443376227;
        Sun, 08 Aug 2021 10:22:56 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:7101:8b48:5eab:cb5f? (p200300ea8f10c20071018b485eabcb5f.dip0.t-ipconnect.de. [2003:ea:8f10:c200:7101:8b48:5eab:cb5f])
        by smtp.googlemail.com with ESMTPSA id s10sm3549960wrv.54.2021.08.08.10.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 10:22:55 -0700 (PDT)
Subject: [PATCH 5/6] PCI/VPD: Determine VPD size in pci_vpd_init already
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Message-ID: <cc4a6538-557a-294d-4f94-e6d1d3c91589@gmail.com>
Date:   Sun, 8 Aug 2021 19:22:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After preceding patches in this series we now can move determining
VPD size to pci_vpd_init(). Any quirk sets dev->vpd.len to a
non-zero value and therefore causes skipping the dynamic size
calculation. Prerequisite is that we move the quirks from FINAL
to HEADER stage.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 86f9440e0..9187ba496 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -125,9 +125,6 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (pos < 0)
 		return -EINVAL;
 
-	if (!vpd->len)
-		vpd->len = pci_vpd_size(dev);
-
 	if (vpd->len == PCI_VPD_SZ_INVALID)
 		return -EIO;
 
@@ -192,9 +189,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	if (pos < 0 || (pos & 3) || (count & 3))
 		return -EINVAL;
 
-	if (!vpd->len)
-		vpd->len = pci_vpd_size(dev);
-
 	if (vpd->len == PCI_VPD_SZ_INVALID)
 		return -EIO;
 
@@ -235,6 +229,9 @@ void pci_vpd_init(struct pci_dev *dev)
 {
 	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
 	mutex_init(&dev->vpd.lock);
+
+	if (!dev->vpd.len)
+		dev->vpd.len = pci_vpd_size(dev);
 }
 
 static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
@@ -395,25 +392,24 @@ static void quirk_blacklist_vpd(struct pci_dev *dev)
 	dev->vpd.len = PCI_VPD_SZ_INVALID;
 	pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
-		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
 /*
  * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
  * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
  */
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
-			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
+			       PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
@@ -438,7 +434,7 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 		dev->vpd.len = 2048;
 }
 
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
-			quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
+			 quirk_chelsio_extend_vpd);
 
 #endif
-- 
2.32.0


