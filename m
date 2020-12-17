Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941202DDA10
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 21:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgLQUaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 15:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731562AbgLQUaF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2020 15:30:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66190C06138C
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2020 12:29:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id j22so21823438eja.13
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2020 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=w6kXRav+V3yvyrVOqvLuVvzhZG9YhhbrKM8BwIz1iN0=;
        b=g+rrNbTSPEYQmo1OCz0HWfxo/zdBp8TyKwX+5yAFJlkiY3DlYDYqql6fwTzdGSfTSj
         fOOfqvMP56C5PhzEXryuGGQYzELFcLg/04gklX1qv2SJY8PzpFqQ7Tjn6jnNWuaWRd8L
         vHcZsGdhrEwn2TWBQX6ZNYkzovu+5qBzHdaNtTmj8kXq7oCsbaboAMNLIU8Haf03Gqfw
         Q1BzSZd/zH3KQbsIbovDyYloUPmKeUGb2rnRa4OIMetB182NVomOaSVFqopoYtbK1sop
         Mkb0/opXUQ47IyXuxyA1XSoYjgIxilwdAWeDuwbA3J1KASBtm8byDQCB0JziU8NutaLv
         9yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=w6kXRav+V3yvyrVOqvLuVvzhZG9YhhbrKM8BwIz1iN0=;
        b=QPKW+OFvnllHXUASXGWQ/r74KQ0pFBOIdJ4g9hF9WBT4oWuw7awBex4NMug8TQIYcn
         UbRz0PVhGRnA/WF0z7r21NQGB3xyEZCsNZ9OPeLH2WJUP4SJ3/jY3Xw/mjLlMsuCLl/l
         nMOrD3zuYi1HceZD5qI+UoeLFEt24UCmms5PHdLoUKLJ+xQ82hczQL7zir0tvlm6UDdV
         afnKqPjCc0RAvNhp6T/KnzDzMjgKXYlaxy/CKVoKv9oFRvSn2hwAli0vZ1vrH7/rfdG6
         uFKl/3oaphmYF171P/x4ukzAUgWLIS9DW+j24QwFdCUJumFxIcvarNQ8PhhFmjqNWvLE
         bcDA==
X-Gm-Message-State: AOAM533/iuz5vKUBy5HWSRnKNY5rk8KpGp/NQS+sTjz+ic3ruBrEp2xB
        RLelbq/52/OZSLdv3Ufvh2GhVU6AR6Y=
X-Google-Smtp-Source: ABdhPJwIONE8eBPpFsRrk8xr0HDdd3CHzQ1FHdE4cl9p+w2eOsWEp3tR5mJUFRGRVSaM1eDloUYYNA==
X-Received: by 2002:a17:906:705:: with SMTP id y5mr773869ejb.428.1608236963387;
        Thu, 17 Dec 2020 12:29:23 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:c095:d389:734d:8e2a? (p200300ea8f065500c095d389734d8e2a.dip0.t-ipconnect.de. [2003:ea:8f06:5500:c095:d389:734d:8e2a])
        by smtp.googlemail.com with ESMTPSA id be6sm24166488edb.29.2020.12.17.12.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 12:29:22 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Remove not any longer needed Broadcom NIC quirk
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <1c0c94d1-37bd-442f-a93e-6e2fa202526b@gmail.com>
Date:   Thu, 17 Dec 2020 21:29:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This quirk was added in 2008 when we didn't have the logic yet to
determine VPD size based on checking for the VPD end tag. Now that we
have this logic and don't read beyond the end tag this quirk can be
removed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
This is basically the same as what you're currently discussing
for the Marvell / QLogic 1077 quirk.
---
 drivers/pci/vpd.c | 46 ----------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 7915d10f9..ef5165eb3 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -578,52 +578,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
-/*
- * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
- * VPD end tag will hang the device.  This problem was initially
- * observed when a vpd entry was created in sysfs
- * ('/sys/bus/pci/devices/<id>/vpd').   A read to this sysfs entry
- * will dump 32k of data.  Reading a full 32k will cause an access
- * beyond the VPD end tag causing the device to hang.  Once the device
- * is hung, the bnx2 driver will not be able to reset the device.
- * We believe that it is legal to read beyond the end tag and
- * therefore the solution is to limit the read/write length.
- */
-static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
-{
-	/*
-	 * Only disable the VPD capability for 5706, 5706S, 5708,
-	 * 5708S and 5709 rev. A
-	 */
-	if ((dev->device == PCI_DEVICE_ID_NX2_5706) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5706S) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5708) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5708S) ||
-	    ((dev->device == PCI_DEVICE_ID_NX2_5709) &&
-	     (dev->revision & 0xf0) == 0x0)) {
-		if (dev->vpd)
-			dev->vpd->len = 0x80;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5706,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5706S,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5708,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5708S,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5709,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5709S,
-			quirk_brcm_570x_limit_vpd);
-
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
 	int chip = (dev->device & 0xf000) >> 12;
-- 
2.29.2

